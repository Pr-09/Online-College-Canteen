//package servlet;
//
//
//import dao.DBConnection;
//import java.io.IOException;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.net.URLEncoder;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.sql.Statement;
//import java.sql.Timestamp;
//import java.time.Instant;
//import java.util.List;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//@WebServlet(name = "Prince", urlPatterns = {"/PaymentServlet"})
//public class Prince extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//
//        String razorpayPaymentId = req.getParameter("razorpay_payment_id");
//        if (razorpayPaymentId == null || razorpayPaymentId.isEmpty()) {
//            resp.sendRedirect("payment.jsp?error=paymentFailed");
//            return;
//        }
//
//        HttpSession session = req.getSession(false);
//        if (session == null || session.getAttribute("orderLines") == null) {
//            resp.sendRedirect("menu.jsp?error=sessionExpired");
//            return;
//        }
//
//        @SuppressWarnings("unchecked")
//        List<PlaceOrderServlet.OrderLine> lines = (List<PlaceOrderServlet.OrderLine>) session.getAttribute("orderLines");
//        double total = (double) session.getAttribute("orderTotal");
//        String username = (String) session.getAttribute("username");
//        String tableNo = (String) session.getAttribute("tableNo");
//        String userType = (String) session.getAttribute("userType");
//        String rollno = (String) session.getAttribute("rollno");
//        String mobile = (String) session.getAttribute("mobile");
//        String college = (String) session.getAttribute("college");
//        String email = (String) session.getAttribute("email");
//        String purpose = (String) session.getAttribute("purpose");
//
//        String orderItems = String.join(", ", lines.stream().map(l -> l.name).toArray(String[]::new));
//        String orderId;
//
//        try (Connection conn = DBConnection.getConnection()) {
//            // Insert into orders table
//            String sql = "INSERT INTO orders (username, rollno, mobile, college, email, purpose, user_type, table_no, food_items, order_time, order_status, total_amount) " +
//                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
//                ps.setString(1, username);
//                ps.setString(2, rollno);
//                ps.setString(3, mobile);
//                ps.setString(4, college);
//                ps.setString(5, email);
//                ps.setString(6, purpose);
//                ps.setString(7, userType);
//                ps.setString(8, tableNo);
//                ps.setString(9, orderItems);
//                ps.setTimestamp(10, Timestamp.from(Instant.now()));
//                ps.setString(11, "Preparing");
//                ps.setDouble(12, total);
//                ps.executeUpdate();
//
//                try (ResultSet gk = ps.getGeneratedKeys()) {
//                    if (gk.next()) {
//                        orderId = gk.getString(1);
//                    } else {
//                        throw new SQLException("Failed to get generated order ID.");
//                    }
//                }
//            }
//
//            // Insert into audit log
//         String auditSql = "INSERT INTO audit_log (order_id, username, TRANSACTION_ID, action, timestamp) VALUES (?, ?, ?, ?, ?)";
//try (PreparedStatement auditPs = conn.prepareStatement(auditSql)) {
//    auditPs.setString(1, orderId);
//    auditPs.setString(2, username);
//    auditPs.setString(3, razorpayPaymentId);
//    auditPs.setString(4, "Order Placed via Razorpay");
//    auditPs.setTimestamp(5, Timestamp.from(Instant.now()));
//    auditPs.executeUpdate();
//}
//
//            System.out.println("Order placed successfully. Order ID: " + orderId);
//
//            // Send SMS
//            String message = "Hi " + username + ", your order (Order ID: " + orderId + ") was placed successfully.";
//            sendSMSNotification(mobile, message);
//
//            // Clear session data (optional)
//            session.removeAttribute("orderLines");
//            session.removeAttribute("orderTotal");
//
//            // Redirect to success page
//            resp.sendRedirect("orderSuccess.jsp");
//
//        } catch (Exception e) {
//            throw new ServletException("Payment processing failed", e);
//        }
//    }
//
//    private void sendSMSNotification(String phone, String message) {
//        try {
//            String apiKey = "jPqi10XCfmSi8QWoYpEtVAorE5JpjTGNtrqKLpD9XRHJpuulnZYokEOBIU29";
//            String encodedMessage = URLEncoder.encode(message, "UTF-8");
//
//            String urlStr = "https://www.fast2sms.com/dev/bulkV2" +
//                    "?authorization=" + apiKey +
//                    "&sender_id=FSTSMS" +
//                    "&message=" + encodedMessage +
//                    "&language=english&route=p" +
//                    "&numbers=" + phone;
//
//            URL url = new URL(urlStr);
//            HttpURLConnection con = (HttpURLConnection) url.openConnection();
//            con.setRequestMethod("GET");
//
//            int responseCode = con.getResponseCode();
//            if (responseCode == 200) {
//                System.out.println("SMS sent successfully to " + phone);
//            } else {
//                System.out.println("Failed to send SMS. Response Code: " + responseCode);
//            }
//
//        } catch (Exception e) {
//            System.out.println("Error sending SMS: " + e.getMessage());
//        }
//    }
//}

