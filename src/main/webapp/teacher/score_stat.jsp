<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User,com.example.dazuoye.entity.Score,java.util.List,java.util.Map" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"teacher".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=teacher"); return; }
    List<Score> scoreList = (List<Score>) request.getAttribute("scoreList");
    Object avgScore = request.getAttribute("avgScore");
    Object maxScore = request.getAttribute("maxScore");
    Object minScore = request.getAttribute("minScore");
    Object totalCount = request.getAttribute("totalCount");
    Object passCount = request.getAttribute("passCount");
    Object failCount = request.getAttribute("failCount");
    Object passRate = request.getAttribute("passRate");
    int[] rangeCounts = (int[]) request.getAttribute("rangeCounts");
    if (rangeCounts == null) rangeCounts = new int[]{0,0,0,0,0};
    int total = 0; for (int c : rangeCounts) total += c;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>成绩统计 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="navbar no-print">
    <div class="brand">网络考试系统 · 教师后台</div>
    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/teacher/dashboard">返回主页</a>
        <a href="${pageContext.request.contextPath}/logout">退出登录</a>
    </div>
</div>
<div class="main-content">
    <div class="no-print" style="margin-bottom:14px;text-align:right;">
        <button class="btn-primary" onclick="window.print()">🖨 打印成绩分析表</button>
    </div>
    <div id="printArea">
        <div style="text-align:center;margin-bottom:20px;">
            <h2>网络考试系统 · 成绩分析报表</h2>
            <p style="color:#888;font-size:13px;">打印时间：<%= new java.util.Date() %></p>
        </div>

        <% if (scoreList == null || scoreList.isEmpty()) { %>
        <div class="card"><div class="empty-box">暂无学生考试成绩，请学生完成考试后再查看统计。</div></div>
        <% } else { %>
        <div class="card">
            <div class="card-title">成绩概览</div>
            <div class="stat-grid">
                <div class="stat-item"><div class="stat-val"><%= avgScore != null ? avgScore : 0 %></div><div class="stat-label">平均分</div></div>
                <div class="stat-item"><div class="stat-val"><%= maxScore != null ? maxScore : 0 %></div><div class="stat-label">最高分</div></div>
                <div class="stat-item"><div class="stat-val"><%= minScore != null ? minScore : 0 %></div><div class="stat-label">最低分</div></div>
                <div class="stat-item"><div class="stat-val"><%= totalCount != null ? totalCount : 0 %></div><div class="stat-label">参考总人次</div></div>
                <div class="stat-item"><div class="stat-val"><%= passCount != null ? passCount : 0 %></div><div class="stat-label">通过人数</div></div>
                <div class="stat-item"><div class="stat-val"><%= failCount != null ? failCount : 0 %></div><div class="stat-label">未通过人数</div></div>
                <div class="stat-item"><div class="stat-val"><%= passRate != null ? passRate : "0.0" %>%</div><div class="stat-label">及格率</div></div>
            </div>
        </div>
        <div class="card">
            <div class="card-title">分数段分布</div>
            <table>
                <tr><th>分数段</th><th style="width:120px;text-align:center;">人数</th><th>占比</th></tr>
                <% String[] labels = {"90-100分（优秀）","80-89分（良好）","70-79分（中等）","60-69分（及格）","60分以下（不及格）"};
                   String[] colors = {"#27ae60","#27ae60","#e67e22","#e67e22","#e74c3c"};
                   for (int i = 0; i < 5; i++) { int cnt = rangeCounts[i];
                       String pct = total > 0 ? String.format("%.1f", cnt * 100.0 / total) + "%" : "0%";
                %>
                <tr>
                    <td><%= labels[i] %></td>
                    <td style="text-align:center;font-weight:bold;color:<%= colors[i] %>;"><%= cnt %> 人</td>
                    <td><div style="display:flex;align-items:center;gap:8px;"><div style="background:<%= colors[i] %>;height:14px;width:<%= total > 0 ? (cnt * 200 / total) : 0 %>px;border-radius:2px;"></div><span><%= pct %></span></div></td>
                </tr>
                <% } %>
            </table>
        </div>
        <div class="card">
            <div class="card-title">成绩明细</div>
            <table>
                <tr>
                    <th style="width:50px">序号</th>
                    <th>学生姓名</th>
                    <th>班级</th>
                    <th style="width:100px">考试编号</th>
                    <th style="width:100px">得分</th>
                    <th>提交时间</th>
                    <th style="width:80px">是否通过</th>
                </tr>
                <% int idx = 1; for (Score s : scoreList) { boolean passed = s.getScore() >= 60; %>
                <tr>
                    <td style="text-align:center;"><%= idx++ %></td>
                    <td><%= s.getRealName() != null ? s.getRealName() : "-" %></td>
                    <td><%= s.getClassName() != null ? s.getClassName() : "-" %></td>
                    <td style="text-align:center;">#<%= s.getExamId() %></td>
                    <td style="text-align:center;font-weight:bold;color:<%= passed ? "#27ae60":"#e74c3c" %>;"><%= s.getScore() %> 分</td>
                    <td><%= s.getSubmitTime() %></td>
                    <td style="text-align:center;color:<%= passed ? "#27ae60":"#e74c3c" %>;"><%= passed ? "✔ 通过" : "✘ 未通过" %></td>
                </tr>
                <% } %>
            </table>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
