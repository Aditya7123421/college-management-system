# College Management System — Oracle 11g XE

A complete relational database implementation for a **College Management System**, built for **Oracle Database 11g Express Edition (11.2.0.2.0)** and **SQL\*Plus**.

This repository encompasses relational schema design, circular foreign-key resolution, deterministic sample data, 15 analytical SQL queries, transactional PL/SQL stored procedures, deterministic calculation functions, an explicit reporting cursor, and row-level data validation triggers.

---

## Project Structure

```text
college-management-system/
├── schema/
│   └── 01_create_tables.sql              # DDL for 8 core tables & 37 constraints
├── data/
│   └── 02_insert_data.sql                # Deterministic sample dataset (325 rows)
├── queries/
│   ├── Q01_active_students.sql           # Active student roster with departments
│   ├── Q02_faculty_directory.sql         # Faculty directory with HOD indicators
│   ├── Q03_course_catalogue.sql          # Course inventory and credit definitions
│   ├── Q04_course_offerings.sql          # Scheduled offerings, instructors & seats
│   ├── Q05_students_in_offering.sql      # Parameterized offering enrollment list
│   ├── Q06_students_by_department.sql    # Active student headcount (incl. zero)
│   ├── Q07_faculty_by_department.sql     # Faculty headcount per department
│   ├── Q08_offering_capacity.sql         # Seat capacity, occupied & remaining
│   ├── Q09_multiple_enrollments.sql      # Students in multiple offerings per year
│   ├── Q10_low_attendance.sql            # Students below 75% attendance threshold
│   ├── Q11_full_offerings.sql            # Offerings at full seat capacity
│   ├── Q12_top_performers.sql            # Top student per offering using RANK()
│   ├── Q13_missing_results.sql           # Students missing a specified exam result
│   ├── Q14_course_performance.sql        # Weighted average result % per course
│   └── Q15_academic_summary.sql          # Complete student summary (CTE-based)
├── plsql/
│   ├── P01_register_student.sql          # Procedure: REGISTER_STUDENT
│   ├── P02_record_attendance.sql         # Procedure: RECORD_ATTENDANCE
│   ├── F01_get_attendance_percentage.sql # Function: GET_ATTENDANCE_PERCENTAGE
│   ├── F02_get_course_percentage.sql     # Function: GET_COURSE_PERCENTAGE
│   ├── C01_student_attendance_report.sql # Explicit Cursor: Attendance Report
│   ├── T01_validate_student_dob.sql      # Trigger: TRG_VALIDATE_STUDENT
│   └── T02_validate_result.sql           # Trigger: TRG_VALIDATE_RESULT
└── README.md
```

---

## 1. Relational Schema Architecture

The database consists of **8 normalized tables** enforcing strict referential and domain integrity:

| Table | Primary Key | Description |
| :--- | :--- | :--- |
| **`DEPARTMENT`** | `dept_code` | Academic departments, office locations, and designated HOD (`hod_emp_id`). |
| **`FACULTY`** | `emp_id` | Faculty profiles, contact details, designations (`Professor`, `Associate Professor`, `Assistant Professor`, `Lecturer`), hire dates, and department affiliation. |
| **`STUDENT`** | `reg_no` | Student demographics, admission year (`2000–2100`), status (`ACTIVE`, `INACTIVE`, `GRADUATED`), and department affiliation. |
| **`COURSE`** | `course_code` | Course catalogue with positive credit weights and managing department. |
| **`COURSE_OFFERING`** | `(course_code, academic_year, semester)` | Scheduled course instances across semesters (`Winter`, `Summer`, `Fall`), assigned instructor, and maximum seat capacity. |
| **`ENROLLMENT`** | `(reg_no, course_code, academic_year, semester)` | Student course registrations with status tracking (`ENROLLED`, `COMPLETED`, `DROPPED`). |
| **`ATTENDANCE`** | `(reg_no, course_code, academic_year, semester, attendance_date)` | Session-level attendance tracking (`PRESENT`, `ABSENT`, `LATE`). |
| **`RESULT`** | `(reg_no, course_code, academic_year, semester, exam_type)` | Examination scores across assessment types (`INTERNAL_1`, `INTERNAL_2`, `MIDTERM`, `ENDSEM`). |

### Key Design Highlights

- **Circular Dependency Resolution (`DEPARTMENT` &harr; `FACULTY`)**:
  1. `DEPARTMENT` is created first without the `hod_emp_id` foreign key.
  2. `FACULTY` is created referencing `DEPARTMENT(dept_code)`.
  3. `ALTER TABLE department ADD CONSTRAINT fk_department_hod ...` attaches the HOD reference after both tables exist.
  4. During data population, departments are inserted with `hod_emp_id = NULL`, faculty records are inserted next, and `UPDATE` statements assign valid HODs.
- **Referential Deletion Behavior**:
  - **Restrictive (`NO ACTION`)**: Default behavior across all parent-child relationships (`DEPARTMENT`, `FACULTY`, `STUDENT`, `COURSE`, `COURSE_OFFERING`, `ENROLLMENT`).
  - **Cascading (`ON DELETE CASCADE`)**: Enabled specifically on `ATTENDANCE` &rarr; `ENROLLMENT` and `RESULT` &rarr; `ENROLLMENT`.

