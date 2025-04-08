package vn.fs.util;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class VnpayUtil {

    public static String createPaymentUrl(
            String orderId,
            int amount,
            String returnUrl,
            String vnp_TmnCode,
            String vnp_HashSecret,
            String vnp_Url) throws Exception {
        Map<String, String> vnpParams = new HashMap<>();
        vnpParams.put("vnp_Version", "2.1.0");
        vnpParams.put("vnp_Command", "pay");
        vnpParams.put("vnp_TmnCode", vnp_TmnCode);
        vnpParams.put("vnp_Amount", String.valueOf(amount * 100)); // Nhân 100
        vnpParams.put("vnp_CurrCode", "VND");
        vnpParams.put("vnp_TxnRef", orderId);
        vnpParams.put("vnp_OrderInfo", "Thanh toan don hang " + orderId);
        vnpParams.put("vnp_OrderType", "other");
        vnpParams.put("vnp_Locale", "vn");
        vnpParams.put("vnp_ReturnUrl", returnUrl);
        vnpParams.put("vnp_IpAddr", "127.0.0.1"); // Thay bằng IP thực tế nếu cần
        vnpParams.put("vnp_CreateDate", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));

        // Sắp xếp theo key
        List<String> sortedKeys = new ArrayList<>(vnpParams.keySet());
        Collections.sort(sortedKeys);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (String key : sortedKeys) {
            String value = vnpParams.get(key);
            if (value != null && !value.isEmpty()) { // Chỉ thêm nếu giá trị không rỗng
                hashData.append(key).append("=").append(URLEncoder.encode(value, StandardCharsets.UTF_8)).append("&");
                query.append(key).append("=").append(URLEncoder.encode(value, StandardCharsets.UTF_8)).append("&");
            }
        }

        // Xóa dấu & cuối
        String finalHashData = hashData.substring(0, hashData.length() - 1);
        String queryString = query.substring(0, query.length() - 1);

        // Tính HMAC SHA512
        String secureHash = hmacSHA512(vnp_HashSecret, finalHashData);

        return vnp_Url + "?" + queryString + "&vnp_SecureHashType=SHA512&vnp_SecureHash=" + secureHash;
    }

    // Hàm tính HMAC SHA512
    public static String hmacSHA512(String key, String data) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA512");
        SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA512");
        mac.init(secretKey);
        byte[] hmacData = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));
        StringBuilder hex = new StringBuilder();
        for (byte b : hmacData) {
            hex.append(String.format("%02x", b));
        }
        return hex.toString();
    }

    // // Bỏ hàm sha256 cũ nếu không cần
    // public static String sha256(String input) throws Exception {
    //     // Giữ lại nếu cần dùng chỗ khác
    // }
}