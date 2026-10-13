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
