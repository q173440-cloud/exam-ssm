package com.example.dazuoye.service;

import com.example.dazuoye.entity.Score;
import java.util.List;
import java.util.Map;

public interface ScoreService {
    List<Score> findByStudentId(Integer studentId);
    List<Score> findAllWithStudentInfo();
    Map<String, Object> statistics();
    void saveScore(Integer studentId, Integer examId, Integer score);
    Map<String, Object> findStudentScoreDetail(Integer examId, Integer studentId);
}
