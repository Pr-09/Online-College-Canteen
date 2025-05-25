<%-- 
    Document   : viewMenuItems
    Created on : May 4, 2025, 12:14:16 AM
    Author     : prince rajput
--%>

<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="dao.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Menu Items</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4 text-center">Menu Items</h2>
    <table class="table table-bordered table-hover table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Food Name</th>
            <th>Description</th>
            <th>Price (₹)</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                conn = DBConnection.getConnection();
                ps = conn.prepareStatement("SELECT id, name, description, price FROM menu_items ORDER BY id");
                rs = ps.executeQuery();

                while (rs.next()) {
                    int id = rs.getInt("id");
        %>
            <tr>
                <td><%= id %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= String.format("%.2f", rs.getDouble("price")) %></td>
                <td>
                    <a href="editItem.jsp?id=<%= id %>" class="btn btn-sm btn-primary">Edit</a>
                    <a href="DeleteMenuItemServlet?id=<%= id %>" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='5'>Error loading menu items</td></tr>");
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

