-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 08, 2025 at 04:23 AM
-- Server version: 8.0.40
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `know_sphere`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` bigint NOT NULL,
  `category_image` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_image`, `category_name`) VALUES
(4, NULL, 'Văn Học'),
(5, NULL, 'Kinh Tế'),
(6, NULL, 'Tâm Lý - Kĩ Năng Sống'),
(7, NULL, 'Nuôi Dậy Con'),
(8, NULL, 'Sách Thiếu Nhi'),
(9, NULL, 'Tiểu Sử Hồi Ký'),
(10, NULL, 'Giáo Khoa - Tham Khảo'),
(11, NULL, 'Sách Học Ngoại Ngữ');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `rate_date` datetime DEFAULT NULL,
  `rating` double DEFAULT NULL,
  `order_detail_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `favorite_id` bigint NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`favorite_id`, `product_id`, `user_id`) VALUES
(132, 14, 5),
(133, 50, 5),
(134, 51, 5),
(135, 52, 5);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` bigint NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `user_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `address`, `amount`, `order_date`, `phone`, `status`, `user_id`) VALUES
(31, 'sdf', 163500, '2025-03-19 00:00:00', 'a23423', 3, 5),
(32, 'hcm', 56000, '2025-03-19 00:00:00', '0325689147', 2, 5),
(33, 'hcm', 56000, '2025-03-26 00:00:00', '0325689147', 3, 5),
(34, '31 Đường Làng Tăng Phú', 149000, '2025-03-26 00:00:00', '0372431130', 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` bigint NOT NULL,
  `price` double DEFAULT NULL,
  `quantity` int NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_detail_id`, `price`, `quantity`, `order_id`, `product_id`) VALUES
(69, 94500, 1, 31, 54),
(70, 69000, 1, 31, 87),
(71, 56000, 1, 32, 118),
(72, 56000, 1, 33, 118),
(73, 149000, 1, 34, 73);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` bigint NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `discount` int NOT NULL,
  `entered_date` datetime DEFAULT NULL,
  `price` double NOT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL,
  `status` bit(1) DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `favorite` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `description`, `discount`, `entered_date`, `price`, `product_image`, `product_name`, `quantity`, `status`, `category_id`, `favorite`) VALUES
