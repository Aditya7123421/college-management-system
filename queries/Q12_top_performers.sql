-- Query 12: Highest-Performing Student per Offering (RANK)
--   Computes overall weighted percentage: 100 * SUM(marks) / SUM(max_marks)
--   for each student per offering and uses analytic RANK() to identify the
--   top student(s), correctly handling ties.


SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN course_code FORMAT A12 HEADING "Course Code"
COLUMN academic_year FORMAT 9999 HEADING "Year"
COLUMN semester FORMAT A8 HEADING "Semester"
COLUMN reg_no FORMAT A10 HEADING "Reg No"
COLUMN student_name FORMAT A22 HEADING "Student Name"
COLUMN total_marks_obtained FORMAT 999.99 HEADING "Marks"
COLUMN total_max_marks FORMAT 999.99 HEADING "Max Marks"
COLUMN weighted_pct FORMAT 990.99 HEADING "Score %"

WITH offering_scores AS (
    SELECT r.course_code,
           r.academic_year,
           r.semester,
           r.reg_no,
           s.first_name || ' ' || s.last_name AS student_name,
           SUM(r.marks) AS total_marks_obtained,
           SUM(r.max_marks) AS total_max_marks,
           ROUND(100.0 * SUM(r.marks) / SUM(r.max_marks), 2) AS weighted_pct,
           RANK() OVER (
               PARTITION BY r.course_code, r.academic_year, r.semester
               ORDER BY 100.0 * SUM(r.marks) / SUM(r.max_marks) DESC
           ) AS rnk
    FROM result r
    JOIN student s ON r.reg_no = s.reg_no
    GROUP BY r.course_code, r.academic_year, r.semester, r.reg_no, s.first_name, s.last_name
)
SELECT course_code,
       academic_year,
       semester,
       reg_no,
       student_name,
       total_marks_obtained,
       total_max_marks,
       weighted_pct
FROM offering_scores
WHERE rnk = 1
ORDER BY academic_year, semester, course_code, reg_no;

CLEAR COLUMNS
