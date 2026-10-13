-- Query 11: Offerings That Have Reached Capacity
--   Filters offerings where occupied seats (status IN ('ENROLLED', 'COMPLETED'))
--   equal or exceed maximum configured capacity.

SET LINESIZE 160
SET PAGESIZE 60
SET FEEDBACK ON

COLUMN course_code FORMAT A12 HEADING "Course Code"
COLUMN course_name FORMAT A35 HEADING "Course Name"
COLUMN academic_year FORMAT 9999 HEADING "Year"
COLUMN semester FORMAT A8 HEADING "Semester"
COLUMN capacity FORMAT 999 HEADING "Capacity"
COLUMN occupied_seats FORMAT 999 HEADING "Occupied"

SELECT co.course_code,
       c.course_name,
       co.academic_year,
       co.semester,
       co.max_seats AS capacity,
       COUNT(CASE WHEN e.status IN ('ENROLLED', 'COMPLETED') THEN 1 END) AS occupied_seats
FROM course_offering co
JOIN course c ON co.course_code = c.course_code
LEFT JOIN enrollment e 
       ON co.course_code = e.course_code 
      AND co.academic_year = e.academic_year 
      AND co.semester = e.semester
GROUP BY co.course_code, c.course_name, co.academic_year, co.semester, co.max_seats
HAVING COUNT(CASE WHEN e.status IN ('ENROLLED', 'COMPLETED') THEN 1 END) >= co.max_seats
ORDER BY co.academic_year, co.semester, co.course_code;

CLEAR COLUMNS
