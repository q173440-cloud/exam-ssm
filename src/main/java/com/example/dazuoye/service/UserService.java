package com.example.dazuoye.service;

import com.example.dazuoye.entity.User;

public interface UserService {
    User loginStudent(String username, String password);
    User loginTeacher(String username, String password);
    int countStudents();
}
