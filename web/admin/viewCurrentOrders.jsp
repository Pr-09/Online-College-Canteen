<%--<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.DBConnection" %>
<%@ page session="true" %>
//
<%
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        session.setAttribute("errorMessage", "First you have to login yourself");
        response.sendRedirect("../index.jsp"); // or your login page name
        return;
    }
%>
<%
    if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect("../index.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Current Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Current Orders (Admin View)</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>Order ID</th>
            <th>Table Number</th>
            <th>Order Details</th>
            <th>Status</th>
            <th>Order Time</th>
            <th>Update Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement ps = null, psNames = null;
            ResultSet rs = null, rsNames = null;

            try {
                conn = DBConnection.getConnection();

                String sql = 
                    "SELECT id, table_no, food_items, order_status, order_time " +
                    "FROM orders " +
                    "WHERE TRUNC(order_time) = TRUNC(SYSDATE) " +
                    "ORDER BY CASE order_status WHEN 'Pending' THEN 1 ELSE 2 END, order_time DESC";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int orderId     = rs.getInt("id");
                    int tableNumber = rs.getInt("table_no");
                    String itemsCsv = rs.getString("food_items");
                    String status   = rs.getString("order_status");
                    Timestamp time  = rs.getTimestamp("order_time");

                    // Convert item IDs to names
                    List<String> names = new ArrayList<>();
                    if (itemsCsv != null && !itemsCsv.trim().isEmpty()) {
                        String[] ids = itemsCsv.split("\\s*,\\s*");
                        String placeholders = String.join(",", Collections.nCopies(ids.length, "?"));
                        String nameSql = "SELECT name FROM menu_items WHERE id IN (" + placeholders + ")";
                        psNames = conn.prepareStatement(nameSql);
                        for (int i = 0; i < ids.length; i++) {
                            psNames.setInt(i + 1, Integer.parseInt(ids[i]));
                        }
                        rsNames = psNames.executeQuery();
                        while (rsNames.next()) {
                            names.add(rsNames.getString("name"));
                        }
                        rsNames.close();
                        psNames.close();
                    }
                    String displayNames = names.isEmpty()
                                          ? "<em>No items</em>"
                                          : String.join(", ", names);
        %>
        <tr>
            <td><%= orderId %></td>
            <td><%= tableNumber %></td>
            <td><%= displayNames %></td>
            <td><%= status %></td>
            <td><%= time %></td>
            <td>
                <form action="../UpdateOrderStatusServlet" method="post" class="d-flex">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <select name="newStatus" class="form-select form-select-sm me-2" required>
                        <option disabled selected>Change...</option>
                        <option value="Preparing">Preparing</option>
                        <option value="Ready">Ready</option>
                        <option value="Delivered">Delivered</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="6" class="text-danger">
                Error loading orders: <%= e.getMessage() %>
            </td>
        </tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>



<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.DBConnection" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect("../index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Current Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Current Orders (Admin View)</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>Order ID</th>
            <th>Table Number</th>
            <th>Order Details</th>
            <th>Status</th>
            <th>Order Time</th>
            <th>Update Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement ps = null, psNames = null;
            ResultSet rs = null, rsNames = null;

            try {
                conn = DBConnection.getConnection();

                String sql = 
                    "SELECT id, table_no, food_items, order_status, order_time " +
                    "FROM orders " +
                    "WHERE TRUNC(order_time) = TRUNC(SYSDATE) " +
                    "ORDER BY CASE order_status WHEN 'Pending' THEN 1 ELSE 2 END, order_time DESC";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int orderId     = rs.getInt("id");
                    int tableNumber = rs.getInt("table_no");
                    String itemsCsv = rs.getString("food_items");
                    String status   = rs.getString("order_status");
                    Timestamp time  = rs.getTimestamp("order_time");

                    // Convert item IDs to names
                    List<String> names = new ArrayList<>();
                    if (itemsCsv != null && !itemsCsv.trim().isEmpty()) {
                        String[] ids = itemsCsv.split("\\s*,\\s*");
                        String placeholders = String.join(",", Collections.nCopies(ids.length, "?"));
                        String nameSql = "SELECT name FROM menu_items WHERE id IN (" + placeholders + ")";
                        psNames = conn.prepareStatement(nameSql);
                        for (int i = 0; i < ids.length; i++) {
                            psNames.setInt(i + 1, Integer.parseInt(ids[i]));
                        }
                        rsNames = psNames.executeQuery();
                        while (rsNames.next()) {
                            names.add(rsNames.getString("name"));
                        }
                        rsNames.close();
                        psNames.close();
                    }
                    String displayNames = names.isEmpty()
                                          ? "<em>No items</em>"
                                          : String.join(", ", names);
        %>
        <tr>
            <td><%= orderId %></td>
            <td><%= tableNumber %></td>
            <td><%= displayNames %></td>
            <td><%= status %></td>
            <td><%= time %></td>
            <td>
                <form action="../UpdateOrderStatusServlet" method="post" class="d-flex">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <select name="newStatus" class="form-select form-select-sm me-2" required>
                        <option disabled selected>Change...</option>
                        <option value="Preparing">Preparing</option>
                        <option value="Ready">Ready</option>
                        <option value="Delivered">Delivered</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="6" class="text-danger">
                Error loading orders: <%= e.getMessage() %>
            </td>
        </tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>


<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.DBConnection" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect("../index.jsp");
    }
%>
--%>

<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="dao.DBConnection" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect("../index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Current Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Current Orders (Admin View)</h2>
    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>Order ID</th>
            <th>Table Number</th>
            <th>Order Details</th>
            <th>Status</th>
            <th>Order Time</th>
            <th>Update Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.getConnection();

                String sql = 
                    "SELECT id, table_no, food_items, order_status, order_time " +
                    "FROM orders " +
                    "WHERE TRUNC(order_time) = TRUNC(SYSDATE) " +
                    "ORDER BY CASE order_status WHEN 'Pending' THEN 1 ELSE 2 END, order_time DESC";
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();

                while (rs.next()) {
                    int orderId     = rs.getInt("id");
                    int tableNumber = rs.getInt("table_no");
                    String itemsCsv = rs.getString("food_items"); // Already contains names
                    String status   = rs.getString("order_status");
                    Timestamp time  = rs.getTimestamp("order_time");
        %>
        <tr>
            <td><%= orderId %></td>
            <td><%= tableNumber %></td>
            <td><%= (itemsCsv != null && !itemsCsv.trim().isEmpty()) ? itemsCsv : "<em>No items</em>" %></td>
            <td><%= status %></td>
            <td><%= time %></td>
            <td>
                <form action="../UpdateOrderStatusServlet" method="post" class="d-flex">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <select name="newStatus" class="form-select form-select-sm me-2" required>
                        <option disabled selected>Change...</option>
                        <option value="Preparing">Preparing</option>
                        <option value="Ready">Ready</option>
                        <option value="Delivered">Delivered</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm">Update</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
        %>
        <tr>
            <td colspan="6" class="text-danger">
                Error loading orders: <%= e.getMessage() %>
            </td>
        </tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                try { if (conn != null) conn.close(); } catch (Exception ignored) {}
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
