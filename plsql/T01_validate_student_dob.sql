-- ============================================================================
-- College Management System - Trigger: TRG_VALIDATE_STUDENT
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/T01_validate_student_dob.sql
-- Description     : Row-level BEFORE INSERT OR UPDATE OF dob trigger on STUDENT.
--                   Enforces that a student's date of birth (DOB) is strictly in
--                   the past (cannot be today or in the future).
--
-- Business Rules:
--   - Rejects any DOB where dob >= TRUNC(SYSDATE).
--   - Raises application error -20031 with a clear descriptive message.
--   - Keeps table constraints independent while enforcing runtime temporal validation.
--
-- ============================================================================
-- HOW TO COMPILE & TEST
-- ============================================================================
-- 1. Compilation in SQL*Plus:
--      @plsql/T01_validate_student_dob.sql
--      SHOW ERRORS TRIGGER trg_validate_student;
--
-- 2. Testing Examples (with ROLLBACK to keep baseline data unchanged):
--
--    -- Test Case 1 (Success - Past DOB):
--    INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
--    VALUES ('STU991', 'Test', 'Student', TO_DATE('2004-05-15', 'YYYY-MM-DD'), 'Male', 'test.valid@college.edu', '9999900001', 2026, 'ACTIVE', 'CS');
--    -- Verification: 1 row created
--    ROLLBACK;
--
--    -- Test Case 2 (Rejection - DOB Today, Expects ORA-20031):
--    INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
--    VALUES ('STU992', 'Test', 'Student', TRUNC(SYSDATE), 'Male', 'test.today@college.edu', '9999900002', 2026, 'ACTIVE', 'CS');
--    -- Expected Error: ORA-20031: Student date of birth must be strictly prior to current date
--
--    -- Test Case 3 (Rejection - Future DOB, Expects ORA-20031):
--    INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
--    VALUES ('STU993', 'Test', 'Student', TRUNC(SYSDATE) + 1, 'Male', 'test.future@college.edu', '9999900003', 2026, 'ACTIVE', 'CS');
--    -- Expected Error: ORA-20031: Student date of birth must be strictly prior to current date
--
--    -- Test Case 4 (Rejection - UPDATE setting DOB to future, Expects ORA-20031):
--    UPDATE student SET dob = TRUNC(SYSDATE) + 5 WHERE reg_no = 'STU001';
--    -- Expected Error: ORA-20031: Student date of birth must be strictly prior to current date
--    ROLLBACK;
-- ============================================================================

CREATE OR REPLACE TRIGGER trg_validate_student
BEFORE INSERT OR UPDATE OF dob ON student
FOR EACH ROW
BEGIN
    IF :NEW.dob >= TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(
            -20031,
            'Invalid Date of Birth: ' || TO_CHAR(:NEW.dob, 'YYYY-MM-DD') ||
            '. Student date of birth must be strictly prior to current date (' ||
            TO_CHAR(TRUNC(SYSDATE), 'YYYY-MM-DD') || ').'
        );
    END IF;
END trg_validate_student;
/

SHOW ERRORS TRIGGER trg_validate_student;