(14, 'Sự kết hợp màu sắc nhã nhặn giữa hoa và lá cùng cách gói đơn giản đã tạo nên một món quà phù hợp với những ai có gu thẩm mỹ tinh tế, yêu thích sự đơn giản nhưng vẫn đầy tính sang trọng.\r\nSản phẩm bao gồm:\r\nCẩm chướng chùm trắng: 5\r\nHồng Victo: 7\r\nSản phẩm thực nhận có thể khác với hình đại diện trên website (đặc điểm thủ công và tính chất tự nhiên của hàng nông nghiệp)', 0, '2022-01-31 00:00:00', 40000, 'ngdanong.jpg', 'Người Đàn Ông Mang Tên OVE (Tái Bản)', 50, NULL, 4, b'1'),
(50, '', 0, '2025-03-02 00:00:00', 100000, 'dongtubqtvanptacanban-new2025_bia1.jpg', 'Động Từ Bất Quy Tắc Và Ngữ Pháp Tiếng Anh Căn Bản', 10, NULL, 11, b'1'),
(51, '', 0, '2025-03-02 00:00:00', 100000, 'image_194254.jpg', 'Tiếng Anh Cho Nhân Viên Khách Sạn - Sách Bỏ Túi', 10, NULL, 11, b'1'),
(52, '', 0, '2025-03-02 00:00:00', 100000, '9786048556754.jpg', 'English Communication For Your Career Health Science (Kèm CD)', 10, NULL, 11, b'1'),
(53, '', 0, '2025-03-02 00:00:00', 120000, 'e.jpg', 'English For Everyone - Business English - Course Book 2 (CD)', 10, NULL, 11, b'0'),
(54, '', 0, '2025-03-10 00:00:00', 94500, 'tinhyeu.jpg', 'Tình Yêu Vẫn Cháy Trong Đống Tro Tàn', 10, NULL, 4, b'0'),
(55, '', 0, '2025-03-10 00:00:00', 188000, 'b_a-1_4_34.jpg', 'Tổ Điều Tra Đặc Biệt - Tập 1', 45, NULL, 4, b'0'),
(56, '', 0, '2025-03-10 00:00:00', 94000, 'bia_truoc_6.jpg', 'Giữa Hai Nhịp Thở Ngày Đêm', 54, NULL, 4, b'0'),
(57, '', 0, '2025-03-10 00:00:00', 89000, 'b_a-tr_c_49.jpg', 'Khách Sạn Sau Song Sắt', 2, NULL, 4, b'0'),
(58, '', 0, '2025-03-10 00:00:00', 148000, 'b_a-tr_c-thanh-y-dao.jpg', 'Thanh Y Dao', 6, NULL, 4, b'0'),
(59, '', 0, '2025-03-10 00:00:00', 116000, 'z6380241721538_ad6d02e66bd97b028f4bfd7b00d96f80.jpg', 'Nhật Ký Crush Bạn Cùng Bàn - Bản Đặc Biệt - Tặng Kèm Bookmark Bồi Cứng + Poster Lịch 2025 A3', 32, NULL, 4, b'0'),
(60, '', 0, '2025-03-10 00:00:00', 106000, 'untitled-1_2_4.jpg', 'Death In The Clouds - Án Mạng Giữa Không Trung', 64, NULL, 4, b'0'),
(61, '', 0, '2025-03-10 00:00:00', 126000, '8935235243866.jpg', 'Grasshopper - Sát Thủ Báo Thù', 56, NULL, 4, b'0'),
(62, '', 0, '2025-03-10 00:00:00', 108000, '8935235243781.jpg', 'Cuốn Sách Hoang Dã', 35, NULL, 4, b'0'),
(63, '', 0, '2025-03-10 00:00:00', 143000, '8935235243774.jpg', 'Những Thủ Lĩnh Trên Cát', 32, NULL, 4, b'0'),
(64, '', 0, '2025-03-10 00:00:00', 51000, 'image_sach_baby_lucky_b_a_tr_c (1).jpg', 'Baby Three - Lucky Everyday - Lời Chúc May Mắn', 47, NULL, 4, b'0'),
(65, '', 0, '2025-03-10 00:00:00', 108000, 'chemta-bino_bia1_1.jpg', '\"Chém\" Tiếng Anh Không Cần Động Não - Tặng Kèm Bộ Video Luyện Nghe-Nói + Sổ Học Từ Vựng', 7, NULL, 11, b'0'),
(66, '', 0, '2025-03-10 00:00:00', 115000, '8935246945001.jpg', 'Destination B1 - Grammar And Vocabulary With Answer Key (Tái Bản 2024)', 65, NULL, 11, b'0'),
(67, '', 0, '2025-03-10 00:00:00', 47000, '2023_02_20_11_54_17_1-390x510.jpg', 'Giáo Trình Chuẩn YCT 1 - Sách Bài Tập', 54, NULL, 11, b'0'),
(68, '', 0, '2025-03-10 00:00:00', 5000, 'image_195509_1_32135.jpg', 'Giúp Trí Nhớ Ngữ Pháp Tiếng Anh Và Động Từ Bất Quy Tắc', 8, NULL, 11, b'0'),
(69, '', 0, '2025-03-10 00:00:00', 45000, '24df17f9bab58ba053c6c08c3af2f470_1.jpg', 'Tự Học 2000 Từ Vựng Tiếng Anh Theo Chủ Đề (Tái Bản)', 6, NULL, 11, b'0'),
(70, '', 0, '2025-03-10 00:00:00', 78000, 'giaithichnguphapta-tb2024_bia1.jpg', 'Giải Thích Ngữ Pháp Tiếng Anh (Tái Bản 2024)', 65, NULL, 11, b'0'),
(71, '', 0, '2025-03-10 00:00:00', 124000, 'unnamed_1.jpg', 'Lộ Trình Học Tiếng Anh Cho Người Mất Gốc - The English Journey', 36, NULL, 11, b'0'),
(72, '', 0, '2025-03-10 00:00:00', 128000, '2020_04_09_16_28_02_1-390x510.jpg', 'Essential Words For The Toeic 6th (Tái Bản 2019)', 9, NULL, 11, b'0'),
(73, '', 0, '2025-03-10 00:00:00', 149000, '9786047787616.jpg', 'Kế Toán Vỉa Hè - Thực Hành Báo Cáo Tài Chính Căn Bản Từ Quầy Bán Nước Chanh', 7, NULL, 5, b'0'),
(74, '', 0, '2025-03-05 00:00:00', 141000, '8935235238978.jpg', 'MBA Bằng Hình - The Visual MBA', 73, NULL, 5, b'0'),
(75, '', 0, '2025-02-27 00:00:00', 123000, 'image_195509_1_32101.jpg', '48 Nguyên Tắc Chủ Chốt Của Quyền Lực (Tái Bản 2020)', 40, NULL, 5, b'0'),
(76, '', 0, '2025-02-25 00:00:00', 83000, 'nghigiaulamgiau_110k-01_bia-1.jpg', 'Nghĩ Giàu & Làm Giàu (Tái Bản 2020)', 12, NULL, 5, b'0'),
(77, '', 0, '2025-03-12 00:00:00', 156000, 'ai-5.0-bia-1.jpg', 'AI 5.0 - Nhanh Hơn, Dễ Hơn, Rẻ Hơn, Chính Xác Hơn', 23, NULL, 5, b'0'),
(78, '', 0, '2025-02-25 00:00:00', 78000, 'image_188995_1_1.jpg', 'Bí Mật Tư Duy Triệu Phú (Tái Bản 2021)', 32, NULL, 5, b'0'),
(79, '', 0, '2025-02-28 00:00:00', 99000, 'bia-truoc-chien-tranh-tien-te-phan-1-1.jpg', 'Chiến Tranh Tiền Tệ - Phần 1 - Ai Thực Sự Là Người Giàu Nhất Thế Giới? (Tái bản 2022)', 34, NULL, 5, b'0'),
(80, '', 0, '2025-02-23 00:00:00', 101000, 'nxbtre_full_09462021_024609.jpg', 'Từ Tốt Đến Vĩ Đại - Jim Collins (Tái Bản 2021)', 12, NULL, 5, b'0'),
(81, '', 0, '2025-02-27 00:00:00', 98000, 'image_195509_1_49918.jpg', 'D. Trump - Nghệ Thuật Đàm Phán (Tái Bản 2020)', 12, NULL, 5, b'0'),
(82, '', 0, '2025-03-01 00:00:00', 78000, '2023_07_12_09_35_57_1-390x510.jpg', 'Biến Mọi Thứ Thành Tiền - Make Money', 25, NULL, 5, b'0'),
(83, '', 0, '2025-02-26 00:00:00', 50000, '2024_01_20_12_47_45_1-390x510.jpg', 'Người Giàu Có Nhất Thành Babylon', 36, NULL, 5, b'0'),
(84, '', 0, '2025-02-27 00:00:00', 97000, 'tien-de-ra-tien-1.jpg', 'Tiền Đẻ Ra Tiền - Đầu Tư Tài Chính Thông Minh (Tái Bản)', 34, NULL, 5, b'0'),
(85, '', 0, '2025-02-28 00:00:00', 141000, '_2024_-thay_doi_ti_hon_hieu_qua_bat_ngo-tb8-02.jpg', 'Atomic Habits - Thay Đổi Tí Hon Hiệu Quả Bất Ngờ (Tái Bản 2023)', 6, NULL, 6, b'0'),
(86, '', 0, '2025-03-27 00:00:00', 62000, 'b_a-tr_c-manifest.jpg', 'Manifest - 7 Bước Để Thay Đổi Cuộc Đời Bạn Mãi Mãi', 9, NULL, 6, b'0'),
(87, '', 0, '2025-03-13 00:00:00', 69000, '8935235243163.jpg', 'Khi Mọi Điều Không Như Ý', 6, NULL, 6, b'0'),
(88, '', 0, '2025-03-09 00:00:00', 99000, '9786044009674.jpg', 'Con Đường Chẳng Mấy Ai Đi', 8, NULL, 6, b'0'),
(89, '', 0, '2025-03-04 00:00:00', 65000, '2022_10_21_16_49_32_1-390x510.jpg', 'Tư Duy Ngược', 65, NULL, 6, b'0'),
(90, '', 0, '2025-02-25 00:00:00', 66000, '8936225390027.jpg', 'Stop Overthinking - Sống Tự Do, Không Âu Lo - 7 Bước Loại Bỏ Suy Nghĩ Tiêu Cực Và Bắt Đầu Suy Nghĩ Tích Cực', 12, NULL, 6, b'0'),
(91, '', 0, '2025-03-06 00:00:00', 74000, '2022_06_03_15_27_44_1-390x510.jpg', 'Khéo Ăn Nói Sẽ Có Được Thiên Hạ (Tái Bản 2022)', 16, NULL, 6, b'0'),
(92, '', 0, '2025-03-04 00:00:00', 65000, '2023_02_24_11_34_47_1-390x510.jpg', '30 Tuổi - Mọi Thứ Chỉ Mới Bắt Đầu', 56, NULL, 6, b'0'),
(93, '', 0, '2025-03-03 00:00:00', 126000, 'z4118763446785_cf4bc22d353b065bbb37e686de1f9207.jpg', 'Hiểu Về Trái Tim (Tái Bản 2023)', 35, NULL, 6, b'0'),
(94, '', 0, '2025-03-10 00:00:00', 166000, 'image_244718_1_4401.jpg', 'Flow - Dòng Chảy', 5, NULL, 6, b'0'),
(95, '', 0, '2025-03-05 00:00:00', 104000, '4ceb6ba3bd81614df8ff4c1411b11f59.jpg', 'Yêu Những Điều Không Hoàn Hảo', 36, NULL, 6, b'0'),
(96, '', 0, '2025-02-28 00:00:00', 95000, 'image_234642.jpg', 'Làm Ra Làm, Chơi Ra Chơi (Tái Bản 2021)', 34, NULL, 6, b'0'),
(97, '', 0, '2025-03-05 00:00:00', 73000, 'image_195509_1_33297.jpg', 'Chào Con! Ba Mẹ Đã Sẵn Sàng (Tái Bản 2020)', 32, NULL, 7, b'0'),
(98, '', 0, '2025-03-13 00:00:00', 90000, '8935235235168.jpg', 'Để Con Được Ốm (Tái Bản 2022)', 34, NULL, 7, b'0'),
(99, '', 0, '2025-03-03 00:00:00', 51000, '2023_03_23_16_29_22_1-390x510.jpg', 'Phương Pháp Giáo Dục Con Của Người Do Thái - Giúp Trẻ Tự Tin Bước Vào Cuộc Sống', 42, NULL, 7, b'0'),
(100, '', 0, '2025-03-04 00:00:00', 63000, 'thai_giao_theo_chuyen_gia___280_ngay___moi_ngay_doc_mot_trang_tai_ban_2021_1_2022_03_08_15_56_09.png', 'Thai Giáo Theo Chuyên Gia - 280 Ngày - Mỗi Ngày Đọc Một Trang (Tái Bản 2021)', 42, NULL, 7, b'0'),
(101, '', 0, '2025-02-26 00:00:00', 149000, '2021_06_04_14_33_33_1-390x510.jpg', 'Lần Đầu Làm Mẹ', 35, NULL, 7, b'0'),
(102, '', 0, '2025-02-26 00:00:00', 47000, 'z3201911566454_951a32cff4e1a7e99d1d6b12fd341292.jpg', 'Cẩm Nang Con Gái (Tái Bản 2021)', 6, NULL, 7, b'0'),
(103, '', 0, '2025-02-28 00:00:00', 105000, '8935235236219.jpg', 'Tận Hưởng Hành Trình Nuôi Con Sữa Mẹ', 4, NULL, 7, b'0'),
(104, '', 0, '2025-02-25 00:00:00', 86000, 'image_241036.jpg', 'Nuôi Con Không Phải Là Cuộc Chiến 1 - Chào Con - Em Bé Sơ Sinh (Tái Bản 2021)', 7, NULL, 7, b'0'),
(105, '', 0, '2025-03-10 00:00:00', 96000, 'nuoi-con-khong-phai-cuoc-chien_bia-1-.jpg', 'Nuôi Con Không Phải Là Cuộc Chiến (Tái Bản 2023)', 3, NULL, 7, b'0'),
(106, '', 0, '2025-03-06 00:00:00', 45000, '8935210307859.jpg', 'Mười Phút Mỗi Ngày Thì Thầm Với Con - Những Câu Chuyện Thai Giáo Hay Nhất Thế Giới', 43, NULL, 7, b'0'),
(107, '', 0, '2025-03-14 00:00:00', 16000, '8935235236455.jpg', 'Cuốn Sách Bạn Ước Cha Mẹ Mình Từng Đọc (Và Con Bạn Sẽ Vui Nếu Bạn Đọc Nó)', 7, NULL, 7, b'0'),
(108, '', 0, '2025-03-06 00:00:00', 52000, 'image_189688.jpg', 'Kinh Nghiệm Từ Nước Nhật - 43 Kĩ Năng Kiểm Soát Tức Giận (Dành Cho Trẻ Em)', 42, NULL, 7, b'0'),
(109, '', 0, '2025-02-27 00:00:00', 112000, '8935244874389.jpg', 'Lược Sử Nước Việt Bằng Tranh (Tái Bản 2024)', 42, NULL, 8, b'0'),
(110, '', 0, '2025-02-26 00:00:00', 51000, 'lhmn-10thanniversary-cover-front-1.jpg', 'Lớp Học Mật Ngữ - Tập Đặc Biệt Kỷ Niệm 10 Năm - Phần 2 - Thiệp Mời \"Dự Tiệc Bên Cồn\" Đầu Năm - Tặng Kèm Thẻ Đeo Card Bo Góc Ngẫu Nhiên', 56, NULL, 8, b'0'),
(111, '', 0, '2025-03-11 00:00:00', 57000, '8935244826487.jpg', 'Búp Sen Xanh (Tái Bản 2020)', 45, NULL, 8, b'0'),
(112, '', 0, '2025-03-10 00:00:00', 27000, '2023_04_05_15_26_37_1-390x510.jpg', 'Giáo Dục Đầu Đời Cho Trẻ - Những Bài Học Tự Bảo Vệ Bản Thân - Không Được Chạm Vào Vùng Riêng Tư Của Tớ', 4, NULL, 8, b'0'),
(113, '', 0, '2025-02-26 00:00:00', 20000, '2023_03_13_15_34_17_1-390x510.jpg', 'EQ - IQ Giúp Trẻ Làm Chủ Cảm Xúc - Cáu Giận', 7, NULL, 8, b'0'),
(114, '', 0, '2025-02-26 00:00:00', 64000, 'image_195509_1_46272.jpg', '100 Kỹ Năng Sinh Tồn', 42, NULL, 8, b'0'),
(115, '', 0, '2025-03-05 00:00:00', 18000, '8935212361910.jpg', 'Những Câu Chuyện Tò Mò Của Bé - Con Có Thể Đánh Trả Khi Bị Bắt Nạt Không?', 14, NULL, 8, b'0'),
(116, '', 0, '2025-03-06 00:00:00', 56000, 'image_187162.jpg', 'Tuổi Thơ Dữ Dội - Tập 1 (Tái Bản 2019)', 15, NULL, 8, b'0'),
(117, '', 0, '2025-03-05 00:00:00', 55000, 'bia-1_6_6.jpg', 'Hoàng Tử Bé (Song Ngữ Việt-Anh)', 17, NULL, 8, b'0'),
(118, '', 0, '2025-03-14 00:00:00', 56000, 'image_187163.jpg', 'Tuổi Thơ Dữ Dội - Tập 2 (Tái Bản 2019)', 16, NULL, 8, b'0'),
(119, '', 0, '2025-03-06 00:00:00', 161000, 'image_229833.jpg', 'Tiểu Sử Các Quốc Gia Qua Góc Nhìn Lầy Lội', 16, NULL, 8, b'0'),
(120, '', 0, '2025-02-26 00:00:00', 16000, '2022_06_21_10_55_17_1-390x510.jpg', 'Kỹ Năng Sống Đầu Đời Cho Bé - Quy Tắc Ứng Xử Trên Bàn Ăn', 14, NULL, 8, b'0'),
(121, '', 0, '2025-03-05 00:00:00', 98000, '8935235241015.jpg', 'Thư Cho Em', 16, NULL, 9, b'0'),
(123, '', 0, '2025-02-27 00:00:00', 135000, '8935235236547.jpg', 'Tự Truyện Của Một Yogi (Tái Bản)', 19, NULL, 9, b'0'),
(124, '', 0, '2025-03-07 00:00:00', 81000, 'image_220964.jpg', 'Khi Hơi Thở Hóa Thinh Không (Tái Bản 2020)', 16, NULL, 9, b'0'),
(125, '', 0, '2025-03-06 00:00:00', 129000, '8935086855737.jpg', 'Điệp Viên Hoàn Hảo X6 - Phạm Xuân Ẩn', 14, NULL, 9, b'0'),
(126, '', 0, '2025-03-05 00:00:00', 202000, 'nxbtre_full_23312025_043116.jpg', 'Source Code - Mã Nguồn - Khởi Đầu Của Tôi', 15, NULL, 9, b'0'),
(127, '', 0, '2025-03-06 00:00:00', 60000, 'image_244296.jpg', 'Tôi Nói Gì Khi Nói Về Chạy Bộ (Tái Bản 2021)', 16, NULL, 9, b'0'),
(128, '', 0, '2025-03-14 00:00:00', 122000, '8935086855591.jpg', 'Chân Trần Chí Thép (Tái Bản 2022)', 16, NULL, 9, b'0'),
(129, '', 0, '2025-03-05 00:00:00', 122000, 'image_216008.jpg', 'Putin - Logic Của Quyền Lực - Putin: Innenansichten Der Macht', 32, NULL, 9, b'0'),
(130, '', 0, '2025-02-26 00:00:00', 93000, '8935086856321_1.jpg', 'Tự Truyện Nguyễn Bích Lan - Không Gục Ngã (Tái Bản)', 14, NULL, 9, b'0'),
(131, '', 0, '2025-03-06 00:00:00', 127000, 'b_a-1-s_ng-m_o-hi_m.jpg', 'Sống Mạo Hiểm Một Cách Cẩn Thận', 16, NULL, 9, b'0'),
(132, '', 0, '2025-03-06 00:00:00', 513000, '514083751a66972514d29e8b29a03e6f.jpg', 'Hòn Tuyết Lăn - Những Triết Lý Sống Và Đầu Tư Vượt Thời Gian Của Warren Buffett (Tái Bản 2024)', 16, NULL, 9, b'0'),
(133, '', 0, '2025-03-05 00:00:00', 41000, 'image_237520.jpg', 'Kể Chuyện Cuộc Đời Các Thiên Tài: Albert Einstein - Tuổi Thơ Gian Khó Và Cuộc Đời Khoa Học Vĩ Đại', 16, NULL, 9, b'0'),
(134, '', 0, '2025-03-01 00:00:00', 199000, 'untitled-1_217.jpg', '25 Đề Ôn Thi Đánh Giá Năng Lực Đại Học Quốc Gia TP. HCM', 16, NULL, 10, b'0'),
(135, '', 0, '2025-03-05 00:00:00', 159000, '9786044065526.jpg', '50 Đề Minh Họa Tốt Nghiệp THPT 2025 - Môn Toán', 16, NULL, 10, b'0'),
(136, '', 0, '2025-03-07 00:00:00', 159000, '9786044067179.jpg', '50 Đề Minh Họa Tốt Nghiệp THPT 2025 - Môn Tiếng Anh', 19, NULL, 10, b'0'),
(137, '', 0, '2025-03-07 00:00:00', 18000, '9786040350831.jpg', 'Ngữ Văn 11 - Tập 2 (Kết Nối Tri Thức) (Chuẩn)', 17, NULL, 10, b'0'),
(138, '', 0, '2025-02-28 00:00:00', 24000, '9786040288165_1.jpg', 'Tiếng Việt 1 - Tập 2 (Chân Trời Sáng Tạo) (Chuẩn)', 16, NULL, 10, b'0'),
(139, '', 0, '2025-02-27 00:00:00', 5000, 'image_230593.jpg', ' Chính sách ưu đãi của Fahasa Thời gian giao hàng :  Giao nhanh và uy tín Chính sách đổi trả :  Đổi trả miễn phí toàn quốc Chính sách khách sỉ :  Ưu đãi khi mua số lượng lớn Bảng Tóm Tắt Toán Tiểu Học', 13, NULL, 10, b'0'),
(140, '', 0, '2025-03-07 00:00:00', 13000, '9786040287571_1.jpg', 'Vở Bài Tập Tiếng Việt 1 - Tập 2 (Chân Trời Sáng Tạo) (Chuẩn)', 18, NULL, 10, b'0'),
(141, '', 0, '2025-02-28 00:00:00', 18000, '9786040392275.jpg', 'Tiếng Việt 5 - Tập 2 (Kết Nối) (Chuẩn)', 16, NULL, 10, b'0'),
(142, '', 0, '2025-02-27 00:00:00', 42000, '9786040433268.jpg', 'Hướng Dẫn Ôn Thi Vào Lớp 10 - Môn Ngữ Văn (Theo Định Hướng Phát Triển Năng Lực)', 15, NULL, 10, b'0'),
(143, '', 0, '2025-03-13 00:00:00', 111100, '8935236436212.jpg', '50 Đề Thực Chiến Luyện Thi Tiếng Anh Vào Lớp 10 (Có Đáp Án)', 10, NULL, 10, b'0'),
(144, '', 0, '2025-03-07 00:00:00', 8000, '8936036316346.jpg', 'Bảng Tuần Hoàn Các Nguyên Tố Hóa Học Theo Chương Trình Giáo Dục Phổ Thông Mới', 12, NULL, 10, b'0'),
(145, '', 0, '2025-02-27 00:00:00', 55000, '9786040433251.jpg', 'Hướng Dẫn Ôn Thi Vào Lớp 10 - Môn Toán (Theo Định Hướng Phát Triển Năng Lực)', 16, NULL, 10, b'0');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` bigint NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(5, 'ROLE_ADMIN'),
(6, 'ROLE_USER'),
(7, 'ROLE_USER'),
(8, 'ROLE_USER'),
(10, 'ROLE_ADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` bigint NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `register_date` date DEFAULT NULL,
  `status` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `avatar`, `email`, `name`, `password`, `register_date`, `status`) VALUES
