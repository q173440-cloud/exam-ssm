<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User,java.util.List,java.util.Map" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"student".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=student"); return; }
    Integer score = (Integer) session.getAttribute("lastScore");
    Integer examId = (Integer) session.getAttribute("lastExamId");
    List<Map<String, Object>> detail = (List<Map<String, Object>>) session.getAttribute("lastDetail");
    if (score == null || examId == null) { response.sendRedirect(request.getContextPath() + "/student/index"); return; }
    boolean passed = score >= 60;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>考试结果 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">网络考试系统</div>
    <div class="nav-right">
        <span><%= user.getRealName() %></span>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="main-content">
    <div class="card">
        <div class="result-box">
            <div class="score-num"><%= score %></div>
            <div class="score-unit">分</div>
            <div class="<%= passed ? "pass" : "fail" %>"><%= passed ? "✔ 恭喜您，考试通过！" : "✘ 未通过，请继续努力" %></div>
            <p style="color:#888;margin-top:12px;font-size:13px;">满分 100 分，60 分及格 · 本次共 <%= detail != null ? detail.size() : 0 %> 题</p>
            <div style="margin-top:24px;">
                <a href="${pageContext.request.contextPath}/student/index" class="btn-primary" style="margin-right:12px;">返回主页</a>
                <a href="${pageContext.request.contextPath}/myScores" class="btn-primary">查看历史成绩</a>
            </div>
        </div>
    </div>
    <% if (detail != null && !detail.isEmpty()) { %>
    <div class="card">
        <div class="card-title">答题详情</div>
        <table>
            <tr>
                <th style="width:50px">题号</th>
                <th>题目</th>
                <th style="width:80px">正确答案</th>
                <th style="width:80px">我的答案</th>
                <th style="width:70px">结果</th>
            </tr>
            <% int idx = 1; for (Map<String, Object> row : detail) {
                String correctAns = (String) row.get("correctAnswer");
                String studentAns = (String) row.get("studentAnswer");
                boolean correct = correctAns != null && correctAns.equals(studentAns);
            %>
            <tr style="<%= correct?"":"background:#fff5f5;" %>">
                <td style="text-align:center;"><%= idx++ %></td>
                <td><%= row.get("content") %></td>
                <td style="text-align:center;color:#27ae60;font-weight:bold;"><%= correctAns %></td>
                <td style="text-align:center;<%= correct?"":"color:#e74c3c;font-weight:bold;" %>"><%= studentAns == null ? "未作答" : studentAns %></td>
                <td style="text-align:center;<%= correct?"color:#27ae60;":"color:#e74c3c;" %>"><%= correct ? "✔ 正确" : "✘ 错误" %></td>
            </tr>
            <% } %>
        </table>
    </div>
    <% } %>
</div>
</body>
</html>
