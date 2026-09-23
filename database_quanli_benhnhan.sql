DROP DATABASE IF EXISTS quanli_benhnhan;
CREATE DATABASE quanli_benhnhan;
USE quanli_benhnhan;

-- PHẦN 1: Thao tác với dữ liệu các bảng

-- Tạo 4 bảng BenhNhan, DichVu, PhieuKham, HoaDon
CREATE TABLE BenhNhan (
	benhnhan_id VARCHAR(10) PRIMARY KEY,
	ho_ten VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	so_dien_thoai VARCHAR(15) NOT NULL,
    dia_chi VARCHAR(200)
);

CREATE TABLE DichVu (
	dichvu_id VARCHAR(10) PRIMARY KEY,
	ten_dich_vu VARCHAR(150) NOT NULL UNIQUE,
	gia_dich_vu DECIMAL(12,2) NOT NULL CHECK (gia_dich_vu > 0),
	trang_thai VARCHAR(50) NOT NULL DEFAULT 'Hoạt động',
	thoi_gian_uoc_tinh INT
);

CREATE TABLE PhieuKham (
	phieukham_id INT PRIMARY KEY AUTO_INCREMENT,
	benhnhan_id VARCHAR(10) NOT NULL,
	dichvu_id VARCHAR(10) NOT NULL,
	ngay_kham DATE NOT NULL,
	ngay_tai_kham DATE,
	tong_tien DECIMAL(12,2) DEFAULT 0,
	FOREIGN KEY (benhnhan_id) REFERENCES BenhNhan(benhnhan_id),
	FOREIGN KEY (dichvu_id) REFERENCES DichVu(dichvu_id)
);

CREATE TABLE HoaDon (
hoadon_id INT PRIMARY KEY AUTO_INCREMENT,
phieukham_id INT NOT NULL,
phuong_thuc_tt VARCHAR(50) NOT NULL,
ngay_tt DATE NOT NULL,
so_tien_tt DECIMAL(12,2) NOT NULL CHECK (so_tien_tt > 0),
FOREIGN KEY (phieukham_id) REFERENCES PhieuKham(phieukham_id)
);


-- Thêm dữ liệu vào 4 bảng
INSERT INTO BenhNhan (benhnhan_id, ho_ten, email, so_dien_thoai, dia_chi)
VALUES
    ('BN001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0912345678', 'Hanoi, Vietnam'),
    ('BN002', 'Tran Thi Mai', 'mai.tran@example.com', '0923456789', 'Ho Chi Minh, Vietnam'),
    ('BN003', 'Le Minh Hoang', 'hoang.le@example.com', '0934567890', 'Danang, Vietnam'),
    ('BN004', 'Pham Hoang Nam', 'nam.pham@example.com', '0945678901', 'Hue, Vietnam'),
    ('BN005', 'Vu Minh Thu', 'thu.vu@example.com', '0956789012', 'Hai Phong, Vietnam'),
    ('BN006', 'Nguyen Thi Lan', 'lan.nguyen@example.com', '0967890123', 'Quang Ninh, Vietnam'),
    ('BN007', 'Bui Minh Tuan', 'tuan.bui@example.com', '0978901234', 'Bac Giang, Vietnam'),
    ('BN008', 'Pham Quang Hieu', 'hieu.pham@example.com', '0989012345', 'Quang Nam, Vietnam');
    
INSERT INTO DichVu (dichvu_id, ten_dich_vu, gia_dich_vu, trang_thai, thoi_gian_uoc_tinh)
VALUES
    ('DV001', 'Khám tổng quát', 200.00, 'Hoạt động', 30),
    ('DV002', 'Chụp X-Quang', 150.00, 'Tạm ngưng', 15),
    ('DV003', 'Xét nghiệm máu', 300.00, 'Hoạt động', 20),
    ('DV004', 'Siêu âm 4D', 400.00, 'Hoạt động', 45),
    ('DV005', 'Khám chuyên khoa', 250.00, 'Hoạt động', 30),
    ('DV006', 'Nội soi dạ dày', 500.00, 'Hoạt động', 60),
    ('DV007', 'Khám mắt', 150.00, 'Hoạt động', 20),
    ('DV008', 'Khám tai mũi họng', 200.00, 'Tạm ngưng', 25);
    
INSERT INTO PhieuKham (phieukham_id, benhnhan_id, dichvu_id, ngay_kham, ngay_tai_kham, tong_tien)
VALUES
    (1, 'BN001', 'DV001', '2026-09-01', '2026-09-10', 200.00),
    (2, 'BN002', 'DV002', '2026-09-02', '2026-09-11', 150.00),
    (3, 'BN003', 'DV003', '2026-09-03', '2026-09-12', 300.00),
    (4, 'BN004', 'DV004', '2026-09-04', '2026-09-13', 400.00),
    (5, 'BN005', 'DV005', '2026-09-05', '2026-09-14', 250.00),
    (6, 'BN006', 'DV006', '2026-09-06', '2026-09-15', 500.00),
    (7, 'BN007', 'DV007', '2026-09-07', '2026-09-16', 150.00),
    (8, 'BN008', 'DV008', '2026-09-08', '2026-09-17', 200.00);
    
