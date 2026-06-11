package com.example.dazuoye.service.impl;

import com.example.dazuoye.entity.Exam;
import com.example.dazuoye.entity.Question;
import com.example.dazuoye.entity.Score;
import com.example.dazuoye.mapper.ExamMapper;
import com.example.dazuoye.mapper.QuestionMapper;
import com.example.dazuoye.mapper.ScoreMapper;
import com.example.dazuoye.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class ExamServiceImpl implements ExamService {

    private static final int QUESTION_COUNT = 10;
    private static final int SCORE_PER_QUESTION = 10;
    private static final int PASS_SCORE = 60;

    @Autowired
    private QuestionMapper questionMapper;

    @Autowired
    private ExamMapper examMapper;

    @Autowired
    private ScoreMapper scoreMapper;

    @Override
    @Transactional
    public Map<String, Object> startExam(Integer studentId) {
        Map<String, Object> result = new HashMap<String, Object>();

        // 随机抽题
        List<Question> questions = questionMapper.findRandom(QUESTION_COUNT);
        if (questions == null || questions.size() == 0) {
            result.put("success", false);
            result.put("message", "题库题目不足");
            return result;
        }

        // 创建考试记录（用 Exam 实体，MyBatis 自动将自增主键写回实体）
        Exam exam = new Exam();
        exam.setStudentId(studentId);
        exam.setStatus("ongoing");
        examMapper.insertExam(exam);

        Integer examId = exam.getId();

        // 插入考试题目关联
        for (Question q : questions) {
            examMapper.insertExamQuestion(examId, q.getId());
        }

        result.put("success", true);
        result.put("examId", examId);
        result.put("questions", questions);
        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> submitExam(Integer examId, Map<Integer, String> answers) {
        // 保存学生答案
        for (Map.Entry<Integer, String> entry : answers.entrySet()) {
            examMapper.updateStudentAnswer(examId, entry.getKey(), entry.getValue());
        }

        // 结束考试
        examMapper.finishExam(examId);

        // 计算得分
        int correctCount = examMapper.countCorrectAnswers(examId);
        int score = correctCount * SCORE_PER_QUESTION;

        // 获取考试信息用于学生ID
        List<Map<String, Object>> details = examMapper.findExamQuestionDetails(examId);

        // 保存成绩（需要从session获取studentId，这里由Controller传入）
        Map<String, Object> result = new HashMap<>();
        result.put("score", score);
        result.put("correctCount", correctCount);
        result.put("totalCount", QUESTION_COUNT);
        result.put("passed", score >= PASS_SCORE);
        result.put("details", details);
        return result;
    }

    @Override
    public List<Map<String, Object>> findExamQuestionDetails(Integer examId) {
        return examMapper.findExamQuestionDetails(examId);
    }
}
