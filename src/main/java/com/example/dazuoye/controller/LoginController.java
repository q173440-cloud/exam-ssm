package com.example.dazuoye.controller;

import com.example.dazuoye.entity.User;
import com.example.dazuoye.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @GetMapping({"/", "/index"})
    public String index() {
        return "index";
    }

    @PostMapping("/studentLogin")
    public String studentLogin(@RequestParam String username,
                                @RequestParam String password,
                                HttpSession session,
                                javax.servlet.http.HttpServletRequest request) {
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("loginType", "student");
            request.setAttribute("errorMsg", "学号和密码不能为空");
            return "index";
        }
        User user = userService.loginStudent(username.trim(), password.trim());
        if (user == null) {
            request.setAttribute("loginType", "student");
            request.setAttribute("errorMsg", "学号或密码错误");
            return "index";
        }
        session.setAttribute("loginUser", user);
        return "redirect:/student/index";
    }

    @PostMapping("/teacherLogin")
    public String teacherLogin(@RequestParam String username,
                                @RequestParam String password,
                                HttpSession session,
                                javax.servlet.http.HttpServletRequest request) {
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("loginType", "teacher");
            request.setAttribute("errorMsg", "教师账号和密码不能为空");
            return "index";
        }
        User user = userService.loginTeacher(username.trim(), password.trim());
        if (user == null) {
            request.setAttribute("loginType", "teacher");
            request.setAttribute("errorMsg", "教师账号或密码错误");
            return "index";
        }
        session.setAttribute("loginUser", user);
        return "redirect:/teacher/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
