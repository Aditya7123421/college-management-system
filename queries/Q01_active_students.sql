-- Query 01: Active Students with Department Names
--   Lists all students with 'ACTIVE' academic status along with their registered
--   department details.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN reg_no FORMAT A10 HEADING "Reg No"
COLUMN student_name FORMAT A22 HEADING "Student Name"
COLUMN gender FORMAT A8 HEADING "Gender"
COLUMN email FORMAT A35 HEADING "Email Address"
COLUMN admission_year FORMAT 9999 HEADING "Adm Year"
COLUMN dept_name FORMAT A43 HEADING "Department Name"

SELECT s.reg_no,
       s.first_name || ' ' || s.last_name AS student_name,
       s.gender,
       s.email,
       s.admission_year,
       d.dept_name
FROM student s
JOIN department d ON s.dept_code = d.dept_code
WHERE s.status = 'ACTIVE'
ORDER BY d.dept_name, s.reg_no;

CLEAR COLUMNS
