package com.example.dazuoye.controller;

import com.example.dazuoye.entity.Question;
import com.example.dazuoye.entity.User;
import com.example.dazuoye.service.ExamService;
import com.example.dazuoye.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class ExamController {

    @Autowired
    private ExamService examService;

    @Autowired
    private ScoreService scoreService;

    @GetMapping("/startExam")
    public String startExam(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"student".equals(user.getRole())) {
            return "redirect:/index.jsp?type=student";
        }

        Map<String, Object> examData = examService.startExam(user.getId());

        Boolean success = (Boolean) examData.get("success");
        if (success == null || !success) {
            request.setAttribute("errorMsg", examData.get("message"));
            return "student/index";
        }

        session.setAttribute("currentExamId", examData.get("examId"));
        session.setAttribute("currentQuestions", examData.get("questions"));
        return "redirect:/student/exam";
    }

    @GetMapping("/student/exam")
    public String examPage(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"student".equals(user.getRole())) {
            return "redirect:/index.jsp?type=student";
        }
        if (session.getAttribute("currentQuestions") == null
                || session.getAttribute("currentExamId") == null) {
            return "redirect:/student/index";
        }
        return "student/exam";
    }

    @PostMapping("/submitExam")
    public String submitExam(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"student".equals(user.getRole())) {
            return "redirect:/index.jsp?type=student";
        }

        Integer examId = (Integer) session.getAttribute("currentExamId");
        if (examId == null) {
            return "redirect:/student/index";
        }

        // 收集答案
        Map<Integer, String> answers = new HashMap<>();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String name = paramNames.nextElement();
            if (name.startsWith("q_")) {
                Integer qId = Integer.parseInt(name.substring(2));
                String answer = request.getParameter(name);
                if (answer != null && !answer.isEmpty()) {
                    answers.put(qId, answer);
                }
            }
        }

        // 提交考试
        Map<String, Object> result = examService.submitExam(examId, answers);
        int score = (int) result.get("score");

        // 保存成绩
        scoreService.saveScore(user.getId(), examId, score);

        // 清理考试 session，保存结果
        session.removeAttribute("currentExamId");
        session.removeAttribute("currentQuestions");
        session.setAttribute("lastScore", result.get("score"));
        session.setAttribute("lastExamId", examId);
        session.setAttribute("lastDetail", result.get("details"));

        return "redirect:/student/result";
    }

    @GetMapping("/student/result")
    public String resultPage(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"student".equals(user.getRole())) {
            return "redirect:/index.jsp?type=student";
        }
        if (session.getAttribute("lastScore") == null) {
            return "redirect:/student/index";
        }
        return "student/result";
    }
}
