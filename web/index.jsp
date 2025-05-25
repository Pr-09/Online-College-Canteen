<%-- 
    Document   : index
    Created on : Apr 29, 2025, 9:04:24 PM
    Author     : prince rajput


<!--<!DOCTYPE html>
<html lang="en">
<head>
    <title>Canteen Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5 bg-white p-4 rounded shadow">
            <h2 class="text-center mb-4">Login</h2>
            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label>Username</label>
                    <input type="text" name="username" class="form-control" required/>
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" name="password" class="form-control" required/>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>
<%--  <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
%>
                <div class="alert alert-danger mt-3"><%= error %></div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("menu.jsp?tableNo=1"); // default redirect if already logged in
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Canteen Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-5 bg-white p-4 rounded shadow">
            <h2 class="text-center mb-4">Login</h2>
            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label for="username">Username</label>
                    <input type="text" name="username" id="username" class="form-control" required placeholder="Enter your username"/>
                </div>
                <div class="mb-3">
                    <label for="password">Password</label>
                    <input type="password" name="password" id="password" class="form-control" required placeholder="Enter your password"/>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Login</button>
                </div>
            </form>

            <% String error = (String) request.getAttribute("error");
               if (error != null) { %>
                <div class="alert alert-danger mt-3"><%= error %></div>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("menu.jsp?tableNo=1"); // redirect if already logged in
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Login Page</title>
  <link rel="stylesheet" href="index.css" />
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
    crossorigin="anonymous"
    referrerpolicy="no-referrer"
  />
</head>
<body>
<h2>Admin Login Page</h2>
<div class="container" id="container">
  <div class="form-container sign-up-container">
    <form action="RegisterServlet" method="post">
      <h1>Create Account</h1>
      <div class="social-container">
        <a href="https://www.facebook.com" class="social"><i class="fa-brands fa-facebook"></i></a>
        <a href="https://www.google.com" class="social"><i class="fa-brands fa-google"></i></a>
        <a href="https://www.linkedin.com" class="social"><i class="fa-brands fa-linkedin"></i></a>
      </div>
      <span>or use your email for registration</span>
      <input type="text" name="name" placeholder="Name" required />
      <input type="email" name="email" placeholder="Email" required />
      <input type="password" name="password" placeholder="Password" required />
      <button type="submit">Sign Up</button>
    </form>
  </div>

  <div class="form-container sign-in-container">
    <form action="LoginServlet" method="post">
      <h1>Sign in</h1>
      <div class="social-container">
        <a href="https://www.facebook.com/" class="social" style="background-image: url('fblogo.png')">
          <i class="fab fa-facebook-f"></i>
        </a>
        <a href="https://www.google.com" class="social" style="background-image: url('glogo.png')">
          <i class="fab fa-google-plus-g"></i>
        </a>
        <a href="https://www.linkedin.com" class="social" style="background-image: url('inslogo.png')">
          <i class="fab fa-linkedin-in"></i>
        </a>
      </div>
      <span>or use your account</span>
      <input type="text" name="username" placeholder="UserName" id="username" required />
      <input type="password" name="password" placeholder="Password" id="password" required />
      <a href="#">Forgot your password?</a>
      <button type="submit">Sign In</button>

      <% String error = (String) request.getAttribute("error");
         if (error != null) { %>
         <div class="error-message" style="color:red; margin-top:10px;"><%= error %></div>
      <% } %>
    </form>
  </div>

  <div class="overlay-container">
    <div class="overlay">
      <div class="overlay-panel overlay-left">
        <h1>Welcome Back!</h1>
        <p>To keep connected with us please login with your personal info</p>
        <button class="ghost" id="signIn">Sign In</button>
      </div>
      <div class="overlay-panel overlay-right">
        <h1>Hello, Foodies!</h1>
        <p>
          Enter your personal details and satisfy your every craving with us.
        </p>
<!--        <button class="ghost" id="signUp">Sign Up</button>-->
      </div>
    </div>
  </div>
</div>

<script>
  const signUpButton = document.getElementById('signUp');
  const signInButton = document.getElementById('signIn');
  const container = document.getElementById('container');

  signUpButton.addEventListener('click', () => {
    container.classList.add("right-panel-active");
  });

  signInButton.addEventListener('click', () => {
    container.classList.remove("right-panel-active");
  });
</script>
</body>
</html>
