package vn.fs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import vn.fs.entities.Order;

public interface OrderRepository2 extends JpaRepository<Order, Long> {

    Order findByOrderId(Long orderId);

}