package com.example.dazuoye.service;

import com.example.dazuoye.entity.Question;
import java.util.List;

public interface QuestionService {
    List<Question> findAll();
    Question findById(Integer id);
    List<Question> findRandom(int count);
    int countAll();
    void add(Question question);
    void update(Question question);
    void delete(Integer id);
}