INSERT INTO HoaDon (hoadon_id, phieukham_id, phuong_thuc_tt, ngay_tt, so_tien_tt)
VALUES
    (1, 1, 'Cash', '2026-09-01', 200.00),
    (2, 2, 'Credit Card', '2026-09-02', 150.00),
    (3, 3, 'Bank Transfer', '2026-09-03', 300.00),
    (4, 4, 'Cash', '2026-09-04', 400.00),
    (5, 5, 'Credit Card', '2026-09-05', 250.00),
    (6, 6, 'Bank Transfer', '2026-09-06', 500.00),
    (7, 7, 'Cash', '2026-09-07', 150.00),
    (8, 8, 'Credit Card', '2026-09-08', 200.00);

-- UPDATE để cập nhật lại tong_tien trong bảng PhieuKham
UPDATE PhieuKham
JOIN DichVu
	ON PhieuKham.dichvu_id = DichVu.dichvu_id
SET tong_tien = gia_dich_vu + 50.0
WHERE trang_thai = 'Hoạt động' AND ngay_kham < CURDATE();

-- DELETE để xóa các thanh toán trong bảng HoaDon nếu,
-- - Phương thức thanh toán (phuong_thuc_tt) là "Cash".
-- - Và số tiền thanh toán (so_tien_tt) nhỏ hơn 200.0.
DELETE FROM HoaDon
WHERE phuong_thuc_tt = 'Cash' AND so_tien_tt < 200.0;

-- PHẦN 2: Truy vấn dữ liệu

-- Lấy thông tin bệnh nhân gồm mã bệnh nhân, họ tên, email, số điện thoại và 
-- địa chỉ được sắp xếp theo họ tên bệnh nhân tăng dần.
SELECT 
	benhnhan_id AS 'Mã bệnh nhân', 
    ho_ten AS 'Họ tên', 
    email AS Email, 
    so_dien_thoai AS 'Số điện thoại',
    dia_chi AS 'Địa chỉ'
FROM BenhNhan
ORDER BY ho_ten;

-- Lấy thông tin các dịch vụ gồm mã dịch vụ, tên dịch vụ, giá dịch vụ và 
-- thời gian ước tính, sắp xếp theo giá dịch vụ giảm dần.
SELECT 
	dichvu_id AS 'Mã dịch vụ',
    ten_dich_vu AS 'Tên dịch vụ',
    gia_dich_vu AS 'Giá dịch vụ',
    thoi_gian_uoc_tinh AS 'Thời gian ước tính'
FROM DichVu
ORDER BY gia_dich_vu DESC;

-- Lấy thông tin bệnh nhân và dịch vụ đã đăng ký, 
-- gồm mã bệnh nhân, họ tên bệnh nhân, mã dịch vụ, ngày khám và ngày tái khám.
SELECT 
	bn.benhnhan_id AS 'Mã bệnh nhân',
    bn.ho_ten AS 'Tên bệnh nhân',
    dv.dichvu_id AS 'Mã dịch vụ',
    pk.ngay_kham AS 'Ngày khám',
    pk.ngay_tai_kham AS 'Ngày tái khám'
FROM BenhNhan bn
JOIN PhieuKham pk
	ON bn.benhnhan_id = pk.benhnhan_id
JOIN DichVu dv
	ON pk.dichvu_id = dv.dichvu_id;
    
-- Lấy danh sách bệnh nhân và tổng tiền đã thanh toán khi khám bệnh, 
-- gồm mã bệnh nhân, họ tên bệnh nhân, phương thức thanh toán và số tiền thanh toán, 
-- sắp xếp theo số tiền thanh toán giảm dần.
SELECT 
	bn.benhnhan_id AS 'Mã bệnh nhân',
    bn.ho_ten AS 'Tên bệnh nhân',
    hd.phuong_thuc_tt AS 'Phương thức thanh toán',
    hd.so_tien_tt AS 'Số tiền thanh toán'
FROM BenhNhan bn
JOIN PhieuKham pk
	ON bn.benhnhan_id = pk.benhnhan_id
JOIN HoaDon hd
	ON pk.phieukham_id = hd.phieukham_id
ORDER BY so_tien_tt DESC;

-- Lấy thông tin bệnh nhân từ vị trí thứ 2 đến thứ 4 trong bảng BenhNhan 
-- được sắp xếp theo tên bệnh nhân.
SELECT *
FROM BenhNhan
ORDER BY ho_ten
LIMIT 3 OFFSET 1;

