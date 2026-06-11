<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User,com.example.dazuoye.entity.Question,java.util.List" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"teacher".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=teacher"); return; }
    List<Question> questionList = (List<Question>) request.getAttribute("questionList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>题库管理 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">网络考试系统 · 教师后台</div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/teacher/dashboard">返回主页</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="main-content">
    <div class="card">
        <div class="card-title">题库管理</div>
        <div style="margin-bottom:14px;">
            <a href="${pageContext.request.contextPath}/teacher/question?action=toAdd" class="btn-primary">+ 添加题目</a>
            <span style="margin-left:12px;color:#888;font-size:13px;">共 <%= questionList == null ? 0 : questionList.size() %> 道题</span>
        </div>
        <table>
            <tr>
                <th style="width:50px">ID</th>
                <th>题目内容</th>
                <th style="width:60px">A</th>
                <th style="width:60px">B</th>
                <th style="width:60px">C</th>
                <th style="width:60px">D</th>
                <th style="width:60px">答案</th>
                <th style="width:120px">操作</th>
            </tr>
            <% if (questionList == null || questionList.isEmpty()) { %>
            <tr><td colspan="8" style="text-align:center;color:#999;padding:30px 0;">题库暂无题目</td></tr>
            <% } else { for (Question q : questionList) { %>
            <tr>
                <td style="text-align:center;"><%= q.getId() %></td>
                <td><%= q.getContent().length() > 40 ? q.getContent().substring(0,40) + "..." : q.getContent() %></td>
                <td><%= q.getOptionA() %></td>
                <td><%= q.getOptionB() %></td>
                <td><%= q.getOptionC() %></td>
                <td><%= q.getOptionD() %></td>
                <td style="text-align:center;font-weight:bold;color:#1a7cd6;"><%= q.getAnswer() %></td>
                <td style="text-align:center;">
                    <a href="${pageContext.request.contextPath}/teacher/question?action=toEdit&id=<%= q.getId() %>" class="btn-success" style="padding:4px 10px;font-size:12px;">编辑</a>
                    &nbsp;<a href="${pageContext.request.contextPath}/teacher/question?action=delete&id=<%= q.getId() %>" class="btn-danger" style="padding:4px 10px;font-size:12px;" onclick="return confirm('确认删除？')">删除</a>
                </td>
            </tr>
            <% } } %>
        </table>
    </div>
</div>
</body>
</html>
