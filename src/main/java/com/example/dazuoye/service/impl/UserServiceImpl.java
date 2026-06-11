package com.example.dazuoye.service.impl;

import com.example.dazuoye.entity.User;
import com.example.dazuoye.mapper.UserMapper;
import com.example.dazuoye.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public User loginStudent(String username, String password) {
        return userMapper.loginStudent(username, password);
    }

    @Override
    public User loginTeacher(String username, String password) {
        return userMapper.loginTeacher(username, password);
    }

    @Override
    public int countStudents() {
        return userMapper.countStudents();
    }
}
