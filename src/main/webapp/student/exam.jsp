<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.dazuoye.entity.User,com.example.dazuoye.entity.Question,java.util.List" %>
<%
    User user = (User) session.getAttribute("loginUser");
    if (user == null || !"student".equals(user.getRole())) { response.sendRedirect(request.getContextPath() + "/?type=student"); return; }
    List<Question> questions = (List<Question>) session.getAttribute("currentQuestions");
    Integer examId = (Integer) session.getAttribute("currentExamId");
    if (questions == null || examId == null) { response.sendRedirect(request.getContextPath() + "/student/index"); return; }
    int totalQuestions = questions.size();
    int totalSeconds = 20 * 60;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>正在考试 - 网络考试系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="exam-topbar">
    <div class="exam-topbar-left">网络考试系统 · 正在考试</div>
    <div class="exam-topbar-right">
        <span>考生：<%= user.getRealName() %></span>
        <span>剩余时间：<span id="countdown">20:00</span></span>
        <span>已答：<span id="answeredCount">0</span>/<%= totalQuestions %></span>
    </div>
</div>
<div class="main-content exam-page">
    <div class="exam-shell">
        <div class="exam-main">
            <form id="examForm" action="${pageContext.request.contextPath}/submitExam" method="post">
                <% int num = 1; for (Question q : questions) { %>
                <div class="question-card single-question-card" id="question_<%= num %>" style="<%= num == 1 ? "" : "display:none;" %>">
                    <div class="q-num">第 <%= num %> 题（10分）</div>
                    <div class="q-content"><%= q.getContent() %></div>
                    <label class="option-item"><input type="radio" name="q_<%= q.getId() %>" value="A" />A. <%= q.getOptionA() %></label>
                    <label class="option-item"><input type="radio" name="q_<%= q.getId() %>" value="B" />B. <%= q.getOptionB() %></label>
                    <label class="option-item"><input type="radio" name="q_<%= q.getId() %>" value="C" />C. <%= q.getOptionC() %></label>
                    <label class="option-item"><input type="radio" name="q_<%= q.getId() %>" value="D" />D. <%= q.getOptionD() %></label>
                </div>
                <% num++; } %>
                <div class="exam-actions">
                    <button type="button" class="btn-primary" onclick="prevQuestion()">上一题</button>
                    <button type="button" class="btn-primary" onclick="nextQuestion()">下一题</button>
                    <button type="button" class="btn-danger" onclick="submitExam()">提交试卷</button>
                </div>
            </form>
        </div>
        <div class="exam-sidebar">
            <div class="sidebar-title">答题卡</div>
            <div class="question-nav-grid">
                <% for (int i = 1; i <= totalQuestions; i++) { %>
                <button type="button" class="q-nav-btn <%= i == 1 ? "current" : "" %>" onclick="showQuestion(<%= i %>)"><%= i %></button>
                <% } %>
            </div>
            <div class="nav-info">已答：<span id="answeredCount2">0</span>/<%= totalQuestions %></div>
        </div>
    </div>
</div>
<script>
    var currentQuestion = 1;
    var totalQuestions = <%= totalQuestions %>;
    var totalSeconds = <%= totalSeconds %>;
    var timer = setInterval(function() {
        totalSeconds--;
        var m = Math.floor(totalSeconds / 60), s = totalSeconds % 60;
        document.getElementById("countdown").innerText = (m<10?"0"+m:m) + ":" + (s<10?"0"+s:s);
        if (totalSeconds <= 180) document.getElementById("countdown").className = "urgent";
        if (totalSeconds <= 0) {
            clearInterval(timer);
            window.onbeforeunload = null;
            alert("考试时间已到，系统自动提交！");
            document.getElementById("examForm").submit();
        }
    }, 1000);

    function showQuestion(num) {
        currentQuestion = num;
        for (var i = 1; i <= totalQuestions; i++) {
            var card = document.getElementById("question_" + i);
            if (card) card.style.display = (i === num) ? "block" : "none";
        }
        updateNavButtons();
    }
    function prevQuestion() { if (currentQuestion > 1) showQuestion(currentQuestion - 1); }
    function nextQuestion() { if (currentQuestion < totalQuestions) showQuestion(currentQuestion + 1); }

    function updateAnsweredCount() {
        var answered = {};
        var radios = document.querySelectorAll("input[type=radio]");
        for (var i = 0; i < radios.length; i++) {
            if (radios[i].checked) answered[radios[i].name] = true;
        }
        var count = Object.keys(answered).length;
        document.getElementById("answeredCount").innerText = count;
        document.getElementById("answeredCount2").innerText = count;
        updateNavButtons();
    }

    function updateNavButtons() {
        var buttons = document.querySelectorAll(".q-nav-btn");
        for (var i = 0; i < buttons.length; i++) {
            var num = i + 1;
            var card = document.getElementById("question_" + num);
            var checked = card && card.querySelector("input[type=radio]:checked");
            buttons[i].className = "q-nav-btn";
            if (checked) buttons[i].className += " answered";
            if (num === currentQuestion) buttons[i].className += " current";
        }
    }

    var radios = document.querySelectorAll("input[type=radio]");
    for (var i = 0; i < radios.length; i++) { radios[i].onclick = updateAnsweredCount; }

    function submitExam() {
        var answered = {};
        var radios = document.querySelectorAll("input[type=radio]");
        for (var i = 0; i < radios.length; i++) { if (radios[i].checked) answered[radios[i].name] = true; }
        var answeredCount = Object.keys(answered).length;
        var notAnswered = totalQuestions - answeredCount;
        if (notAnswered > 0) {
            if (!confirm("还有 " + notAnswered + " 道题未作答，确认提交吗？")) return;
        } else {
            if (!confirm("确认提交试卷？提交后不可修改。")) return;
        }
        window.onbeforeunload = null;
        clearInterval(timer);
        document.getElementById("examForm").submit();
    }

    window.onbeforeunload = function() { return "考试进行中，确定要离开吗？"; };
    updateAnsweredCount();
</script>
</body>
</html>
