<%-- 
    Document   : paymentCallback
    Created on : May 11, 2025, 1:53:12 PM
    Author     : prince rajput
--%>

<%@ page import="java.io.*, javax.servlet.*" %>
<%
    String paymentId = request.getParameter("razorpay_payment_id");
     System.out.println(paymentId);
    if (paymentId == null || paymentId.isEmpty()) {
        response.sendRedirect("payment.jsp?error=paymentMissing");
        return;
    }
%>
<html>
<head><title>Processing Payment...</title></head>
<body>
    <form id="forwardForm" action="Prince" method="POST">
        <input type="hidden" name="razorpay_payment_id" value="<%= paymentId %>">
    </form>

    <script>
        document.getElementById('forwardForm').submit();
    </script>
</body>
</html>
