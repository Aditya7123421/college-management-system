-- Query 05: Students Enrolled in a Specified Offering
--   Displays student enrollments for a specific course offering using SQL*Plus

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON
SET VERIFY OFF

-- Default substitution values for standalone execution:
DEFINE p_course_code = 'CS101';
DEFINE p_academic_year = 2025;
DEFINE p_semester = 'Fall';

COLUMN reg_no FORMAT A10 HEADING "Reg No"
COLUMN student_name FORMAT A22 HEADING "Student Name"
COLUMN email FORMAT A32 HEADING "Email Address"
COLUMN enrollment_date FORMAT A12 HEADING "Enrolled On"
COLUMN enrollment_status FORMAT A12 HEADING "Status"

SELECT e.reg_no,
       s.first_name || ' ' || s.last_name AS student_name,
       s.email,
       TO_CHAR(e.enrollment_date, 'YYYY-MM-DD') AS enrollment_date,
       e.status AS enrollment_status
FROM enrollment e
JOIN student s ON e.reg_no = s.reg_no
WHERE e.course_code = '&p_course_code'
  AND e.academic_year = &p_academic_year
  AND e.semester = '&p_semester'
ORDER BY e.reg_no;

CLEAR COLUMNS
SET VERIFY ON