package servlet;

import dao.DBConnection;
import java.io.IOException;
import java.sql.*;
import java.time.Instant;
import java.util.List;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "Prince", urlPatterns = {"/Prince"})
public class Prince extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String razorpayPaymentId = req.getParameter("razorpay_payment_id");
        if (razorpayPaymentId == null || razorpayPaymentId.isEmpty()) {
            resp.sendRedirect("payment.jsp?error=paymentFailed");
            return;
        }

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("orderLines") == null) {
            resp.sendRedirect("menu.jsp?error=sessionExpired");
            return;
        }

        @SuppressWarnings("unchecked")
        List<PlaceOrderServlet.OrderLine> lines = (List<PlaceOrderServlet.OrderLine>) session.getAttribute("orderLines");
        double total = (double) session.getAttribute("orderTotal");
        String username = (String) session.getAttribute("username");
        String tableNo = (String) session.getAttribute("tableNo");
        String userType = (String) session.getAttribute("userType");
        String rollno = (String) session.getAttribute("rollno");
        String mobile = (String) session.getAttribute("mobile");
        String college = (String) session.getAttribute("college");
        String email = (String) session.getAttribute("email");
        String purpose = (String) session.getAttribute("purpose");

        String orderItems = String.join(", ", lines.stream().map(l -> l.name).toArray(String[]::new));
        String orderId;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO orders (username, rollno, mobile, college, email, purpose, user_type, table_no, food_items, order_time, order_status, total_amount) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, username);
                ps.setString(2, rollno);
                ps.setString(3, mobile);
                ps.setString(4, college);
                ps.setString(5, email);
                ps.setString(6, purpose);
                ps.setString(7, userType);
                ps.setString(8, tableNo);
                ps.setString(9, orderItems);
                ps.setTimestamp(10, Timestamp.from(Instant.now()));
                ps.setString(11, "Preparing");
                ps.setDouble(12, total);
                ps.executeUpdate();

                try (ResultSet gk = ps.getGeneratedKeys()) {
                    if (gk.next()) {
                        orderId = gk.getString(1);
                    } else {
                        throw new SQLException("Failed to get generated order ID.");
                    }
                }
            }

            String auditSql = "INSERT INTO audit_log (order_id, username, TRANSACTION_ID, action, timestamp) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement auditPs = conn.prepareStatement(auditSql)) {
                auditPs.setString(1, orderId);
                auditPs.setString(2, username);
                auditPs.setString(3, razorpayPaymentId);
                auditPs.setString(4, "Order Placed via Razorpay");
                auditPs.setTimestamp(5, Timestamp.from(Instant.now()));
                auditPs.executeUpdate();
            }

            session.setAttribute("orderId", orderId);
            session.setAttribute("orderTotal", total);
            session.setAttribute("orderLines", lines);
            session.setAttribute("username", username);
            session.setAttribute("tableNo", tableNo);
            sendConfirmationEmail(getServletContext(), email, username, tableNo, orderId, orderItems, total);

            resp.sendRedirect("orderSuccess.jsp");

        } catch (Exception e) {
            throw new ServletException("Payment processing failed", e);
        }
    }

    private void sendConfirmationEmail(ServletContext context, String recipientEmail, String username, String tableNo, String orderId, String orderItems, double total) {
        String smtpHost = context.getInitParameter("smtpHost");
        String smtpPort = context.getInitParameter("smtpPort");
        final String smtpUser = context.getInitParameter("smtpUser");
        final String smtpPass = context.getInitParameter("smtpPass");
        
  System.out.println(smtpHost+", "+smtpPort+", "+smtpPass);
        if (smtpHost == null || smtpPort == null || smtpUser == null || smtpPass == null) {
            System.err.println("SMTP configuration missing in web.xml");
            return;
        }

        String subject = "Order Confirmation - Online Canteen";
        String messageBody = "Hi " + username + ",\n\n" +
                "Thank you for your order!\n\n" +
                "Order ID: " + orderId + "\n" +
                "Table No: " + tableNo + "\n" +
                "Items: " + orderItems + "\n" +
                "Total Amount: ₹" + total + "\n\n" +
                "We are preparing your order. You'll be notified once it's ready!\n\n" +
                "Regards,\nOnline Canteen System";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);
        
        Session mailSession = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUser, smtpPass);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(smtpUser));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject(subject);
            message.setText(messageBody);

            Transport.send(message);
            System.out.println("Confirmation email sent to: " + recipientEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }
}
