-- ================================================
-- DATA ENGINEERING JOURNEY
-- Hospital Database — Final Capstone Project
-- Author: Dorcas Agbakaizu
-- Date: April 2026
-- Database: Hospital_db
-- ================================================
-- This project combines ALL concepts learned across
-- Days 1-7: SELECT, WHERE, JOINs, Aggregates,
-- GROUP BY, HAVING, CASE WHEN, CTEs, Window Functions,
-- Views, Stored Procedures, Subqueries and Aliases
-- ================================================

-- ------------------------------------------------
-- PHASE 1: WINDOW FUNCTIONS & RANKING
-- ------------------------------------------------

-- Rank all patients by age oldest to youngest
SELECT *,
    RANK() OVER (ORDER BY age DESC) AS rank_num
FROM patients;

-- Rank patients by age within each condition group
-- youngest first — each condition restarts from 1
SELECT first_name, age, condition,
    RANK() OVER (PARTITION BY condition ORDER BY age ASC) AS condition_rank
FROM patients;

-- Assign row numbers to appointments by date
SELECT doctor_name, appointment_date,
    ROW_NUMBER() OVER (ORDER BY appointment_date ASC) AS row_num
FROM appointments;

-- ------------------------------------------------
-- PHASE 2: VIEWS
-- ------------------------------------------------

-- View: Senior diabetic patients with their doctors
-- Shows patients over 50 with Diabetes who have appointments
DROP VIEW IF EXISTS senior_diabetic_view;

CREATE VIEW senior_diabetic_view AS
SELECT 
    p.first_name,
    p.age,
    a.doctor_name
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id
WHERE p.age > 50 AND p.condition = 'Diabetes';

-- Query the view sorted by age descending
SELECT * FROM senior_diabetic_view
ORDER BY age DESC;

-- ------------------------------------------------
-- PHASE 3: STORED PROCEDURES
-- ------------------------------------------------

-- Procedure: Get appointments filtered by status
-- Accepts 'Completed', 'Cancelled' or 'Pending'
CREATE PROCEDURE GetAppointmentsByStatus
    @status VARCHAR(50)
AS
BEGIN
    SELECT 
        p.first_name,
        p.age,
        a.doctor_name,
        a.status
    FROM patients p
    INNER JOIN appointments a
    ON p.patient_id = a.patient_id
    WHERE a.status = @status;
END;

-- Call with different statuses
EXEC GetAppointmentsByStatus 'Completed';
EXEC GetAppointmentsByStatus 'Cancelled';

-- ------------------------------------------------
-- PHASE 4: CTEs + WINDOW FUNCTIONS COMBINED
-- ------------------------------------------------

-- CTE: Young patients (under 40) with row numbers
-- Row numbers assigned oldest to youngest within group
WITH young_patients AS (
    SELECT first_name, last_name, age
    FROM patients
    WHERE age < 40
)
SELECT first_name, last_name, age,
    ROW_NUMBER() OVER (ORDER BY age DESC) AS age_rank
FROM young_patients;

-- CTE: Appointment summary
-- Find patients with more than 1 appointment
WITH appointment_summary AS (
    SELECT patient_id, COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY patient_id
)
SELECT patient_id, total_appointments
FROM appointment_summary
WHERE total_appointments > 1;

-- ------------------------------------------------
-- PHASE 5: FULL ANALYSIS QUERIES
-- ------------------------------------------------

-- Priority dashboard: CASE WHEN + JOIN + ORDER BY CASE
-- Orders results by clinical priority automatically
SELECT 
    p.first_name,
    p.city,
    p.condition,
    CASE
        WHEN p.condition = 'Hypertension' THEN 'High Priority'
        WHEN p.condition = 'Diabetes'     THEN 'Medium Priority'
        WHEN p.condition = 'Malaria'      THEN 'Low Priority'
        ELSE 'UNKNOWN'
    END AS priority_level,
    a.doctor_name
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id
ORDER BY 
    CASE 
        WHEN p.condition = 'Hypertension' THEN 1
        WHEN p.condition = 'Diabetes'     THEN 2
        WHEN p.condition = 'Malaria'      THEN 3
        ELSE 4
    END ASC;

-- Subquery: Patients older than average Lagos patient age
-- Inner query calculates Lagos average first
-- Outer query filters everyone older than that average
SELECT * FROM patients
WHERE age > (SELECT AVG(age) FROM patients WHERE city = 'Lagos');

-- Doctor performance summary
-- Total appointments per doctor + completion count
-- Uses conditional SUM — counts only Completed appointments
SELECT 
    doctor_name,
    COUNT(appointment_id)                                    AS total_appointments,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END)   AS completed_count
FROM appointments
GROUP BY doctor_name;

-- ================================================
-- END OF CAPSTONE PROJECT
-- ================================================
