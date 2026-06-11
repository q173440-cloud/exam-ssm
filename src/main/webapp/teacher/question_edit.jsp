<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User,com.example.dazuoye.entity.Question" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"teacher".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=teacher"); return; }
    Question q = (Question) request.getAttribute("question");
    if (q == null) { response.sendRedirect(request.getContextPath() + "/teacher/question?action=list"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑题目 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">网络考试系统 · 教师后台</div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/teacher/question?action=list">返回题库</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="main-content">
    <div class="card">
        <div class="card-title">编辑题目（ID：<%= q.getId() %>）</div>
        <form action="${pageContext.request.contextPath}/teacher/question" method="post">
            <input type="hidden" name="action" value="edit" />
            <input type="hidden" name="id" value="<%= q.getId() %>" />
            <div class="form-group"><label>题目内容 <span style="color:red;">*</span></label><textarea name="content" rows="3" required><%= q.getContent() %></textarea></div>
            <div class="form-group"><label>选项 A</label><input type="text" name="optionA" value="<%= q.getOptionA() %>" required /></div>
            <div class="form-group"><label>选项 B</label><input type="text" name="optionB" value="<%= q.getOptionB() %>" required /></div>
            <div class="form-group"><label>选项 C</label><input type="text" name="optionC" value="<%= q.getOptionC() %>" required /></div>
            <div class="form-group"><label>选项 D</label><input type="text" name="optionD" value="<%= q.getOptionD() %>" required /></div>
            <div class="form-group"><label>正确答案</label>
                <select name="answer" required>
                    <option value="A" <%= "A".equals(q.getAnswer())?"selected":"" %>>A</option>
                    <option value="B" <%= "B".equals(q.getAnswer())?"selected":"" %>>B</option>
                    <option value="C" <%= "C".equals(q.getAnswer())?"selected":"" %>>C</option>
                    <option value="D" <%= "D".equals(q.getAnswer())?"selected":"" %>>D</option>
                </select>
            </div>
            <button type="submit" class="btn-primary">保存修改</button>
            &nbsp;&nbsp;<a href="${pageContext.request.contextPath}/teacher/question?action=list">取消</a>
        </form>
    </div>
</div>
</body>
</html>