(4, 'user.png', 'knowsphere@gmail.com', 'Admin Know Sphere', '$2a$10$I3kJJZf.SOSy18zYcURwLunpxFnn3PPQByCTgYy4F3EP6vvwYptO.', '2025-03-05', b'1'),
(5, 'user.png', 'demo@gmail.com', 'user1', '$2a$10$I3kJJZf.SOSy18zYcURwLunpxFnn3PPQByCTgYy4F3EP6vvwYptO.', '2025-02-17', b'1'),
(6, 'user.png', 'demo2@gmail.com', 'user2', '$2a$10$PUWkbGnEa1OdKmxiQfvw/u3oh3I09nGG6zVHmGLxgigSJC2tCz4Ta', '2025-02-17', b'1'),
(7, 'user.png', 'demo3@gmail.com', 'user3', '$2a$10$ePg/cUabs6dShg4hC4Buv.QaVFx6VqqBUSlmQBntalEOAaWCfY2Hi', '2025-02-17', b'1'),
(9, 'user.png', '1@gmail.com', '1', '$2a$10$I3kJJZf.SOSy18zYcURwLunpxFnn3PPQByCTgYy4F3EP6vvwYptO.', '2025-03-02', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users_roles`
--

INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(9, 10);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKfwepd0s8syqc9s06xnqa7mdwf` (`order_detail_id`),
  ADD KEY `FK6uv0qku8gsu6x1r2jkrtqwjtn` (`product_id`),
  ADD KEY `FKqi14bvepnwtjbbaxm7m4v44yg` (`user_id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`favorite_id`),
  ADD KEY `FK6sgu5npe8ug4o42bf9j71x20c` (`product_id`),
  ADD KEY `FK1uphh0glinnprjknyl68k1hw1` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `FKel9kyl84ego2otj2accfd8mr7` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`),
  ADD KEY `FK4q98utpd73imf4yhttm3w0eax` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `UKob8kqyqqgmefl0aco34akdtpe` (`email`),
  ADD UNIQUE KEY `UKoshmjvr6wht0bg9oivn75aajr` (`email`);

--
-- Indexes for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  ADD KEY `FKgd3iendaoyh04b95ykqise6qh` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `favorite_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=146;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `FK6uv0qku8gsu6x1r2jkrtqwjtn` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKfwepd0s8syqc9s06xnqa7mdwf` FOREIGN KEY (`order_detail_id`) REFERENCES `order_details` (`order_detail_id`),
  ADD CONSTRAINT `FKqi14bvepnwtjbbaxm7m4v44yg` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `FK1uphh0glinnprjknyl68k1hw1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `FK6sgu5npe8ug4o42bf9j71x20c` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FKel9kyl84ego2otj2accfd8mr7` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `FK4q98utpd73imf4yhttm3w0eax` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `users_roles`
--
ALTER TABLE `users_roles`
  ADD CONSTRAINT `FKgd3iendaoyh04b95ykqise6qh` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
