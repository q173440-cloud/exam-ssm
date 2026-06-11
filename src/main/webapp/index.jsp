<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String loginType = request.getParameter("type");
    if (loginType == null) loginType = request.getAttribute("loginType") != null ? (String)request.getAttribute("loginType") : "student";
    boolean teacherLogin = "teacher".equals(loginType);
    String action = teacherLogin ? "/teacherLogin" : "/studentLogin";
    String title = teacherLogin ? "教师登录" : "学生登录";
    String usernameLabel = teacherLogin ? "教师账号" : "学号";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= title %> - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="login-wrap">
    <div class="login-box">
        <h2>网络考试系统</h2>
        <p class="subtitle">Online Examination System (SSM)</p>
        <div class="login-switch">
            <a href="${pageContext.request.contextPath}/?type=student" class="<%= teacherLogin ? "" : "active" %>">学生登录</a>
            <a href="${pageContext.request.contextPath}/?type=teacher" class="<%= teacherLogin ? "active" : "" %>">教师登录</a>
        </div>
        <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="error-msg"><%= request.getAttribute("errorMsg") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}<%= action %>" method="post">
            <div class="form-group">
                <label><%= usernameLabel %></label>
                <input type="text" name="username" placeholder="<%= usernameLabel %>" required />
            </div>
            <div class="form-group">
                <label>密码</label>
                <input type="password" name="password" placeholder="请输入密码" required />
            </div>
            <button type="submit" class="btn-primary btn-block">登 录</button>
        </form>
    </div>
</div>
</body>
</html>
