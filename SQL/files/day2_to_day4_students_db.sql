-- ================================================
-- DATA ENGINEERING JOURNEY
-- Days 2-4: Students Database
-- Author: Dorcas Agbakaizu
-- Date: April 2026
-- Database: Data_Eng
-- ================================================

-- ------------------------------------------------
-- DAY 2: DATABASE & TABLE SETUP
-- ------------------------------------------------

-- Create the database
CREATE DATABASE Data_Eng;

-- Tell SQL to work inside this database
USE [Data_Eng];

-- ------------------------------------------------
-- LESSON 1: CREATE TABLE
-- INT stores whole numbers (age, ID)
-- VARCHAR(50) stores text up to 50 characters
-- PRIMARY KEY uniquely identifies each row
-- and prevents duplicate entries
-- ------------------------------------------------

CREATE TABLE students (
    student_id  INT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    age         INT,
    city        VARCHAR(50)
);

-- ------------------------------------------------
-- LESSON 2: INSERT DATA
-- Numbers have no quotes
-- Text values have single quotes
-- Each row is wrapped in its own brackets ()
-- ------------------------------------------------

INSERT INTO students (student_id, first_name, last_name, age, city)
VALUES 
    (1, 'Dorcas',  'Agbakaizu', 23, 'Lagos'),
    (2, 'Alex',    'Cole',      21, 'Abuja'),
    (3, 'Olumide', 'Adodo',     23, 'Ibadan'),
    (4, 'Paul',    'Williams',  26, 'Enugu'),
    (5, 'Dera',    'Dapson',    24, 'Lagos');

-- ------------------------------------------------
-- LESSON 3: SELECT QUERIES
-- SELECT * means show ALL columns
-- SELECT column_name means show specific columns
-- ------------------------------------------------

-- Show everything
SELECT * FROM students;

-- Show specific columns only
SELECT first_name, city FROM students;

-- ------------------------------------------------
-- DAY 3: FILTERING & SORTING
-- ------------------------------------------------

-- ------------------------------------------------
-- LESSON 4: WHERE Clause
-- Filters rows based on a condition
-- Numbers: no quotes | Text: single quotes
-- ------------------------------------------------

-- Filter by city
SELECT * FROM students
WHERE city = 'Lagos';

-- Filter by age
SELECT first_name, age FROM students
WHERE age = 23;

-- Filter by student ID
SELECT * FROM students
WHERE student_id = 3;

-- Filter by city for specific columns
SELECT first_name, last_name FROM students
WHERE city = 'Abuja';

-- ------------------------------------------------
-- LESSON 5: AND / OR
-- AND = both conditions must be true
-- OR = at least one condition must be true
-- ------------------------------------------------

-- AND example
SELECT * FROM students
WHERE age = 23 AND city = 'Lagos';

-- OR example
SELECT * FROM students
WHERE city = 'Lagos' OR city = 'Abuja';

-- More OR examples
SELECT * FROM students
WHERE city = 'Ibadan' OR city = 'Enugu';

-- AND with comparison operator
SELECT * FROM students
WHERE age > 22 AND city = 'Lagos';

-- ------------------------------------------------
-- LESSON 6: ORDER BY
-- ASC = ascending (smallest to largest / A to Z)
-- DESC = descending (largest to smallest / Z to A)
-- ------------------------------------------------

-- Sort by age ascending
SELECT * FROM students
ORDER BY age ASC;

-- Sort by name alphabetically
SELECT * FROM students
ORDER BY first_name ASC;

-- Sort by age descending
SELECT * FROM students
ORDER BY age DESC;

-- Combine WHERE and ORDER BY
SELECT first_name, age FROM students
WHERE age = 23 OR age = 24
ORDER BY age ASC;

-- ------------------------------------------------
-- LESSON 7: BETWEEN & LIKE
-- BETWEEN filters a range (inclusive of both ends)
-- LIKE searches for patterns in text
-- % means "anything can go here"
-- ------------------------------------------------

-- BETWEEN example
SELECT * FROM students
WHERE age BETWEEN 21 AND 24;

SELECT * FROM students
WHERE age BETWEEN 23 AND 26;

-- LIKE examples
SELECT * FROM students
WHERE first_name LIKE 'D%';    -- starts with D

SELECT * FROM students
WHERE first_name LIKE '%e';    -- ends with e

SELECT * FROM students
WHERE last_name LIKE '%o%';    -- contains o anywhere

-- Combine LIKE with OR
SELECT first_name, age FROM students
WHERE first_name LIKE 'A%' OR first_name LIKE '%a';

-- ------------------------------------------------
-- DAY 4: AGGREGATE FUNCTIONS & DATA MANIPULATION
-- ------------------------------------------------

-- ------------------------------------------------
-- LESSON 8: Aggregate Functions
-- COUNT(*) = how many rows
-- AVG() = average value
-- MIN() = smallest value
-- MAX() = largest value
-- ------------------------------------------------

-- All aggregates together
SELECT 
    COUNT(*) AS total_students,
    AVG(age) AS average_age,
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM students;

-- Aggregate with WHERE filter
SELECT 
    COUNT(*) AS total_students,
    AVG(age) AS average_age,
    MIN(age) AS youngest,
    MAX(age) AS oldest
FROM students
WHERE age >= 23;

-- ------------------------------------------------
-- LESSON 9: GROUP BY
-- Summarises data by category
-- Like asking "how many per city?"
-- ------------------------------------------------

-- Count students per city
SELECT city, COUNT(*) AS total_students
FROM students
GROUP BY city;

-- Average age per city sorted descending
SELECT city, AVG(age) AS average_age
FROM students
GROUP BY city
ORDER BY average_age DESC;

-- ------------------------------------------------
-- LESSON 10: HAVING
-- Like WHERE but filters groups after GROUP BY
-- ------------------------------------------------

-- Cities with more than 1 student
SELECT city, COUNT(*) AS total_students
FROM students
GROUP BY city
HAVING COUNT(*) > 1;

-- Cities with at least 1 student sorted descending
SELECT city, COUNT(*) AS total_students
FROM students
GROUP BY city
HAVING COUNT(*) >= 1
ORDER BY total_students DESC;

-- ------------------------------------------------
-- LESSON 11: UPDATE & DELETE
-- UPDATE modifies existing rows
-- DELETE removes rows -- ALWAYS use WHERE!
-- ------------------------------------------------

-- Update a specific student's city
UPDATE students
SET city = 'Port Harcourt'
WHERE student_id = 2;

-- Update a specific student's age
UPDATE students
SET age = 25
WHERE student_id = 3;

-- Delete a specific student (written but not run)
-- DELETE FROM students
-- WHERE first_name = 'Alex';

-- Verify changes
SELECT * FROM students;
