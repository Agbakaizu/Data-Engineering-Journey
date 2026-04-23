-- ================================================
-- DATA ENGINEERING JOURNEY
-- Day 1: SQL Basics
-- Author: Dorcas Agbakaizu
-- Date: April 2026
-- Database: Any (no database required for these queries)
-- ================================================

-- ------------------------------------------------
-- LESSON 1: Your First Query
-- SELECT tells SQL "show me something"
-- AS gives the result column a readable name
-- ------------------------------------------------

SELECT 'Hello, Data Engineering!' AS my_first_query;

-- ------------------------------------------------
-- LESSON 2: Selecting Multiple Values
-- Comma separates each item you want to SELECT
-- Semicolon ends the query (like a full stop)
-- ------------------------------------------------

SELECT 
    'Dorcas'           AS student_name,
    'Data Engineering' AS career_path,
    2026               AS year_started;

-- ------------------------------------------------
-- LESSON 3: Math Operations in SQL
-- SQL can perform arithmetic directly
-- + addition, - subtraction, * multiply, / divide
-- ------------------------------------------------

SELECT 
    10 + 5  AS addition,
    10 - 3  AS subtraction,
    10 * 4  AS multiplication,
    10 / 2  AS division;

-- ------------------------------------------------
-- LESSON 4: Built-in Functions
-- GETDATE() returns the current date and time
-- Functions always have brackets () after them
-- ------------------------------------------------

SELECT GETDATE() AS today;

-- ------------------------------------------------
-- LESSON 5: String Functions
-- CONCAT() joins text together (like gluing words)
-- UPPER() converts text to UPPERCASE
-- LEN() counts how many characters are in text
-- ------------------------------------------------

SELECT
    CONCAT('My name ', 'John')    AS introduction,
    UPPER('data engineering')      AS shouting,
    LEN('Hello World')             AS character_count;

-- ------------------------------------------------
-- LESSON 6: Practice Queries
-- Combining math and string functions together
-- ------------------------------------------------

SELECT
    100 * 3               AS result,
    UPPER('nigeria')      AS my_country,
    LEN('data engineer')  AS job_length;

SELECT 
    GETDATE()                          AS today_date,
    CONCAT('I am ', 'a Data engineer') AS my_goal,
    UPPER('lagos')                     AS my_city;

-- ------------------------------------------------
-- LESSON 7: Creative Practice
-- Combining multiple functions in one query
-- ------------------------------------------------

SELECT
    'Olumide'                        AS student_name,
    CONCAT('I love ', 'picking beans') AS hobby,
    UPPER('china')                   AS destination,
    LEN('Xo kitty')                  AS betrayal,
    GETDATE()                        AS today;
