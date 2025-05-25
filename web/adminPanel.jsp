<!-- This is basicaly for coversion from Item id to name -->
<%--

<%@page import="java.util.*"%>
<%@page import="dao.DBConnection"%>
<%@page import="Order.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    List<Order> orders = new ArrayList<>();

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT id, username, mobile, table_no, food_items, order_status FROM orders ORDER BY order_time DESC");
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            int id = rs.getInt("id");
            String username = rs.getString("username");
            String mobile = rs.getString("mobile");
            String tableNo = rs.getString("table_no");
            String foodItems = rs.getString("food_items");
            String orderStatus = rs.getString("order_status");

            // Convert item IDs to names
            List<String> itemNames = new ArrayList<>();
            String[] ids = foodItems.split(",");

            if (ids.length > 0) {
              StringBuilder sql = new StringBuilder("SELECT name FROM menu_items WHERE id IN (");
for (int i = 0; i < ids.length; i++) {
    sql.append("?,");
}
sql.setLength(sql.length() - 1); // remove last comma
sql.append(")");

                PreparedStatement itemStmt = con.prepareStatement(sql.toString());
                for (int i = 0; i < ids.length; i++) {
                    itemStmt.setInt(i + 1, Integer.parseInt(ids[i]));
                }

                ResultSet itemsRs = itemStmt.executeQuery();
                while (itemsRs.next()) {
                    itemNames.add(itemsRs.getString("name"));
                }
                itemsRs.close();
                itemStmt.close();
            }

            orders.add(new Order(id, username, mobile, tableNo, String.join(", ", itemNames), orderStatus));
        }
        rs.close();
        ps.close();
        con.close();

    } catch(Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - Order Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center">Admin Panel - Order Status</h2>

    <div class="table-responsive mt-4">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Mobile No</th>
                    <th>Table No</th>
                    <th>Food Items</th>
                    <th>Order Status</th>
                    <th>Update Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Order order : orders) { %>
                <tr>
                    <td><%= order.getId() %></td>
                    <td><%= order.getUsername() %></td>
                    <td><%= order.getMobile() %></td> <!-- This now holds mobile number -->
                    <td><%= order.getTableNo() %></td>
                    <td><%= order.getFoodItems() %></td>
                    <td><%= order.getOrderStatus() %></td>
                    <td>
                        <form action="updateOrderStatus.jsp" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                            <select name="status" class="form-select">
                                <option value="Preparing" <%= "Preparing".equals(order.getOrderStatus()) ? "selected" : "" %>>Preparing</option>
                                <option value="Ready" <%= "Ready".equals(order.getOrderStatus()) ? "selected" : "" %>>Ready</option>
                                <option value="Delivered" <%= "Delivered".equals(order.getOrderStatus()) ? "selected" : "" %>>Delivered</option>
                            </select>
                            <button type="submit" class="btn btn-success mt-2">Update</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
--%>



<%@page import="java.util.*"%>
<%@page import="dao.DBConnection"%>
<%@page import="Order.Order"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    List<Order> orders = new ArrayList<>();

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT id, username, mobile, table_no, food_items, order_status FROM orders ORDER BY order_time DESC");
        ResultSet rs = ps.executeQuery();

        while(rs.next()) {
            int id = rs.getInt("id");
            String username = rs.getString("username");
            String mobile = rs.getString("mobile");
            String tableNo = rs.getString("table_no");
            String foodItems = rs.getString("food_items"); // Directly using names now
            String orderStatus = rs.getString("order_status");

            orders.add(new Order(id, username, mobile, tableNo, foodItems, orderStatus));
        }
        rs.close();
        ps.close();
        con.close();

    } catch(Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - Order Status</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center">Admin Panel - Order Status</h2>

    <div class="table-responsive mt-4">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Mobile No</th>
                    <th>Table No</th>
                    <th>Food Items</th>
                    <th>Order Status</th>
                    <th>Update Status</th>
                </tr>
            </thead>
            <tbody>
                <% for (Order order : orders) { %>
                <tr>
                    <td><%= order.getId() %></td>
                    <td><%= order.getUsername() %></td>
                    <td><%= order.getMobile() %></td>
                    <td><%= order.getTableNo() %></td>
                    <td><%= order.getFoodItems() %></td>
                    <td><%= order.getOrderStatus() %></td>
                    <td>
                        <form action="updateOrderStatus.jsp" method="post">
                            <input type="hidden" name="orderId" value="<%= order.getId() %>">
                            <select name="status" class="form-select">
                                <option value="Preparing" <%= "Preparing".equals(order.getOrderStatus()) ? "selected" : "" %>>Preparing</option>
                                <option value="Ready" <%= "Ready".equals(order.getOrderStatus()) ? "selected" : "" %>>Ready</option>
                                <option value="Delivered" <%= "Delivered".equals(order.getOrderStatus()) ? "selected" : "" %>>Delivered</option>
                            </select>
                            <button type="submit" class="btn btn-success mt-2">Update</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
