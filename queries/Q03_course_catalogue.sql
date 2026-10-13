-- Query 03: Course Catalogue with Credits and Departments
--   Retrieves all catalog courses with credit values and offering department.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN course_code FORMAT A12 HEADING "Course Code"
COLUMN course_name FORMAT A38 HEADING "Course Name"
COLUMN credits FORMAT 99 HEADING "Credits"
COLUMN dept_code FORMAT A10 HEADING "Dept Code"
COLUMN dept_name FORMAT A43 HEADING "Department Name"

SELECT c.course_code,
       c.course_name,
       c.credits,
       d.dept_code,
       d.dept_name
FROM course c
JOIN department d ON c.dept_code = d.dept_code
ORDER BY c.course_code;

CLEAR COLUMNS
