# Know_Sphere

![Know_Sphere Logo](upload/images/logo.png)

## Giới thiệu

Know_Sphere là một nền tảng thương mại điện tử chuyên cung cấp sách và tài liệu học tập. Dự án được phát triển nhằm mục đích tạo ra một không gian mua sắm trực tuyến thuận tiện cho người dùng, đặc biệt là học sinh, sinh viên và những người có nhu cầu học tập.

## Tính năng chính

- **Đăng ký và đăng nhập**: Người dùng có thể tạo tài khoản và đăng nhập vào hệ thống
- **Duyệt sản phẩm**: Xem danh sách sản phẩm, tìm kiếm và lọc theo danh mục
- **Giỏ hàng**: Thêm sản phẩm vào giỏ hàng, cập nhật số lượng và xóa sản phẩm
- **Thanh toán**: Hỗ trợ nhiều phương thức thanh toán như COD, VNPay và PayPal
- **Quản lý đơn hàng**: Theo dõi trạng thái đơn hàng và xem lịch sử mua hàng
- **Quản lý sản phẩm**: Admin có thể thêm, sửa, xóa sản phẩm và quản lý danh mục
- **Quản lý người dùng**: Admin có thể quản lý tài khoản người dùng

## Công nghệ sử dụng

- **Backend**: Spring Boot, Spring MVC, Spring Data JPA
- **Frontend**: Thymeleaf, HTML, CSS, JavaScript, Bootstrap
- **Cơ sở dữ liệu**: MySQL
- **Thanh toán**: VNPay, PayPal API
- **Gửi email**: JavaMail API

## Cài đặt và chạy dự án

### Yêu cầu hệ thống

- JDK 11 trở lên
- Maven 3.6 trở lên
- MySQL 5.7 trở lên

### Các bước cài đặt

1. Clone repository:
```
git clone https://github.com/phn/BookStore.git
cd BookStore
```

2. Cấu hình cơ sở dữ liệu trong file `src/main/resources/application.properties`:
```
spring.datasource.url=jdbc:mysql://localhost:3306/know_sphere
spring.datasource.username=your_username
spring.datasource.password=your_password
```

3. Cấu hình thông tin thanh toán VNPay và PayPal trong file `application.properties`

4. Build dự án:
```
mvn clean install
```

5. Chạy dự án:
```
mvn spring-boot:run
```

6. Truy cập ứng dụng tại: `http://localhost:9090`

## Cấu trúc dự án

```
Know_Sphere/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── vn/fs/
│   │   │       ├── config/         # Cấu hình ứng dụng
│   │   │       ├── controller/     # Xử lý request
│   │   │       ├── entities/       # Các entity
│   │   │       ├── repository/     # Repository để truy vấn dữ liệu
│   │   │       ├── service/        # Logic nghiệp vụ
│   │   │       └── util/           # Các tiện ích
│   │   └── resources/
│   │       ├── static/             # CSS, JS, images
│   │       ├── templates/          # Thymeleaf templates
│   │       └── application.properties
│   └── test/                       # Unit tests
├── upload/                         # Thư mục lưu trữ file upload
├── pom.xml                         # Quản lý dependencies
└── README.md
```

## Thành viên dự án

| Họ và tên | MSSV | Vai trò |
|-----------|------|---------|
| Phạm Hoài Nam | 2180607217 | Trưởng nhóm, Backend Developer |
| Trang Hạnh Nhi | 2180608398 | Frontend Developer |
| Nguyễn Đỗ Hoàng Nhật Linh | 2180608880 | Full-stack Developer |

## Liên hệ

Nếu bạn có bất kỳ câu hỏi hoặc góp ý nào về dự án, vui lòng liên hệ:

- Email: phamnam1449@gmail.com
- GitHub: [phn47](https://phn47.github.io/profile/)

## Giấy phép

Dự án này được phân phối dưới giấy phép MIT. Xem file `LICENSE` để biết thêm chi tiết.