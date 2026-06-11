<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User,com.example.dazuoye.entity.Score,java.util.List" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"student".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=student"); return; }
    List<Score> scoreList = (List<Score>) request.getAttribute("scoreList");
    int examCount = 0, maxScore = 0, totalScore = 0, passCount = 0;
    if (scoreList != null) {
        examCount = scoreList.size();
        for (Score s : scoreList) {
            totalScore += s.getScore();
            if (s.getScore() > maxScore) maxScore = s.getScore();
            if (s.getScore() >= 60) passCount++;
        }
    }
    int avgScore = examCount > 0 ? totalScore / examCount : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成绩记录 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand">网络考试系统</div>
    <div class="nav-right">
        <span><%= user.getRealName() %></span>
        <a href="${pageContext.request.contextPath}/student/index">返回主页</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="main-content">
    <% if (scoreList == null || scoreList.isEmpty()) { %>
    <div class="card">
        <div class="empty-box">暂无考试记录，请先完成一次考试。</div>
    </div>
    <% } else { %>
    <div class="card">
        <div class="card-title">成绩概览</div>
        <div class="score-summary-grid">
            <div class="stat-item"><div class="stat-val"><%= examCount %></div><div class="stat-label">考试次数</div></div>
            <div class="stat-item"><div class="stat-val"><%= maxScore %></div><div class="stat-label">最高分</div></div>
            <div class="stat-item"><div class="stat-val"><%= avgScore %></div><div class="stat-label">平均分</div></div>
            <div class="stat-item"><div class="stat-val"><%= passCount %></div><div class="stat-label">通过次数</div></div>
        </div>
    </div>
    <div class="card">
        <div class="card-title">成绩明细</div>
        <div style="margin-bottom:14px;text-align:right;">
            <button class="btn-primary" onclick="window.print()">🖨 打印个人成绩单</button>
        </div>
        <table>
            <tr>
                <th style="width:60px">序号</th>
                <th style="width:100px">考试编号</th>
                <th>提交时间</th>
                <th style="width:100px">得分</th>
                <th style="width:80px">是否通过</th>
                <th class="no-print" style="width:90px">操作</th>
            </tr>
            <% int i = 1; for (Score s : scoreList) { boolean passed = s.getScore() >= 60; %>
            <tr>
                <td style="text-align:center;"><%= i++ %></td>
                <td style="text-align:center;">#<%= s.getExamId() %></td>
                <td><%= s.getSubmitTime() %></td>
                <td style="text-align:center;font-weight:bold;color:<%= passed?"#27ae60":"#e74c3c" %>;"><%= s.getScore() %> 分</td>
                <td style="text-align:center;color:<%= passed?"#27ae60":"#e74c3c" %>;"><%= passed ? "✔ 通过" : "✘ 未通过" %></td>
                <td class="no-print" style="text-align:center;">
                    <a class="btn-small" href="<%= request.getContextPath() %>/scoreDetail?examId=<%= s.getExamId() %>">查看详情</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
    <% } %>
    <div style="margin-top:20px;"><a href="${pageContext.request.contextPath}/student/index" class="btn-primary">返回主页</a></div>
</div>
</body>
</html>