---

## 2. Quick Start & Execution Order

### Prerequisites
- **Oracle Database 11g XE** (`11.2.0.2.0` or higher) with service `OracleServiceXE` running.
- **SQL\*Plus** available in your system `PATH`.

### Step-by-Step Setup in SQL\*Plus

1. Clone the repository and navigate into the project root:
   ```bash
   git clone <repository-url>
   cd college-management-system
   ```

2. Connect to Oracle via SQL\*Plus:
   ```bash
   sqlplus username/password@XE
   ```

3. **Step 1 — Create Schema & Constraints**:
   ```sql
   @schema/01_create_tables.sql
   ```

4. **Step 2 — Insert Sample Data**:
   ```sql
   @data/02_insert_data.sql
   ```

5. **Step 3 — Compile PL/SQL Procedures & Functions**:
   ```sql
   @plsql/P01_register_student.sql
   @plsql/P02_record_attendance.sql
   @plsql/F01_get_attendance_percentage.sql
   @plsql/F02_get_course_percentage.sql
   ```

6. **Step 4 — Compile Validation Triggers**:
   ```sql
   @plsql/T01_validate_student_dob.sql
   @plsql/T02_validate_result.sql
   ```

7. **Step 5 — Run Analytical Queries or Cursor Report**:
   ```sql
   @queries/Q01_active_students.sql
   @queries/Q15_academic_summary.sql

   DEFINE course_code = 'CS101';
   DEFINE academic_year = 2026;
   DEFINE semester = 'Fall';
   @plsql/C01_student_attendance_report.sql
   ```

---

## 3. Analytical SQL Queries (`queries/`)

Each script in `queries/` is standalone and pre-configured with SQL\*Plus formatting (`LINESIZE`, `PAGESIZE`, `COLUMN` formatting):

| Script | Query Objective | Key SQL Features |
| :--- | :--- | :--- |
| [`Q01_active_students.sql`](queries/Q01_active_students.sql) | Active students with department names | `INNER JOIN`, filtered on `status = 'ACTIVE'` |
| [`Q02_faculty_directory.sql`](queries/Q02_faculty_directory.sql) | Faculty directory with departments & HOD flag | `CASE` expression matching `d.hod_emp_id = f.emp_id` |
| [`Q03_course_catalogue.sql`](queries/Q03_course_catalogue.sql) | Course catalogue with credits and departments | Multi-table join sorted by `course_code` |
| [`Q04_course_offerings.sql`](queries/Q04_course_offerings.sql) | Course offerings with instructors and capacity | 3-table join (`COURSE_OFFERING`, `COURSE`, `FACULTY`) |
| [`Q05_students_in_offering.sql`](queries/Q05_students_in_offering.sql) | Students enrolled in a specified offering | Substitution variables: `&p_course_code`, `&p_academic_year`, `&p_semester` |
| [`Q06_students_by_department.sql`](queries/Q06_students_by_department.sql) | Active student count per department (incl. zero) | `LEFT JOIN` with predicate in `ON` clause (`PHYS` = 0) |
| [`Q07_faculty_by_department.sql`](queries/Q07_faculty_by_department.sql) | Faculty headcount per department | `LEFT JOIN` + `GROUP BY` aggregation |
| [`Q08_offering_capacity.sql`](queries/Q08_offering_capacity.sql) | Offering capacity, occupied, and remaining seats | Conditional aggregation counting `ENROLLED` & `COMPLETED` |
| [`Q09_multiple_enrollments.sql`](queries/Q09_multiple_enrollments.sql) | Students in multiple offerings in the same year | `GROUP BY` + `HAVING COUNT(*) > 1` |
| [`Q10_low_attendance.sql`](queries/Q10_low_attendance.sql) | Students with attendance below 75% | Conditional count (`PRESENT`, `LATE`) + `HAVING < 75` |
| [`Q11_full_offerings.sql`](queries/Q11_full_offerings.sql) | Offerings that have reached capacity | `HAVING occupied_seats >= max_seats` |
| [`Q12_top_performers.sql`](queries/Q12_top_performers.sql) | Highest-performing student per offering | CTE + weighted percentage + `RANK() OVER (PARTITION BY ...)` |
| [`Q13_missing_results.sql`](queries/Q13_missing_results.sql) | Students missing a specified exam result | Correlated `NOT EXISTS` + substitution variable `&p_exam_type` |
| [`Q14_course_performance.sql`](queries/Q14_course_performance.sql) | Weighted average result percentage per course | `100 * SUM(marks) / SUM(max_marks)` grouped by course |
| [`Q15_academic_summary.sql`](queries/Q15_academic_summary.sql) | Complete student academic summary | Separate CTE aggregations for attendance and results to prevent Cartesian fan-out |

---

## 4. PL/SQL Procedures, Functions, Cursor & Triggers (`plsql/`)

