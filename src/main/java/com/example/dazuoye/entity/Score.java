package com.example.dazuoye.entity;

import java.util.Date;

public class Score {
    private Integer id;
    private Integer studentId;
    private Integer examId;
    private Integer score;
    private Date submitTime;
    private String realName;
    private String className;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    public Integer getExamId() { return examId; }
    public void setExamId(Integer examId) { this.examId = examId; }
    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }
    public Date getSubmitTime() { return submitTime; }
    public void setSubmitTime(Date submitTime) { this.submitTime = submitTime; }
    public String getRealName() { return realName; }
    public void setRealName(String realName) { this.realName = realName; }
    public String getClassName() { return className; }
    public void setClassName(String className) { this.className = className; }
}
