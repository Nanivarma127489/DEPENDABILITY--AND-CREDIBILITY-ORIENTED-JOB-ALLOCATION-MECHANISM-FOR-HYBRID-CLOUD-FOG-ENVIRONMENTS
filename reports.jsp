<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Reports — RTATSA2C</title>
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
      <li><a href="${pageContext.request.contextPath}/user/task-monitor"><i class="fas fa-tasks"></i> Task Monitor</a></li>
      <li><a href="${pageContext.request.contextPath}/user/reports" class="active"><i class="fas fa-chart-bar"></i> Reports</a></li>
      <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
  </aside>

  <div class="main-content">
    <div class="topbar">
      <div class="topbar-title">Performance Reports</div>
      <div class="topbar-right">
        <div class="user-avatar">${sessionScope.user.name.substring(0,1).toUpperCase()}</div>
        <span style="font-size:.875rem;">${sessionScope.user.name}</span>
      </div>
    </div>

    <div class="page-content">
      <div class="page-header">
        <div>
          <h4>Performance Reports</h4>
          <p>Makespan, reliability, and resource utilization metrics</p>
        </div>
      </div>

      <div class="card">
        <div class="card-header">
          <h5><i class="fas fa-chart-line" style="color:#4361ee;"></i> Task Performance Metrics</h5>
        </div>
        <div class="table-responsive">
          <table>
            <thead>
              <tr>
                <th>Task</th><th>Makespan (s)</th><th>CPU Util %</th>
                <th>Reliability</th><th>Fault Tolerance</th>
                <th>Scalability</th><th>Algorithm</th><th>Generated</th><th>Download</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty reports}">
                  <tr><td colspan="9" style="text-align:center; color:#aaa; padding:2rem;">
                    No reports yet. Submit a task to generate reports.
                  </td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="r" items="${reports}">
                    <tr>
                      <td><strong>${r.taskName}</strong></td>
                      <td><span style="color:#4361ee; font-weight:600;">
                        <fmt:formatNumber value="${r.makespan}" maxFractionDigits="2"/>
                      </span></td>
                      <td>
                        <div style="display:flex; align-items:center; gap:.5rem;">
                          <div style="flex:1; background:#e0e0e0; border-radius:4px; height:6px;">
                            <div style="width:${r.resourceUtilization}%; background:#4361ee; height:6px; border-radius:4px;"></div>
                          </div>
                          <span style="font-size:.8rem;">
                            <fmt:formatNumber value="${r.resourceUtilization}" maxFractionDigits="1"/>%
                          </span>
                        </div>
                      </td>
                      <td><span class="badge badge-success">
                        <fmt:formatNumber value="${r.reliabilityScore * 100}" maxFractionDigits="1"/>%
                      </span></td>
                      <td><span class="badge badge-info">
                        <fmt:formatNumber value="${r.faultToleranceScore * 100}" maxFractionDigits="1"/>%
                      </span></td>
                      <td><fmt:formatNumber value="${r.scalabilityIndex}" maxFractionDigits="2"/>x</td>
                      <td><span class="badge badge-primary">${r.algorithmUsed}</span></td>
                      <td style="font-size:.8rem; color:#999;">
                        <fmt:formatDate value="${r.generatedAt}" pattern="MMM dd, HH:mm"/>
                      </td>
                      <td>
                        <c:choose>
                          <c:when test="${r.reportFileUrl != null}">
                            <a href="${r.reportFileUrl}" target="_blank" class="btn btn-success btn-sm">
                              <i class="fas fa-download"></i> CSV
                            </a>
                          </c:when>
                          <c:otherwise>
                            <span style="color:#aaa; font-size:.8rem;">—</span>
                          </c:otherwise>
                        </c:choose>
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