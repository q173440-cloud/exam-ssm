package com.example.dazuoye.controller;

import com.example.dazuoye.entity.Question;
import com.example.dazuoye.entity.User;
import com.example.dazuoye.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    @Autowired
    private QuestionService questionService;

    @Autowired
    private ScoreService scoreService;

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"teacher".equals(user.getRole())) {
            return "redirect:/index.jsp?type=teacher";
        }
        request.setAttribute("questionCount", questionService.countAll());
        request.setAttribute("studentCount", userService.countStudents());
        Map<String, Object> stats = scoreService.statistics();
        request.setAttribute("avgScore", stats.get("avgScore"));
        request.setAttribute("maxScore", stats.get("maxScore"));
        return "teacher/dashboard";
    }

    @GetMapping("/question")
    public String questionList(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"teacher".equals(user.getRole())) {
            return "redirect:/index.jsp?type=teacher";
        }
        String action = request.getParameter("action");
        if (action == null) action = "list";

        if ("list".equals(action)) {
            request.setAttribute("questionList", questionService.findAll());
            return "teacher/question_list";
        } else if ("toAdd".equals(action)) {
            return "teacher/question_add";
        } else if ("toEdit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            request.setAttribute("question", questionService.findById(id));
            return "teacher/question_edit";
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            questionService.delete(id);
            return "redirect:/teacher/question?action=list";
        }
        return "redirect:/teacher/question?action=list";
    }

    @PostMapping("/question")
    public String questionPost(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"teacher".equals(user.getRole())) {
            return "redirect:/index.jsp?type=teacher";
        }
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Question q = new Question();
            q.setContent(request.getParameter("content"));
            q.setOptionA(request.getParameter("optionA"));
            q.setOptionB(request.getParameter("optionB"));
            q.setOptionC(request.getParameter("optionC"));
            q.setOptionD(request.getParameter("optionD"));
            q.setAnswer(request.getParameter("answer"));
            questionService.add(q);
        } else if ("edit".equals(action)) {
            Question q = new Question();
            q.setId(Integer.parseInt(request.getParameter("id")));
            q.setContent(request.getParameter("content"));
            q.setOptionA(request.getParameter("optionA"));
            q.setOptionB(request.getParameter("optionB"));
            q.setOptionC(request.getParameter("optionC"));
            q.setOptionD(request.getParameter("optionD"));
            q.setAnswer(request.getParameter("answer"));
            questionService.update(q);
        }
        return "redirect:/teacher/question?action=list";
    }

    @GetMapping("/stat")
    public String stat(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"teacher".equals(user.getRole())) {
            return "redirect:/index.jsp?type=teacher";
        }
        List<com.example.dazuoye.entity.Score> scoreList = scoreService.findAllWithStudentInfo();
        Map<String, Object> stats = scoreService.statistics();

        request.setAttribute("scoreList", scoreList);
        request.setAttribute("avgScore", stats.get("avgScore"));
        request.setAttribute("maxScore", stats.get("maxScore"));
        request.setAttribute("minScore", stats.get("minScore"));
        request.setAttribute("totalCount", stats.get("totalCount"));
        request.setAttribute("passCount", stats.get("passCount"));
        request.setAttribute("failCount", stats.get("failCount"));
        request.setAttribute("passRate", stats.get("passRate"));
        request.setAttribute("rangeCounts", stats.get("rangeCounts"));

        return "teacher/score_stat";
    }
}
