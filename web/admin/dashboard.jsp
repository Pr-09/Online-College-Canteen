<%-- 
    Document   : dashboard
    Created on : Apr 29, 2025, 8:52:55 PM
    Author     : prince rajput
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    if(session.getAttribute("role") == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect("../index.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2>Admin Dashboard</h2>
    <div class="mt-4">
        <a href="addRemoveItems.jsp" class="btn btn-success">Add and Remove Item</a>
<!--        <a href="../menu.jsp" class="btn btn-info">View Menu</a>-->
        <a href="viewCurrentOrders.jsp" class="btn btn-warning">View Current Orders</a>
        <a href="../adminPanel.jsp" class="btn btn-success">All Orders</a>
         <a href="viewMenuItems.jsp" class="btn btn-info">All Menu items</a>
        <a href="../logout.jsp" class="btn btn-danger">Logout</a>
    </div>
</div>
</body>
</html>


