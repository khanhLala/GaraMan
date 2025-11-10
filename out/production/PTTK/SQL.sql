-- =================================================================
-- TẠO CƠ SỞ DỮ LIỆU
-- =================================================================
CREATE DATABASE IF NOT EXISTS `pttk` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `pttk`;


-- =================================================================
-- TẠO CÁC BẢNG CHÍNH (KHÔNG PHỤ THUỘC)
-- =================================================================

-- Bảng `tblMember`: Nền tảng cho tất cả người dùng
CREATE TABLE IF NOT EXISTS `tblMember` (
  `id` INT NOT NULL AUTO_INCREMENT UNIQUE,
  `username` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `phone` VARCHAR(255) NOT NULL UNIQUE,
  `address` VARCHAR(255) NOT NULL,
  `dob` TIMESTAMP NULL,
  PRIMARY KEY (`id`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblScheduleTime`: Khung thời gian cho lịch hẹn
CREATE TABLE IF NOT EXISTS `tblScheduleTime` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `start` TIME NOT NULL,
  `end` TIME NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblService`: Các dịch vụ cung cấp
CREATE TABLE IF NOT EXISTS `tblService` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `price` DOUBLE NOT NULL,
  `description` VARCHAR(255) NULL,
  `status` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblProduct`: Các sản phẩm, phụ tùng
CREATE TABLE IF NOT EXISTS `tblProduct` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `price` DOUBLE NOT NULL,
  `description` VARCHAR(255) NULL,
  `status` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblProvider`: Nhà cung cấp
CREATE TABLE IF NOT EXISTS `tblProvider` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL,
  `phone` VARCHAR(255) NULL,
  `status` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- =================================================================
-- TẠO CÁC BẢNG VAI TRÒ VÀ NGƯỜI DÙNG
-- =================================================================

-- Bảng `tblCustomer`: Khách hàng, kế thừa từ Member (PK = tblMemberId)
CREATE TABLE IF NOT EXISTS `tblCustomer` (
  `tblMemberId` INT NOT NULL,
  `customerId` INT NOT NULL UNIQUE,
  PRIMARY KEY (`tblMemberId`),
  CONSTRAINT `fk_Customer_Member`
    FOREIGN KEY (`tblMemberId`)
    REFERENCES `tblMember` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblStaff`: Nhân viên, kế thừa từ Member
-- Cột `tblManagerId` sẽ được thêm khóa ngoại sau khi bảng tblManager được tạo
CREATE TABLE IF NOT EXISTS `tblStaff` (
  `tblMemberId` INT NOT NULL,
  `position` VARCHAR(255) NULL,
  `status` VARCHAR(255) NULL,
  PRIMARY KEY (`tblMemberId`),
  CONSTRAINT `fk_Staff_Member`
    FOREIGN KEY (`tblMemberId`)
    REFERENCES `tblMember` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblManager`: Quản lý, là một vai trò của Staff
CREATE TABLE IF NOT EXISTS `tblManager` (
  `tblStaffId` INT NOT NULL,
  PRIMARY KEY (`tblStaffId`),
  CONSTRAINT `fk_Manager_Staff`
    FOREIGN KEY (`tblStaffId`)
    REFERENCES `tblStaff` (`tblMemberId`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblTechnician`: Kỹ thuật viên, là một vai trò của Staff
CREATE TABLE IF NOT EXISTS `tblTechnician` (
  `tblStaffId` INT NOT NULL,
  PRIMARY KEY (`tblStaffId`),
  CONSTRAINT `fk_Technician_Staff`
    FOREIGN KEY (`tblStaffId`)
    REFERENCES `tblStaff` (`tblMemberId`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblSales`: Nhân viên kinh doanh, là một vai trò của Staff
CREATE TABLE IF NOT EXISTS `tblSales` (
  `tblStaffId` INT NOT NULL,
  PRIMARY KEY (`tblStaffId`),
  CONSTRAINT `fk_Sales_Staff`
    FOREIGN KEY (`tblStaffId`)
    REFERENCES `tblStaff` (`tblMemberId`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblWarehouseman`: Nhân viên kho, là một vai trò của Staff
CREATE TABLE IF NOT EXISTS `tblWarehouseman` (
  `tblStaffId` INT NOT NULL,
  PRIMARY KEY (`tblStaffId`),
  CONSTRAINT `fk_Warehouseman_Staff`
    FOREIGN KEY (`tblStaffId`)
    REFERENCES `tblStaff` (`tblMemberId`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- =================================================================
-- TẠO CÁC BẢNG GIAO DỊCH VÀ CHI TIẾT
-- =================================================================

-- Bảng `tblAppointment`: Lịch hẹn
CREATE TABLE IF NOT EXISTS `tblAppointment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tblScheduleTimeId` INT NOT NULL,
  `tblCustomerId` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(255) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Appointment_ScheduleTime`
    FOREIGN KEY (`tblScheduleTimeId`)
    REFERENCES `tblScheduleTime` (`id`),
  CONSTRAINT `fk_Appointment_Customer`
    FOREIGN KEY (`tblCustomerId`)
    REFERENCES `tblCustomer` (`tblMemberId`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblInvoice`: Hóa đơn bán hàng
CREATE TABLE IF NOT EXISTS `tblInvoice` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paymentStatus` VARCHAR(255) NULL,
  `tblSalesId` INT NOT NULL,
  `tblCustomerId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Invoice_Sales`
    FOREIGN KEY (`tblSalesId`)
    REFERENCES `tblSales` (`tblStaffId`),
  CONSTRAINT `fk_Invoice_Customer`
    FOREIGN KEY (`tblCustomerId`)
    REFERENCES `tblCustomer` (`tblMemberId`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblInboundInvoice`: Hóa đơn nhập hàng
CREATE TABLE IF NOT EXISTS `tblInboundInvoice` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `createAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paymentStatus` VARCHAR(255) NULL,
  `tblWarehousemanId` INT NOT NULL,
  `tblProviderId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_InboundInvoice_Warehouseman`
    FOREIGN KEY (`tblWarehousemanId`)
    REFERENCES `tblWarehouseman` (`tblStaffId`),
  CONSTRAINT `fk_InboundInvoice_Provider`
    FOREIGN KEY (`tblProviderId`)
    REFERENCES `tblProvider` (`id`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblAssignment`: Phân công công việc
CREATE TABLE IF NOT EXISTS `tblAssignment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `note` VARCHAR(255) NULL,
  `tblTechnicianId` INT NOT NULL,
  `tblInvoiceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Assignment_Technician`
    FOREIGN KEY (`tblTechnicianId`)
    REFERENCES `tblTechnician` (`tblStaffId`),
  CONSTRAINT `fk_Assignment_Invoice`
    FOREIGN KEY (`tblInvoiceId`)
    REFERENCES `tblInvoice` (`id`)
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblServiceInvoiceDetail`: Chi tiết dịch vụ trên hóa đơn
CREATE TABLE IF NOT EXISTS `tblServiceInvoiceDetail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sellprice` DOUBLE NOT NULL,
  `quantity` INT NOT NULL,
  `tblServiceId` INT NOT NULL,
  `tblInvoiceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ServiceDetail_Service`
    FOREIGN KEY (`tblServiceId`)
    REFERENCES `tblService` (`id`),
  CONSTRAINT `fk_ServiceDetail_Invoice`
    FOREIGN KEY (`tblInvoiceId`)
    REFERENCES `tblInvoice` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblProductInvoiceDetail`: Chi tiết sản phẩm trên hóa đơn
CREATE TABLE IF NOT EXISTS `tblProductInvoiceDetail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sellprice` DOUBLE NOT NULL,
  `quantity` INT NOT NULL,
  `tblProductId` INT NOT NULL,
  `tblInvoiceId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ProductDetail_Product`
    FOREIGN KEY (`tblProductId`)
    REFERENCES `tblProduct` (`id`),
  CONSTRAINT `fk_ProductDetail_Invoice`
    FOREIGN KEY (`tblInvoiceId`)
    REFERENCES `tblInvoice` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- ĐÃ CHECK OK BY KHÁNH --

-- Bảng `tblInboundInvoiceDetail`: Chi tiết hóa đơn nhập
CREATE TABLE IF NOT EXISTS `tblInboundInvoiceDetail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cost` DOUBLE NOT NULL,
  `quantity` INT NOT NULL,
  `tblInboundInvoiceId` INT NOT NULL,
  `tblProductId` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_InboundDetail_InboundInvoice`
    FOREIGN KEY (`tblInboundInvoiceId`)
    REFERENCES `tblInboundInvoice` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_InboundDetail_Product`
    FOREIGN KEY (`tblProductId`)
    REFERENCES `tblProduct` (`id`)
);


-- =================================================================
-- DỮ LIỆU MẪU (theo đúng thứ tự khóa ngoại)
-- =================================================================

-- Member (người dùng nền tảng)
INSERT INTO `tblMember` (`id`, `username`, `password`, `name`, `email`, `phone`, `address`, `dob`) VALUES
  (1, 'kh1', '123456', N'Nguyễn Văn A', 'a@example.com', '0901000001', N'12 Nguyễn Trãi, Q.1, TP.HCM', '1990-01-15 00:00:00'),
  (2, 'kh2', '123456', N'Trần Thị B', 'b@example.com', '0901000002', N'45 Lê Lợi, Q.1, TP.HCM', '1992-02-20 00:00:00'),
  (3, 'st1', '123456', N'Lê Văn Nhân Viên 1', 'st1@example.com', '0902000003', N'101 Hai Bà Trưng, Q.3, TP.HCM', '1988-03-10 00:00:00'),
  (4, 'st2', '123456', N'Phạm Thị Nhân Viên 2', 'st2@example.com', '0902000004', N'88 Trần Hưng Đạo, Q.5, TP.HCM', '1989-04-12 00:00:00'),
  (5, 'mgr', '123456', N'Hoàng Quản Lý', 'mgr@example.com', '0903000005', N'22 Nguyễn Huệ, Q.1, TP.HCM', '1985-05-05 00:00:00'),
  (6, 'sales', '123456', N'Nguyễn Bán Hàng', 'sales@example.com', '0904000006', N'55 Đồng Khởi, Q.1, TP.HCM', '1991-06-06 00:00:00'),
  (7, 'tech', '123456', N'Võ Kỹ Thuật', 'tech@example.com', '0905000007', N'77 Lý Thường Kiệt, Q.10, TP.HCM', '1993-07-07 00:00:00'),
  (8, 'wh', '123456', N'Bùi Kho', 'wh@example.com', '0906000008', N'66 Cách Mạng Tháng 8, Q.3, TP.HCM', '1987-08-08 00:00:00');

-- Customer (1-1 với Member)
INSERT INTO `tblCustomer` (`tblMemberId`, `customerId`) VALUES (1, 1001), (2, 1002);

-- Staff (1-1 với Member)
INSERT INTO `tblStaff` (`tblMemberId`, `position`, `status`) VALUES
  (3, N'Nhân viên', 'ACTIVE'),
  (4, N'Nhân viên', 'ACTIVE'),
  (5, N'Quản lý', 'ACTIVE'),
  (6, N'Kinh doanh', 'ACTIVE'),
  (7, N'Kỹ thuật', 'ACTIVE'),
  (8, N'Kho', 'ACTIVE');

-- Manager/Sales/Technician/Warehouseman (kế thừa từ Staff)
INSERT INTO `tblManager` (`tblStaffId`) VALUES (5);
INSERT INTO `tblSales` (`tblStaffId`) VALUES (6);
INSERT INTO `tblTechnician` (`tblStaffId`) VALUES (7);
INSERT INTO `tblWarehouseman` (`tblStaffId`) VALUES (8);

-- Lịch trống (ScheduleTime)
INSERT INTO `tblScheduleTime` (`id`, `date`, `start`, `end`, `status`) VALUES
  (1, '2025-10-20', '09:00:00', '10:00:00', 'BOOKED'),
  (2, '2025-10-20', '10:00:00', '11:00:00', 'BOOKED');

-- Dịch vụ
INSERT INTO `tblService` (`id`, `name`, `price`, `description`, `status`) VALUES
  (1, N'Thay lốp xe ô tô', 1000000, N'Dịch vụ thay lốp ô tô', 'ACTIVE'),
  (2, N'Vá bánh xe', 100000, N'Dịch vụ vá bánh xe', 'ACTIVE'),
  (3, N'Sửa động cơ', 400000, N'Sửa chữa động cơ cơ bản', 'ACTIVE');

-- Sản phẩm
INSERT INTO `tblProduct` (`id`, `name`, `price`, `description`, `status`) VALUES
  (1, N'Bánh xe ô tô', 500000, N'Bánh xe tiêu chuẩn', 'ACTIVE'),
  (2, N'Động cơ máy', 2000000, N'Động cơ lắp ráp', 'ACTIVE');

-- Nhà cung cấp
INSERT INTO `tblProvider` (`id`, `name`, `email`, `phone`, `status`) VALUES
  (1, N'Công ty Phụ tùng Minh Long', 'contact@minhlong.vn', '02812345678', 'ACTIVE');

-- Lịch hẹn
INSERT INTO `tblAppointment` (`id`, `tblScheduleTimeId`, `tblCustomerId`, `name`, `email`, `phone`, `description`, `address`) VALUES
  (1, 1, 1, N'Nguyễn Văn A', 'a@example.com', '0901000001', N'Bảo dưỡng 5.000km', N'12 Nguyễn Trãi, Q.1, TP.HCM'),
  (2, 2, 2, N'Trần Thị B', 'b@example.com', '0901000002', N'Thay dầu', N'45 Lê Lợi, Q.1, TP.HCM');

-- Hóa đơn nhập kho (warehouseman 8, provider 1)
INSERT INTO `tblInboundInvoice` (`id`, `createAt`, `paymentStatus`, `tblWarehousemanId`, `tblProviderId`) VALUES
  (1, NOW(), 'PAID', 8, 1);

-- Chi tiết nhập kho
INSERT INTO `tblInboundInvoiceDetail` (`id`, `cost`, `quantity`, `tblInboundInvoiceId`, `tblProductId`) VALUES
  (1, 450000, 20, 1, 1),
  (2, 1800000, 10, 1, 2);

-- Hóa đơn bán hàng (sales 6, customer 1)
INSERT INTO `tblInvoice` (`id`, `createAt`, `paymentStatus`, `tblSalesId`, `tblCustomerId`) VALUES
  (1, NOW(), 'PENDING', 6, 1);

-- Chi tiết hóa đơn (sản phẩm + dịch vụ)
INSERT INTO `tblProductInvoiceDetail` (`id`, `sellprice`, `quantity`, `tblProductId`, `tblInvoiceId`) VALUES
  (1, 500000, 1, 1, 1);

INSERT INTO `tblServiceInvoiceDetail` (`id`, `sellprice`, `quantity`, `tblServiceId`, `tblInvoiceId`) VALUES
  (1, 1000000, 2, 1, 1);

-- Phân công kỹ thuật viên cho hóa đơn 1
INSERT INTO `tblAssignment` (`id`, `note`, `tblTechnicianId`, `tblInvoiceId`) VALUES
  (1, N'KTV kiểm tra phanh và thay dầu', 7, 1);

-- =================================================================
-- BỔ SUNG THÊM DỮ LIỆU (gấp đôi số lượng)
-- =================================================================

-- Thêm Member mới (khách + staff)
INSERT INTO `tblMember` (`id`, `username`, `password`, `name`, `email`, `phone`, `address`, `dob`) VALUES
  (9, 'st3', '123456', N'Đỗ Nhân Viên 3', 'st3@example.com', '0907000009', N'12-3B Điện Biên Phủ, Q.Bình Thạnh, TP.HCM', '1990-09-09 00:00:00'),
  (10, 'sales2', '123456', N'Phan Bán Hàng 2', 'sales2@example.com', '0908000010', N'24 Nguyễn Văn Cừ, Q.5, TP.HCM', '1992-10-10 00:00:00'),
  (11, 'tech2', '123456', N'La Kỹ Thuật 2', 'tech2@example.com', '0909000011', N'9 Phạm Ngọc Thạch, Q.3, TP.HCM', '1994-11-11 00:00:00'),
  (12, 'wh2', '123456', N'Vũ Kho 2', 'wh2@example.com', '0910000012', N'5 Nguyễn Thị Minh Khai, Q.1, TP.HCM', '1986-12-12 00:00:00'),
  (13, 'kh3', '123456', N'Phạm Minh C', 'c@example.com', '0911000013', N'30 Pasteur, Q.1, TP.HCM', '1995-01-01 00:00:00'),
  (14, 'kh4', '123456', N'Đặng Thị D', 'd@example.com', '0912000014', N'200 Võ Văn Kiệt, Q.1, TP.HCM', '1996-02-02 00:00:00');

-- Thêm Customer mới (1-1)
INSERT INTO `tblCustomer` (`tblMemberId`, `customerId`) VALUES (13, 1003), (14, 1004);

-- Staff mới (tham chiếu manager 5)
INSERT INTO `tblStaff` (`tblMemberId`, `position`, `status`) VALUES
  (9, N'Nhân viên', 'ACTIVE'),
  (10, N'Kinh doanh', 'ACTIVE'),
  (11, N'Kỹ thuật', 'ACTIVE'),
  (12, N'Kho', 'ACTIVE');

-- Vai trò kế thừa từ Staff
INSERT INTO `tblSales` (`tblStaffId`) VALUES (10);
INSERT INTO `tblTechnician` (`tblStaffId`) VALUES (11);
INSERT INTO `tblWarehouseman` (`tblStaffId`) VALUES (12);

-- Lịch trống bổ sung
INSERT INTO `tblScheduleTime` (`id`, `date`, `start`, `end`, `status`) VALUES
  (3, '2025-10-21', '09:00:00', '10:00:00', 'BOOKED'),
  (4, '2025-10-21', '10:00:00', '11:00:00', 'BOOKED'),
  (5, '2025-10-21', '14:00:00', '15:00:00', 'AVAILABLE'),
  (6, '2025-10-21', '15:00:00', '16:00:00', 'AVAILABLE'),
  (7, '2025-10-22', '09:00:00', '10:00:00', 'AVAILABLE'),
  (8, '2025-10-22', '10:00:00', '11:00:00', 'AVAILABLE'),
  (9, '2025-10-22', '14:00:00', '15:00:00', 'AVAILABLE'),
  (10, '2025-10-22', '15:00:00', '16:00:00', 'AVAILABLE');

-- Dịch vụ bổ sung
-- Giữ đúng 3 dịch vụ như yêu cầu (không thêm dịch vụ khác)

-- Sản phẩm bổ sung
INSERT INTO `tblProduct` (`id`, `name`, `price`, `description`, `status`) VALUES
  (3, N'Bugi', 80000, N'Bugi tiêu chuẩn', 'ACTIVE'),
  (4, N'Lọc gió', 70000, N'Lọc gió động cơ', 'ACTIVE');

-- Provider bổ sung
INSERT INTO `tblProvider` (`id`, `name`, `email`, `phone`, `status`) VALUES
  (2, N'Công ty Phụ tùng An Phát', 'contact@anphat.vn', '02887654321', 'ACTIVE');

-- Lịch hẹn bổ sung
INSERT INTO `tblAppointment` (`id`, `tblScheduleTimeId`, `tblCustomerId`, `name`, `email`, `phone`, `description`, `address`) VALUES
  (3, 3, 13, N'Phạm Minh C', 'c@example.com', '0911000013', N'Vệ sinh kim phun', N'88 Trần Hưng Đạo, Q.5, TP.HCM'),
  (4, 4, 14, N'Đặng Thị D', 'd@example.com', '0912000014', N'Cân chỉnh phanh', N'101 Hai Bà Trưng, Q.3, TP.HCM');

-- Hóa đơn nhập kho bổ sung (warehouseman 12, provider 2)
INSERT INTO `tblInboundInvoice` (`id`, `createAt`, `paymentStatus`, `tblWarehousemanId`, `tblProviderId`) VALUES
  (2, NOW(), 'PENDING', 12, 2);

-- Chi tiết nhập kho bổ sung
INSERT INTO `tblInboundInvoiceDetail` (`id`, `cost`, `quantity`, `tblInboundInvoiceId`, `tblProductId`) VALUES
  (3, 450000, 5, 2, 1),
  (4, 1800000, 2, 2, 2);

-- Hóa đơn bán hàng bổ sung (sales 10, customer 13)
INSERT INTO `tblInvoice` (`id`, `createAt`, `paymentStatus`, `tblSalesId`, `tblCustomerId`) VALUES
  (2, NOW(), 'PAID', 10, 13);

-- Chi tiết hóa đơn bổ sung
INSERT INTO `tblProductInvoiceDetail` (`id`, `sellprice`, `quantity`, `tblProductId`, `tblInvoiceId`) VALUES
  (2, 2000000, 1, 2, 2);

INSERT INTO `tblServiceInvoiceDetail` (`id`, `sellprice`, `quantity`, `tblServiceId`, `tblInvoiceId`) VALUES
  (2, 400000, 2, 3, 2);

-- Phân công kỹ thuật viên bổ sung cho hóa đơn 2
INSERT INTO `tblAssignment` (`id`, `note`, `tblTechnicianId`, `tblInvoiceId`) VALUES
  (2, N'KTV vệ sinh kim phun', 11, 2);