DROP DATABASE IF EXISTS db_library_management;
CREATE DATABASE db_library_management;
USE db_library_management;
CREATE TABLE borrow_cards (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    book_title VARCHAR(150) NOT NULL,
    borrower_name VARCHAR(100) NOT NULL,
    borrow_date TIMESTAMP NOT NULL,
    return_deadline TIMESTAMP NOT NULL,
    quantity INT NOT NULL,
    status VARCHAR(30) NOT NULL
);

--  Procedure thực hiện lấy danh sách tất cả các phiếu mượn

DELIMITER //
CREATE PROCEDURE get_all_borrow_cards()
BEGIN
SELECT *
FROM borrow_cards;
END//
DELIMITER ;

--  Procedure thực hiện thêm mới một phiếu mượn

DELIMITER //

CREATE PROCEDURE insert_borrow_card (
    IN p_book_title VARCHAR(150),
    IN p_borrower_name VARCHAR(100),
    IN p_borrow_date TIMESTAMP,
    IN p_return_deadline TIMESTAMP,
    IN p_quantity INT,
    IN p_status VARCHAR(30)
)
BEGIN
INSERT INTO borrow_cards (
    book_title,
    borrower_name,
    borrow_date,
    return_deadline,
    quantity,
    status
)
VALUES (
           p_book_title,
           p_borrower_name,
           p_borrow_date,
           p_return_deadline,
           p_quantity,
           p_status
       );
END //

DELIMITER ;

--   Procedure thực hiện lấy danh sách phiếu mượn theo tên độc giả borrower_name

DELIMITER //
CREATE PROCEDURE get_borrow_cards_by_borrower (
    IN p_borrower_name VARCHAR(100)
)
BEGIN
SELECT *
FROM borrow_cards
WHERE borrower_name = p_borrower_name;
END//
DELIMITER ;

--   Procedure thực hiện cập nhật thông tin phiếu mượn theo card_id

DELIMITER //
CREATE PROCEDURE update_borrow_card (
    IN p_card_id INT,
    IN p_book_title VARCHAR(150),
    IN p_borrower_name VARCHAR(100),
    IN p_borrow_date TIMESTAMP,
    IN p_return_deadline TIMESTAMP,
    IN p_quantity INT,
    IN p_status VARCHAR(30)
)
BEGIN
UPDATE borrow_cards
SET
    book_title = p_book_title,
    borrower_name = p_borrower_name,
    borrow_date = p_borrow_date,
    return_deadline = p_return_deadline,
    quantity = p_quantity,
    status = p_status
WHERE card_id = p_card_id;
END //
DELIMITER ;

  -- Procedure thực hiện xóa phiếu mượn theo card_id
DELIMITER //
CREATE PROCEDURE delete_borrow_card (
    IN p_card_id INT
)
BEGIN
DELETE FROM borrow_cards
WHERE card_id = p_card_id;
END//
DELIMITER ;

--  Procedure thực hiện tìm kiếm phiếu mượn theo tên sách book_title
-- (Tìm gần đúng, không phân biệt hoa thường)

DELIMITER //
CREATE PROCEDURE search_borrow_cards_by_book_title(
    IN p_book_title VARCHAR(150)
)
BEGIN
SELECT *
FROM borrow_cards
WHERE LOWER(book_title)
          LIKE LOWER(CONCAT('%', p_book_title, '%'));
END //
DELIMITER ;

INSERT INTO borrow_cards (
    book_title,
    borrower_name,
    borrow_date,
    return_deadline,
    quantity,
    status
)
VALUES
    (
        'Khong Gia Dinh',
        'Nguyen Van A',
        '2026-11-01 08:00:00',
        '2026-11-15 08:00:00',
        2,
        'Borrowing'
    ),
    (
        'Trong Gia Dinh',
        'Tran Thi B',
        '2026-11-05 09:30:00',
        '2026-11-19 09:30:00',
        1,
        'Returned'
    ),
    (
        'Bay Hanh Phuc',
        'Le Van C',
        '2026-11-10 10:00:00',
        '2026-11-24 10:00:00',
        3,
        'Overdue'
    ),
    (
        'Con nhan ma trong vuon',
        'Pham Thi D',
        '2026-11-15 14:00:00',
        '2026-11-29 14:00:00',
        1,
        'Borrowing'
    ),
    (
        'Bo Ba',
        'Hoang Van E',
        '2026-11-20 16:00:00',
        '2026-12-04 16:00:00',
        2,
        'Borrowing'
    );
