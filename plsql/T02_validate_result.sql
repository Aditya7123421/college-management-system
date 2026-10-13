-- ============================================================================
-- College Management System - Trigger: TRG_VALIDATE_RESULT
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/T02_validate_result.sql
-- Description     : Row-level BEFORE INSERT OR UPDATE trigger on RESULT.
--                   Enforces score integrity and exam classification rules:
--                     1. Valid exam type ('INTERNAL_1', 'INTERNAL_2', 'MIDTERM', 'ENDSEM').
--                     2. max_marks > 0.
--                     3. marks >= 0.
--                     4. marks <= max_marks.
--
-- Business Rules:
--   - Demonstrates trigger validation behavior matching table CHECK constraints.
--   - Raises specific application errors (-20041 through -20044) with detailed messages.
--
-- ============================================================================
-- HOW TO COMPILE & TEST
-- ============================================================================
-- 1. Compilation in SQL*Plus:
--      @plsql/T02_validate_result.sql
--      SHOW ERRORS TRIGGER trg_validate_result;
--
-- 2. Testing Examples (with ROLLBACK to keep baseline data unchanged):
--
--    -- Test Case 1 (Success - Valid Result):
--    INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
--    VALUES ('STU003', 'CS101', 2026, 'Fall', 'INTERNAL_1', SYSDATE, 22.00, 25.00);
--    -- Verification: 1 row created
--    ROLLBACK;
--
--    -- Test Case 2 (Rejection - Invalid exam_type, Expects ORA-20041):
--    INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
--    VALUES ('STU003', 'CS101', 2026, 'Fall', 'SURPRISE_TEST', SYSDATE, 20.00, 25.00);
--    -- Expected Error: ORA-20041: Invalid examination type
--
--    -- Test Case 3 (Rejection - Non-positive max_marks, Expects ORA-20042):
--    INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
--    VALUES ('STU003', 'CS101', 2026, 'Fall', 'INTERNAL_1', SYSDATE, 0.00, 0.00);
--    -- Expected Error: ORA-20042: Maximum marks must be strictly greater than zero
--
--    -- Test Case 4 (Rejection - Negative marks, Expects ORA-20043):
--    INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
--    VALUES ('STU003', 'CS101', 2026, 'Fall', 'INTERNAL_1', SYSDATE, -5.00, 25.00);
--    -- Expected Error: ORA-20043: Marks obtained cannot be negative
--
--    -- Test Case 5 (Rejection - Marks exceed max_marks, Expects ORA-20044):
--    INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
--    VALUES ('STU003', 'CS101', 2026, 'Fall', 'INTERNAL_1', SYSDATE, 28.00, 25.00);
--    -- Expected Error: ORA-20044: Marks obtained cannot exceed maximum marks
--    ROLLBACK;
-- ============================================================================

CREATE OR REPLACE TRIGGER trg_validate_result
BEFORE INSERT OR UPDATE ON result
FOR EACH ROW
BEGIN
    -- 1. Validate examination type
    IF :NEW.exam_type NOT IN ('INTERNAL_1', 'INTERNAL_2', 'MIDTERM', 'ENDSEM') OR :NEW.exam_type IS NULL THEN
        RAISE_APPLICATION_ERROR(
            -20041,
            'Invalid examination type: ' || NVL(:NEW.exam_type, 'NULL') ||
            '. Allowed exam types are INTERNAL_1, INTERNAL_2, MIDTERM, ENDSEM.'
        );
    END IF;

    -- 2. Validate maximum marks is strictly positive
    IF :NEW.max_marks <= 0 THEN
        RAISE_APPLICATION_ERROR(
            -20042,
            'Maximum marks must be strictly greater than zero. Provided: ' || :NEW.max_marks || '.'
        );
    END IF;

    -- 3. Validate marks obtained is non-negative
    IF :NEW.marks < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20043,
            'Marks obtained cannot be negative. Provided: ' || :NEW.marks || '.'
        );
    END IF;

    -- 4. Validate marks obtained does not exceed maximum marks
    IF :NEW.marks > :NEW.max_marks THEN
        RAISE_APPLICATION_ERROR(
            -20044,
            'Marks obtained (' || :NEW.marks || ') cannot exceed maximum marks (' || :NEW.max_marks || ').'
        );
    END IF;
END trg_validate_result;
/

SHOW ERRORS TRIGGER trg_validate_result;
