<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"student".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=student"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生主页 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">网络考试系统</div>
    <div class="nav-right">
        <span>欢迎，<strong><%= user.getRealName() %></strong>（<%= user.getClassName() %>）</span>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="main-content">
    <% if (request.getAttribute("errorMsg") != null) { %>
        <div class="error-msg"><%= request.getAttribute("errorMsg") %></div>
    <% } %>
    <div class="card">
        <div class="card-title">考试中心</div>
        <table>
            <tr>
                <th style="width:120px">考试名称</th>
                <th>考试说明</th>
                <th style="width:100px">题目数量</th>
                <th style="width:100px">考试时间</th>
                <th style="width:100px">操作</th>
            </tr>
            <tr>
                <td>计算机基础测试</td>
                <td>随机抽取10道单选题，每题10分，满分100分，60分及格</td>
                <td>10 题</td>
                <td>20 分钟</td>
                <td><a href="${pageContext.request.contextPath}/startExam" onclick="return confirm('确认开始考试？')" class="btn-primary" style="padding:5px 14px;font-size:13px;">开始考试</a></td>
            </tr>
        </table>
    </div>
    <div class="card">
        <div class="card-title">我的记录</div>
        <a href="${pageContext.request.contextPath}/myScores" class="btn-primary">查看成绩记录</a>
    </div>
</div>
</body>
</html>