### 4.1 Stored Procedures & Functions

| File | Object Name | Type | Summary & Error Codes |
| :--- | :--- | :--- | :--- |
| [`P01_register_student.sql`](plsql/P01_register_student.sql) | `REGISTER_STUDENT` | Procedure | Verifies active student (`-20001`, `-20002`), locks offering via `SELECT ... FOR UPDATE` (`-20003`), rejects duplicate enrollment (`-20004`), checks seat capacity (`-20005`), and inserts `ENROLLED` record. Caller controls transaction. |
| [`P02_record_attendance.sql`](plsql/P02_record_attendance.sql) | `RECORD_ATTENDANCE` | Procedure | Validates attendance status (`-20011`), verifies active/completed enrollment (`-20012`, `-20013`), rejects duplicate attendance on the same date (`-20014`), and inserts record. Caller controls transaction. |
| [`F01_get_attendance_percentage.sql`](plsql/F01_get_attendance_percentage.sql) | `GET_ATTENDANCE_PERCENTAGE` | Function | Returns `ROUND(100 * (PRESENT + LATE) / total, 2)`. Returns `0` when no attendance records exist. Read-only. |
| [`F02_get_course_percentage.sql`](plsql/F02_get_course_percentage.sql) | `GET_COURSE_PERCENTAGE` | Function | Returns `ROUND(100 * marks / max_marks, 2)` for a given student, offering, and exam type. Raises `-20021` if result does not exist. Read-only. |

### 4.2 Explicit Cursor & Row-Level Triggers

| File | Object Name | Type | Summary & Error Codes |
| :--- | :--- | :--- | :--- |
| [`C01_student_attendance_report.sql`](plsql/C01_student_attendance_report.sql) | *(Anonymous Block)* | Explicit Cursor | Accepts `&course_code`, `&academic_year`, and `&semester`. Iterates over attendees (`ENROLLED` and `COMPLETED`, including `GRADUATED` alumni), invokes `GET_ATTENDANCE_PERCENTAGE`, and outputs a formatted report via `DBMS_OUTPUT`. |
| [`T01_validate_student_dob.sql`](plsql/T01_validate_student_dob.sql) | `TRG_VALIDATE_STUDENT` | Trigger | `BEFORE INSERT OR UPDATE OF dob ON student FOR EACH ROW`. Rejects `:NEW.dob >= TRUNC(SYSDATE)` with `-20031`. |
| [`T02_validate_result.sql`](plsql/T02_validate_result.sql) | `TRG_VALIDATE_RESULT` | Trigger | `BEFORE INSERT OR UPDATE ON result FOR EACH ROW`. Validates exam type (`-20041`), `max_marks > 0` (`-20042`), `marks >= 0` (`-20043`), and `marks <= max_marks` (`-20044`). |

---

## 5. Verification & Non-Destructive Testing

### 5.1 Verify Schema Objects & Row Counts

```sql
-- 1. Confirm all 8 tables exist
SELECT table_name FROM user_tables ORDER BY table_name;

-- 2. Confirm sample data row counts
SELECT 'DEPARTMENT' AS table_name, COUNT(*) AS row_count FROM department
UNION ALL SELECT 'FACULTY', COUNT(*) FROM faculty
UNION ALL SELECT 'STUDENT', COUNT(*) FROM student
UNION ALL SELECT 'COURSE', COUNT(*) FROM course
UNION ALL SELECT 'COURSE_OFFERING', COUNT(*) FROM course_offering
UNION ALL SELECT 'ENROLLMENT', COUNT(*) FROM enrollment
UNION ALL SELECT 'ATTENDANCE', COUNT(*) FROM attendance
UNION ALL SELECT 'RESULT', COUNT(*) FROM result;
```

**Expected Row Counts:**
- `DEPARTMENT`: 10 | `FACULTY`: 20 | `STUDENT`: 30 | `COURSE`: 10
- `COURSE_OFFERING`: 20 | `ENROLLMENT`: 51 | `ATTENDANCE`: 150 | `RESULT`: 62

### 5.2 Check PL/SQL Compilation Status

```sql
SHOW ERRORS PROCEDURE register_student;
SHOW ERRORS PROCEDURE record_attendance;
SHOW ERRORS FUNCTION get_attendance_percentage;
SHOW ERRORS FUNCTION get_course_percentage;
SHOW ERRORS TRIGGER trg_validate_student;
SHOW ERRORS TRIGGER trg_validate_result;
```

### 5.3 Test Triggers Safely (With Rollback)

```sql
-- Test DOB Trigger (Raises ORA-20031: future/today DOB rejected)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU999', 'Test', 'Student', TRUNC(SYSDATE), 'Male', 'test@college.edu', '9999900099', 2026, 'ACTIVE', 'CS');

-- Test Result Trigger (Raises ORA-20044: marks > max_marks rejected)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU003', 'CS101', 2026, 'Fall', 'INTERNAL_1', SYSDATE, 30.00, 25.00);

-- Rollback to keep baseline data unchanged
ROLLBACK;
```
