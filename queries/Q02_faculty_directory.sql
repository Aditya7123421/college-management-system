-- Query 02: Faculty Directory with Departments
--   Provides a complete directory of faculty members including their designation,
--   contact information, assigned department, and whether they serve as HOD.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN emp_id FORMAT A8 HEADING "Emp ID"
COLUMN faculty_name FORMAT A22 HEADING "Faculty Name"
COLUMN designation FORMAT A22 HEADING "Designation"
COLUMN email FORMAT A36 HEADING "Email Address"
COLUMN phone FORMAT A12 HEADING "Phone"
COLUMN dept_name FORMAT A43 HEADING "Department Name"
COLUMN is_hod FORMAT A6 HEADING "Is HOD"

SELECT f.emp_id,
       f.first_name || ' ' || f.last_name AS faculty_name,
       f.designation,
       f.email,
       f.phone,
       d.dept_name,
       CASE WHEN d.hod_emp_id = f.emp_id THEN 'YES' ELSE 'NO' END AS is_hod
FROM faculty f
JOIN department d ON f.dept_code = d.dept_code
ORDER BY d.dept_name, f.emp_id;

CLEAR COLUMNS
