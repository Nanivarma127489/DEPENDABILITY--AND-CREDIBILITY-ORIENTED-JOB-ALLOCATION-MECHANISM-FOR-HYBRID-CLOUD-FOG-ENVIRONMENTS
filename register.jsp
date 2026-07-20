<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Register — RTATSA2C Scheduler</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="auth-wrapper">
  <div class="auth-card">
    <div class="brand">
      <h1><i class="fas fa-cloud"></i> RTATSA2C</h1>
      <p>Create your developer account</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-danger"><i class="fas fa-exclamation-circle"></i> ${error}</div>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post">
      <div class="form-group">
        <label class="form-label">Full Name</label>
        <input type="text" name="name" class="form-control" placeholder="Your full name" required>
      </div>
      <div class="form-group">
        <label class="form-label">Email Address</label>
        <input type="email" name="email" class="form-control" placeholder="you@example.com" required>
      </div>
      <div class="form-group">
        <label class="form-label">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Choose a password" required minlength="6">
      </div>
      <button type="submit" class="btn btn-primary" style="width:100%; justify-content:center; padding:.75rem;">
        <i class="fas fa-user-plus"></i> Create Account
      </button>
    </form>

    <p style="text-align:center; margin-top:1.25rem; font-size:.875rem; color:#6c757d;">
      Already have an account? <a href="${pageContext.request.contextPath}/login" style="color:#4361ee; font-weight:500;">Sign In</a>
    </p>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>