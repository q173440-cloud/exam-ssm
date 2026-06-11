<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User" %>
<%@ page import="com.example.dazuoye.entity.Score" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    User loginUser = (User) request.getAttribute("loginUser");
    Score score = (Score) request.getAttribute("score");
    List<Map<String, Object>> detailList = (List<Map<String, Object>>) request.getAttribute("detailList");

    if (loginUser == null) {
        loginUser = (User) session.getAttribute("loginUser");
    }
    if (loginUser == null) { response.sendRedirect(request.getContextPath() + "/?type=student"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考试详情 - 网络考试系统</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="navbar no-print">
    <div class="brand">网络考试系统 · 考试详情</div>
    <div class="nav-right">
        <span><%= loginUser.getRealName() %></span>
        <a href="<%= request.getContextPath() %>/myScores">返回成绩列表</a>
        <a href="<%= request.getContextPath() %>/logout">退出登录</a>
    </div>
</div>

<div class="main-content">
    <div class="card print-area">
        <h2 style="margin-bottom:16px;">个人考试详情</h2>

        <div class="no-print" style="text-align:right;margin-bottom:15px;">
            <button type="button" class="btn-primary" onclick="window.print()">🖨 打印本次考试详情</button>
            <a class="btn-secondary" href="<%= request.getContextPath() %>/myScores">返回成绩列表</a>
        </div>

        <div class="score-detail-summary">
            <p>考试编号：#<%= score != null ? score.getExamId() : "" %></p>
            <p>学生姓名：<%= loginUser.getRealName() %></p>
            <p>班级：<%= loginUser.getClassName() != null ? loginUser.getClassName() : "-" %></p>
            <p>提交时间：<%= score != null && score.getSubmitTime() != null ? score.getSubmitTime() : "" %></p>
            <p>得分：<strong style="color:#1a7cd6;font-size:18px;"><%= score != null ? score.getScore() : 0 %> 分</strong></p>
            <p>结果：<strong style="color:<%= score != null && score.getScore() >= 60 ? "#27ae60" : "#e74c3c" %>;"><%= score != null && score.getScore() >= 60 ? "✔ 通过" : "✘ 未通过" %></strong></p>
        </div>

        <h3 style="margin-bottom:12px;">答题详情</h3>

        <table>
            <thead>
            <tr>
                <th style="width:50px;">题号</th>
                <th>题目</th>
                <th style="width:80px;">正确答案</th>
                <th style="width:80px;">我的答案</th>
                <th style="width:70px;">结果</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (detailList != null && !detailList.isEmpty()) {
                    int index = 1;
                    for (Map<String, Object> item : detailList) {
                        String correctAnswer = item.get("correctAnswer") == null ? "" : String.valueOf(item.get("correctAnswer"));
                        Object sa = item.get("studentAnswer");
                        String studentAnswer = sa == null ? "未作答" : String.valueOf(sa);
                        boolean right = correctAnswer.equals(studentAnswer) && sa != null;
            %>
            <tr class="<%= right ? "right-row" : "wrong-row" %>">
                <td style="text-align:center;"><%= index++ %></td>
                <td><%= item.get("content") %></td>
                <td style="text-align:center;font-weight:bold;color:#27ae60;"><%= correctAnswer %></td>
                <td style="text-align:center;<%= right ? "" : "color:#e74c3c;font-weight:bold;" %>"><%= studentAnswer %></td>
                <td style="text-align:center;color:<%= right ? "#27ae60" : "#e74c3c" %>;font-weight:bold;"><%= right ? "✔ 正确" : "✘ 错误" %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="5" style="text-align:center;color:#999;padding:20px;">暂无答题详情</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
