package com.example.dazuoye.mapper;

import com.example.dazuoye.entity.Exam;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface ExamMapper {
    int insertExam(Exam exam);
    int insertExamQuestion(@Param("examId") Integer examId, @Param("questionId") Integer questionId);
    int updateStudentAnswer(@Param("examId") Integer examId, @Param("questionId") Integer questionId, @Param("studentAnswer") String studentAnswer);
    int finishExam(@Param("examId") Integer examId);
    List<Map<String, Object>> findExamQuestionDetails(@Param("examId") Integer examId);
    int countCorrectAnswers(@Param("examId") Integer examId);
}
