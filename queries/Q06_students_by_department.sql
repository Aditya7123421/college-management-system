-- Query 06: Active Student Count per Department (Including Zero)
--   Aggregates the count of 'ACTIVE' students per department using a LEFT OUTER
--   JOIN so that departments with zero active students are included.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN dept_code FORMAT A10 HEADING "Dept Code"
COLUMN dept_name FORMAT A43 HEADING "Department Name"
COLUMN active_student_count FORMAT 9999 HEADING "Active Students"

SELECT d.dept_code,
       d.dept_name,
       COUNT(s.reg_no) AS active_student_count
FROM department d
LEFT JOIN student s 
       ON d.dept_code = s.dept_code 
      AND s.status = 'ACTIVE'
GROUP BY d.dept_code, d.dept_name
ORDER BY active_student_count DESC, d.dept_code;

CLEAR COLUMNS
