package vn.fs.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import vn.fs.config.VnpayConfig;
import vn.fs.entities.Order;
import vn.fs.entities.User;
import vn.fs.repository.UserRepository;
import vn.fs.service.OrderService;
import vn.fs.service.ShoppingCartService;
import vn.fs.service.UserDetailService;
import vn.fs.util.VnpayUtil;

import java.time.LocalDateTime;
import java.time.ZoneId;
// import java.time.LocalDateTime;
import java.util.*;

// @RestController
@Controller
@RequestMapping("/vnpay")
public class VnpayController {

    @Autowired
    private VnpayConfig vnpayConfig;

    @Autowired
    private OrderService orderService;
    @Autowired
    private UserDetailService userDetailService;
    @Autowired
    private UserRepository userRepository; // Thêm dependency này
    @Autowired
    private ShoppingCartService shoppingCartService; // Thêm dependency này

    @GetMapping("/create-payment")
    public ResponseEntity<Map<String, String>> createPayment(
            @RequestParam String orderId,
            @RequestParam int totalPrice) {
        Map<String, String> response = new HashMap<>();
        try {
            Long orderIdLong = Long.parseLong(orderId);
            System.out.println("Received request for orderId: " + orderIdLong + " with totalPrice: " + totalPrice);

            // Lấy thông tin người dùng từ SecurityContext
            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username;
            if (principal instanceof UserDetails) {
                username = ((UserDetails) principal).getUsername();
            } else {
                username = principal.toString();
            }

            // Lấy userId từ UserDetailService
            Long userId = userDetailService.getUserIdByUsername(username);
            if (userId == null) {
                throw new Exception("Không tìm thấy userId cho người dùng: " + username);
            }

            // Lấy đối tượng User từ UserRepository
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new Exception("Không tìm thấy người dùng với ID: " + userId));
            System.out.println("Fetched user with userId: " + user.getUserId() + ", email: " + user.getEmail());

            Order order = orderService.getOrderById(orderIdLong);
            if (order == null) {
                order = new Order();
                order.setOrderId(orderIdLong);
                order.setAmount((double) totalPrice);
                order.setAddress("Default Address");
                order.setPhone("0123456789");
                order.setStatus(0);
                order.setOrderDate(Date.from(LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant()));
                order.setUser(user); // Gán đối tượng User
                orderService.saveOrder(order);
                System.out.println("Created new order with orderId: " + orderIdLong + " for userId: " + userId);
            }

            String paymentUrl = VnpayUtil.createPaymentUrl(
                    orderId,
                    totalPrice,
                    vnpayConfig.getReturnUrl(),
                    vnpayConfig.getTmnCode(),
                    vnpayConfig.getHashSecret(),
                    vnpayConfig.getUrl());
            System.out.println("Generated paymentUrl: " + paymentUrl);
            response.put("paymentUrl", paymentUrl);
            return ResponseEntity.ok(response);
        } catch (NumberFormatException e) {
            response.put("error", "Lỗi: orderId không hợp lệ - " + e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        } catch (Exception e) {
            response.put("error", "Lỗi tạo thanh toán: " + e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }

    // @GetMapping("/create-payment")
    // public ResponseEntity<Map<String, String>> createPayment(
    // @RequestParam String orderId, // Nhận String từ request
    // @RequestParam int totalPrice) {
    // Map<String, String> response = new HashMap<>();
    // try {
    // // Chuyển đổi orderId từ String thành Long
    // Long orderIdLong = Long.parseLong(orderId);
    // System.out.println("Received request for orderId: " + orderIdLong + " with
    // totalPrice: " + totalPrice);

    // Order order = orderService.getOrderById(orderIdLong);
    // if (order == null) {
    // order = new Order();
    // order.setOrderId(orderIdLong); // Sử dụng Long
    // order.setAmount((double) totalPrice); // Chuyển int thành Double
    // order.setAddress("Default Address");
    // order.setPhone("0123456789");
    // order.setStatus(0);
    // order.setOrderDate(Date.from(LocalDateTime.now().atZone(ZoneId.systemDefault()).toInstant()));
    // order.setUser(null);
    // orderService.saveOrder(order);
    // System.out.println("Created new order with orderId: " + orderIdLong);
    // }

    // String paymentUrl = VnpayUtil.createPaymentUrl(
    // orderId, // Truyền String vì VnpayUtil mong đợi String
    // totalPrice,
    // vnpayConfig.getReturnUrl(),
    // vnpayConfig.getTmnCode(),
    // vnpayConfig.getHashSecret(),
    // vnpayConfig.getUrl());
    // System.out.println("Generated paymentUrl: " + paymentUrl);
    // response.put("paymentUrl", paymentUrl);
    // return ResponseEntity.ok(response);
    // } catch (NumberFormatException e) {
    // response.put("error", "Lỗi: orderId không hợp lệ - " + e.getMessage());
    // return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
    // } catch (Exception e) {
    // response.put("error", "Lỗi tạo thanh toán: " + e.getMessage());
    // return
    // ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
    // }
    // }

    @GetMapping("/return")
    public ResponseEntity<?> paymentReturn(@RequestParam Map<String, String> queryParams) {
        String vnp_SecureHash = queryParams.get("vnp_SecureHash");
        String orderId = queryParams.get("vnp_TxnRef");
        String paymentStatus = queryParams.get("vnp_TransactionStatus");

        System.out.println("Received return from VNPay for orderId: " + orderId);

        String signValue = buildSignValue(queryParams, vnpayConfig.getHashSecret());

        if (signValue.equals(vnp_SecureHash)) {
            if ("00".equals(paymentStatus)) { // Payment successful
                try {
                    Long orderIdLong = Long.parseLong(orderId);
                    Order order = orderService.getOrderById(orderIdLong);
                    if (order == null) {
                        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                                .body("Không tìm thấy đơn hàng với mã: " + orderId);
                    }
                    order.setStatus(1); // Update order status to successful
                    orderService.saveOrder(order);

                    // Redirect to success page
                    return ResponseEntity.status(HttpStatus.FOUND)
                            .header("Location", "/vnpay/success?orderId=" + orderId)
                            .build();
                } catch (NumberFormatException e) {
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                            .body("Lỗi: Mã đơn hàng không hợp lệ - " + e.getMessage());
                }
            } else {
                // Payment failed, redirect to failure page or show error
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Thanh toán thất bại. Vui lòng thử lại!");
            }
        } else {
            shoppingCartService.clear();
            // Signature verification failed, redirect to success page as requested
            return ResponseEntity.status(HttpStatus.FOUND)
                    .header("Location", "/vnpay/success?orderId=" + orderId)
                    .build();
        }
    }

    @GetMapping("/success")
    public String paymentSuccess(@RequestParam(required = false) String orderId, Model model) {
        return "redirect:/checkout_success";
    }

    private String buildSignValue(Map<String, String> params, String secretKey) {
        List<String> fieldNames = new ArrayList<>(params.keySet());
        Collections.sort(fieldNames);

        StringBuilder signData = new StringBuilder();
        for (String fieldName : fieldNames) {
            if (!"vnp_SecureHash".equals(fieldName) && params.get(fieldName) != null
                    && !params.get(fieldName).isEmpty()) {
                signData.append(fieldName).append("=").append(params.get(fieldName)).append("&");
            }
        }

        if (signData.length() > 0) {
            signData.setLength(signData.length() - 1); // Xóa ký tự & cuối
        }

        try {
            // Dùng HMAC SHA512 thay vì SHA256
            return VnpayUtil.hmacSHA512(secretKey, signData.toString());
        } catch (Exception e) {
            throw new RuntimeException("Lỗi tạo signature: " + e.getMessage());
        }
    }
}