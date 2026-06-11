package com.example.dazuoye.service.impl;

import com.example.dazuoye.entity.Question;
import com.example.dazuoye.mapper.QuestionMapper;
import com.example.dazuoye.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionMapper questionMapper;

    @Override
    public List<Question> findAll() {
        return questionMapper.findAll();
    }

    @Override
    public Question findById(Integer id) {
        return questionMapper.findById(id);
    }

    @Override
    public List<Question> findRandom(int count) {
        return questionMapper.findRandom(count);
    }

    @Override
    public int countAll() {
        return questionMapper.countAll();
    }

    @Override
    public void add(Question question) {
        questionMapper.insert(question);
    }

    @Override
    public void update(Question question) {
        questionMapper.update(question);
    }

    @Override
    public void delete(Integer id) {
        questionMapper.delete(id);
    }
}
