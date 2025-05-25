//
////This page will not accept payment page it directly sends to the next page
//
//package servlet;
//
//import dao.DBConnection;
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.sql.*;
//import java.time.Instant;
//import java.util.*;
//
//@WebServlet(name = "PlaceOrderServlet", urlPatterns = {"/PlaceOrderServlet"})
//public class PlaceOrderServlet extends HttpServlet {
//
//    public static class OrderLine {
//        public final String name;
//        public final double price;
//        public OrderLine(String name, double price) {
//            this.name = name;
//            this.price = price;
//        }
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//
//        // Get form inputs
//        String userType = trim(req.getParameter("userType"));
//        String username = trim(req.getParameter("username"));
//        String rollno   = trim(req.getParameter("rollno"));
//        String mobile   = trim(req.getParameter("mobile"));
//        String college  = trim(req.getParameter("college"));
//        String email    = trim(req.getParameter("email"));
//        String purpose  = trim(req.getParameter("purpose"));
//        String tableNo  = trim(req.getParameter("tableNo"));
//        String[] itemIds = req.getParameterValues("itemIds");
//
//        // Validate inputs
//        if (itemIds == null || itemIds.length == 0) {
//            resp.sendRedirect("menu.jsp?error=selectItem");
//            return;
//        }
//
//        if (username.isEmpty()) {
//            resp.sendRedirect("userDetails.jsp?tableNo=" + tableNo + "&error=nameRequired");
//            return;
//        }
//
//        List<Integer> ids = new ArrayList<>();
//        for (String s : itemIds) {
//            if (s != null && !s.trim().isEmpty()) {
//                try {
//                    ids.add(Integer.parseInt(s.trim()));
//                } catch (NumberFormatException ignored) {}
//            }
//        }
//
//        if (ids.isEmpty()) {
//            resp.sendRedirect("menu.jsp?error=invalidItems");
//            return;
//        }
//
//        try (Connection conn = DBConnection.getConnection()) {
//            List<OrderLine> lines = new ArrayList<>();
//            double total = 0;
//
//            // Prepare SQL to fetch item details
//            String placeholders = String.join(",", Collections.nCopies(ids.size(), "?"));
//            try (PreparedStatement ps = conn.prepareStatement(
//                    "SELECT name, price FROM menu_items WHERE id IN (" + placeholders + ")")) {
//                for (int i = 0; i < ids.size(); i++) {
//                    ps.setInt(i + 1, ids.get(i));
//                }
//
//                try (ResultSet rs = ps.executeQuery()) {
//                    while (rs.next()) {
//                        String name = rs.getString("name");
//                        double price = rs.getDouble("price");
//                        lines.add(new OrderLine(name, price));
//                        total += price;
//                    }
//                }
//            }
//
//            // Insert into orders table
//            String sql = "INSERT INTO orders " +
//                    "(username, rollno, mobile, college, email, purpose, user_type, table_no, food_items, order_time, order_status, total_amount) " +
//                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//            String orderId;
//
//            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
//                ps.setString(1, username);
//                ps.setString(2, rollno);
//                ps.setString(3, mobile);
//                ps.setString(4, college);
//                ps.setString(5, email);
//                ps.setString(6, purpose);
//                ps.setString(7, userType);
//                ps.setString(8, tableNo);
//                ps.setString(9, String.join(",", ids.stream().map(String::valueOf).toArray(String[]::new)));
//                ps.setTimestamp(10, Timestamp.from(Instant.now()));
//                ps.setString(11, "Pending");
//                ps.setDouble(12, total);
//
//                ps.executeUpdate();
//
//                try (ResultSet gk = ps.getGeneratedKeys()) {
//                    if (gk.next()) {
//                        orderId = gk.getString(1); // use String instead of parsing to int
//                    } else {
//                        throw new SQLException("Failed to get generated order ID.");
//                    }
//                }
//            }
//
//            // Set session attributes
//            HttpSession session = req.getSession();
//            session.setAttribute("orderId", orderId);
//            session.setAttribute("orderLines", lines);
//            session.setAttribute("orderTotal", total);
//            session.setAttribute("tableNo", tableNo);
//            session.setAttribute("username", username);
//
//            // Redirect to order success page
//            
//            resp.sendRedirect("orderSuccess.jsp");
//
//        } catch (Exception e) {
//            throw new ServletException("Order placement failed", e);
//        }
//    }
//
//    private String trim(String s) {
//        return (s == null) ? "" : s.trim();
//    }
//}

