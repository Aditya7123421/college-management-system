-- Query 04: Course Offerings with Instructors and Capacity
--   Lists scheduled course offerings per academic year and semester, showing
--   assigned instructor and maximum seat capacity.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN course_code FORMAT A12 HEADING "Course Code"
COLUMN course_name FORMAT A38 HEADING "Course Name"
COLUMN academic_year FORMAT 9999 HEADING "Year"
COLUMN semester FORMAT A8 HEADING "Semester"
COLUMN emp_id FORMAT A8 HEADING "Emp ID"
COLUMN instructor_name FORMAT A22 HEADING "Instructor"
COLUMN capacity FORMAT 999 HEADING "Capacity"

SELECT co.course_code,
       c.course_name,
       co.academic_year,
       co.semester,
       f.emp_id,
       f.first_name || ' ' || f.last_name AS instructor_name,
       co.max_seats AS capacity
FROM course_offering co
JOIN course c ON co.course_code = c.course_code
JOIN faculty f ON co.emp_id = f.emp_id
ORDER BY co.academic_year DESC, co.semester, co.course_code;

CLEAR COLUMNS
