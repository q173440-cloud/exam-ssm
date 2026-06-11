package com.example.dazuoye.mapper;

import com.example.dazuoye.entity.User;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface UserMapper {
    User loginStudent(@Param("username") String username, @Param("password") String password);
    User loginTeacher(@Param("username") String username, @Param("password") String password);
    List<User> findAllStudents();
    int countStudents();
}
