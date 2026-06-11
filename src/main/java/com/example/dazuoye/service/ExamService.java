package com.example.dazuoye.service;

import java.util.List;
import java.util.Map;

public interface ExamService {
    Map<String, Object> startExam(Integer studentId);
    Map<String, Object> submitExam(Integer examId, Map<Integer, String> answers);
    List<Map<String, Object>> findExamQuestionDetails(Integer examId);
}
