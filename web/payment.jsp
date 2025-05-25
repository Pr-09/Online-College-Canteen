<%-- 
    Document   : payment
    Created on : May 5, 2025, 10:40:06 PM
    Author     : prince rajput


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, servlet.PlaceOrderServlet.OrderLine" %>
<%@ page session="true" %>
<%
    // Pull order details from session
    String orderId    = (String) session.getAttribute("orderId");
    List<OrderLine> lines = (List<OrderLine>) session.getAttribute("orderLines");
    Double total      = (Double) session.getAttribute("orderTotal");
    String tableNo    = (String) session.getAttribute("tableNo");
    String username   = (String) session.getAttribute("username");

    if (orderId == null || lines == null) {
        response.sendRedirect("menu.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Payment</title>
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>
<body class="bg-light">
  <div class="container my-5">
    <h3 class="mb-4">Order #<%= orderId %> ? Review & Pay</h3>

    <form action="PaymentServlet" method="post">
      <input type="hidden" name="orderId" value="<%= orderId %>"/>
      <input type="hidden" name="tableNo" value="<%= tableNo %>"/>
      <input type="hidden" name="username" value="<%= username %>"/>

      <!-- Order Lines with remove option -->
      <ul class="list-group mb-3">
        <% for (int i = 0; i < lines.size(); i++) {
             OrderLine ln = lines.get(i);
        %>
        <li class="list-group-item d-flex justify-content-between align-items-center">
          <div>
            <input type="checkbox" name="removeIds" value="<%= i %>">
            <strong><%= ln.name %></strong> ? ?<%= String.format("%.2f", ln.price) %>
          </div>
          <span>?<%= String.format("%.2f", ln.price) %></span>
        </li>
        <% } %>
      </ul>

      <!-- New total after removal -->
      <div class="mb-3">
        <label class="form-label">Amount to Pay:</label>
        <input type="text" id="payAmount" name="payAmount"
               value="<%= String.format("%.2f", total) %>"
               readonly class="form-control"/>
      </div>

      <!-- Simulated payment gateway button -->
      <button type="submit" class="btn btn-primary">
        Proceed to Payment
      </button>
    </form>
  </div>

  <script>
    // Simple JS: remove checked items and recalc total on the fly
    document.querySelector("form").addEventListener("change", e => {
      const checkboxes = Array.from(
        document.querySelectorAll("input[name=removeIds]"));
      let baseTotal = parseFloat("<%= total %>");
      checkboxes.forEach((cb, idx) => {
        if (cb.checked) {
          // subtract the corresponding price
          const priceText = cb.closest("li")
                              .querySelector("span").innerText;
          baseTotal -= parseFloat(priceText);
        }
      });
      document.getElementById("payAmount").value =
        baseTotal.toFixed(2);
    });
  </script>
</body>
</html>



<%@ page import="java.util.*, servlet.PlaceOrderServlet.OrderLine" %>
<%@ page session="true" %>
<%
    List<OrderLine> orderLines = (List<OrderLine>) session.getAttribute("orderLines");
    String username = (String) session.getAttribute("username");
    String tableNo = (String) session.getAttribute("tableNo");
    Double totalAmount = (Double) session.getAttribute("orderTotal");
    String email = (String) session.getAttribute("email");
    String mobile = (String) session.getAttribute("mobile");

    if (orderLines == null || orderLines.isEmpty()) {
        response.sendRedirect("menu.jsp?error=emptyOrder");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        table { width: 60%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .summary { margin-bottom: 20px; }
    </style>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>

<h2>Payment Details</h2>

<p class="summary">
    <strong>Name: </strong><h3><%= username %></h3>
    <strong>Table No: </strong><h3><%= tableNo %></h3>
</p>

<table>
    <tr>
        <th><h3>Item</h3></th>
        <th><h3>Price (Rs.)</h3></th>
    </tr>
    <% for (OrderLine line : orderLines) { %>
        <tr>
            <td><%= line.name %></td>
            <td><%= line.price %></td>
        </tr>
    <% } %>
</table>

<p><strong>Total: Rs </strong><%= totalAmount %></p>

<!-- Razorpay button -->
<button id="rzp-button1">Proceed to Pay</button>

<script>
    var options = {
        "key": "rzp_test_8eJ3Bw4Wj5FYAd", 
        "amount": <%= (int)(totalAmount * 100) %>, // Amount in paise
        "currency": "INR",
        "name": "Canteen Order",
        "description": "Order Payment",
        "handler": function (response) {
            // Redirect to servlet with payment ID
            window.location.href = "PaymentServlet?razorpay_payment_id=" + response.razorpay_payment_id;
        },
        
        "prefill": {
            "name": "<%= username %>",
            "email": "<%= email %>",
            "contact": "<%= mobile %>"
        },
        "theme": {
            "color": "#3399cc"
        }
    };

    var rzp1 = new Razorpay(options);

    document.getElementById('rzp-button1').onclick = function (e) {
        rzp1.open();
        e.preventDefault();
    };
</script>

</body>
</html>
--%>


<%@ page import="java.util.*, servlet.PlaceOrderServlet.OrderLine" %>
<%@ page session="true" %>
<%
    List<OrderLine> orderLines = (List<OrderLine>) session.getAttribute("orderLines");
    String username = (String) session.getAttribute("username");
    String tableNo = (String) session.getAttribute("tableNo");
    Double totalAmount = (Double) session.getAttribute("orderTotal");
    String email = (String) session.getAttribute("email");
    String mobile = (String) session.getAttribute("mobile");

    if (orderLines == null || orderLines.isEmpty()) {
        response.sendRedirect("menu.jsp?error=emptyOrder");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Secure Payment</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f8fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
        }

        .container {
            background: #fff;
            margin-top: 40px;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 700px;
        }

        h2 {
            margin-top: 0;
            color: #333;
        }

        .summary {
            font-size: 16px;
            margin-bottom: 20px;
            color: #555;
        }

        .summary h3 {
            margin: 5px 0;
            color: #000;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        th, td {
            padding: 12px 16px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f1f1f1;
            color: #222;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .total {
            font-size: 18px;
            font-weight: bold;
            text-align: right;
            margin-top: 10px;
        }

        #rzp-button1 {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        #rzp-button1:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Payment Summary</h2>

    <div class="summary">
        <strong>Name:</strong> <h3><%= username %></h3>
        <strong>Table No:</strong> <h3><%= tableNo %></h3>
    </div>

    <table>
        <tr>
            <th>Item</th>
            <th>Price (Rs.)</th>
        </tr>
        <% for (OrderLine line : orderLines) { %>
        <tr>
            <td><%= line.name %></td>
            <td><%= line.price %></td>
        </tr>
        <% } %>
    </table>

    <div class="total">Total: ? <%= totalAmount %></div>

    <button id="rzp-button1">Proceed to Secure Payment</button>
</div>

<script>
    var options = {
        "key": "rzp_test_8eJ3Bw4Wj5FYAd", // Replace with your Razorpay key
        "amount": <%= (int)(totalAmount * 100) %>,
        "currency": "INR",
        "name": "OnlineCanteenOrderingSystem",
        "description": "Order Payment",
        "handler": function (response) {
            // Redirect to JSP that forwards to PaymentServlet
            window.location.href = "paymentCallback.jsp?razorpay_payment_id=" + response.razorpay_payment_id;
        },
        "prefill": {
            "name": "<%= username %>",
            "email": "<%= email %>",
            "contact": "<%= mobile %>"
        },
        "theme": {
            "color": "#4CAF50"
        }
    };

    var rzp1 = new Razorpay(options);
    document.getElementById('rzp-button1').onclick = function (e) {
        rzp1.open();
        e.preventDefault();
    };
</script>

</body>
</html>
