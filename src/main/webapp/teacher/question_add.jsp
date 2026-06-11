<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"teacher".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=teacher"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加题目 - 网络考试系统</title>
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
        <div class="card-title">添加题目</div>
        <form action="${pageContext.request.contextPath}/teacher/question" method="post">
            <input type="hidden" name="action" value="add" />
            <div class="form-group"><label>题目内容 <span style="color:red;">*</span></label><textarea name="content" rows="3" required></textarea></div>
            <div class="form-group"><label>选项 A <span style="color:red;">*</span></label><input type="text" name="optionA" required /></div>
            <div class="form-group"><label>选项 B <span style="color:red;">*</span></label><input type="text" name="optionB" required /></div>
            <div class="form-group"><label>选项 C <span style="color:red;">*</span></label><input type="text" name="optionC" required /></div>
            <div class="form-group"><label>选项 D <span style="color:red;">*</span></label><input type="text" name="optionD" required /></div>
            <div class="form-group"><label>正确答案 <span style="color:red;">*</span></label>
                <select name="answer" required>
                    <option value="">-- 请选择 --</option>
                    <option value="A">A</option>
                    <option value="B">B</option>
                    <option value="C">C</option>
                    <option value="D">D</option>
                </select>
            </div>
            <button type="submit" class="btn-primary">保存题目</button>
            &nbsp;&nbsp;<a href="${pageContext.request.contextPath}/teacher/question?action=list">取消</a>
        </form>
    </div>
</div>
</body>
</html>
