package com.example.dazuoye.controller;

import com.example.dazuoye.entity.Score;
import com.example.dazuoye.entity.User;
import com.example.dazuoye.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ScoreController {

    @Autowired
    private ScoreService scoreService;

    @GetMapping("/myScores")
    public String myScores(HttpSession session, HttpServletRequest request) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"student".equals(user.getRole())) {
            return "redirect:/index.jsp?type=student";
        }

        List<Score> scoreList = scoreService.findByStudentId(user.getId());
        request.setAttribute("scoreList", scoreList);
        return "student/score_list";
    }
}
