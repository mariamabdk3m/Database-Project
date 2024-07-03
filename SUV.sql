CREATE DATABASE `suv`;

USE `suv`;

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) UNIQUE,
    sup_id INT UNIQUE
    /* FOREIGN KEY (sup_id) REFERENCES Professor(prof_id)*/
);
CREATE TABLE Professor (
    prof_id INT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(255),
    Name VARCHAR(100),
    Email VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

ALTER TABLE Department ADD CONSTRAINT FOREIGN KEY(sup_id) REFERENCES Professor(prof_id);

CREATE TABLE Student (
    std_id INT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE,
    Password VARCHAR(255),
    name VARCHAR(100),
    Email VARCHAR(100),
    Degree_lvl  ENUM('Undergraduate', 'Postgraduate'),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    prof_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id),
    FOREIGN KEY (prof_id) REFERENCES Professor(prof_id)
);
CREATE TABLE CourseProfessor (
    course_id INT,
    prof_id INT,
    PRIMARY KEY (course_id, prof_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (prof_id) REFERENCES Professor(prof_id)
);

CREATE TABLE Exam (
    exam_id INT PRIMARY KEY,
    course_id INT,
    exam_name VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE ExamScore (
    exam_id INT,
    std_id INT,
    score FLOAT,
    Grade VARCHAR(10),
    PRIMARY KEY (exam_id, std_id),
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id),
    FOREIGN KEY (std_id) REFERENCES Student(std_id)
);

CREATE TABLE Question (
    ques_id INT PRIMARY KEY,
    course_id INT,
    ques_txt TEXT,
    ques_ans VARCHAR(255),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE ExamQuestion (
    exam_id INT,
    ques_id INT,
    PRIMARY KEY (exam_id, ques_id),
    FOREIGN KEY (exam_id) REFERENCES Exam(exam_id),
    FOREIGN KEY (ques_id) REFERENCES Question(ques_id)
);

CREATE TABLE CourseEvaluation (
    course_id INT,
    std_id INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    
    PRIMARY KEY (course_id, std_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (std_id) REFERENCES Student(std_id)
);
CREATE TABLE ProfessorEvaluation (
    prof_id INT,
    std_id INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comments TEXT,
    PRIMARY KEY (prof_id, std_id, course_id),
    FOREIGN KEY (prof_id) REFERENCES Professor(prof_id),
    FOREIGN KEY (std_id) REFERENCES Student(std_id)
);


-- Disable foreign key checks
SET FOREIGN_KEY_CHECKS = 0;

-- Insert initial data into Professor and Department tables

-- Insert professors (without dept_id)
INSERT INTO Professor (prof_id, Username, Password, Name, Email)
VALUES 
    (1, 'prof_john', 'password123', 'John Doe', 'john.doe@example.com'),
    (2, 'prof_jane', 'password123', 'Jane Smith', 'jane.smith@example.com'),
    (3, 'prof_alex', 'password123', 'Alex Johnson', 'alex.johnson@example.com'),
    (4, 'prof_linda', 'password123', 'Linda White', 'linda.white@example.com'),
    (5, 'prof_mike', 'password123', 'Mike Brown', 'mike.brown@example.com');

-- Insert departments (without sup_id)
INSERT INTO Department (dept_id, dept_name)
VALUES 
    (1, 'Computer Science'),
    (2, 'Mathematics'),
    (3, 'Physics'),
    (4, 'Chemistry'),
    (5, 'Biology');

-- Update Department table to set sup_id
UPDATE Department SET sup_id = 1 WHERE dept_id = 1;
UPDATE Department SET sup_id = 2 WHERE dept_id = 2;
UPDATE Department SET sup_id = 3 WHERE dept_id = 3;
UPDATE Department SET sup_id = 4 WHERE dept_id = 4;
UPDATE Department SET sup_id = 5 WHERE dept_id = 5;

-- Update Professor table to set dept_id
UPDATE Professor SET dept_id = 1 WHERE prof_id = 1;
UPDATE Professor SET dept_id = 2 WHERE prof_id = 2;
UPDATE Professor SET dept_id = 3 WHERE prof_id = 3;
UPDATE Professor SET dept_id = 4 WHERE prof_id = 4;
UPDATE Professor SET dept_id = 5 WHERE prof_id = 5;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- Insert students
INSERT INTO Student (std_id, Username, Password, name, Email, Degree_lvl, dept_id)
VALUES 
    (1, 'student_anna', 'password123', 'Anna Lee', 'anna.lee@example.com', 'Undergraduate', 1),
    (2, 'student_bob', 'password123', 'Bob Green', 'bob.green@example.com', 'Undergraduate', 2),
    (3, 'student_chris', 'password123', 'Chris Kim', 'chris.kim@example.com', 'Postgraduate', 3),
    (4, 'student_diana', 'password123', 'Diana Rose', 'diana.rose@example.com', 'Postgraduate', 4),
    (5, 'student_ellen', 'password123', 'Ellen Gray', 'ellen.gray@example.com', 'Undergraduate', 5)
    (6, 'student_fiona', 'password123', 'Fiona Blue', 'fiona.blue@example.com', 'Undergraduate', 1),
    (7, 'student_george', 'password123', 'George White', 'george.white@example.com', 'Postgraduate', 2),
    (8, 'student_henry', 'password123', 'Henry Black', 'henry.black@example.com', 'Undergraduate', 3),
    (9, 'student_ivy', 'password123', 'Ivy Pink', 'ivy.pink@example.com', 'Postgraduate', 4),
    (10, 'student_jack', 'password123', 'Jack Red', 'jack.red@example.com', 'Undergraduate', 5);

# Insert courses
INSERT INTO Course (course_id, course_name, dept_id)
VALUES 
    (1, 'Algorithms', 1),
    (2, 'Calculus', 2),
    (3, 'Quantum Mechanics', 3),
    (4, 'Organic Chemistry', 4),
    (5, 'Genetics', 5);

# Insert CourseProfessor entries
INSERT INTO CourseProfessor (course_id, prof_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5)
    (1, 2), 
    (3, 4);

# Insert exams
INSERT INTO Exam (exam_id, course_id, exam_name)
VALUES 
    (1, 1, 'Midterm Exam'),
    (2, 2, 'Final Exam'),
    (3, 3, 'Midterm Exam'),
    (4, 4, 'Final Exam'),
    (5, 5, 'Midterm Exam');

# Insert exam scores
INSERT INTO ExamScore (exam_id, std_id, score, Grade)
VALUES 
    (1, 1, 85.5, 'B'),
    (2, 2, 90.0, 'A'),
    (3, 3, 88.0, 'B+'),
    (4, 4, 92.0, 'A'),
    (5, 5, 78.0, 'C+'),
    (1, 6, 88.5, 'B+'),
    (2, 7, 91.0, 'A'),
    (3, 8, 86.0, 'B'),
    (4, 9, 89.0, 'B+'),
    (5, 10, 80.0, 'B-'),
    (5, 1, 85.5, 'B'),
    (3, 2, 90.0, 'A'),
    (4, 3, 88.0, 'B+'),
    (2, 4, 92.0, 'A'),
    (1, 5, 78.0, 'C+'),
    (5, 6, 88.5, 'B+'),
    (3, 7, 91.0, 'A'),
    (4, 8, 86.0, 'B'),
    (2, 9, 89.0, 'B+'),
    (1, 10, 80.0, 'B-');

# Insert questions
INSERT INTO Question (ques_id, course_id, ques_txt, ques_ans)
VALUES 
    (1, 1, 'What is a binary tree?', 'A tree data structure with at most two children.'),
    (2, 2, 'Define integral calculus.', 'Branch of calculus dealing with integrals and their properties.'),
    (3, 3, 'What is Schrodingers equation?', 'A fundamental equation in quantum mechanics describing how the quantum state of a physical system changes with time.'),
    (4, 4, 'What are organic compounds?', 'Compounds containing carbon, typically with hydrogen, oxygen, nitrogen, etc.'),
    (5, 5, 'Define genetic mutation.', 'A change in the nucleotide sequence of the DNA.')
    (6, 1, 'Explain quicksort algorithm.', 'A divide-and-conquer algorithm for sorting.'),
    (7, 2, 'What is a derivative?', 'A measure of how a function changes as its input changes.'),
    (8, 3, 'What is the uncertainty principle?', 'A principle in quantum mechanics stating that it is impossible to simultaneously know the exact position and momentum of a particle.'),
    (9, 4, 'Describe the structure of benzene.', 'A ring of six carbon atoms with alternating double bonds.'),
    (10, 5, 'What is DNA replication?', 'The process by which a double-stranded DNA molecule is copied to produce two identical DNA molecules.');

-- Insert exam questions
INSERT INTO ExamQuestion (exam_id, ques_id)
VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5)
    (1, 6),
    (2, 7),
    (3, 8),
    (4, 9),
    (5, 10);

# Insert course evaluations
INSERT INTO CourseEvaluation (course_id, std_id, Rating)
VALUES 
    (1, 1, 4),
    (2, 2, 5),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5)
    (1, 6, 5),
    (2, 7, 4),
    (3, 8, 4),
    (4, 9, 5),
    (5, 10, 4);

# Insert professor evaluations
INSERT INTO ProfessorEvaluation (prof_id, std_id, Rating)
VALUES 
    (1, 1, 4),
    (2, 2, 5),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (1, 6, 5),
    (2, 7, 4),
    (3, 8, 4),
    (4, 9, 5),
    (5, 10, 4);
----------------------------------------------------------------
# Quires on the database:
/*
1- Write a query that enables the students to view their results per course
*/
SELECT 
    s.std_id AS student_ID,
    s.name AS student_name,
    c.course_name,
    e.exam_name,
    es.score,
    es.Grade
FROM 
    Student s JOIN ExamScore es ON s.std_id = es.std_id
    JOIN Exam e ON es.exam_id = e.exam_id
    JOIN Course c ON e.course_id = c.course_id
WHERE s.std_id = 4;
-----------------------------------------------------------------
/*
2- Write a query that enables the head of department to see evaluation of each course and
professor.
*/
SELECT 
    d.dept_name,
    c.course_name,
    AVG(ce.Rating) AS avg_course_rating,
    p.Name AS professor_name,
    AVG(pe.Rating) AS avg_professor_rating
FROM 
    Department d
    JOIN Course c ON d.dept_id = c.dept_id
    LEFT JOIN CourseEvaluation ce ON c.course_id = ce.course_id
    JOIN CourseProfessor cp ON c.course_id = cp.course_id
    JOIN Professor p ON cp.prof_id = p.prof_id
    LEFT JOIN ProfessorEvaluation pe ON p.prof_id = pe.prof_id
GROUP BY 
    d.dept_name, c.course_name, p.Name;

/*
3- Write a query that enables you to get top 10 high scores per course .
*/
SELECT 
    c.course_name,
    s.name AS student_name,
    es.score,
    es.Grade
FROM 
    Course c
    JOIN Exam e ON c.course_id = e.course_id
    JOIN ExamScore es ON e.exam_id = es.exam_id
    JOIN Student s ON es.std_id = s.std_id
ORDER BY 
    c.course_name, es.score DESC
LIMIT 10;

/*
4- Write a query to get the highest evaluation professor from the set of professors teaching the
same course .
*/
SELECT
    p.Name,
    c.course_name,
    d.dept_name,
    avg_ratings.avg_rating AS max_avg_rating
FROM (
    SELECT
        cp.course_id,
        pe.prof_id,
        AVG(pe.Rating) AS avg_rating
    FROM
        professorevaluation pe
    JOIN
        courseprofessor cp ON pe.prof_id = cp.prof_id
    GROUP BY
        cp.course_id, pe.prof_id
) avg_ratings
JOIN (
    SELECT
        course_id,
        MAX(avg_rating) AS max_avg_rating
    FROM (
        SELECT
            cp.course_id,
            pe.prof_id,
            AVG(pe.Rating) AS avg_rating
        FROM
            professorevaluation pe
        JOIN
            courseprofessor cp ON pe.prof_id = cp.prof_id
        GROUP BY
            cp.course_id, pe.prof_id
    ) avg_subquery
    GROUP BY
        course_id
) max_avg_per_course ON avg_ratings.course_id = max_avg_per_course.course_id
AND avg_ratings.avg_rating = max_avg_per_course.max_avg_rating
JOIN
    professor p ON avg_ratings.prof_id = p.prof_id
JOIN
    course c ON avg_ratings.course_id = c.course_id
JOIN
    department d ON c.dept_id = d.dept_id
ORDER BY c.course_name;
