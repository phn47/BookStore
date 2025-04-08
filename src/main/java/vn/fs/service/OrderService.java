
package vn.fs.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.fs.entities.Order;
import vn.fs.repository.OrderRepository;
import vn.fs.repository.OrderRepository2;

@Service
public class OrderService {

    @Autowired
    private OrderRepository2 orderRepository;

    public Order saveOrder(Order order) {
        return orderRepository.save(order);
    }

    public Order getOrderById(Long orderId) {
        return orderRepository.findByOrderId(orderId);
    }
}