-- Lấy danh sách bệnh nhân đã đăng ký ít nhất 2 phiếu khám và có tổng số tiền thanh toán trên 500.0, 
-- gồm mã bệnh nhân, họ tên bệnh nhân và số lượng phiếu khám đã đăng ký.
SELECT 
	bn.benhnhan_id AS 'Mã bệnh nhân',
    bn.ho_ten AS 'Họ tên',
    COUNT(pk.benhnhan_id) AS 'Số lượng phiếu khám'
FROM BenhNhan bn
JOIN PhieuKham pk
	ON bn.benhnhan_id = pk.benhnhan_id
JOIN HoaDon hd
	ON pk.phieukham_id = hd.phieukham_id
GROUP BY bn.benhnhan_id
HAVING COUNT(pk.benhnhan_id) >= 2 AND SUM(hd.so_tien_tt) > 500.0;

-- Lấy danh sách các dịch vụ có tổng số tiền thanh toán dưới 1000.0 và có ít nhất 3 bệnh nhân đăng ký, 
-- gồm mã dịch vụ, tên dịch vụ, giá dịch vụ và tổng số tiền thanh toán.
SELECT
	dv.dichvu_id AS 'Mã dịch vụ',
    dv.ten_dich_vu AS 'Tên dịch vụ',
    dv.gia_dich_vu AS 'Giá dịch vụ',
    SUM(hd.so_tien_tt) AS 'Tổng số tiền thanh toán'
FROM DichVu dv
JOIN PhieuKham pk
	ON dv.dichvu_id = pk.dichvu_id
JOIN HoaDon hd
	ON pk.phieukham_id = hd.phieukham_id
JOIN BenhNhan bn
	ON pk.benhnhan_id = bn.benhnhan_id
GROUP BY dv.dichvu_id, dv.ten_dich_vu, dv.gia_dich_vu
HAVING SUM(hd.so_tien_tt) < 1000.0
	AND COUNT(DISTINCT bn.benhnhan_id) >= 3;

-- Lấy danh sách các bệnh nhân có tổng số tiền thanh toán lớn hơn 500.0, 
-- gồm mã bệnh nhân, họ tên bệnh nhân, mã dịch vụ, tổng số tiền thanh toán.
SELECT 
	bn.benhnhan_id AS 'Mã bệnh nhân',
    bn.ho_ten AS 'Họ tên bệnh nhân',
    dv.dichvu_id AS 'Mã dịch vụ',
    SUM(hd.so_tien_tt) AS 'Tổng số tiền thanh toán'
FROM BenhNhan bn
JOIN PhieuKham pk
	ON bn.benhnhan_id = pk.benhnhan_id
JOIN DichVu dv
	ON pk.dichvu_id = dv.dichvu_id
JOIN HoaDon hd
	ON pk.phieukham_id = hd.phieukham_id
GROUP BY bn.benhnhan_id, bn.ho_ten
HAVING SUM(hd.so_tien_tt) > 500.0;

-- Lấy danh sách các bệnh nhân (Mã BN, Họ tên, Email, SĐT) có họ tên chứa chữ "Minh" hoặc địa chỉ (dia_chi) ở "Hanoi". 
-- Sắp xếp kết quả theo họ tên tăng dần.
SELECT 
	benhnhan_id AS 'Mã bệnh nhân',
    ho_ten AS 'Họ tên bệnh nhân',
    email AS 'Email',
    so_dien_thoai AS 'Số điện thoại'
FROM BenhNhan
WHERE ho_ten LIKE '%Minh%' 
	OR dia_chi LIKE 'Hanoi%'
ORDER BY ho_ten ASC;

-- Lấy danh sách tất cả các dịch vụ (Mã dịch vụ, Tên dịch vụ, Giá), sắp xếp theo giá dịch vụ giảm dần. 
-- Hiển thị 2 dịch vụ tiếp theo sau 2 dịch vụ đầu tiên 
-- (tức là lấy kết quả của trang thứ 2, biết mỗi trang có 2 dịch vụ).
SELECT 
    dichvu_id AS 'Mã dịch vụ',
    ten_dich_vu AS 'Tên dịch vụ',
    gia_dich_vu AS 'Giá'
FROM DichVu
ORDER BY gia_dich_vu DESC
LIMIT 2 OFFSET 2;

-- PHẦN 3: Tạo View

-- View để lấy thông tin các dịch vụ và bệnh nhân đã đăng ký, 
-- với điều kiện ngày khám nhỏ hơn ngày 2026-09-08. 
-- Cần hiển thị các thông tin sau: Mã dịch vụ, Tên dịch vụ, Mã bệnh nhân, họ tên bệnh nhân.
CREATE VIEW v_DichVu_BenhNhan_DaDangKy
AS
SELECT 
	dv.dichvu_id AS 'Mã dịch vụ',
    dv.ten_dich_vu AS 'Tên dịch vụ',
    bn.benhnhan_id AS 'Mã bệnh nhân',
    bn.ho_ten AS 'Tên bệnh nhân'
