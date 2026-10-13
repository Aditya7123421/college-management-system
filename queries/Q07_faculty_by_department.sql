-- Query 07: Faculty Count per Department
--   Counts total faculty members assigned to each department.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN dept_code FORMAT A10 HEADING "Dept Code"
COLUMN dept_name FORMAT A43 HEADING "Department Name"
COLUMN faculty_count FORMAT 9999 HEADING "Faculty Count"

SELECT d.dept_code,
       d.dept_name,
       COUNT(f.emp_id) AS faculty_count
FROM department d
LEFT JOIN faculty f ON d.dept_code = f.dept_code
GROUP BY d.dept_code, d.dept_name
ORDER BY d.dept_code;

CLEAR COLUMNS