//package servlet;
//
//import dao.DBConnection;
//import javax.servlet.*;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.sql.*;
//import java.util.*;
//
//@WebServlet(name = "PlaceOrderServlet", urlPatterns = {"/PlaceOrderServlet"})
//public class PlaceOrderServlet extends HttpServlet {
//
//    
//
//    public static class OrderLine {
//        public final String name;
//        public final double price;
//        public OrderLine(String name, double price) {
//            this.name = name;
//            this.price = price;
//        }
//    }
//
//    /**
//     *
//     * @param req
//     * @param resp
//     * @throws ServletException
//     * @throws IOException
//     */
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//
//        // Get form inputs
//        String userType = trim(req.getParameter("userType"));
//        String username = trim(req.getParameter("username"));
//        String rollno   = trim(req.getParameter("rollno"));
//        String mobile   = trim(req.getParameter("mobile"));
//        String college  = trim(req.getParameter("college"));
//        String email    = trim(req.getParameter("email"));
//        String purpose  = trim(req.getParameter("purpose"));
//        String tableNo  = trim(req.getParameter("tableNo"));
//        String[] itemIds = req.getParameterValues("itemIds");
//
//        // Validate inputs
//        if (itemIds == null || itemIds.length == 0) {
//            System.out.println("Product is not selected");
//            resp.sendRedirect("menu.jsp?error=selectItem");
//            return;
//        }
//
//        if (username.isEmpty()) {
//             System.out.println("User name is not selected");
//            resp.sendRedirect("userDetails.jsp?tableNo=" + tableNo + "&error=nameRequired");
//            return;
//        }
//
//        List<Integer> ids = new ArrayList<>();
//        for (String s : itemIds) {
//            if (s != null && !s.trim().isEmpty()) {
//                try {
//                    ids.add(Integer.parseInt(s.trim()));
//                } catch (NumberFormatException ignored) {}
//            }
//        }
//
//        if (ids.isEmpty()) {
//            resp.sendRedirect("menu.jsp?error=invalidItems");
//            return;
//        }
//
//        try (Connection conn = DBConnection.getConnection()) {
//            List<OrderLine> lines = new ArrayList<>();
//            double total = 0;
//
//            // Prepare SQL to fetch item details
//            String placeholders = String.join(",", Collections.nCopies(ids.size(), "?"));
//            try (PreparedStatement ps = conn.prepareStatement(
//                    "SELECT name, price FROM menu_items WHERE id IN (" + placeholders + ")")) {
//                for (int i = 0; i < ids.size(); i++) {
//                    ps.setInt(i + 1, ids.get(i));
//                }
//
//                try (ResultSet rs = ps.executeQuery()) {
//                    while (rs.next()) {
//                        String name = rs.getString("name");
//                        double price = rs.getDouble("price");
//                        lines.add(new OrderLine(name, price));
//                        total += price;
//                    }
//                }
//            }
//
//        //     Insert into orders table
//            String sql = "INSERT INTO orders " +
//                    "(username, rollno, mobile, college, email, purpose, user_type, table_no, food_items, order_time, order_status, total_amount) " +
//                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//            String orderId;
//
//            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
//////                ps.setString(1, username);
//////                ps.setString(2, rollno);
//////                ps.setString(3, mobile);
//////                ps.setString(4, college);
//////                ps.setString(5, email);
//////                ps.setString(6, purpose);
//////                ps.setString(7, userType);
//////                ps.setString(8, tableNo);
//////                ps.setString(9, String.join(",", ids.stream().map(String::valueOf).toArray(String[]::new)));
//////                ps.setTimestamp(10, Timestamp.from(Instant.now()));
//////                ps.setString(11, "Pending");
//////                ps.setDouble(12, total);
////
////                ps.executeUpdate();
////
//                try (ResultSet gk = ps.getGeneratedKeys()) {
//                    if (gk.next()) {
//                       orderId = gk.getString(1); // use String instead of parsing to int
//                    } else {
//                        throw new SQLException("Failed to get generated order ID.");
//                    }
//                }
////            }
//
//            // Set session attributes
//            HttpSession session = req.getSession();
//            session.setAttribute("orderId", orderId);
//            session.setAttribute("orderLines", lines);
//            session.setAttribute("orderTotal", total);
//            session.setAttribute("tableNo", tableNo);
//            session.setAttribute("username", username);
//
//            // Redirect to order success page
//            
//             resp.sendRedirect("payment.jsp");
//             
//
//        } catch (Exception e) {
//            throw new ServletException("Order placement failed", e);
//        }
//    }
//
//    private String trim(String s) {
//        return (s == null) ? "" : s.trim();
//    }
//}
//
//

