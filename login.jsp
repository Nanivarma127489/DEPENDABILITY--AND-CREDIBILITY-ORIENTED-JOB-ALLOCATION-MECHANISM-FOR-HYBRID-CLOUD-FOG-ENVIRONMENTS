<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login — RTATSA2C Scheduler</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="auth-wrapper">
  <div class="auth-card">
    <div class="brand">
      <h1><i class="fas fa-cloud"></i> RTATSA2C</h1>
      <p>Cloud-Fog Task Scheduling Platform</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-danger">
        <i class="fas fa-exclamation-circle"></i> ${error}
      </div>
    <% } %>
    <% if (request.getParameter("success") != null) { %>
      <div class="alert alert-success">
        <i class="fas fa-check-circle"></i> Registration successful. Please log in.
      </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="form-group">
        <label class="form-label">Email Address</label>
        <input type="email" name="email" class="form-control" placeholder="you@example.com" required>
      </div>
      <div class="form-group">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
      </div>
      <button type="submit" class="btn btn-primary" style="width:100%; justify-content:center; padding:.75rem;">
        <i class="fas fa-sign-in-alt"></i> Sign In
      </button>
    </form>

    <p style="text-align:center; margin-top:1.25rem; font-size:.875rem; color:#6c757d;">
      New user? <a href="${pageContext.request.contextPath}/register" style="color:#4361ee; font-weight:500;">Create Account</a>
    </p>

    <div style="margin-top:1.5rem; padding-top:1rem; border-top:1px solid #e0e0e0; font-size:.8rem; color:#999; text-align:center;">
      Admin: admin@gmail.com / admin123<br>
      User: user@gmail.com / user123
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>