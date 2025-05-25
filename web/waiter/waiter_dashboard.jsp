<%-- 
    Document   : waiter_dashboard
    Created on : Apr 29, 2025, 8:54:46 PM
    Author     : prince rajput
--%>

<%--<%@page import="org.apache.catalina.servlets.DefaultServlet.SortManager.Order"%>--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="Order.Order" %>
<!DOCTYPE html>
<html>
<head>
    <title>Waiter Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Waiter Dashboard</h2>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
        <tr>
            <th>Order ID</th>
            <th>Table Number</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%-- Assume orders list available from Servlet --%>
        <% List<Order> orders = (List<Order>) request.getAttribute("orders");
           for(Order o : orders) { 
              if ("Ready".equals(o.getOrderStatus())) { %>
        <tr>
            <td><%= o.getId() %></td>
            <td><%= o.getTableNo() %></td>
            <td><%= o.getOrderStatus() %></td>
            <td>
                <form action="MarkDeliveredServlet" method="post">
                    <input type="hidden" name="orderId" value="<%= o.getId() %>">
                    <button type="submit" class="btn btn-success btn-sm">Mark as Delivered</button>
                </form>
            </td>
        </tr>
        <% } } %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
