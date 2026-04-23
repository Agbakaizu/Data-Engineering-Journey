-- ================================================
-- DATA ENGINEERING JOURNEY
-- Days 5-7: Hospital Database
-- Author: Dorcas Agbakaizu
-- Date: April 2026
-- Database: Hospital_db
-- ================================================

-- ------------------------------------------------
-- DATABASE & TABLE SETUP
-- ------------------------------------------------

CREATE DATABASE Hospital_db;
USE Hospital_db;

-- Patients table
CREATE TABLE patients (
    patient_id  INT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    age         INT,
    city        VARCHAR(50),
    condition   VARCHAR(50)
);

-- Insert 7 patients
INSERT INTO patients (patient_id, first_name, last_name, age, city, condition)
VALUES 
    (1, 'Amaka',  'Obi',     34, 'Lagos',  'Malaria'),
    (2, 'Tunde',  'Adeola',  45, 'Abuja',  'Diabetes'),
    (3, 'Ngozi',  'Eze',     28, 'Enugu',  'Malaria'),
    (4, 'Emeka',  'Nwosu',   52, 'Lagos',  'Hypertension'),
    (5, 'Fatima', 'Bello',   31, 'Kano',   'Malaria'),
    (6, 'Chidi',  'Okafor',  61, 'Lagos',  'Diabetes'),
    (7, 'Yemi',   'Adeyemi', 40, 'Ibadan', 'Hypertension');

-- Appointments table
CREATE TABLE appointments (
    appointment_id   INT PRIMARY KEY,
    patient_id       INT,
    doctor_name      VARCHAR(50),
    appointment_date VARCHAR(50),
    status           VARCHAR(50)
);