// Working code for the payment option

package servlet;

import dao.DBConnection;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet(name = "PlaceOrderServlet", urlPatterns = {"/PlaceOrderServlet"})
public class PlaceOrderServlet extends HttpServlet {

    public static class OrderLine {
        public final String name;
        public final double price;
        public final int id;

        public OrderLine(int id, String name, double price) {
            this.id = id;
            this.name = name;
            this.price = price;
        }
         public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Get form inputs
        String userType = trim(req.getParameter("userType"));
        String username = trim(req.getParameter("username"));
        String rollno   = trim(req.getParameter("rollno"));
        String mobile   = trim(req.getParameter("mobile"));
        String college  = trim(req.getParameter("college"));
        String email    = trim(req.getParameter("email"));
        String purpose  = trim(req.getParameter("purpose"));
        String tableNo  = trim(req.getParameter("tableNo"));
        String[] itemIds = req.getParameterValues("itemIds");

        // Validate inputs
        if (itemIds == null || itemIds.length == 0) {
            resp.sendRedirect("menu.jsp?error=selectItem");
            return;
        }
System.out.println(username);
System.out.println(mobile);
System.out.println(email);
System.out.println(userType);
System.out.println(college);


        if (username.isEmpty()) {
            resp.sendRedirect("userDetails.jsp?tableNo=" + tableNo + "&error=nameRequired");
            return;
        }

        List<Integer> ids = new ArrayList<>();
        for (String s : itemIds) {
            if (s != null && !s.trim().isEmpty()) {
                try {
                    ids.add(Integer.parseInt(s.trim()));
                } catch (NumberFormatException ignored) {}
            }
        }

        if (ids.isEmpty()) {
            resp.sendRedirect("menu.jsp?error=invalidItems");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            List<OrderLine> lines = new ArrayList<>();
            double total = 0;

            // Prepare SQL to fetch item details
            String placeholders = String.join(",", Collections.nCopies(ids.size(), "?"));
            try (PreparedStatement ps = conn.prepareStatement(
                    "SELECT id, name, price FROM menu_items WHERE id IN (" + placeholders + ")")) {
                for (int i = 0; i < ids.size(); i++) {
                    ps.setInt(i + 1, ids.get(i));
                }

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        double price = rs.getDouble("price");
                        lines.add(new OrderLine(id, name, price));
                        total += price;
                    }
                }
            }

            // Save order info in session temporarily
            HttpSession session = req.getSession();
            session.setAttribute("userType", userType);
            session.setAttribute("username", username);
            session.setAttribute("rollno", rollno);
            session.setAttribute("mobile", mobile);
            session.setAttribute("college", college);
            session.setAttribute("email", email);
            session.setAttribute("purpose", purpose);
            session.setAttribute("tableNo", tableNo);
            session.setAttribute("orderLines", lines);
            session.setAttribute("orderTotal", total);

            // Redirect to payment page
            resp.sendRedirect("payment.jsp");

        } catch (Exception e) {
            throw new ServletException("Failed to fetch order items", e);
        }
    }

    private String trim(String s) {
        return (s == null) ? "" : s.trim();
    }
}
