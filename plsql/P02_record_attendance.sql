-- ============================================================================
-- College Management System - Stored Procedure: RECORD_ATTENDANCE
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/P02_record_attendance.sql
-- Description     : Records daily attendance for an enrolled student after
--                   verifying enrollment status, status validity, and
--                   duplicate entry constraints.
--
-- Parameters:
--   p_reg_no          : Student registration number
--   p_course_code     : Course identifier
--   p_academic_year   : Academic cycle year
--   p_semester        : Term identifier ('Winter', 'Summer', 'Fall')
--   p_attendance_date : Date of the lecture/session
--   p_status          : Attendance status ('PRESENT', 'ABSENT', 'LATE')
--
-- Business Rules & Behavior:
--   1. Accept only valid attendance status values: 'PRESENT', 'ABSENT', 'LATE'.
--   2. Verify student has an enrollment with status 'ENROLLED' or 'COMPLETED'.
--   3. Reject duplicate attendance record for the same student, offering, and date.
--   4. Insert attendance record into ATTENDANCE table.
--   5. Transaction control is left to the caller (no COMMIT or ROLLBACK).
--
-- ============================================================================
-- HOW TO COMPILE, RUN & TEST
-- ============================================================================
-- 1. Compilation in SQL*Plus:
--      @plsql/P02_record_attendance.sql
--      SHOW ERRORS PROCEDURE record_attendance;
--
-- 2. Execution syntax:
--      EXEC record_attendance('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-09-25', 'YYYY-MM-DD'), 'PRESENT');
--      COMMIT; -- or ROLLBACK;
--
-- 3. Testing Examples:
--
--    -- Test Case 1 (Success): Record valid attendance on a new date for enrolled student STU001
--    BEGIN
--        record_attendance('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-09-25', 'YYYY-MM-DD'), 'PRESENT');
--        DBMS_OUTPUT.PUT_LINE('Success: Attendance recorded for STU001 on 2025-09-25.');
--        ROLLBACK; -- rollback test data
--    END;
--    /
--
--    -- Test Case 2 (Duplicate Attendance - Expects ORA-20014):
--    -- Attendance on 2025-08-10 already exists for STU001 in CS101 2025 Fall
--    BEGIN
--        record_attendance('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-08-10', 'YYYY-MM-DD'), 'PRESENT');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20014): ' || SQLERRM);
--    END;
--    /
--
--    -- Test Case 3 (Invalid Status - Expects ORA-20011):
--    -- Status must be PRESENT, ABSENT, or LATE (not EXCUSED)
--    BEGIN
--        record_attendance('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-09-28', 'YYYY-MM-DD'), 'EXCUSED');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20011): ' || SQLERRM);
--    END;
--    /
--
--    -- Test Case 4 (Not Enrolled - Expects ORA-20012):
--    -- Student STU030 is not enrolled in CS101 2025 Fall
--    BEGIN
--        record_attendance('STU030', 'CS101', 2025, 'Fall', TO_DATE('2025-09-28', 'YYYY-MM-DD'), 'PRESENT');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20012): ' || SQLERRM);
--    END;
--    /
--
--    -- Test Case 5 (Dropped Student - Expects ORA-20013):
--    -- Student STU005 has status DROPPED in CS101 2025 Fall
--    BEGIN
--        record_attendance('STU005', 'CS101', 2025, 'Fall', TO_DATE('2025-09-28', 'YYYY-MM-DD'), 'PRESENT');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20013): ' || SQLERRM);
--    END;
--    /
-- ============================================================================

CREATE OR REPLACE PROCEDURE record_attendance (
    p_reg_no          IN attendance.reg_no%TYPE,
    p_course_code     IN attendance.course_code%TYPE,
    p_academic_year   IN attendance.academic_year%TYPE,
    p_semester        IN attendance.semester%TYPE,
    p_attendance_date IN attendance.attendance_date%TYPE,
    p_status          IN attendance.status%TYPE
)
IS
    v_enrollment_status enrollment.status%TYPE;
    v_existing_count    NUMBER;
BEGIN
    -- 1. Validate attendance status value
    IF p_status NOT IN ('PRESENT', 'ABSENT', 'LATE') OR p_status IS NULL THEN
        RAISE_APPLICATION_ERROR(
            -20011,
            'Invalid attendance status: ' || NVL(p_status, 'NULL') ||
            '. Allowed values are PRESENT, ABSENT, or LATE.'
        );
    END IF;

    -- 2. Verify enrollment exists and is ENROLLED or COMPLETED
    BEGIN
        SELECT status
        INTO v_enrollment_status
        FROM enrollment
        WHERE reg_no = p_reg_no
          AND course_code = p_course_code
          AND academic_year = p_academic_year
          AND semester = p_semester;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(
                -20012,
                'Enrollment not found for student ' || p_reg_no ||
                ' in course offering ' || p_course_code || ' (' ||
                p_academic_year || ' ' || p_semester || ').'
            );
    END;

    IF v_enrollment_status NOT IN ('ENROLLED', 'COMPLETED') THEN
        RAISE_APPLICATION_ERROR(
            -20013,
            'Cannot record attendance: enrollment status for student ' ||
            p_reg_no || ' is ' || v_enrollment_status ||
            ' (must be ENROLLED or COMPLETED).'
        );
    END IF;

    -- 3. Reject duplicate attendance record
    SELECT COUNT(*)
    INTO v_existing_count
    FROM attendance
    WHERE reg_no = p_reg_no
      AND course_code = p_course_code
      AND academic_year = p_academic_year
      AND semester = p_semester
      AND attendance_date = p_attendance_date;

    IF v_existing_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20014,
            'Attendance record already exists for student ' || p_reg_no ||
            ' in offering ' || p_course_code || ' (' || p_academic_year ||
            ' ' || p_semester || ') on date ' ||
            TO_CHAR(p_attendance_date, 'YYYY-MM-DD') || '.'
        );
    END IF;

    -- 4. Insert attendance record
    INSERT INTO attendance (
        reg_no,
        course_code,
        academic_year,
        semester,
        attendance_date,
        status
    ) VALUES (
        p_reg_no,
        p_course_code,
        p_academic_year,
        p_semester,
        p_attendance_date,
        p_status
    );

END record_attendance;
/

SHOW ERRORS PROCEDURE record_attendance;
