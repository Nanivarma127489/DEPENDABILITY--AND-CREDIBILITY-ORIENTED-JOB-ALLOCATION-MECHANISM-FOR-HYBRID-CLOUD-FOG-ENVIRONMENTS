<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Task Monitor — RTATSA2C</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="app-layout">
  <aside class="sidebar">
    <div class="sidebar-brand"><h2><i class="fas fa-cloud"></i> RTATSA2C</h2><span>Task Scheduler</span></div>
    <ul class="sidebar-menu">
      <li><a href="${pageContext.request.contextPath}/user/dashboard"><i class="fas fa-th-large"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/user/submit-task"><i class="fas fa-plus-circle"></i> Submit Task</a></li>
      <li><a href="${pageContext.request.contextPath}/user/task-monitor" class="active"><i class="fas fa-tasks"></i> Task Monitor</a></li>
      <li><a href="${pageContext.request.contextPath}/user/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
      <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
  </aside>

  <div class="main-content">
    <div class="topbar">
      <div class="topbar-title">Task Monitor</div>
      <div class="topbar-right">
        <div class="user-avatar">${sessionScope.user.name.substring(0,1).toUpperCase()}</div>
        <span style="font-size:.875rem;">${sessionScope.user.name}</span>
      </div>
    </div>

    <div class="page-content">
      <div class="page-header">
        <div>
          <h4>My Tasks</h4>
          <p>Monitor execution progress and scheduling decisions</p>
        </div>
        <a href="${pageContext.request.contextPath}/user/submit-task" class="btn btn-primary">
          <i class="fas fa-plus"></i> New Task
        </a>
      </div>

      <div class="card">
        <div class="card-header">
          <h5><i class="fas fa-list" style="color:#4361ee;"></i> All Submitted Tasks</h5>
          <span style="font-size:.85rem; color:#999;">${tasks.size()} tasks</span>
        </div>
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>#</th><th>Task Name</th><th>Priority</th>
                <th>CPU</th><th>Memory</th><th>Exec Time</th>
                <th>Node</th><th>Sensitivity</th><th>Status</th><th>Submitted</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty tasks}">
                  <tr><td colspan="10" style="text-align:center; color:#aaa; padding:2rem;">No tasks found.</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="t" items="${tasks}">
                    <tr>
                      <td style="color:#999;">#${t.id}</td>
                      <td>
                        <strong>${t.taskName}</strong>
                        <br><small style="color:#999;">${t.description}</small>
                      </td>
                      <td>
                        <span class="badge <c:choose>
                          <c:when test="${t.priority == 'CRITICAL'}">badge-danger</c:when>
                          <c:when test="${t.priority == 'HIGH'}">badge-warning</c:when>
                          <c:when test="${t.priority == 'MEDIUM'}">badge-info</c:when>
                          <c:otherwise>badge-secondary</c:otherwise>
                        </c:choose>">${t.priority}</span>
                      </td>
                      <td>${t.cpuRequired} cores</td>
                      <td>${t.memoryRequired} MB</td>
                      <td>${t.executionTime}s</td>
                      <td>
                        <c:choose>
                          <c:when test="${t.assignedNode != null}">
                            <span style="font-weight:500; color:#4361ee;">${t.assignedNode}</span>
                          </c:when>
                          <c:otherwise><span style="color:#aaa;">—</span></c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <span class="badge <c:choose>
                          <c:when test="${t.delaySensitivity == 'DELAY_SENSITIVE'}">badge-warning</c:when>
                          <c:otherwise>badge-secondary</c:otherwise>
                        </c:choose>">
                          ${t.delaySensitivity == 'DELAY_SENSITIVE' ? 'Sensitive' : 'Tolerant'}
                        </span>
                      </td>
                      <td>
                        <span class="badge <c:choose>
                          <c:when test="${t.status == 'COMPLETED'}">badge-success</c:when>
                          <c:when test="${t.status == 'RUNNING'}">badge-info</c:when>
                          <c:when test="${t.status == 'FAILED'}">badge-danger</c:when>
                          <c:otherwise>badge-secondary</c:otherwise>
                        </c:choose>">${t.status}</span>
                      </td>
                      <td style="font-size:.8rem; color:#999;">
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
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>