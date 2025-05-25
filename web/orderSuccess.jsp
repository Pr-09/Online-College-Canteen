<%--
<%@ page import="java.util.List" %>
<%@ page session="true" language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Order Confirmation</title>
  <link 
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" 
    rel="stylesheet"/>
</head>
<body class="bg-light">
<div class="container mt-5">
  <div class="card p-5 shadow-lg">
    <h2 class="text-success">
      ✅ Order #<%=session.getAttribute("orderId")%> Placed!
    </h2>
    <p class="lead mt-2">
      Thank you, <b><%=session.getAttribute("username")%></b>!<br/>
      Your food will be served shortly at table <b><%=session.getAttribute("tableNo")%></b>.
    </p>

    <h4 class="mt-4">Your Ordered Items:</h4>
    <ul class="list-group mb-3">
      <%
        List<?> lines = (List<?>)session.getAttribute("orderLines");
        for(Object o : lines){
          servlet.PlaceOrderServlet.OrderLine l = (servlet.PlaceOrderServlet.OrderLine)o;
      %>
        <li class="list-group-item d-flex justify-content-between align-items-center">
          <%= l.name %>
          <span class="badge bg-primary rounded-pill">Rs <%= l.price %></span>
        </li>
      <% } %>
    </ul>

    <h4 class="text-end">Total: <span class="text-success">Rs <%=session.getAttribute("orderTotal")%></span></h4>

    <div class="mt-4 text-center">
      <a href="menu.jsp?tableNo=<%=session.getAttribute("tableNo")%>" class="btn btn-primary me-2">🍽️ Order More</a>
      <a href="logout.jsp" class="btn btn-outline-danger">Logout</a>
    </div>
  </div>
</div>
</body>
</html>

--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*, servlet.PlaceOrderServlet.OrderLine" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Success</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Order Placed Successfully</h1>

        <div class="order-details">
            <h2>Order Details:</h2>

            <%
                String orderId = (String) session.getAttribute("orderId");
                String username = (String) session.getAttribute("username");
                String tableNo = (String) session.getAttribute("tableNo");
                Double orderTotal = (Double) session.getAttribute("orderTotal");
                List<OrderLine> orderLines = (List<OrderLine>) session.getAttribute("orderLines");
            %>

            <p><strong>Order ID:</strong> <%= orderId %></p>
            <p><strong>Username:</strong> <%= username %></p>
            <p><strong>Table No:</strong> <%= tableNo %></p>
            <p><strong>Total Amount:</strong> ₹<%= orderTotal %></p>

            <h3>Ordered Items:</h3>
            <ul>
                <%
                    if (orderLines != null) {
                        for (OrderLine line : orderLines) {
                %>
                            <li><%= line.getName() %> - ₹<%= line.getPrice() %></li>
                <%
                        }
                    }
                %>
            </ul>
        </div>

        <div class="sms-notification">
            <p>Your order has been successfully placed, and a confirmation SMS has been sent to the mobile number associated with your order.</p>
            <p><a href="menu.jsp">Back to Menu</a></p>
        </div>
    </div>
    <!-- Optional: Add some basic styling -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #28a745;
        }

        h2 {
            color: #333;
        }

        .order-details {
            margin-top: 20px;
            text-align: left;
        }

        .order-details ul {
            list-style-type: none;
            padding: 0;
        }

        .sms-notification {
            margin-top: 30px;
            color: #28a745;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }
    </style>
</body>
</html>
