CREATE TABLE Students
(
    student_id int PRIMARY KEY,
    student_name varchar(100),
    student_department varchar(50)
);

CREATE TABLE Attendance
(
    id int PRIMARY KEY AUTO_INCREMENT,
    student_id int,
    total_classes int,
    attended_classes int
);

CREATE TABLE Performance
(
    id int PRIMARY KEY AUTO_INCREMENT,
    student_id int,
    course varchar(100),
    score decimal(5,2)
);

ALTER TABLE attendance 
ADD FOREIGN KEY (student_id) 
REFERENCES students(student_id) 
ON UPDATE CASCADE;

ALTER TABLE performance 
ADD FOREIGN KEY (student_id) 
REFERENCES students(student_id) 
ON UPDATE CASCADE;


ALTER TABLE students MODIFY student_id INT AUTO_INCREMENT;

INSERT INTO students (student_name, student_department) 
VALUES
('Faisal','CSE'),
('Trisha','CSE'),
('Kazi','EEE'),
('Mitu','EEE'),
('Alice','BBA');



INSERT INTO attendance (student_id, total_classes, attended_classes)
VALUES 
(1, 40, 38),
(2, 40, 39),
(3, 40, 30),
(4, 40, 40),
(5, 40, 20);

INSERT INTO performance (student_id, course, score)
VALUES
(4, 'Programming', 92.00),
(4, 'Algorithms', 88.00),
(1, 'Database', 95.50),
(1, 'AI', 98.00),
(2, 'Circuits', 60.00),
(2, 'Electronics', 40.00),
(3, 'Marketing', 55.00),
(3, 'Finance', 48.00),
(5, 'Operating System', 97.00),
(5, 'TOC', 94.00);



-- Q1
SELECT* FROM students;

-- Q2
SELECT s.student_name, s.student_id, (a.attended_classes*100/a.total_classes ) as attendance_percentage
FROM attendance a JOIN students s
on a.student_id = s.student_id;

-- Q3
SELECT s.student_name, s.student_id, (a.attended_classes*100/a.total_classes ) as attendance_percentage
FROM attendance a JOIN students s
on a.student_id = s.student_id
WHERE (a.attended_classes*100/a.total_classes ) <75 ; 


-- Q4
SELECT s.student_name, avg(p.score) as average_score
FROM students s JOIN performance p
on s.student_id = p.student_id
group by s.student_id;


-- Q5
SELECT s.student_name, p.course, p.score
FROM students s JOIN performance p
on s.student_id = p.student_id
where p.score <50;


-- Q6
SELECT s.student_id, s.student_name, (a.attended_classes*100/ a.total_classes) as average_percentage
FROM students s JOIN attendance a 
on s.student_id = a.student_id 
where a.attended_classes = a.total_classes ;


-- Q7
select s.student_name,avg(p.score) as average_score
FROM students s JOIN performance p
on s.student_id = p.student_id
group by s.student_id, s.student_name
order by average_score DESC
LIMIT 3;

-- Q8
select s.student_name,avg(p.score) as average_score
FROM students s JOIN performance p
on s.student_id = p.student_id
where s.student_department='CSE'
group by s.student_id, s.student_name
HAVING average_score>80



-- Q9
select course from performance
group by course
having max(score)<=90 ;


-- Q10 
SELECT s.student_id, s.student_name, (a.attended_classes*100/a.total_classes) as attend, avg(p.score) as average_score
from students s join performance p join attendance a 
on s.student_id = p.student_id and p.student_id=a.student_id
group by s.student_id, s.student_name
HAVING attend<75 and average_score<50 ;

