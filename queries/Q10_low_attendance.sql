-- Query 10: Students with Attendance Below 75%
-- File    : queries/Q10_low_attendance.sql
--   Identifies student-offering enrollments where overall attendance falls below
--   75%. Both 'PRESENT' and 'LATE' statuses are counted as attended.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN reg_no FORMAT A10 HEADING "Reg No"
COLUMN student_name FORMAT A22 HEADING "Student Name"
COLUMN course_code FORMAT A12 HEADING "Course Code"
COLUMN academic_year FORMAT 9999 HEADING "Year"
COLUMN semester FORMAT A8 HEADING "Semester"
COLUMN total_sessions FORMAT 9999 HEADING "Sessions"
COLUMN attended_sessions FORMAT 9999 HEADING "Attended"
COLUMN attendance_pct FORMAT 990.99 HEADING "Attd %"

SELECT a.reg_no,
       s.first_name || ' ' || s.last_name AS student_name,
       a.course_code,
       a.academic_year,
       a.semester,
       COUNT(*) AS total_sessions,
       COUNT(CASE WHEN a.status IN ('PRESENT', 'LATE') THEN 1 END) AS attended_sessions,
       ROUND(100.0 * COUNT(CASE WHEN a.status IN ('PRESENT', 'LATE') THEN 1 END) / COUNT(*), 2) AS attendance_pct
FROM attendance a
JOIN student s ON a.reg_no = s.reg_no
GROUP BY a.reg_no, s.first_name, s.last_name, a.course_code, a.academic_year, a.semester
HAVING 100.0 * COUNT(CASE WHEN a.status IN ('PRESENT', 'LATE') THEN 1 END) / COUNT(*) < 75
ORDER BY attendance_pct ASC, a.reg_no;

CLEAR COLUMNS
