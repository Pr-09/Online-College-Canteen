
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page session="true" %>
<%
    // Invalidate the session safely
    if (session != null) {
        session.invalidate();
    }
%>--%>
<%@ page session="true" %>
<%
    if (session != null)
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="refresh" content="2;URL=index.jsp">
    <title>Logging Out...</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="text-center">
            <h2 class="text-secondary">Logging you out...</h2>
            <p class="text-muted">Redirecting to the home page shortly.</p>
        </div>
    </div>
</body>
</html>