-- Insert appointments
-- Note: appointment 6 has patient_id 8 (doesn't exist in patients)
-- This is intentional to demonstrate JOIN differences
INSERT INTO appointments (appointment_id, patient_id, doctor_name, appointment_date, status)
VALUES
    (1, 1, 'Dr. Adeyemi', '2026-01-05', 'Completed'),
    (2, 2, 'Dr. Okafor',  '2026-01-07', 'Completed'),
    (3, 3, 'Dr. Adeyemi', '2026-01-10', 'Cancelled'),
    (4, 1, 'Dr. Okafor',  '2026-01-12', 'Completed'),
    (5, 4, 'Dr. Bello',   '2026-01-15', 'Pending'),
    (6, 8, 'Dr. Bello',   '2026-01-18', 'Completed');

-- ------------------------------------------------
-- DAY 5: JOINS
-- Combining data from multiple tables
-- ------------------------------------------------

-- ------------------------------------------------
-- INNER JOIN: Only matching rows from BOTH tables
-- ------------------------------------------------

SELECT 
    patients.first_name,
    patients.condition,
    appointments.doctor_name,
    appointments.appointment_date,
    appointments.status
FROM patients
INNER JOIN appointments 
ON patients.patient_id = appointments.patient_id;

-- ------------------------------------------------
-- LEFT JOIN: ALL rows from left table + matches
-- Unmatched rows show NULL
-- ------------------------------------------------

SELECT 
    patients.first_name,
    patients.condition,
    appointments.doctor_name,
    appointments.status
FROM patients
LEFT JOIN appointments 
ON patients.patient_id = appointments.patient_id;

-- ------------------------------------------------
-- RIGHT JOIN: ALL rows from right table + matches
-- Unmatched rows show NULL
-- ------------------------------------------------

SELECT 
    patients.first_name,
    patients.condition,
    appointments.doctor_name,
    appointments.appointment_date,
    appointments.status
FROM patients
RIGHT JOIN appointments
ON patients.patient_id = appointments.patient_id;

-- ------------------------------------------------
-- JOINS WITH FILTERS
-- Combining JOIN with WHERE clause
-- ------------------------------------------------

-- Completed appointments only
SELECT
    patients.first_name,
    patients.condition,
    appointments.doctor_name,
    appointments.status
FROM patients
INNER JOIN appointments
ON patients.patient_id = appointments.patient_id
WHERE appointments.status = 'Completed';

-- Malaria patients with appointments
SELECT
    patients.first_name,
    patients.condition,
    appointments.doctor_name
FROM patients
INNER JOIN appointments
ON patients.patient_id = appointments.patient_id
WHERE patients.condition = 'Malaria';

-- ------------------------------------------------
-- DAY 6: ALIASES, SUBQUERIES, CASE WHEN & CTEs
-- ------------------------------------------------

-- ------------------------------------------------
-- ALIASES: Shortening table names
-- Instead of writing 'patients' use 'p'
-- Makes queries cleaner and faster to write
-- ------------------------------------------------

-- INNER JOIN with aliases
SELECT 
    p.first_name,
    p.condition,
    a.doctor_name,
    a.status
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id;

-- LEFT JOIN with aliases
SELECT 
    p.first_name,
    p.condition,
    a.doctor_name,
    a.status
FROM patients p
LEFT JOIN appointments a
ON p.patient_id = a.patient_id;

-- ------------------------------------------------
-- SUBQUERIES: A query inside another query
-- Inner query runs first, outer query uses result
-- ------------------------------------------------

-- Patients older than average age
SELECT first_name, age
FROM patients
WHERE age > (SELECT AVG(age) FROM patients);

-- Patients from same city as Chidi
SELECT * FROM patients
WHERE city = (SELECT city FROM patients WHERE first_name = 'Chidi');

-- Patients older than youngest patient
SELECT first_name, age
FROM patients
WHERE age > (SELECT MIN(age) FROM patients);

-- ------------------------------------------------
-- CASE WHEN: Conditional logic
-- Creates a new column based on conditions
-- Like if/else inside SQL
-- ------------------------------------------------

-- Age group classification
SELECT first_name, age,
    CASE 
        WHEN age < 35           THEN 'Young'
        WHEN age BETWEEN 30 AND 50 THEN 'Middle Aged'
        ELSE 'Senior'
    END AS age_group
FROM patients;

-- Condition priority level
SELECT first_name, condition,
    CASE 
        WHEN condition = 'Hypertension' THEN 'Critical'
        WHEN condition = 'Diabetes'     THEN 'Moderate'
        WHEN condition = 'Malaria'      THEN 'Mild'
        ELSE 'UNKNOWN'
    END AS priority_level
FROM patients;

-- ------------------------------------------------
-- CTEs: Common Table Expressions
-- A temporary named result used to simplify queries
-- Exists only for the duration of the query
-- ------------------------------------------------

-- CTE: Lagos patients
WITH lagos_patients AS (
    SELECT * FROM patients
    WHERE city = 'Lagos'
)
SELECT * FROM lagos_patients;

-- CTE: Senior patients
WITH senior_patients AS (
    SELECT * FROM patients
    WHERE age > 40
)
SELECT first_name, age, condition 
FROM senior_patients;

-- CTE + JOIN + CASE WHEN combined
WITH malaria_patients AS (
    SELECT * FROM patients
    WHERE condition = 'Malaria'
)
SELECT 
    m.first_name,
    a.doctor_name,
    a.status,
    CASE
        WHEN a.status = 'Completed'                    THEN 'Follow up'
        WHEN a.status = 'Cancelled' OR a.status = 'Pending' THEN 'Needs Attention'
        ELSE 'UNKNOWN'
    END AS urgency
FROM malaria_patients m
INNER JOIN appointments a
ON m.patient_id = a.patient_id;

-- ------------------------------------------------
-- DAY 7: WINDOW FUNCTIONS, VIEWS & STORED PROCEDURES
-- ------------------------------------------------

-- ------------------------------------------------
-- WINDOW FUNCTIONS
-- Perform calculations across rows without
-- collapsing them like GROUP BY does
-- ------------------------------------------------

-- ROW_NUMBER: Assigns unique number to each row
SELECT 
    first_name,
    age,
    ROW_NUMBER() OVER (ORDER BY age DESC) AS row_num
FROM patients;

-- RANK: Same as ROW_NUMBER but handles ties
-- Tied rows get same rank, next rank is skipped
SELECT 
    first_name,
    age,
    RANK() OVER (ORDER BY age DESC) AS rank_num
FROM patients;

-- PARTITION BY: Rank within groups separately
-- Each city restarts from rank 1
SELECT 
    first_name,
    city,
    age,
    RANK() OVER (PARTITION BY city ORDER BY age DESC) AS city_rank
FROM patients;

-- ROW_NUMBER with PARTITION BY condition
SELECT first_name, condition,
    ROW_NUMBER() OVER (PARTITION BY condition ORDER BY age ASC) AS row_num
FROM patients;

-- ------------------------------------------------
-- VIEWS: Saved queries that act like virtual tables
-- Permanent and reusable by anyone on the team
-- ------------------------------------------------

-- View: Lagos patients
CREATE VIEW lagos_patients_view AS
SELECT first_name, age, condition
FROM patients
WHERE city = 'Lagos';

-- Query the view
SELECT * FROM lagos_patients_view;

-- View: Completed appointments with JOIN
CREATE VIEW completed_appointments_view AS
SELECT 
    p.first_name,
    p.condition,
    a.doctor_name,
    a.appointment_date
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id
WHERE a.status = 'Completed';

-- Query the view
SELECT * FROM completed_appointments_view;

-- ------------------------------------------------
-- STORED PROCEDURES: Saved reusable SQL code blocks
-- Accept parameters so results change based on input
-- Like a function — write once, call anytime
-- ------------------------------------------------

-- Procedure: Get patients by city
CREATE PROCEDURE GetPatientsByCity
    @city VARCHAR(50)
AS
BEGIN
    SELECT * FROM patients
    WHERE city = @city;
END;

-- Call the procedure with different cities
EXEC GetPatientsByCity 'Lagos';
EXEC GetPatientsByCity 'Abuja';

-- Procedure: Get patients by condition
CREATE PROCEDURE GetPatientsByCondition
    @condition VARCHAR(50)
AS
BEGIN
    SELECT * FROM patients
    WHERE condition = @condition;
END;

-- Call the procedure with different conditions
EXEC GetPatientsByCondition 'Malaria';
EXEC GetPatientsByCondition 'Diabetes';

-- ------------------------------------------------
-- DATA MANIPULATION
-- ------------------------------------------------

-- Update Emeka's condition (misdiagnosis correction)
UPDATE patients
SET condition = 'Hypertension'
WHERE patient_id = 4;

-- Update Kano to Kaduna (hospital relocation)
UPDATE patients
SET city = 'Kaduna'
WHERE city = 'Kano';

-- Verify all changes
SELECT * FROM patients;
SELECT * FROM appointments;
