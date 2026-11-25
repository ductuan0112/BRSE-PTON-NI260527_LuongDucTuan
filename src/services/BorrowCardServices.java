
package services;

import databases.DatabaseConnection;
import utils.InputUtil;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class BorrowCardServices {

    private final Connection conn = DatabaseConnection.getConn();

    // 1. Lấy danh sách tất cả phiếu mượn
    public void getAllBorrowCards() {
        String sql = "{CALL get_all_borrow_cards()}";
        try (CallableStatement cs = conn.prepareCall(sql)) {
            boolean hasResult = cs.execute();
            if (hasResult) {
                ResultSet rs = cs.getResultSet();
                int count = printTable(rs);
                if (count == 0) {
                    System.out.println("Không có phiếu mượn nào!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách phiếu mượn: " + e.getMessage());
        }
    }

    // 2. Thêm mới phiếu mượn
    public void createBorrowCard() {
        String sql = "{CALL insert_borrow_card(?, ?, ?, ?, ?, ?)}";
        try (CallableStatement cs = conn.prepareCall(sql)) {
            inputBorrowCard(cs);
            cs.execute();
            System.out.println("Thêm phiếu mượn thành công!");
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm phiếu mượn: " + e.getMessage());
        }
    }

    // 3. Cập nhật thông tin phiếu mượn
    public void updateBorrowCard() {
        String sql = "{CALL update_borrow_card(?, ?, ?, ?, ?, ?, ?)}";
        try {
            int cardId = InputUtil.readInt(
                    "Nhập card_id cần cập nhật: "
            );
            try (CallableStatement cs = conn.prepareCall(sql)) {
                cs.setInt(1, cardId);
                System.out.println("\nNhập thông tin mới:");
                inputBorrowCardWithoutId(cs, 2);
                int result = cs.executeUpdate();
                if (result > 0) {
                    System.out.println("Cập nhật phiếu mượn thành công!");
                } else {
                    System.out.println("Không tìm thấy phiếu mượn hoặc không có dữ liệu thay đổi!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi cập nhật phiếu mượn: " + e.getMessage());
        }
    }
    // 4. Xóa phiếu mượn
    public void deleteBorrowCard() {
        String sql = "{CALL delete_borrow_card(?)}";
        try {
            int cardId = InputUtil.readInt("Nhập card_id cần xóa: ");
            String confirm = InputUtil.readString(
                    "Bạn có chắc chắn muốn xóa phiếu mượn này? (Y/N): ",
                    "Y|N|y|n",
                    "Vui lòng nhập Y hoặc N!"
            );
            if (confirm.equalsIgnoreCase("N")) {
                System.out.println("Đã hủy thao tác xóa.");
                return;
            }
            try (CallableStatement cs = conn.prepareCall(sql)) {
                cs.setInt(1, cardId);
                int result = cs.executeUpdate();
                if (result > 0) {
                    System.out.println("Xóa phiếu mượn thành công!");
                } else {
                    System.out.println("Không tìm thấy phiếu mượn cần xóa!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi xóa phiếu mượn: " + e.getMessage());
        }
    }
    // 5. Tìm kiếm phiếu mượn theo tên độc giả
    public void searchByBorrowerName() {
        String sql = "{CALL get_borrow_cards_by_borrower(?)}";
        try (CallableStatement cs = conn.prepareCall(sql)) {
            String borrowerName = InputUtil.readString("Nhập tên độc giả cần tìm: ");
            cs.setString(1, borrowerName);
            boolean hasResult = cs.execute();
            if (hasResult) {
                ResultSet rs = cs.getResultSet();
                int count = printTable(rs);
                if (count == 0) {
                    System.out.println("Không tìm thấy phiếu mượn của độc giả này!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm kiếm theo tên độc giả: " + e.getMessage());
        }
    }

    // 6. Tìm kiếm phiếu mượn theo tên sách
    public void searchByBookTitle() {
        String sql = "{CALL search_borrow_cards_by_book_title(?)}";
        try (CallableStatement cs = conn.prepareCall(sql)) {
            String bookTitle = InputUtil.readString("Nhập tên sách cần tìm: ");
            cs.setString(1, bookTitle);
            boolean hasResult = cs.execute();
            if (hasResult) {
                ResultSet rs = cs.getResultSet();
                int count = printTable(rs);
                if (count == 0) {
                    System.out.println("Không tìm thấy phiếu mượn của sách này!");
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm kiếm theo tên sách: " + e.getMessage());
        }
    }

    // Nhập thông tin phiếu mượn khi thêm mới
    private void inputBorrowCard(CallableStatement cs) throws SQLException {
        String bookTitle = InputUtil.readString("Nhập tên sách: ");
        String borrowerName = InputUtil.readString("Nhập tên độc giả: ");
        LocalDateTime borrowDate = InputUtil.readLocalDateTime("Nhập ngày mượn (yyyy-MM-dd HH:mm:ss): ");
        LocalDateTime returnDeadline = InputUtil.readLocalDateTime("Nhập hạn trả (yyyy-MM-dd HH:mm:ss): ");
        int quantity = InputUtil.readInt("Nhập số lượng sách: ");
        String status = InputUtil.readString(
                "Nhập trạng thái (Borrowing/Returned/Overdue): ",
                "Borrowing|Returned|Overdue",
                "Trạng thái không hợp lệ!"
        );

        cs.setString(1, bookTitle);
        cs.setString(2, borrowerName);
        cs.setTimestamp(3, Timestamp.valueOf(borrowDate));
        cs.setTimestamp(4, Timestamp.valueOf(returnDeadline));
        cs.setInt(5, quantity);
        cs.setString(6, status);
    }

    // Nhập thông tin phiếu mượn khi cập nhật
    private void inputBorrowCardWithoutId(
            CallableStatement cs,
            int startIndex
    ) throws SQLException {
        String bookTitle = InputUtil.readString("Nhập tên sách mới: ");
        String borrowerName = InputUtil.readString("Nhập tên độc giả mới: ");
        LocalDateTime borrowDate = InputUtil.readLocalDateTime("Nhập ngày mượn mới (yyyy-MM-dd HH:mm:ss): ");
        LocalDateTime returnDeadline = InputUtil.readLocalDateTime("Nhập hạn trả mới (yyyy-MM-dd HH:mm:ss): ");
        int quantity = InputUtil.readInt("Nhập số lượng sách mới: ");
        String status = InputUtil.readString(
                "Nhập trạng thái mới (Borrowing/Returned/Overdue): ",
                "Borrowing|Returned|Overdue",
                "Trạng thái không hợp lệ!"
        );

        cs.setString(startIndex, bookTitle);
        cs.setString(startIndex + 1, borrowerName);
        cs.setTimestamp(startIndex + 2, Timestamp.valueOf(borrowDate));
        cs.setTimestamp(startIndex + 3, Timestamp.valueOf(returnDeadline));
        cs.setInt(startIndex + 4, quantity);
        cs.setString(startIndex + 5, status);
    }

    // Hiển thị danh sách phiếu mượn
    private int printTable(ResultSet rs) throws SQLException {
        int count = 0;
        System.out.println("\n==================== DANH SÁCH PHIẾU MƯỢN ====================");
        System.out.printf(
                "%-10s %-25s %-20s %-22s %-22s %-10s %-15s%n",
                "Card ID",
                "Tên sách",
                "Tên độc giả",
                "Ngày mượn",
                "Hạn trả",
                "Số lượng",
                "Trạng thái"
        );
        System.out.println("-----------------------------------------------------------------------------------------------------------------------------");
        try (rs) {
            while (rs.next()) {
                int cardId = rs.getInt("card_id");
                String bookTitle = rs.getString("book_title");
                String borrowerName = rs.getString("borrower_name");
                Timestamp borrowDate = rs.getTimestamp("borrow_date");
                Timestamp returnDeadline = rs.getTimestamp("return_deadline");
                int quantity = rs.getInt("quantity");
                String status = rs.getString("status");
                System.out.printf(
                        "%-10d %-25s %-20s %-22s %-22s %-10d %-15s%n",
                        cardId,
                        bookTitle,
                        borrowerName,
                        borrowDate.toLocalDateTime().toString().replace("T", " "),
                        returnDeadline.toLocalDateTime().toString().replace("T", " "),
                        quantity,
                        status
                );
                count++;
            }
        }
        System.out.println(
                "-----------------------------------------------------------------------------------------------------------------------------"
        );
        System.out.println("Tổng số phiếu mượn: " + count);
        return count;
    }
}