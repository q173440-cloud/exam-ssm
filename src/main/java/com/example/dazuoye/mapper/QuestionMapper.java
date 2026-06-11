package com.example.dazuoye.mapper;

import com.example.dazuoye.entity.Question;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface QuestionMapper {
    List<Question> findAll();
    Question findById(Integer id);
    List<Question> findRandom(@Param("count") int count);
    int countAll();
    int insert(Question question);
    int update(Question question);
    int delete(Integer id);
}
