-- ============================================================================
-- College Management System - Stored Function: GET_ATTENDANCE_PERCENTAGE
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/F01_get_attendance_percentage.sql
-- Description     : Computes attendance percentage for a student in a specific
--                   course offering: 100 * (PRESENT + LATE) / total_sessions.
--
-- Parameters:
--   p_reg_no        : Student registration number
--   p_course_code   : Course identifier
--   p_academic_year : Academic cycle year
--   p_semester      : Term identifier ('Winter', 'Summer', 'Fall')
--
-- Return:
--   NUMBER: Attendance percentage rounded to 2 decimal places.
--           Returns 0 if no attendance records exist for the offering.
--
-- Purity:
--   DETERMINISTIC / Read-Only (does not modify database state).
-- ============================================================================

CREATE OR REPLACE FUNCTION get_attendance_percentage (
    p_reg_no        IN student.reg_no%TYPE,
    p_course_code   IN course_offering.course_code%TYPE,
    p_academic_year IN course_offering.academic_year%TYPE,
    p_semester      IN course_offering.semester%TYPE
) RETURN NUMBER
IS
    v_total_records    NUMBER;
    v_attended_records NUMBER;
BEGIN
    SELECT COUNT(*),
           COUNT(CASE WHEN status IN ('PRESENT', 'LATE') THEN 1 END)
    INTO v_total_records,
         v_attended_records
    FROM attendance
    WHERE reg_no = p_reg_no
      AND course_code = p_course_code
      AND academic_year = p_academic_year
      AND semester = p_semester;

    -- Return 0 if no attendance sessions have been recorded
    IF v_total_records = 0 THEN
        RETURN 0;
    ELSE
        RETURN ROUND(100.0 * v_attended_records / v_total_records, 2);
    END IF;

END get_attendance_percentage;
/

SHOW ERRORS FUNCTION get_attendance_percentage;
