package model;
import java.time.LocalDateTime;

public class BorrowCard {
    private int card_id;
    private String book_title;
    private String borrower_name;
    private LocalDateTime borrow_date;
    private LocalDateTime return_deadline;
    private int quantity;
    private String status;

    public BorrowCard() {
    }

    public BorrowCard(int card_id, String book_title, String borrower_name,
                      LocalDateTime borrow_date, LocalDateTime return_deadline,
                      int quantity, String status) {
        this.card_id = card_id;
        this.book_title = book_title;
        this.borrower_name = borrower_name;
        this.borrow_date = borrow_date;
        this.return_deadline = return_deadline;
        this.quantity = quantity;
        this.status = status;
    }

    @Override
    public String toString() {
        return "BorrowCard{" +
                "card_id=" + card_id +
                ", book_title='" + book_title + '\'' +
                ", borrower_name='" + borrower_name + '\'' +
                ", borrow_date=" + borrow_date +
                ", return_deadline=" + return_deadline +
                ", quantity=" + quantity +
                ", status='" + status + '\'' +
                '}';
    }

    public long getCard_id() {
        return card_id;
    }

    public void setCard_id(int card_id) {
        this.card_id = card_id;
    }

    public String getBook_title() {
        return book_title;
    }

    public void setBook_title(String book_title) {
        this.book_title = book_title;
    }

    public String getBorrower_name() {
        return borrower_name;
    }

    public void setBorrower_name(String borrower_name) {
        this.borrower_name = borrower_name;
    }

    public LocalDateTime getBorrow_date() {
        return borrow_date;
    }

    public void setBorrow_date(LocalDateTime borrow_date) {
        this.borrow_date = borrow_date;
    }

    public LocalDateTime getReturn_deadline() {
        return return_deadline;
    }

    public void setReturn_deadline(LocalDateTime return_deadline) {
        this.return_deadline = return_deadline;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
