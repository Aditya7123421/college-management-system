-- Query 14: Weighted Average Result Percentage per Course
--   Calculates the overall weighted average performance per course across all
--   examination records: 100 * SUM(marks) / SUM(max_marks).


SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN course_code FORMAT A12 HEADING "Course Code"
COLUMN course_name FORMAT A40 HEADING "Course Name"
COLUMN dept_name FORMAT A45 HEADING "Department Name"
COLUMN total_marks_obtained FORMAT 9999.99 HEADING "Total Marks"
COLUMN total_max_marks FORMAT 9999.99 HEADING "Total Max"
COLUMN weighted_avg_pct FORMAT 990.99 HEADING "Weighted Avg %"

SELECT c.course_code,
       c.course_name,
       d.dept_name,
       SUM(r.marks) AS total_marks_obtained,
       SUM(r.max_marks) AS total_max_marks,
       ROUND(100.0 * SUM(r.marks) / SUM(r.max_marks), 2) AS weighted_avg_pct
FROM course c
JOIN department d ON c.dept_code = d.dept_code
JOIN result r ON c.course_code = r.course_code
GROUP BY c.course_code, c.course_name, d.dept_name
ORDER BY weighted_avg_pct DESC, c.course_code;

CLEAR COLUMNS
