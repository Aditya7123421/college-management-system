-- Query 15: Student Academic Summary (Independent Aggregation)
--   Constructs a comprehensive academic summary per enrollment. Attendance and
--   examination metrics are aggregated separately via CTEs to prevent Cartesian
--   product row inflation before joining to ENROLLMENT.

SET LINESIZE 200
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN reg_no FORMAT A10 HEADING "Reg No"
COLUMN student_name FORMAT A20 HEADING "Student Name"
COLUMN course_code FORMAT A10 HEADING "Course"
COLUMN course_name FORMAT A40 HEADING "Course Name"
COLUMN academic_year FORMAT 9999 HEADING "Year"
COLUMN semester FORMAT A8 HEADING "Semester"
COLUMN enrollment_status FORMAT A10 HEADING "Status"
COLUMN total_sessions FORMAT 9999 HEADING "Sessions"
COLUMN attended_sessions FORMAT 9999 HEADING "Attended"
COLUMN attendance_pct FORMAT 990.99 HEADING "Attd %"
COLUMN total_obtained FORMAT 999.99 HEADING "Marks"
COLUMN total_max FORMAT 999.99 HEADING "Max"
COLUMN exam_pct FORMAT 990.99 HEADING "Exam %"

WITH att_agg AS (
    SELECT reg_no,
           course_code,
           academic_year,
           semester,
           COUNT(*) AS total_sessions,
           COUNT(CASE WHEN status IN ('PRESENT', 'LATE') THEN 1 END) AS attended_sessions,
           ROUND(100.0 * COUNT(CASE WHEN status IN ('PRESENT', 'LATE') THEN 1 END) / COUNT(*), 2) AS attendance_pct
    FROM attendance
    GROUP BY reg_no, course_code, academic_year, semester
),
res_agg AS (
    SELECT reg_no,
           course_code,
           academic_year,
           semester,
           SUM(marks) AS total_obtained,
           SUM(max_marks) AS total_max,
           ROUND(100.0 * SUM(marks) / SUM(max_marks), 2) AS exam_pct
    FROM result
    GROUP BY reg_no, course_code, academic_year, semester
)
SELECT e.reg_no,
       s.first_name || ' ' || s.last_name AS student_name,
       e.course_code,
       c.course_name,
       e.academic_year,
       e.semester,
       e.status AS enrollment_status,
       NVL(a.total_sessions, 0) AS total_sessions,
       NVL(a.attended_sessions, 0) AS attended_sessions,
       a.attendance_pct,
       NVL(r.total_obtained, 0) AS total_obtained,
       NVL(r.total_max, 0) AS total_max,
       r.exam_pct
FROM enrollment e
JOIN student s ON e.reg_no = s.reg_no
JOIN course c ON e.course_code = c.course_code
LEFT JOIN att_agg a 
       ON e.reg_no = a.reg_no 
      AND e.course_code = a.course_code 
      AND e.academic_year = a.academic_year 
      AND e.semester = a.semester
LEFT JOIN res_agg r 
       ON e.reg_no = r.reg_no 
      AND e.course_code = r.course_code 
      AND e.academic_year = r.academic_year 
      AND e.semester = r.semester
ORDER BY e.academic_year, e.semester, e.course_code, e.reg_no;

CLEAR COLUMNS
