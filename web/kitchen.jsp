<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="dao.DBConnection" %>
<%
    String adminUser = (String) session.getAttribute("adminUser");
    if (adminUser == null) {
        session.setAttribute("errorMessage", "First you have to login yourself");
        response.sendRedirect("index.jsp"); // or your login page name
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
    <title>Kitchen Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Auto-refresh every 5 seconds -->
    <meta http-equiv="refresh" content="20">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Kitchen Dashboard 🍽️</h2>
    <div class="card">
        <div class="card-body">
            <table class="table table-bordered table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Order ID</th>
                        <th>Table No</th>
                        <th>Food Items</th>
                        <th>Status</th>
                        <th>Update Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection con = null;
                    PreparedStatement ps = null, psNames = null;
                    ResultSet rs = null, rsNames = null;

                    try {
                        con = DBConnection.getConnection();
                        String sql = 
                            "SELECT id, table_no, food_items, order_status " +
                            "FROM orders " +
                            "WHERE order_status != 'Delivered' " +
                            "ORDER BY id DESC";
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int orderId     = rs.getInt("id");
                            String tableNo  = rs.getString("table_no");
                            String itemsCsv = rs.getString("food_items");
                            String status   = rs.getString("order_status");

                            // Resolve item IDs to names
                            List<String> names = new ArrayList<>();
                            if (itemsCsv != null && !itemsCsv.trim().isEmpty()) {
                                String[] ids = itemsCsv.split("\\s*,\\s*");
                                String placeholders = String.join(",", Collections.nCopies(ids.length, "?"));
                                String nameSql = "SELECT name FROM menu_items WHERE id IN (" + placeholders + ")";
                                psNames = con.prepareStatement(nameSql);
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
                        <td><%= tableNo %></td>
                        <td><%= displayNames %></td>
                        <td><%= status %></td>
                        <td>
                            <form action="UpdateOrderStatusServlet" method="post" class="d-flex justify-content-center">
                                <input type="hidden" name="orderId" value="<%= orderId %>">
                                <select name="newStatus" class="form-select w-50" required>
                                    <option value="" disabled selected>Select</option>
                                    <option value="Preparing">Preparing</option>
                                    <option value="Ready">Ready</option>
                                    <option value="Delivered">Delivered</option>
                                </select>
                                <button type="submit" class="btn btn-primary ms-2">Update</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr>
                        <td colspan="5" class="text-danger">
                            Error loading orders: <%= e.getMessage() %>
                        </td>
                    </tr>
                <%
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception ignore) {}
                        try { if (ps != null) ps.close(); } catch (Exception ignore) {}
                        try { if (con != null) con.close(); } catch (Exception ignore) {}
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
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
    <title>Kitchen Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Auto-refresh every 5 seconds -->
    <meta http-equiv="refresh" content="5">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Kitchen Dashboard 🍽️</h2>
    <div class="card">
        <div class="card-body">
            <table class="table table-bordered table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Order ID</th>
                        <th>Table No</th>
                        <th>Food Items</th>
                        <th>Status</th>
                        <th>Update Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection con = null;
                    PreparedStatement ps = null, psNames = null;
                    ResultSet rs = null, rsNames = null;

                    try {
                        con = DBConnection.getConnection();
                        String sql = 
                            "SELECT id, table_no, food_items, order_status " +
                            "FROM orders " +
                            "WHERE order_status != 'Delivered' " +
                            "ORDER BY id DESC";
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int orderId     = rs.getInt("id");
                            String tableNo  = rs.getString("table_no");
                            String itemsCsv = rs.getString("food_items");
                            String status   = rs.getString("order_status");

                            // Resolve item IDs to names
                            List<String> names = new ArrayList<>();
                            if (itemsCsv != null && !itemsCsv.trim().isEmpty()) {
                                String[] ids = itemsCsv.split("\\s*,\\s*");
                                String placeholders = String.join(",", Collections.nCopies(ids.length, "?"));
                                String nameSql = "SELECT name FROM menu_items WHERE id IN (" + placeholders + ")";
                                psNames = con.prepareStatement(nameSql);
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
                        <td><%= tableNo %></td>
                        <td><%= displayNames %></td>
                        <td><%= status %></td>
                        <td>
                            <form action="UpdateOrderStatusServlet" method="post" class="d-flex justify-content-center">
                                <input type="hidden" name="orderId" value="<%= orderId %>">
                                <select name="newStatus" class="form-select w-50" required>
                                    <option value="" disabled selected>Select</option>
                                    <option value="Preparing">Preparing</option>
                                    <option value="Ready">Ready</option>
                                    <option value="Delivered">Delivered</option>
                                </select>
                                <button type="submit" class="btn btn-primary ms-2">Update</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr>
                        <td colspan="5" class="text-danger">
                            Error loading orders: <%= e.getMessage() %>
                        </td>
                    </tr>
                <%
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception ignore) {}
                        try { if (ps != null) ps.close(); } catch (Exception ignore) {}
                        try { if (con != null) con.close(); } catch (Exception ignore) {}
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
--%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.sql.*" %>
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
    <title>Kitchen Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Auto-refresh every 5 seconds -->
    <meta http-equiv="refresh" content="5">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Kitchen Dashboard 🍽️</h2>
    <div class="card">
        <div class="card-body">
            <table class="table table-bordered table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Order ID</th>
                        <th>Table No</th>
                        <th>Food Items</th>
                        <th>Status</th>
                        <th>Update Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = DBConnection.getConnection();
                        String sql = 
                            "SELECT id, table_no, food_items, order_status " +
                            "FROM orders " +
                            "WHERE order_status != 'Delivered' " +
                            "ORDER BY id DESC";
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            int orderId     = rs.getInt("id");
                            String tableNo  = rs.getString("table_no");
                            String itemsCsv = rs.getString("food_items");  // Already contains names
                            String status   = rs.getString("order_status");
                %>
                    <tr>
                        <td><%= orderId %></td>
                        <td><%= tableNo %></td>
                        <td><%= (itemsCsv != null && !itemsCsv.trim().isEmpty()) ? itemsCsv : "<em>No items</em>" %></td>
                        <td><%= status %></td>
                        <td>
                            <form action="UpdateOrderStatusServlet" method="post" class="d-flex justify-content-center">
                                <input type="hidden" name="orderId" value="<%= orderId %>">
                                <select name="newStatus" class="form-select w-50" required>
                                    <option value="" disabled selected>Select</option>
                                    <option value="Preparing">Preparing</option>
                                    <option value="Ready">Ready</option>
                                    <option value="Delivered">Delivered</option>
                                </select>
                                <button type="submit" class="btn btn-primary ms-2">Update</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr>
                        <td colspan="5" class="text-danger">
                            Error loading orders: <%= e.getMessage() %>
                        </td>
                    </tr>
                <%
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception ignore) {}
                        try { if (ps != null) ps.close(); } catch (Exception ignore) {}
                        try { if (con != null) con.close(); } catch (Exception ignore) {}
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
