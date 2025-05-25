<%--

<%@ page session="true" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="menu.jsp">Online Canteen</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav" aria-controls="navbarNav"
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="menu.jsp">Menu</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userDetails.jsp?tableNo=<%=session.getAttribute("tableNo")%>">Your Details</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="orderSuccess.jsp">Order Summary</a>
        </li>
      </ul>

      <span class="navbar-text me-3 text-white">
        Logged in as: <%=session.getAttribute("username") != null ? session.getAttribute("username") : "Guest"%>
      </span>
      <a class="btn btn-outline-light" href="logout.jsp">Logout</a>
    </div>
  </div>
</nav>

--%> 
      
      
      
      <%@ page session="true" %>
<nav class="navbar navbar-expand-lg custom-navbar">
  <div class="container-fluid">
    <a class="navbar-brand d-flex align-items-center" href="menu.jsp">
      <img src="./images/png-original.png" alt="Canteen Logo" class="navbar-logo me-2">
<!--      <span class="brand-text"> Canteen</span>-->
    </a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav" aria-controls="navbarNav"
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="menu.jsp">
            <i class="fas fa-utensils me-1"></i> Menu
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="userDetails.jsp?tableNo=<%=session.getAttribute("tableNo")%>">
            <i class="fas fa-user me-1"></i> Your Details
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="orderSuccess.jsp">
            <i class="fas fa-receipt me-1"></i> Order Summary
          </a>
        </li>
      </ul>

      <div class="d-flex align-items-center">
        <div class="user-profile me-3">
          <i class="fas fa-user-circle me-2"></i>
          <span class="user-name">
            <%=session.getAttribute("username") != null ? session.getAttribute("username") : "Guest"%>
          </span>
        </div>
        <a class="logout-btn" href="logout.jsp">
          <i class="fas fa-sign-out-alt me-1"></i> Logout
        </a>
      </div>
    </div>
  </div>
</nav>

<style>

.custom-navbar {
 background: #000000;
  backdrop-filter: blur(10px);
  padding: 1rem;
  box-shadow: 0 2px 10px rgba(0,0,0,0.5);
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000; 
}

.navbar-logo {
  height: auto;
  width: 60px;
}

.brand-text {
  font-size: 1.5rem;
  font-weight: 600;
  background: linear-gradient(45deg, #fff, #e0e0e0);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.navbar-nav .nav-link {
  color: rgba(255,255,255,0.9) !important;
  font-weight: 500;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.navbar-nav .nav-link:hover {
  color: #fff !important;
  background: rgba(255,255,255,0.1);
  transform: translateY(-2px);
}

.user-profile {
  color: #fff;
  padding: 0.5rem 1rem;
  border-radius: 25px;
  background: rgba(255,255,255,0.1);
}

.user-name {
  font-weight: 500;
}

.logout-btn {
  color: #fff;
  text-decoration: none;
  padding: 0.5rem 1.5rem;
  border-radius: 25px;
  border: 2px solid rgba(255,255,255,0.2);
  transition: all 0.3s ease;
}

.logout-btn:hover {
  background: #fff;
  color: #1e3c72;
  border-color: #fff;
}

.navbar-toggler {
  border: none;
  padding: 0.5rem;
}

.navbar-toggler:focus {
  box-shadow: none;
}

@media (max-width: 991.98px) {
  .user-profile {
    margin-bottom: 1rem;
  }
  
  .navbar-nav {
    padding: 1rem 0;
  }
  
  .nav-link {
    padding: 0.5rem 0;
  }
}
</style>

<!-- Add Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">