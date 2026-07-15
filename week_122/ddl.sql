CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_122;

USE SCHEMA week_122;

CREATE TABLE student_enroll_info (student_id INT PRIMARY KEY,course VARCHAR(50),duration VARCHAR(50));
-- Step 2: Insert data into the table
INSERT INTO student_enroll_info (student_id, course, duration) VALUES
(1, 'CSE', 'Four Years'),
(2, 'EEE', 'Three Years'),
(3, 'CSE', 'Four Years'),
(4, 'MSC', 'Three Years'),
(5, 'BSC', 'Three Years'),
(6, 'Mech', 'Four Years');

select count(*), course, duration
from student_enroll_info
group by grouping sets(course, duration)
