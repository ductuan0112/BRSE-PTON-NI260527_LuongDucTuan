package utils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Scanner;

public class InputUtil {
    private static final Scanner SCANNER;

    public InputUtil() {
    }

    public static int readInt(String prompt) {
        while(true) {
            System.out.print(prompt);

            try {
                String input = SCANNER.nextLine();
                return Integer.parseInt(input.trim());
            } catch (NumberFormatException var2) {
                System.out.println("❌ Lỗi: Vui lòng nhập vào một số nguyên hợp lệ!");
            }
        }
    }

    public static int readInt(String prompt, int min, int max) {
        while(true) {
            int value = readInt(prompt);
            if (value >= min && value <= max) {
                return value;
            }

            System.out.println("❌ Lỗi: Giá trị phải nằm trong khoảng từ " + min + " đến " + max + "!");
        }
    }

    public static double readDouble(String prompt) {
        while(true) {
            System.out.print(prompt);

            try {
                String input = SCANNER.nextLine();
                return Double.parseDouble(input.trim());
            } catch (NumberFormatException var2) {
                System.out.println("❌ Lỗi: Vui lòng nhập vào một số thực hợp lệ!");
            }
        }
    }

    public static String readString(String prompt) {
        while(true) {
            System.out.print(prompt);
            String input = SCANNER.nextLine();
            if (input != null && !input.trim().isEmpty()) {
                return input.trim();
            }

            System.out.println("❌ Lỗi: Nội dung không được để trống!");
        }
    }

    public static String readString(String prompt, String regex, String errorMessage) {
        while(true) {
            String input = readString(prompt);
            if (input.matches(regex)) {
                return input;
            }

            System.out.println("❌ Lỗi: " + errorMessage);
        }
    }

    public static LocalDate readLocalDate(String prompt) {
        return readLocalDate(prompt, "yyyy-MM-dd");
    }

    public static LocalDate readLocalDate(String prompt, String pattern) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);

        while(true) {
            String input = readString(prompt);

            try {
                return LocalDate.parse(input, formatter);
            } catch (DateTimeParseException var5) {
                System.out.println("❌ Lỗi: Sai định dạng ngày tháng! (Yêu cầu định dạng: " + pattern + ")");
            }
        }
    }

    public static LocalDateTime readLocalDateTime(String prompt) {
        return readLocalDateTime(prompt, "yyyy-MM-dd HH:mm:ss");
    }

    public static LocalDateTime readLocalDateTime(String prompt, String pattern) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(pattern);

        while(true) {
            String input = readString(prompt);

            try {
                return LocalDateTime.parse(input, formatter);
            } catch (DateTimeParseException var5) {
                System.out.println("❌ Lỗi: Sai định dạng ngày giờ! (Yêu cầu định dạng: " + pattern + ", ví dụ: 2026-11-18 20:00:00)");
            }
        }
    }

    static {
        SCANNER = new Scanner(System.in);
    }

    public static void close() {
    }
}
