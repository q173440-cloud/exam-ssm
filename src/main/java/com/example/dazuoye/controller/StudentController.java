package com.example.dazuoye.controller;

import com.example.dazuoye.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/student")
public class StudentController {

    @GetMapping("/index")
    public String index(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null || !"student".equals(user.getRole())) {
            return "redirect:/index.jsp?type=student";
        }
        return "student/index";
    }
}
