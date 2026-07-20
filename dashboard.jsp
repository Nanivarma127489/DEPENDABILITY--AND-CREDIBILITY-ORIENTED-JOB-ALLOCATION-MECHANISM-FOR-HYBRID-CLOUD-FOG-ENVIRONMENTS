<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Dashboard — RTATSA2C</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="app-layout">
  <aside class="sidebar">
    <div class="sidebar-brand"><h2><i class="fas fa-cloud"></i> RTATSA2C</h2><span>Task Scheduler</span></div>
    <div class="sidebar-section-title">Main</div>
    <ul class="sidebar-menu">
      <li><a href="${pageContext.request.contextPath}/user/dashboard" class="active"><i class="fas fa-th-large"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/user/submit-task"><i class="fas fa-plus-circle"></i> Submit Task</a></li>
      <li><a href="${pageContext.request.contextPath}/user/task-monitor"><i class="fas fa-tasks"></i> Task Monitor</a></li>
      <li><a href="${pageContext.request.contextPath}/user/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
    </ul>
    <div class="sidebar-section-title">Account</div>
    <ul class="sidebar-menu">
      <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
  </aside>

  <div class="main-content">
    <div class="topbar">
      <div class="topbar-title">Dashboard</div>
      <div class="topbar-right">
        <button class="notification-btn">
          <i class="fas fa-bell"></i>
          <c:if test="${unreadCount > 0}">
            <span class="badge">${unreadCount}</span>
          </c:if>
        </button>
        <div class="user-avatar">${sessionScope.user.name.substring(0,1).toUpperCase()}</div>
        <span style="font-size:.875rem; font-weight:500;">${sessionScope.user.name}</span>
      </div>
    </div>

    <div class="page-content">
      <div class="page-header">
        <div>
          <h4>Welcome back, ${sessionScope.user.name}!</h4>
          <p>Here's your task scheduling overview</p>
        </div>
        <a href="${pageContext.request.contextPath}/user/submit-task" class="btn btn-primary">
          <i class="fas fa-plus"></i> New Task
        </a>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon blue"><i class="fas fa-list-check"></i></div>
          <div class="stat-info"><h3>${tasks.size()}</h3><p>Total Tasks</p></div>
        </div>
        <div class="stat-card">
          <div class="stat-icon green"><i class="fas fa-check-double"></i></div>
          <div class="stat-info">
            <h3>
              <c:set var="completed" value="0"/>
              <c:forEach var="t" items="${tasks}">
                <c:if test="${t.status == 'COMPLETED'}"><c:set var="completed" value="${completed + 1}"/></c:if>
              </c:forEach>
              ${completed}
            </h3>
            <p>Completed</p>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon orange"><i class="fas fa-spinner"></i></div>
          <div class="stat-info">
            <h3>
              <c:set var="running" value="0"/>
              <c:forEach var="t" items="${tasks}">
                <c:if test="${t.status == 'RUNNING'}"><c:set var="running" value="${running + 1}"/></c:if>
              </c:forEach>
              ${running}
            </h3>
            <p>Running</p>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon purple"><i class="fas fa-clock"></i></div>
          <div class="stat-info">
            <h3>
              <c:set var="pending" value="0"/>
              <c:forEach var="t" items="${tasks}">
                <c:if test="${t.status == 'PENDING'}"><c:set var="pending" value="${pending + 1}"/></c:if>
              </c:forEach>
              ${pending}
            </h3>
            <p>Pending</p>
          </div>
        </div>
      </div>

      <div style="display:grid; grid-template-columns:2fr 1fr; gap:1.5rem;">
        <div class="card">
          <div class="card-header">
            <h5><i class="fas fa-tasks" style="color:#4361ee;"></i> Recent Tasks</h5>
            <a href="${pageContext.request.contextPath}/user/task-monitor" class="btn btn-outline btn-sm">View All</a>
          </div>
          <div class="table-responsive">
            <table>
              <thead>
                <tr><th>Task</th><th>Priority</th><th>Node</th><th>Status</th><th>Submitted</th></tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${empty tasks}">
                    <tr><td colspan="5" style="text-align:center; color:#aaa; padding:2rem;">
                      No tasks yet. <a href="${pageContext.request.contextPath}/user/submit-task">Submit your first task</a>
                    </td></tr>
                  </c:when>
                  <c:otherwise>
                    <c:forEach var="t" items="${tasks}" begin="0" end="4">
                      <tr>
                        <td><strong>${t.taskName}</strong></td>
                        <td>
                          <span class="badge <c:choose>
                            <c:when test="${t.priority == 'CRITICAL'}">badge-danger</c:when>
                            <c:when test="${t.priority == 'HIGH'}">badge-warning</c:when>
                            <c:when test="${t.priority == 'MEDIUM'}">badge-info</c:when>
                            <c:otherwise>badge-secondary</c:otherwise>
                          </c:choose>">${t.priority}</span>
                        </td>
                        <td>${t.assignedNode != null ? t.assignedNode : '—'}</td>
                        <td>
                          <span class="badge <c:choose>
                            <c:when test="${t.status == 'COMPLETED'}">badge-success</c:when>
                            <c:when test="${t.status == 'RUNNING'}">badge-info</c:when>
                            <c:when test="${t.status == 'FAILED'}">badge-danger</c:when>
                            <c:otherwise>badge-secondary</c:otherwise>
                          </c:choose>">${t.status}</span>
                        </td>
                        <td style="color:#999; font-size:.8rem;">
                          <fmt:formatDate value="${t.submittedAt}" pattern="MMM dd, HH:mm"/>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>
        </div>

        <div class="card">
          <div class="card-header">
            <h5><i class="fas fa-bell" style="color:#f8961e;"></i> Notifications</h5>
          </div>
          <div class="card-body">
            <c:choose>
              <c:when test="${empty notifications}">
                <p style="color:#aaa; text-align:center; font-size:.875rem;">No notifications</p>
              </c:when>
              <c:otherwise>
                <c:forEach var="n" items="${notifications}" begin="0" end="7">
                  <div class="notif-item">
                    <div class="notif-dot ${n.type}"></div>
                    <div>
                      <p style="font-size:.83rem;">${n.message}</p>
                      <span style="font-size:.75rem; color:#999;">
                        <fmt:formatDate value="${n.createdAt}" pattern="MMM dd, HH:mm"/>
                      </span>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>