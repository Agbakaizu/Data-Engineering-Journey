# 🎓 Data Engineering Journey
### By Dorcas Agbakaizu | April 2026

---

## 📋 Content Outline
- [Project Overview](#project-overview)
- [Goals](#goals)
- [Tools Used](#tools-used)
- [Stage 1: SQL Fundamentals](#stage-1-sql-fundamentals)
  - [Database 1: Students Database](#database-1-students-database)
  - [Database 2: Hospital Database](#database-2-hospital-database)
- [Stage 2: Python Fundamentals](#stage-2-python-fundamentals)
- [Key Concepts Learned](#key-concepts-learned)
- [Capstone Project](#capstone-project)
- [Next Steps](#next-steps)

---

## 📖 Project Overview

This repository documents my complete data engineering learning journey from absolute zero — no prior technical background — to writing advanced SQL queries, Python scripts and Pandas pipelines independently.

Every line of code here was written by me after learning each concept from scratch. The journey covers SQL fundamentals, Python programming, Pandas data manipulation and version control with Git and GitHub.

---

## 🎯 Goals

- Learn SQL from basic SELECT queries to advanced Window Functions and Stored Procedures
- Build real databases and write queries that solve real problems
- Learn Python from variables to functions, loops and Pandas
- Document the entire learning journey on GitHub as a portfolio
- Transition into a data engineering career

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| **SQL Server** | Database engine for all SQL work |
| **SSMS** | SQL Server Management Studio — writing and running queries |
| **Python 3.12** | Programming language |
| **Jupyter Notebook** | Interactive Python development environment |
| **Pandas** | Python library for data manipulation |
| **VS Code** | Code editor |
| **Git & GitHub** | Version control and portfolio hosting |
| **DataCamp** | Structured learning platform (scholarship) |

---

## 📁 Stage 1: SQL Fundamentals

---

### 🗄️ Database 1: Students Database

**Database:** `Data_Eng`  
**Purpose:** Learn core SQL concepts — creating tables, inserting data, filtering, sorting, aggregating and manipulating data.

#### Database & Table Setup

```sql
-- Create the database
CREATE DATABASE Data_Eng;
USE Data_Eng;

-- Create students table with PRIMARY KEY
-- PRIMARY KEY prevents duplicate entries
CREATE TABLE students (
    student_id  INT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    age         INT,
    city        VARCHAR(50)
);

-- Insert 5 students
-- Numbers have no quotes, text values have single quotes
INSERT INTO students (student_id, first_name, last_name, age, city)
VALUES 
    (1, 'Dorcas',  'Agbakaizu', 23, 'Lagos'),
    (2, 'Alex',    'Cole',      21, 'Abuja'),
    (3, 'Tomi',    'Richard',     23, 'Ibadan'),
    (4, 'Paul',    'Williams',  26, 'Enugu'),
    (5, 'Dera',    'Dapson',    24, 'Lagos');
```

#### Basic SELECT Queries

```sql
-- Show all data (* means all columns)
SELECT * FROM students;
```
<img width="321" height="124" alt="1" src="https://github.com/user-attachments/assets/a7ad853f-ce1e-408b-8719-46ea1e739a42" />

```sql
-- Show specific columns only
SELECT first_name, city FROM students;
```
<img width="148" height="119" alt="2" src="https://github.com/user-attachments/assets/6f664ba4-7fe9-4f53-af33-a00e1f3d8795" />

#### Filtering with WHERE

```sql
-- Filter by city
SELECT * FROM students
WHERE city = 'Lagos';
```
<img width="313" height="62" alt="3" src="https://github.com/user-attachments/assets/ed0705cb-f311-40aa-83ce-4b32c1ae85c2" />

```sql
-- Filter by age
SELECT first_name, age FROM students
WHERE age = 23;
```
<img width="135" height="56" alt="4" src="https://github.com/user-attachments/assets/23762d09-2097-4e3f-8286-604687daf623" />

```sql
-- Filter by student ID
SELECT * FROM students
WHERE student_id = 3;
```
<img width="312" height="43" alt="5" src="https://github.com/user-attachments/assets/3c75a4be-8e18-40fb-82d9-d9aea142b711" />

```sql
-- Show specific columns with filter
SELECT first_name, last_name FROM students
WHERE city = 'Abuja';
```
<img width="166" height="41" alt="6" src="https://github.com/user-attachments/assets/4bbcc79b-ac9b-49a0-bebb-7965f764f5c8" />

#### AND / OR Conditions

```sql
-- AND: both conditions must be true
SELECT * FROM students
WHERE age = 23 AND city = 'Lagos';
```
<img width="311" height="43" alt="7" src="https://github.com/user-attachments/assets/d21ce550-e970-4c1b-850f-4737126131cc" />

```sql
-- OR: at least one condition must be true
SELECT * FROM students
WHERE city = 'Lagos' OR city = 'Abuja';
```
<img width="307" height="78" alt="8" src="https://github.com/user-attachments/assets/69c1ece0-ee7a-4854-b82b-e9734195cc04" />

```sql
-- Comparison operator with AND
SELECT * FROM students
WHERE age > 22 AND city = 'Lagos';
```
<img width="305" height="58" alt="9" src="https://github.com/user-attachments/assets/0c82fa49-4256-4c75-9b0a-f901ef554145" />

#### ORDER BY — Sorting Results

```sql
-- Sort by age ascending (youngest first)
SELECT * FROM students
ORDER BY age ASC;
```
<img width="310" height="115" alt="10" src="https://github.com/user-attachments/assets/e06ba0f6-91b5-4c0a-b70d-61339b2466b6" />

```sql
-- Sort alphabetically by first name
SELECT * FROM students
ORDER BY first_name ASC;

-- Sort by age descending (oldest first)
SELECT * FROM students
ORDER BY age DESC;

-- Combine filter and sort
SELECT first_name, age FROM students
WHERE age = 23 OR age = 24
ORDER BY age ASC;
```

#### BETWEEN & LIKE

```sql
-- BETWEEN: filter a range (inclusive of both ends)
SELECT * FROM students
WHERE age BETWEEN 21 AND 24;

-- LIKE: pattern matching
-- % means anything can go here
SELECT * FROM students
WHERE first_name LIKE 'D%';      -- starts with D

SELECT * FROM students
WHERE first_name LIKE '%e';      -- ends with e

SELECT * FROM students
WHERE last_name LIKE '%o%';      -- contains o anywhere

-- Combine LIKE with OR
SELECT first_name, age FROM students
WHERE first_name LIKE 'A%' OR first_name LIKE '%a';
```

#### Aggregate Functions

```sql
-- COUNT, AVG, MIN, MAX together
SELECT 
    COUNT(*) AS total_students,
    AVG(age)  AS average_age,
    MIN(age)  AS youngest,
    MAX(age)  AS oldest
FROM students;

-- Aggregate with WHERE filter
SELECT 
    COUNT(*) AS total_students,
    AVG(age)  AS average_age,
    MIN(age)  AS youngest,
    MAX(age)  AS oldest
FROM students
WHERE age >= 23;
```

#### GROUP BY & HAVING

```sql
-- Count students per city
SELECT city, COUNT(*) AS total_students
FROM students
GROUP BY city;

-- Average age per city sorted descending
SELECT city, AVG(age) AS average_age
FROM students
GROUP BY city
ORDER BY average_age DESC;

-- HAVING: filter groups after GROUP BY
SELECT city, COUNT(*) AS total_students
FROM students
GROUP BY city
HAVING COUNT(*) > 1;
```

#### UPDATE & DELETE

```sql
-- Update a student's city
UPDATE students
SET city = 'Port Harcourt'
WHERE student_id = 2;

-- Update a student's age
UPDATE students
SET age = 25
WHERE student_id = 3;

-- Delete a specific student
-- ALWAYS use WHERE with DELETE to avoid deleting everything
DELETE FROM students
WHERE first_name = 'Alex';
```

---

### 🏥 Database 2: Hospital Database

**Database:** `Hospital_db`  
**Purpose:** Learn advanced SQL — JOINs, Subqueries, CASE WHEN, CTEs, Window Functions, Views and Stored Procedures using a realistic hospital scenario.

#### Database & Table Setup

```sql
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
-- Note: appointment 6 has patient_id 8 which doesn't exist in patients
-- This demonstrates how different JOINs handle unmatched rows
CREATE TABLE appointments (
    appointment_id   INT PRIMARY KEY,
    patient_id       INT,
    doctor_name      VARCHAR(50),
    appointment_date VARCHAR(50),
    status           VARCHAR(50)
);

INSERT INTO appointments (appointment_id, patient_id, doctor_name, appointment_date, status)
VALUES
    (1, 1, 'Dr. Adeyemi', '2026-01-05', 'Completed'),
    (2, 2, 'Dr. Okafor',  '2026-01-07', 'Completed'),
    (3, 3, 'Dr. Adeyemi', '2026-01-10', 'Cancelled'),
    (4, 1, 'Dr. Okafor',  '2026-01-12', 'Completed'),
    (5, 4, 'Dr. Bello',   '2026-01-15', 'Pending'),
    (6, 8, 'Dr. Bello',   '2026-01-18', 'Completed');
```

#### JOINs — Combining Two Tables

```sql
-- INNER JOIN: only matching rows from BOTH tables
SELECT 
    p.first_name,
    p.condition,
    a.doctor_name,
    a.appointment_date,
    a.status
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id;

-- LEFT JOIN: ALL rows from left table + matches from right
-- Patients with no appointments show NULL
SELECT 
    p.first_name,
    p.condition,
    a.doctor_name,
    a.status
FROM patients p
LEFT JOIN appointments a
ON p.patient_id = a.patient_id;

-- RIGHT JOIN: ALL rows from right table + matches from left
-- Appointments with no matching patient show NULL
SELECT 
    p.first_name,
    p.condition,
    a.doctor_name,
    a.appointment_date,
    a.status
FROM patients p
RIGHT JOIN appointments a
ON p.patient_id = a.patient_id;

-- INNER JOIN + WHERE: Completed appointments only
SELECT
    p.first_name,
    p.condition,
    a.doctor_name,
    a.status
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id
WHERE a.status = 'Completed';

-- INNER JOIN + WHERE: Malaria patients only
SELECT
    p.first_name,
    p.condition,
    a.doctor_name
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id
WHERE p.condition = 'Malaria';
```

#### Subqueries — Queries Inside Queries

```sql
-- Patients older than average age
-- Inner query calculates average first, outer query uses it
SELECT first_name, age
FROM patients
WHERE age > (SELECT AVG(age) FROM patients);

-- Patients from same city as Chidi
SELECT * FROM patients
WHERE city = (SELECT city FROM patients WHERE first_name = 'Chidi');

-- Patients older than the youngest patient
SELECT first_name, age
FROM patients
WHERE age > (SELECT MIN(age) FROM patients);
```

#### CASE WHEN — Conditional Logic

```sql
-- Age group classification
SELECT first_name, age,
    CASE 
        WHEN age < 35              THEN 'Young'
        WHEN age BETWEEN 35 AND 50 THEN 'Middle Aged'
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
```

#### CTEs — Common Table Expressions

```sql
-- CTE: Temporary named result — exists only for the duration of the query
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
        WHEN a.status = 'Completed'                          THEN 'Follow up'
        WHEN a.status = 'Cancelled' OR a.status = 'Pending'  THEN 'Needs Attention'
        ELSE 'UNKNOWN'
    END AS urgency
FROM malaria_patients m
INNER JOIN appointments a
ON m.patient_id = a.patient_id;
```

#### Window Functions — Ranking Without Collapsing Rows

```sql
-- ROW_NUMBER: unique number for each row
SELECT 
    first_name,
    age,
    ROW_NUMBER() OVER (ORDER BY age DESC) AS row_num
FROM patients;

-- RANK: handles ties — tied rows get same rank, next rank skipped
SELECT 
    first_name,
    age,
    RANK() OVER (ORDER BY age DESC) AS rank_num
FROM patients;

-- PARTITION BY: rank within groups — each city restarts from 1
SELECT 
    first_name,
    city,
    age,
    RANK() OVER (PARTITION BY city ORDER BY age DESC) AS city_rank
FROM patients;

-- ROW_NUMBER partitioned by condition, youngest first
SELECT first_name, condition,
    ROW_NUMBER() OVER (PARTITION BY condition ORDER BY age ASC) AS row_num
FROM patients;
```

#### Views — Saved Virtual Tables

```sql
-- Views are permanent and reusable by anyone on the team

-- View: Lagos patients
CREATE VIEW lagos_patients_view AS
SELECT first_name, age, condition
FROM patients
WHERE city = 'Lagos';

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

SELECT * FROM completed_appointments_view;
```

#### Stored Procedures — Reusable Code Blocks with Parameters

```sql
-- Stored procedures are like functions — write once, call anytime

-- Procedure: Get patients by city
CREATE PROCEDURE GetPatientsByCity
    @city VARCHAR(50)
AS
BEGIN
    SELECT * FROM patients
    WHERE city = @city;
END;

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

EXEC GetPatientsByCondition 'Malaria';
EXEC GetPatientsByCondition 'Diabetes';

-- Procedure: Get appointments by status
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

EXEC GetAppointmentsByStatus 'Completed';
EXEC GetAppointmentsByStatus 'Cancelled';
```

---

## 🏆 Capstone Project — Hospital Patient Management System

**A complete end-to-end SQL project combining ALL concepts learned.**

### Phase 1: Window Functions & Ranking

```sql
-- Rank all patients oldest to youngest
SELECT *,
    RANK() OVER (ORDER BY age DESC) AS rank_num
FROM patients;

-- Rank within each condition group youngest first
SELECT first_name, age, condition,
    RANK() OVER (PARTITION BY condition ORDER BY age ASC) AS condition_rank
FROM patients;

-- Row numbers for appointments by date
SELECT doctor_name, appointment_date,
    ROW_NUMBER() OVER (ORDER BY appointment_date ASC) AS row_num
FROM appointments;
```

### Phase 2: Views

```sql
-- Senior diabetic patients with their doctors
CREATE VIEW senior_diabetic_view AS
SELECT 
    p.first_name,
    p.age,
    a.doctor_name
FROM patients p
INNER JOIN appointments a
ON p.patient_id = a.patient_id
WHERE p.age > 50 AND p.condition = 'Diabetes';

SELECT * FROM senior_diabetic_view
ORDER BY age DESC;
```

### Phase 3: CTEs + Window Functions Combined

```sql
-- Young patients (under 40) with row numbers
WITH young_patients AS (
    SELECT first_name, last_name, age
    FROM patients
    WHERE age < 40
)
SELECT first_name, last_name, age,
    ROW_NUMBER() OVER (ORDER BY age DESC) AS age_rank
FROM young_patients;

-- Patients with more than 1 appointment
WITH appointment_summary AS (
    SELECT patient_id, COUNT(*) AS total_appointments
    FROM appointments
    GROUP BY patient_id
)
SELECT patient_id, total_appointments
FROM appointment_summary
WHERE total_appointments > 1;
```

### Phase 4: Full Analysis Queries

```sql
-- Priority dashboard: CASE WHEN + JOIN + ORDER BY priority
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
SELECT * FROM patients
WHERE age > (SELECT AVG(age) FROM patients WHERE city = 'Lagos');

-- Doctor performance: total + completion count
-- Uses conditional SUM — advanced aggregate technique
SELECT 
    doctor_name,
    COUNT(appointment_id)                                   AS total_appointments,
    SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END)  AS completed_count
FROM appointments
GROUP BY doctor_name;
```

---

## 🐍 Stage 2: Python Fundamentals

### Variables & Data Types

```python
# Four main data types in Python
name        = "Dorcas"   # str  — text
age         = 23          # int  — whole number
height      = 5.6         # float — decimal
is_student  = True        # bool — True or False

print(type(name))        # <class 'str'>
print(type(age))         # <class 'int'>
print(type(height))      # <class 'float'>
print(type(is_student))  # <class 'bool'>
```

### String Operations & F-Strings

```python
name = "Dorcas"
city = "Lagos"

print(name.upper())                              # DORCAS
print(len(name))                                 # 6
print(name.lower())                              # dorcas
print(f"My name is {name} and I live in {city}") # f-string
```

### Math Operations

```python
a, b = 20, 6

print(a + b)   # 26  — addition
print(a - b)   # 14  — subtraction
print(a * b)   # 120 — multiplication
print(a / b)   # 3.33 — division
print(a // b)  # 3   — floor division (no decimals)
print(a % b)   # 2   — modulus (remainder)
print(a ** b)  # 64000000 — power
```

### Lists

```python
patients = ["Amaka", "Tunde", "Ngozi", "Emeka", "Fatima"]

print(patients[0])       # Amaka — index starts at 0
print(patients[-1])      # Fatima — last item
print(len(patients))     # 5

patients.append("Chidi") # add to end
patients.remove("Tunde") # remove specific item
patients[0] = "Dorcas"   # replace item at index 0
```

### Dictionaries

```python
patient = {
    "name":      "Dorcas",
    "age":       23,
    "city":      "Lagos",
    "condition": "Healthy"
}

print(patient["name"])        # Dorcas — access by key
patient["city"] = "Abuja"     # update value
patient["doctor"] = "Dr. A"   # add new key
del patient["condition"]      # remove key
```

### If/Else Conditions

```python
age = 23

if age >= 18:
    print("Adult")
elif age >= 13:
    print("Teenager")
else:
    print("Child")
```

### For Loops

```python
# Loop through a list
patients = ["Amaka", "Tunde", "Ngozi"]

for patient in patients:
    print(f"Hello {patient}")

# Loop with zip — two lists simultaneously
cities      = ["Lagos", "Kano", "Ibadan"]
populations = [15.4, 4.1, 3.6]

for city, pop in zip(cities, populations):
    if pop > 5:
        print(f"{city} is a megacity")
    elif 2 <= pop <= 5:
        print(f"{city} is a large city")
    else:
        print(f"{city} is a small city")
```

### Functions

```python
def patient_summary(name, age, condition):
    """
    Returns a patient risk summary string.
    Input: name (str), age (int), condition (str)
    Output: formatted summary string (str)
    """
    if age > 50:
        risk = "High Risk"
    elif age > 30:
        risk = "Medium Risk"
    else:
        risk = "Low Risk"
    
    return f"{name} has {condition} and is {risk}"

print(patient_summary("Amaka", 34, "Malaria"))   # Medium Risk
print(patient_summary("Chidi", 61, "Diabetes"))  # High Risk
```

### Lambda Functions

```python
# Lambda: one-line shortcut function
square    = lambda x: x ** 2
full_name = lambda first, last: f"{first} {last}"

print(square(5))                         # 25
print(full_name("Dorcas", "Agbakaizu"))  # Dorcas Agbakaizu

# Lambda with sorted
patients = [
    {"name": "Amaka", "age": 34},
    {"name": "Tunde", "age": 45},
    {"name": "Ngozi", "age": 28},
]

# Sort by age
sorted_by_age  = sorted(patients, key=lambda x: x["age"])

# Sort by name alphabetically
sorted_by_name = sorted(patients, key=lambda x: x["name"])
```

### *args & **kwargs

```python
# *args: accept any number of positional arguments
def patient_ages(*args):
    """Calculates average from any number of age inputs"""
    if len(args) == 0:
        print("No ages provided.")
        return
    average = sum(args) / len(args)
    print(f"Average age: {average}")

patient_ages(25, 30, 45, 60)   # Average age: 40.0

# **kwargs: accept any number of named arguments
def build_patient(**kwargs):
    """Prints all patient details dynamically"""
    for field, value in kwargs.items():
        print(f"{field}: {value}")

build_patient(name="Dorcas", age=23, city="Lagos", condition="Healthy")
```

### File Handling

```python
# Write a text file
with open("patients.txt", "w") as f:
    f.write("Amaka, 34, Lagos, Malaria\n")
    f.write("Tunde, 45, Abuja, Diabetes\n")
    f.write("Ngozi, 28, Enugu, Malaria\n")

# Read entire file
with open("patients.txt", "r") as f:
    content = f.read()
    print(content)

# Read line by line
with open("patients.txt", "r") as f:
    for line in f:
        print(line.strip())

# Append to existing file without overwriting
with open("patients.txt", "a") as f:
    f.write("Chinedu, 29, Abuja, Diabetes\n")
```

### Pandas — Data Manipulation

```python
import pandas as pd
import numpy as np

# Create DataFrame
data = [
    {"name": "Amaka",  "age": 34, "city": "Lagos",  "condition": "Malaria"},
    {"name": "Tunde",  "age": 45, "city": "Abuja",  "condition": "Diabetes"},
    {"name": "Ngozi",  "age": 28, "city": "Enugu",  "condition": "Malaria"},
    {"name": "Emeka",  "age": 52, "city": "Lagos",  "condition": "Hypertension"},
    {"name": "Fatima", "age": 31, "city": "Kaduna", "condition": "Malaria"},
]
df = pd.DataFrame(data)

# Explore
print(df.head())      # first 5 rows
print(df.shape)       # (rows, columns)
print(df.columns)     # column names
print(df.describe())  # statistical summary

# Select columns
print(df["name"])              # single column = Series
print(df[["name", "age"]])     # multiple columns = DataFrame

# Filter rows (like SQL WHERE)
print(df[df["city"] == "Lagos"])

# Multiple conditions
print(df[(df["city"] == "Lagos") & (df["age"] > 40)])  # AND
print(df[(df["city"] == "Lagos") | (df["city"] == "Abuja")])  # OR

# Aggregate functions
print(df["age"].count())    # COUNT
print(df["age"].mean())     # AVG
print(df["age"].min())      # MIN
print(df["age"].max())      # MAX

# GROUP BY
print(df.groupby("city")["name"].count())
print(df.groupby("condition")["age"].mean())
print(df.groupby("condition")["age"].agg(["min", "max"]))

# Add new column
df["risk_level"] = np.where(df["age"] > 40, "High", "Low")

# Sort
print(df.sort_values("age", ascending=False))
print(df.sort_values(["city", "age"]))

# Read and write CSV
df.to_csv("patients.csv", index=False)
df_loaded = pd.read_csv("patients.csv")

# Read with options
df_cols = pd.read_csv("patients.csv", usecols=["name", "age"])
df_rows = pd.read_csv("patients.csv", nrows=3)
```

---

## 📊 Key Concepts Summary

| Concept | SQL Equivalent | Python/Pandas Equivalent |
|---|---|---|
| Show all data | SELECT * FROM table | df.head() |
| Filter rows | WHERE column = value | df[df["col"] == value] |
| Multiple conditions | AND / OR | & / \| |
| Sort results | ORDER BY col ASC/DESC | df.sort_values("col") |
| Count rows | COUNT(*) | df["col"].count() |
| Average | AVG(col) | df["col"].mean() |
| Min/Max | MIN(col) / MAX(col) | df["col"].min() / .max() |
| Group data | GROUP BY | df.groupby("col") |
| Conditional logic | CASE WHEN | if/else, np.where() |
| Reusable code | Stored Procedures | Functions, Lambda |
| Temporary result | CTE | Variable, DataFrame |
| Rank rows | ROW_NUMBER, RANK | df.rank() |
| Save data | INSERT INTO | df.to_csv() |
| Load data | SELECT * FROM | pd.read_csv() |

---

## 🗺️ Learning Timeline

| Week | Focus |
|---|---|
| Week 1 | SQL Basics — SELECT, WHERE, ORDER BY, GROUP BY |
| Week 2 | Advanced SQL — JOINs, Subqueries, CASE WHEN, CTEs |
| Week 3 | SQL Mastery — Window Functions, Views, Stored Procedures |
| Week 4 | Hospital Capstone Project |
| Week 5 | Python Fundamentals — Variables, Lists, Dictionaries, Loops, Functions |
| Week 6 | Pandas + Intermediate Python — Lambda, *args, File Handling |
| Week 7 | Git, GitHub, Portfolio Setup |
| Ongoing | DataCamp Scholarship — Data Engineering Track |

---

## 🚀 Next Steps

- [ ] Push Python Jupyter notebooks to GitHub
- [ ] Learn cloud basics — Azure or AWS
- [ ] Learn dbt — data transformation tool
- [ ] Learn Apache Airflow — pipeline scheduling
- [ ] Build end-to-end data pipeline project
- [ ] Apply for data engineering internships and roles

---

## 💬 About Me

I started this journey after receiving a rejection email for an internship. Instead of giving up, I decided to build the skills from zero — no shortcuts, no prior technical background, just consistency and hard work.

This repository is proof of that journey.

*Still going.* 💪

---

*Author: Dorcas Agbakaizu | Lagos, Nigeria | April 2026*

