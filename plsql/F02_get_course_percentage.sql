-- ============================================================================
-- College Management System - Stored Function: GET_COURSE_PERCENTAGE
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/F02_get_course_percentage.sql
-- Description     : Calculates examination percentage for a student in a
--                   specific course offering and exam type: 100 * marks / max_marks.
--
-- Parameters:
--   p_reg_no        : Student registration number
--   p_course_code   : Course identifier
--   p_academic_year : Academic cycle year
--   p_semester      : Term identifier ('Winter', 'Summer', 'Fall')
--   p_exam_type     : Examination type ('INTERNAL_1', 'INTERNAL_2', 'MIDTERM', 'ENDSEM')
--
-- Return:
--   NUMBER: Score percentage rounded to 2 decimal places.
--
-- Exceptions:
--   Raises ORA-20021 if no matching RESULT record exists.
--
-- Purity:
--   DETERMINISTIC / Read-Only (does not modify database state).
--
-- ============================================================================
-- HOW TO COMPILE, RUN & TEST
-- ============================================================================
-- 1. Compilation in SQL*Plus:
--      @plsql/F02_get_course_percentage.sql
--      SHOW ERRORS FUNCTION get_course_percentage;
--
-- 2. Execution syntax:
--      -- Within SQL queries:
--      SELECT get_course_percentage('STU001', 'CS101', 2025, 'Fall', 'ENDSEM') AS exam_pct FROM dual;
--
--      -- Within PL/SQL blocks:
--      v_pct := get_course_percentage('STU001', 'CS101', 2025, 'Fall', 'ENDSEM');
--
-- 3. Testing Examples:
--
--    -- Test Case 1 (Success - Endsem):
--    -- STU001 scored 92.00 / 100.00 in ENDSEM of CS101 2025 Fall
--    SELECT get_course_percentage('STU001', 'CS101', 2025, 'Fall', 'ENDSEM') AS pct_endsem FROM dual;
--    -- Expected Output: 92
--
--    -- Test Case 2 (Success - Midterm):
--    -- STU001 scored 46.00 / 50.00 in MIDTERM of CS101 2025 Fall
--    SELECT get_course_percentage('STU001', 'CS101', 2025, 'Fall', 'MIDTERM') AS pct_midterm FROM dual;
--    -- Expected Output: 92
--
--    -- Test Case 3 (Missing Result - Expects ORA-20021):
--    -- STU005 has no ENDSEM record in IT101 2025 Fall
--    BEGIN
--        DBMS_OUTPUT.PUT_LINE(get_course_percentage('STU005', 'IT101', 2025, 'Fall', 'ENDSEM'));
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20021): ' || SQLERRM);
--    END;
--    /
-- ============================================================================

CREATE OR REPLACE FUNCTION get_course_percentage (
    p_reg_no        IN student.reg_no%TYPE,
    p_course_code   IN course_offering.course_code%TYPE,
    p_academic_year IN course_offering.academic_year%TYPE,
    p_semester      IN course_offering.semester%TYPE,
    p_exam_type     IN result.exam_type%TYPE
) RETURN NUMBER
IS
    v_marks     result.marks%TYPE;
    v_max_marks result.max_marks%TYPE;
BEGIN
    SELECT marks, max_marks
    INTO v_marks, v_max_marks
    FROM result
    WHERE reg_no = p_reg_no
      AND course_code = p_course_code
      AND academic_year = p_academic_year
      AND semester = p_semester
      AND exam_type = p_exam_type;

    RETURN ROUND(100.0 * v_marks / v_max_marks, 2);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(
            -20021,
            'Examination result not found for student ' || p_reg_no ||
            ', offering ' || p_course_code || ' (' || p_academic_year ||
            ' ' || p_semester || '), exam type: ' || p_exam_type || '.'
        );
END get_course_percentage;
/

SHOW ERRORS FUNCTION get_course_percentage;
