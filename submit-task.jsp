<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Submit Task — RTATSA2C</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<div class="app-layout">
  <aside class="sidebar">
    <div class="sidebar-brand"><h2><i class="fas fa-cloud"></i> RTATSA2C</h2><span>Task Scheduler</span></div>
    <ul class="sidebar-menu">
      <li><a href="${pageContext.request.contextPath}/user/dashboard"><i class="fas fa-th-large"></i> Dashboard</a></li>
      <li><a href="${pageContext.request.contextPath}/user/submit-task" class="active"><i class="fas fa-plus-circle"></i> Submit Task</a></li>
      <li><a href="${pageContext.request.contextPath}/user/task-monitor"><i class="fas fa-tasks"></i> Task Monitor</a></li>
      <li><a href="${pageContext.request.contextPath}/user/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
      <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
    </ul>
  </aside>

  <div class="main-content">
    <div class="topbar">
      <div class="topbar-title">Submit New Task</div>
      <div class="topbar-right">
        <div class="user-avatar">${sessionScope.user.name.substring(0,1).toUpperCase()}</div>
        <span style="font-size:.875rem; font-weight:500;">${sessionScope.user.name}</span>
      </div>
    </div>

    <div class="page-content">
      <div class="page-header">
        <div>
          <h4>Submit Computational Task</h4>
          <p>Define your task requirements for RTATSA2C scheduling</p>
        </div>
      </div>

      <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><i class="fas fa-exclamation-circle"></i> ${error}</div>
      <% } %>
      <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
      <% } %>

      <div class="card" style="max-width:720px;">
        <div class="card-header">
          <h5><i class="fas fa-plus-circle" style="color:#4361ee;"></i> Task Details</h5>
        </div>
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/user/submit-task" method="post">
            <div class="form-group">
              <label class="form-label">Task Name <span style="color:red;">*</span></label>
              <input type="text" name="taskName" class="form-control" placeholder="e.g., Image Processing Task" required>
            </div>
            <div class="form-group">
              <label class="form-label">Description</label>
              <textarea name="description" class="form-control" rows="3" placeholder="Describe what this task does..."></textarea>
            </div>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Priority Level <span style="color:red;">*</span></label>
                <select name="priority" class="form-control" required>
                  <option value="">Select Priority</option>
                  <option value="LOW">Low</option>
                  <option value="MEDIUM" selected>Medium</option>
                  <option value="HIGH">High</option>
                  <option value="CRITICAL">Critical</option>
                </select>
              </div>
              <div class="form-group">
                <label class="form-label">Delay Sensitivity <span style="color:red;">*</span></label>
                <select name="delaySensitivity" class="form-control" required>
                  <option value="DELAY_TOLERANT" selected>Delay Tolerant</option>
                  <option value="DELAY_SENSITIVE">Delay Sensitive</option>
                </select>
              </div>
            </div>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Execution Time (seconds) <span style="color:red;">*</span></label>
                <input type="number" name="executionTime" class="form-control" min="1" max="3600" value="30" required>
              </div>
              <div class="form-group">
                <label class="form-label">CPU Required (cores) <span style="color:red;">*</span></label>
                <input type="number" name="cpuRequired" class="form-control" min="0.5" max="64" step="0.5" value="1.0" required>
              </div>
            </div>
            <div class="form-row">
              <div class="form-group">
                <label class="form-label">Memory Required (MB) <span style="color:red;">*</span></label>
                <input type="number" name="memoryRequired" class="form-control" min="128" max="65536" step="128" value="512" required>
              </div>
            </div>
            <div style="display:flex; gap:0.75rem; margin-top:0.5rem;">
              <button type="submit" class="btn btn-primary">
                <i class="fas fa-paper-plane"></i> Submit & Schedule Task
              </button>
              <button type="reset" class="btn btn-outline">
                <i class="fas fa-redo"></i> Reset
              </button>
            </div>
          </form>
        </div>
      </div>

      <div class="card" style="max-width:720px; border-left:4px solid #4361ee;">
        <div class="card-body">
          <h6 style="font-weight:600; margin-bottom:.5rem;">
            <i class="fas fa-info-circle" style="color:#4361ee;"></i> How RTATSA2C Schedules Your Task
          </h6>
          <ul style="font-size:.875rem; color:#555; padding-left:1.25rem; line-height:1.8;">
            <li><strong>Delay-Sensitive tasks</strong> are preferentially scheduled on Fog Nodes for low latency</li>
            <li><strong>Delay-Tolerant tasks</strong> are scheduled on Cloud VMs for higher capacity</li>
            <li>The A2C algorithm selects nodes based on trust score, reliability, and available resources</li>
            <li>A performance report CSV is automatically uploaded to Cloudinary upon completion</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>