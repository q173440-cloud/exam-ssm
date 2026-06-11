package com.example.dazuoye.mapper;

import com.example.dazuoye.entity.Score;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface ScoreMapper {
    int insert(Score score);
    List<Score> findByStudentId(@Param("studentId") Integer studentId);
    List<Score> findAllWithStudentInfo();
    int countAllScores();
    int countPassedScores();
    Integer avgScore();
    Integer maxScore();
    Integer minScore();
    int countRange(@Param("min") int min, @Param("max") int max);
}
