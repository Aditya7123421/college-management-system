-- ============================================================================
-- College Management System - Stored Procedure: REGISTER_STUDENT
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/P01_register_student.sql
-- Description     : Enrolls an active student in an existing course offering
--                   while validating student status, offering existence,
--                   duplicate enrollment, and seat capacity.
--
-- Parameters:
--   p_reg_no        : Student registration number (e.g., 'STU001')
--   p_course_code   : Course identifier (e.g., 'CS101')
--   p_academic_year : Academic cycle year (e.g., 2026)
--   p_semester      : Term identifier ('Winter', 'Summer', 'Fall')
--
-- Business Rules & Behavior:
--   1. Verify the student exists and has status 'ACTIVE'.
--   2. Verify the course offering exists.
--   3. Lock course offering row using SELECT ... FOR UPDATE to serialize
--      concurrent capacity checks.
--   4. Reject duplicate enrollment if student is already registered.
--   5. Calculate occupied seats counting only 'ENROLLED' and 'COMPLETED' records.
--   6. Reject enrollment if offering is at capacity (occupied >= max_seats).
--   7. Insert enrollment record with status 'ENROLLED' and SYSDATE.
--   8. Transaction control is left to the caller (no COMMIT or ROLLBACK).
--
-- ============================================================================
-- HOW TO COMPILE, RUN & TEST
-- ============================================================================
-- 1. Compilation in SQL*Plus:
--      @plsql/P01_register_student.sql
--      SHOW ERRORS PROCEDURE register_student;
--
-- 2. Execution syntax:
--      EXEC register_student('STU007', 'CS101', 2026, 'Fall');
--      COMMIT; -- or ROLLBACK;
--
-- 3. Testing Examples:
--
--    -- Test Case 1 (Success): Enroll active student STU007 in offering with open seats
--    BEGIN
--        register_student('STU007', 'CS101', 2026, 'Fall');
--        DBMS_OUTPUT.PUT_LINE('Success: STU007 enrolled in CS101 2026 Fall.');
--        ROLLBACK; -- rollback test data
--    END;
--    /
--
--    -- Test Case 2 (Duplicate Enrollment - Expects ORA-20004):
--    -- Student STU003 is already enrolled in CS101 2026 Fall
--    BEGIN
--        register_student('STU003', 'CS101', 2026, 'Fall');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20004): ' || SQLERRM);
--    END;
--    /
--
--    -- Test Case 3 (Full Offering - Expects ORA-20005):
--    -- Offering CS101 2025 Fall is at maximum capacity (3/3 occupied)
--    BEGIN
--        register_student('STU007', 'CS101', 2025, 'Fall');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20005): ' || SQLERRM);
--    END;
--    /
--
--    -- Test Case 4 (Inactive Student - Expects ORA-20002):
--    -- Student STU028 has status INACTIVE
--    BEGIN
--        register_student('STU028', 'CS101', 2026, 'Fall');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20002): ' || SQLERRM);
--    END;
--    /
--
--    -- Test Case 5 (Non-existent Student - Expects ORA-20001):
--    BEGIN
--        register_student('STU999', 'CS101', 2026, 'Fall');
--    EXCEPTION
--        WHEN OTHERS THEN
--            DBMS_OUTPUT.PUT_LINE('Expected Error (-20001): ' || SQLERRM);
--    END;
--    /
-- ============================================================================

CREATE OR REPLACE PROCEDURE register_student (
    p_reg_no        IN student.reg_no%TYPE,
    p_course_code   IN course_offering.course_code%TYPE,
    p_academic_year IN course_offering.academic_year%TYPE,
    p_semester      IN course_offering.semester%TYPE
)
IS
    v_student_status    student.status%TYPE;
    v_max_seats         course_offering.max_seats%TYPE;
    v_existing_count    NUMBER;
    v_occupied_seats    NUMBER;
BEGIN
    -- 1. Verify student exists and check active status
    BEGIN
        SELECT status
        INTO v_student_status
        FROM student
        WHERE reg_no = p_reg_no;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(
                -20001,
                'Student registration number ' || p_reg_no || ' does not exist.'
            );
    END;

    IF v_student_status != 'ACTIVE' THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'Student ' || p_reg_no || ' cannot be enrolled because status is ' ||
            v_student_status || ' (must be ACTIVE).'
        );
    END IF;

    -- 2. Verify course offering exists and lock row to serialize capacity checks
    BEGIN
        SELECT max_seats
        INTO v_max_seats
        FROM course_offering
        WHERE course_code = p_course_code
          AND academic_year = p_academic_year
          AND semester = p_semester
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(
                -20003,
                'Course offering ' || p_course_code || ' (' ||
                p_academic_year || ' ' || p_semester || ') does not exist.'
            );
    END;

    -- 3. Reject duplicate enrollment
    SELECT COUNT(*)
    INTO v_existing_count
    FROM enrollment
    WHERE reg_no = p_reg_no
      AND course_code = p_course_code
      AND academic_year = p_academic_year
      AND semester = p_semester;

    IF v_existing_count > 0 THEN
        RAISE_APPLICATION_ERROR(
            -20004,
            'Student ' || p_reg_no || ' is already enrolled in course offering ' ||
            p_course_code || ' (' || p_academic_year || ' ' || p_semester || ').'
        );
    END IF;

    -- 4. Check seat capacity (counting ENROLLED and COMPLETED records)
    SELECT COUNT(*)
    INTO v_occupied_seats
    FROM enrollment
    WHERE course_code = p_course_code
      AND academic_year = p_academic_year
      AND semester = p_semester
      AND status IN ('ENROLLED', 'COMPLETED');

    IF v_occupied_seats >= v_max_seats THEN
        RAISE_APPLICATION_ERROR(
            -20005,
            'Course offering ' || p_course_code || ' (' || p_academic_year ||
            ' ' || p_semester || ') is full. Capacity: ' || v_max_seats ||
            ', Occupied: ' || v_occupied_seats || '.'
        );
    END IF;

    -- 5. Insert enrollment record
    INSERT INTO enrollment (
        reg_no,
        course_code,
        academic_year,
        semester,
        enrollment_date,
        status
    ) VALUES (
        p_reg_no,
        p_course_code,
        p_academic_year,
        p_semester,
        SYSDATE,
        'ENROLLED'
    );

END register_student;
/

SHOW ERRORS PROCEDURE register_student;
