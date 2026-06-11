package com.example.dazuoye.controller;

import com.example.dazuoye.entity.Score;
import com.example.dazuoye.entity.User;
import com.example.dazuoye.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class ScoreController {

    @Autowired
    private ScoreService scoreService;

    @GetMapping("/myScores")
    public String myScores(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null || !"student".equals(loginUser.getRole())) {
            return "redirect:/";
        }

        List<Score> scoreList = scoreService.findByStudentId(loginUser.getId());

        model.addAttribute("scoreList", scoreList);
        model.addAttribute("loginUser", loginUser);

        return "student/score_list";
    }

    @RequestMapping("/scoreDetail")
    public String scoreDetail(@RequestParam("examId") Integer examId,
                              HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null || !"student".equals(loginUser.getRole())) {
            return "redirect:/";
        }

        Map<String, Object> result = scoreService.findStudentScoreDetail(examId, loginUser.getId());

        Boolean success = (Boolean) result.get("success");
        if (success == null || !success) {
            model.addAttribute("errorMsg", result.get("message"));
            return "redirect:/myScores";
        }

        model.addAttribute("score", result.get("score"));
        model.addAttribute("detailList", result.get("detailList"));
        model.addAttribute("loginUser", loginUser);

        return "student/score_detail";
    }
}
