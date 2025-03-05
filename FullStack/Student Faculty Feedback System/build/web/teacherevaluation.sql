CREATE TABLE teacherevaluation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    roll_no VARCHAR(20) NOT NULL,
    branch VARCHAR(50) NOT NULL,
    year VARCHAR(10) NOT NULL,
    semester VARCHAR(10) NOT NULL,
    teacher VARCHAR(100) NOT NULL,
    feedback_date DATE NOT NULL,
    q1 INT NOT NULL,
    q2 INT NOT NULL,
    q3 INT NOT NULL,
    q4 INT NOT NULL,
    q5 INT NOT NULL,
    q6 INT NOT NULL,
    q7 INT NOT NULL,
    q8 INT NOT NULL
);
