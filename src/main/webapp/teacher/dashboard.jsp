<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"teacher".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=teacher"); return; }
    Integer questionCount = (Integer) request.getAttribute("questionCount");
    Integer studentCount = (Integer) request.getAttribute("studentCount");
    Object avgScore = request.getAttribute("avgScore");
    Object maxScore = request.getAttribute("maxScore");
    if (questionCount == null) questionCount = 0;
    if (studentCount == null) studentCount = 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>教师主页 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">网络考试系统 · 教师后台</div>
    <div class="nav-right">
        <span>教师：<strong><%= user.getRealName() %></strong></span>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="main-content">
    <div class="card">
        <div class="card-title">系统概览</div>
        <div class="stat-grid">
            <div class="stat-item"><div class="stat-val"><%= questionCount %></div><div class="stat-label">题库总题数</div></div>
            <div class="stat-item"><div class="stat-val"><%= studentCount %></div><div class="stat-label">注册学生数</div></div>
            <div class="stat-item"><div class="stat-val"><%= avgScore != null ? avgScore : 0 %></div><div class="stat-label">平均分</div></div>
            <div class="stat-item"><div class="stat-val"><%= maxScore != null ? maxScore : 0 %></div><div class="stat-label">最高分</div></div>
        </div>
    </div>
    <div class="card">
        <div class="card-title">功能菜单</div>
        <table>
            <tr><th>功能</th><th>说明</th><th style="width:120px">操作</th></tr>
            <tr>
                <td>题库管理</td>
                <td>添加、修改、删除考试题目</td>
                <td><a href="${pageContext.request.contextPath}/teacher/question?action=list" class="btn-primary" style="padding:5px 14px;font-size:13px;">进入</a></td>
            </tr>
            <tr>
                <td>成绩统计</td>
                <td>查看所有学生成绩，按分数段统计，支持打印</td>
                <td><a href="${pageContext.request.contextPath}/teacher/stat" class="btn-primary" style="padding:5px 14px;font-size:13px;">进入</a></td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
