package com.example.dazuoye.service.impl;

import com.example.dazuoye.entity.Score;
import com.example.dazuoye.mapper.ExamMapper;
import com.example.dazuoye.mapper.ScoreMapper;
import com.example.dazuoye.service.ScoreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class ScoreServiceImpl implements ScoreService {

    @Autowired
    private ScoreMapper scoreMapper;

    @Autowired
    private ExamMapper examMapper;

    @Override
    public List<Score> findByStudentId(Integer studentId) {
        return scoreMapper.findByStudentId(studentId);
    }

    @Override
    public List<Score> findAllWithStudentInfo() {
        return scoreMapper.findAllWithStudentInfo();
    }

    @Override
    public Map<String, Object> statistics() {
        Map<String, Object> stats = new LinkedHashMap<>();
        int total = scoreMapper.countAllScores();
        stats.put("avgScore", scoreMapper.avgScore() != null ? scoreMapper.avgScore() : 0);
        stats.put("maxScore", scoreMapper.maxScore() != null ? scoreMapper.maxScore() : 0);
        stats.put("minScore", scoreMapper.minScore() != null ? scoreMapper.minScore() : 0);
        stats.put("totalCount", total);
        int passCount = scoreMapper.countPassedScores();
        stats.put("passCount", passCount);
        stats.put("failCount", total - passCount);
        stats.put("passRate", total > 0 ? String.format("%.1f", passCount * 100.0 / total) : "0.0");

        int[] ranges = new int[5];
        ranges[0] = scoreMapper.countRange(90, 100);   // 优秀
        ranges[1] = scoreMapper.countRange(80, 89);    // 良好
        ranges[2] = scoreMapper.countRange(70, 79);    // 中等
        ranges[3] = scoreMapper.countRange(60, 69);    // 及格
        ranges[4] = scoreMapper.countRange(0, 59);     // 不及格
        stats.put("rangeCounts", ranges);

        return stats;
    }

    @Override
    public void saveScore(Integer studentId, Integer examId, Integer score) {
        Score s = new Score();
        s.setStudentId(studentId);
        s.setExamId(examId);
        s.setScore(score);
        s.setSubmitTime(new Date());
        scoreMapper.insert(s);
    }

    @Override
    public Map<String, Object> findStudentScoreDetail(Integer examId, Integer studentId) {
        Map<String, Object> result = new HashMap<String, Object>();

        if (examId == null || studentId == null) {
            result.put("success", false);
            result.put("message", "参数错误");
            return result;
        }

        Score score = scoreMapper.findByExamIdAndStudentId(examId, studentId);

        if (score == null) {
            result.put("success", false);
            result.put("message", "考试记录不存在或无权查看");
            return result;
        }

        List<Map<String, Object>> detailList = examMapper.findExamQuestionDetails(examId);

        result.put("success", true);
        result.put("score", score);
        result.put("detailList", detailList);

        return result;
    }
}
