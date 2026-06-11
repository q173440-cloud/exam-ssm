-- ============================================
-- 网络考试系统（SSM 版）
-- 数据库：exam_db
-- 字符集：utf8
-- MySQL 版本：5.0+
-- ============================================

CREATE DATABASE IF NOT EXISTS exam_db DEFAULT CHARACTER SET utf8;
USE exam_db;

-- ---------- 教师表 ----------
DROP TABLE IF EXISTS teachers;
CREATE TABLE teachers (
  id        INT          NOT NULL AUTO_INCREMENT,
  username  VARCHAR(50)  NOT NULL,
  password  VARCHAR(50)  NOT NULL,
  real_name VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uk_teacher_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---------- 学生表 ----------
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id         INT          NOT NULL AUTO_INCREMENT,
  username   VARCHAR(50)  NOT NULL,
  password   VARCHAR(50)  NOT NULL,
  real_name  VARCHAR(100) DEFAULT NULL,
  class_name VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uk_student_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---------- 题目表 ----------
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
  id       INT          NOT NULL AUTO_INCREMENT,
  content  TEXT         NOT NULL,
  option_a VARCHAR(500) DEFAULT NULL,
  option_b VARCHAR(500) DEFAULT NULL,
  option_c VARCHAR(500) DEFAULT NULL,
  option_d VARCHAR(500) DEFAULT NULL,
  answer   VARCHAR(5)   NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---------- 考试记录表 ----------
DROP TABLE IF EXISTS exams;
CREATE TABLE exams (
  id          INT         NOT NULL AUTO_INCREMENT,
  student_id  INT         NOT NULL,
  start_time  DATETIME    DEFAULT NULL,
  submit_time DATETIME    DEFAULT NULL,
  status      VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---------- 考试题目关联表 ----------
DROP TABLE IF EXISTS exam_questions;
CREATE TABLE exam_questions (
  id              INT        NOT NULL AUTO_INCREMENT,
  exam_id         INT        NOT NULL,
  question_id     INT        NOT NULL,
  student_answer  VARCHAR(5) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---------- 成绩表 ----------
DROP TABLE IF EXISTS scores;
CREATE TABLE scores (
  id          INT      NOT NULL AUTO_INCREMENT,
  student_id  INT      NOT NULL,
  exam_id     INT      NOT NULL,
  score       INT      DEFAULT 0,
  submit_time DATETIME DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ---------- 初始数据 ----------
-- 教师账号
INSERT INTO teachers (username, password, real_name) VALUES
('teacher', '123456', 'Teacher Wang');

-- 学生账号
INSERT INTO students (username, password, real_name, class_name) VALUES
('stu001', '123456', 'Zhang San',  'Class 1'),
('stu002', '123456', 'Li Si',      'Class 1'),
('stu003', '123456', 'Wang Wu',    'Class 2');

-- 题库（15 道英文计算机基础题，避免 MySQL 5.0 中文导入问题）
INSERT INTO questions (content, option_a, option_b, option_c, option_d, answer) VALUES
('How many bits are in one byte?',                           '4',         '8',         '16',        '32',        'B'),
('Which of the following is NOT an operating system?',       'Windows',   'Linux',     'Oracle',    'macOS',     'C'),
('What does HTML stand for?',                                'Hyper Text Markup Language', 'High Tech Modern Language', 'Hyper Transfer Markup Language', 'High Text Markup Language', 'A'),
('Which keyword is used to define an interface in Java?',    'class',     'abstract',  'interface', 'extends',   'C'),
('Which sorting algorithm has an average time complexity of O(n log n)?', 'Bubble Sort', 'Insertion Sort', 'Quick Sort', 'Selection Sort', 'C'),
('What is the default port number for HTTP?',                '21',        '23',        '80',        '443',       'C'),
('Which SQL statement is used to query data?',               'INSERT',    'UPDATE',    'SELECT',    'DELETE',    'C'),
('Which is a primitive data type in Java?',                  'String',    'Integer',   'int',       'Object',    'C'),
('What does CPU stand for?',                                 'Memory',    'Central Processing Unit', 'Hard Disk', 'Motherboard', 'B'),
('Which type of IP address is 192.168.1.1?',                 'Public',    'Private',   'Broadcast','Loopback',  'B'),
('What does System.out.println() do?',                       'Read input','Print with newline', 'Declare variable', 'Define class', 'B'),
('Which protocol is used to send email?',                    'FTP',       'HTTP',      'SMTP',      'DNS',       'C'),
('Which modifier makes a member visible to all classes?',    'private',   'protected', 'public',    'default',   'C'),
('A mouse and keyboard are which type of device?',           'Output',    'Storage',   'Input',     'Processing','C'),
('Which is NOT one of the three pillars of OOP?',            'Encapsulation', 'Inheritance', 'Polymorphism', 'Recursion', 'D');
