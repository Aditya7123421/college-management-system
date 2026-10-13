-- Query 13: Students Missing a Specified Examination Result
--   Finds students enrolled in an offering who lack an exam record for a
--   parameterized exam type (e.g., 'ENDSEM', 'MIDTERM', 'INTERNAL_1').

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON
SET VERIFY OFF

-- Default substitution value for standalone execution:
DEFINE p_exam_type = 'ENDSEM';

COLUMN course_code FORMAT A12 HEADING "Course Code"
COLUMN academic_year FORMAT 9999 HEADING "Year"
COLUMN semester FORMAT A8 HEADING "Semester"
COLUMN reg_no FORMAT A10 HEADING "Reg No"
COLUMN student_name FORMAT A22 HEADING "Student Name"
COLUMN email FORMAT A35 HEADING "Email Address"
COLUMN enrollment_status FORMAT A10 HEADING "Status"
COLUMN missing_exam_type FORMAT A12 HEADING "Missing Exam"

SELECT e.course_code,
       e.academic_year,
       e.semester,
       e.reg_no,
       s.first_name || ' ' || s.last_name AS student_name,
       s.email,
       e.status AS enrollment_status,
       '&p_exam_type' AS missing_exam_type
FROM enrollment e
JOIN student s ON e.reg_no = s.reg_no
WHERE e.status IN ('ENROLLED', 'COMPLETED')
  AND NOT EXISTS (
      SELECT 1
      FROM result r
      WHERE r.reg_no = e.reg_no
        AND r.course_code = e.course_code
        AND r.academic_year = e.academic_year
        AND r.semester = e.semester
        AND r.exam_type = '&p_exam_type'
  )
ORDER BY e.academic_year, e.semester, e.course_code, e.reg_no;

CLEAR COLUMNS
SET VERIFY ON
