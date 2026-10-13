-- Query 09: Students Enrolled in Multiple Offerings in Same Academic Year
--   Identifies students registered in more than one offering within a single
--   academic year cycle using HAVING COUNT(*) > 1.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN academic_year FORMAT 9999 HEADING "Year"
COLUMN reg_no FORMAT A10 HEADING "Reg No"
COLUMN student_name FORMAT A22 HEADING "Student Name"
COLUMN dept_name FORMAT A40 HEADING "Department"
COLUMN offerings_count FORMAT 9999 HEADING "Offerings Count"

SELECT e.academic_year,
       s.reg_no,
       s.first_name || ' ' || s.last_name AS student_name,
       d.dept_name,
       COUNT(*) AS offerings_count
FROM enrollment e
JOIN student s ON e.reg_no = s.reg_no
JOIN department d ON s.dept_code = d.dept_code
GROUP BY e.academic_year, s.reg_no, s.first_name, s.last_name, d.dept_name
HAVING COUNT(*) > 1
ORDER BY e.academic_year, offerings_count DESC, s.reg_no;

CLEAR COLUMNS