FROM DichVu dv
JOIN PhieuKham pk
	ON dv.dichvu_id = pk.dichvu_id
JOIN BenhNhan bn
	ON pk.benhnhan_id = bn.benhnhan_id
WHERE pk.ngay_kham < '2026-09-08';

SELECT * FROM v_DichVu_BenhNhan_DaDangKy;
    
-- iew để lấy thông tin bệnh nhân và phiếu khám đã đăng ký, với điều kiện giá dịch vụ lớn hơn 200.0. 
-- Cần hiển thị các thông tin sau: Mã bệnh nhân, Họ tên bệnh nhân, Mã dịch vụ, Giá dịch vụ.
CREATE VIEW v_PhieuKham_BenhNhan_DaDangKy
AS
SELECT
	bn.benhnhan_id AS 'Mã bệnh nhân',
    bn.ho_ten AS 'Tên bệnh nhân',
    pk.dichvu_id AS 'Mã dịch vụ',
    dv.gia_dich_vu AS 'Giá dịch vụ'
FROM BenhNhan bn
JOIN PhieuKham pk
	ON bn.benhnhan_id = pk.benhnhan_id
JOIN DichVu dv
	ON pk.dichvu_id = dv.dichvu_id
WHERE dv.gia_dich_vu > 200.0;

SELECT * FROM v_PhieuKham_BenhNhan_DaDangKy;

-- PHẦN 4: Tạo Trigger
-- Trigger check_insert_phieukham để kiểm tra dữ liệu mỗi khi chèn vào bảng PhieuKham
DELIMITER //
CREATE TRIGGER check_insert_phieukham
BEFORE INSERT ON PhieuKham
FOR EACH ROW
BEGIN
	IF NEW.ngay_tai_kham < NEW.ngay_kham THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ngày tái khám không thể trước ngày khám bệnh được !';
	END IF;
END //
DELIMITER ;

-- rigger có tên là update_dichvu_status_on_booking để tự động cập nhật trạng thái dịch vụ thành "Tạm ngưng" 
-- khi dịch vụ đó được đăng ký quá 50 lần trong ngày
DELIMITER //
CREATE TRIGGER update_dichvu_status_on_booking
AFTER INSERT ON PhieuKham
FOR EACH ROW
BEGIN
	DECLARE Solan_Dangky INT;
    
    SELECT COUNT(*)
    INTO Solan_Dangky
    FROM PhieuKham
    WHERE dichvu_id = NEW.dichvu_id
		AND ngay_kham = NEW.ngay_kham;
        
	IF Solan_Dangky > 50 THEN 
	UPDATE DichVu
    SET trang_thai = 'Tạm ngưng'
    WHERE dichvu_id = NEW.dichvu_id;
	END IF;
END //
DELIMITER ;


-- PHẦN 5: Tạo Store Procedure

-- Store procedure có tên add_benhnhan để thêm mới một bệnh nhân 
-- với đầy đủ các thông tin cần thiết.
DELIMITER //
CREATE PROCEDURE add_benhnhan(
    IN p_benhnhan_id VARCHAR(10),
    IN p_ho_ten VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_so_dien_thoai VARCHAR(15),
    IN p_dia_chi VARCHAR(200)
)
BEGIN
    INSERT INTO BenhNhan (benhnhan_id, ho_ten, email, so_dien_thoai, dia_chi)
    VALUES (p_benhnhan_id, p_ho_ten, p_email, p_so_dien_thoai, p_dia_chi);
END //

DELIMITER ;

CALL add_benhnhan ('BN009', 'Bui Thu Phuong', 'phuong.thu@example.com', '0954223535', 'Ninh Binh, Viet Nam');

-- Stored Procedure có tên là add_hoadon 
-- để thực hiện việc thêm một thanh toán mới cho một lần đăng ký khám.
DELIMITER //
CREATE PROCEDURE add_hoadon(
    IN p_phieukham_id INT,
    IN p_phuong_thuc_tt VARCHAR(50),
    IN p_so_tien_tt DECIMAL(12,2),
    IN p_ngay_tt DATE
)
BEGIN
    INSERT INTO HoaDon (phieukham_id, phuong_thuc_tt, so_tien_tt, ngay_tt)
    VALUES (p_phieukham_id, p_phuong_thuc_tt, p_so_tien_tt, p_ngay_tt);
END //

DELIMITER ;

CALL add_hoadon(9, 'Bank Transfer', 500.0, '2026-09-08');