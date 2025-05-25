<%-- 
    Document   : updateOrderStatus
    Created on : May 1, 2025, 9:33:20 AM
    Author     : prince rajput
--%>

<%@page import="dao.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<%@ page session="true" %>
<%
    String orderId = request.getParameter("orderId");
    String status = request.getParameter("status");

    try {
        Connection con = DBConnection.getConnection();
        String sql = "UPDATE orders SET order_status = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, status);
        
        ps.setInt(2, Integer.parseInt(orderId));
        ps.executeUpdate();  // Execute update

        response.sendRedirect("adminPanel.jsp");  // Redirect back to admin panel after update
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(500, "Internal Server Error");
    }
%>

