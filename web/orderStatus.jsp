<%-- 
    Document   : orderStatus
    Created on : May 1, 2025, 9:30:14 AM
    Author     : prince rajput
--%>

<%@page import="dao.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<%@ page session="true" %>
<%
    String mobile = (String)session.getAttribute("mobile");

    String orderStatus = "Preparing"; // Default
    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT order_status FROM orders WHERE mobile = ? ORDER BY order_time DESC FETCH FIRST 1 ROWS ONLY");
        ps.setString(1, mobile);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            orderStatus = rs.getString("order_status");
        }
    } catch(Exception e){
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Status</title>
    <meta http-equiv="refresh" content="5"> <!-- Refresh every 5 seconds -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container text-center mt-5">
    <div class="card shadow-lg p-5">
        <h2>Order Status for <b><%= session.getAttribute("username") %></b></h2>
        <h4 class="mt-4">
            <% if(orderStatus.equalsIgnoreCase("Preparing")) { %>
                <span class="badge bg-warning text-dark">Preparing 🛠️</span>
            <% } else if(orderStatus.equalsIgnoreCase("Ready")) { %>
                <span class="badge bg-primary">Ready ✅</span>
            <% } else if(orderStatus.equalsIgnoreCase("Delivered")) { %>
                <span class="badge bg-success">Delivered 🍽️</span>
            <% } else { %>
                <span class="badge bg-secondary">Unknown</span>
            <% } %>
        </h4>
        <p class="mt-3">This page refreshes automatically every 5 seconds 🔄</p>
    </div>
</div>

</body>
</html>

