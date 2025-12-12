CREATE DATABASE project;
USE project;

CREATE TABLE users(
    email VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100) NOT NULL,
    role ENUM('student','admin') NOT NULL
);

CREATE TABLE courses(
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50),
    description VARCHAR(250),
    fees INT,
    start_date DATE,
    end_date DATE,
    video_expire_days INT
);

CREATE TABLE students(
    reg_no INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    course_id INT,
    mobile_no BIGINT,
    profile_pic BLOB,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE videos(
    video_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    title VARCHAR(100),
    description VARCHAR(250),
    youtube_url VARCHAR(300),
    added_at DATE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);


-- INSERT INTO users
INSERT INTO users (email, password, role) VALUES
('s1', 'pass1', 'student'),
('s2', 'pass2', 'student'),
('s3', 'pass3', 'student'),
('admin@gmail.com', 'admin123', 'admin');

-- INSERT INTO courses
INSERT INTO courses (course_name, description, fees, start_date, end_date, video_expire_days) VALUES
('IIT-MERN-2025', 'MERN', 100000, '2025-12-20', '2026-01-20', 30),
('AI', 'some course related to AI', 100000, '2025-12-24', '2026-01-20', 5),
('Android', 'Android related course', 9999, '2025-12-24', '2026-01-24', 7),
('python', 'py', 100000, '2025-12-24', '2026-01-24', 20);

-- INSERT INTO students
INSERT INTO students (name, email, course_id, mobile_no, profile_pic) VALUES
('student1', 's1', 1, 123456, NULL),
('student3', 's3', 1, 123456, NULL),
('student2', 's2', 3, 123456, NULL);

-- INSERT INTO videos
INSERT INTO videos (course_id, title, description, youtube_url, added_at) VALUES
(1, 'MERN video 6', 'desc', 'url1', '2025-11-26 23:36:18'),
 (1, 'MERN 10','desc', 'url2', '2025-11-26 23:52:13');

-- Q1. Write a Sql query that will fetch all upcoming courses.

select *from courses;

-- Q2. Write a Sql query that will fetch all the registered students along with course name.
  
 select reg_no,name,email,mobile_no,course_id,course_name
 from students natural join 
 courses;

-- Q3. Write an SQL query to fetch the complete details of a student (based on their email) along with the details
-- of the course they are enrolled in.

select reg_no,name,email,mobile_no,course_id,course_name,description,fees,start_date, end_date, video_expire_days
 from students natural join 
 courses;
 
 -- Q4. Write an SQL query to retrieve the course details and the list of non-expired videos for a specific student
--  using their email address. A video is considered active (not expired) if its added_at date plus the course’s
--  video_expire_days has not yet passed compared to the current date.
 
select course_id, course_name, start_date, end_date, video_expire_days,
       video_id, title, added_at
from students
natural join courses
natural join videos
where email = 's1'
  AND DATE_ADD(added_at, INTERVAL video_expire_days DAY) >= CURRENT_DATE;

 

 





