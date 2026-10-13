-- ============================================================================
-- College Management System - Explicit Cursor: Student Attendance Report
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/C01_student_attendance_report.sql
-- Description     : Uses an explicit cursor to display all students currently
--                   ENROLLED in a specified course offering along with their
--                   attendance percentage computed via GET_ATTENDANCE_PERCENTAGE.
--
-- Input Substitution Variables:
--   course_code   : Course code identifier (e.g., 'CS101')
--   academic_year : Academic year (e.g., 2026)
--   semester      : Term identifier ('Fall', 'Winter', 'Summer')
--
-- ============================================================================
-- HOW TO RUN AND TEST
-- ============================================================================
-- 1. Execution via Pre-defined Variables (Recommended):
--      DEFINE course_code = 'CS101';
--      DEFINE academic_year = 2026;
--      DEFINE semester = 'Fall';
--      @plsql/C01_student_attendance_report.sql
--
-- 2. Interactive Execution:
--      @plsql/C01_student_attendance_report.sql
--      (When prompted, enter course_code, academic_year, and semester.
--       You may press ENTER to use default values: CS101, 2026, Fall)
--
-- 3. Expected Test Outcomes:
--
--    -- Test Case 1: Active offering with ENROLLED students (CS101 2026 Fall)
--    DEFINE course_code = 'CS101';
--    DEFINE academic_year = 2026;
--    DEFINE semester = 'Fall';
--    @plsql/C01_student_attendance_report.sql
--    -- Output: Lists STU003 and STU006 (status ENROLLED), total processed = 2
--
--    -- Test Case 2: Past offering with COMPLETED students (CS101 2025 Fall)
--    DEFINE course_code = 'CS101';
--    DEFINE academic_year = 2025;
--    DEFINE semester = 'Fall';
--    @plsql/C01_student_attendance_report.sql
--    -- Output: Explains no ENROLLED students exist because 2025 enrollments
--    --         are archived with status COMPLETED (STU001, STU002, STU004).
-- ============================================================================

SET SERVEROUTPUT ON SIZE 1000000
SET DEFINE ON
SET VERIFY OFF
SET FEEDBACK OFF

DECLARE
    -- Capture substitution variables using Q-quote syntax to safely prevent
    -- syntax errors when users type quotes, extra spaces, or empty values.
    v_input_course  VARCHAR2(100) := q'[&course_code]';
    v_input_year    VARCHAR2(100) := q'[&academic_year]';
    v_input_sem     VARCHAR2(100) := q'[&semester]';

    v_course_code   course_offering.course_code%TYPE;
    v_academic_year course_offering.academic_year%TYPE;
    v_semester      course_offering.semester%TYPE;

    v_offering_exists NUMBER := 0;
    v_completed_count NUMBER := 0;
    v_dropped_count   NUMBER := 0;

    -- Explicit cursor querying ENROLLED students for the target offering
    CURSOR c_enrolled_students (
        p_course course_offering.course_code%TYPE,
        p_year   course_offering.academic_year%TYPE,
        p_sem    course_offering.semester%TYPE
    ) IS
        SELECT e.reg_no,
               s.first_name || ' ' || s.last_name AS full_name,
               e.enrollment_date
        FROM enrollment e
        JOIN student s ON e.reg_no = s.reg_no
        WHERE e.course_code = p_course
          AND e.academic_year = p_year
          AND e.semester = p_sem
          AND e.status = 'ENROLLED'
        ORDER BY e.reg_no;

    -- Local fetch variables
    v_reg_no          student.reg_no%TYPE;
    v_full_name       VARCHAR2(101);
    v_enrollment_date DATE;
    v_attendance_pct  NUMBER;
    v_student_count   PLS_INTEGER := 0;

BEGIN
    -- Strip surrounding single/double quotes and whitespace
    v_input_course := TRIM(BOTH '''' FROM TRIM(BOTH '"' FROM TRIM(v_input_course)));
    v_input_year   := TRIM(BOTH '''' FROM TRIM(BOTH '"' FROM TRIM(v_input_year)));
    v_input_sem    := TRIM(BOTH '''' FROM TRIM(BOTH '"' FROM TRIM(v_input_sem)));

    -- Default fallback values if user submitted blank/empty inputs
    IF v_input_course IS NULL THEN
        v_input_course := 'CS101';
    END IF;
    IF v_input_year IS NULL THEN
        v_input_year := '2026';
    END IF;
    IF v_input_sem IS NULL THEN
        v_input_sem := 'Fall';
    END IF;

    v_course_code   := UPPER(v_input_course);
    v_academic_year := TO_NUMBER(v_input_year);
    v_semester      := INITCAP(v_input_sem);

    -- Report Header
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    DBMS_OUTPUT.PUT_LINE('STUDENT ATTENDANCE REPORT (CURRENTLY ENROLLED)');
    DBMS_OUTPUT.PUT_LINE('Course Offering : ' || v_course_code || ' (' || v_academic_year || ' ' || v_semester || ')');
    DBMS_OUTPUT.PUT_LINE('Generated On    : ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('================================================================================');

    -- Validate offering existence
    SELECT COUNT(*)
    INTO v_offering_exists
    FROM course_offering
    WHERE course_code = v_course_code
      AND academic_year = v_academic_year
      AND semester = v_semester;

    IF v_offering_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Offering ' || v_course_code || ' (' || v_academic_year || ' ' || v_semester || ') does not exist in COURSE_OFFERING.');
        DBMS_OUTPUT.PUT_LINE('Please verify course code, academic year (2025/2026), and semester (Fall).');
        DBMS_OUTPUT.PUT_LINE('================================================================================');
        RETURN;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        RPAD('Reg No', 12) ||
        RPAD('Student Name', 28) ||
        RPAD('Enrolled Date', 16) ||
        LPAD('Attendance %', 14)
    );
    DBMS_OUTPUT.PUT_LINE(
        RPAD('-', 12, '-') || ' ' ||
        RPAD('-', 27, '-') || ' ' ||
        RPAD('-', 15, '-') || ' ' ||
        LPAD('-', 14, '-')
    );

    -- Open, fetch, and process cursor records
    OPEN c_enrolled_students(v_course_code, v_academic_year, v_semester);
    LOOP
        FETCH c_enrolled_students INTO v_reg_no, v_full_name, v_enrollment_date;
        EXIT WHEN c_enrolled_students%NOTFOUND;

        v_student_count := v_student_count + 1;

        -- Compute attendance rate using stored function
        v_attendance_pct := get_attendance_percentage(
            p_reg_no        => v_reg_no,
            p_course_code   => v_course_code,
            p_academic_year => v_academic_year,
            p_semester      => v_semester
        );

        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_reg_no, 12) ||
            RPAD(v_full_name, 28) ||
            RPAD(TO_CHAR(v_enrollment_date, 'YYYY-MM-DD'), 16) ||
            LPAD(TO_CHAR(v_attendance_pct, '990.99') || '%', 14)
        );
    END LOOP;
    CLOSE c_enrolled_students;

    -- Summary Footer
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
    IF v_student_count = 0 THEN
        -- Check if students exist with COMPLETED or DROPPED status in this offering
        SELECT COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END),
               COUNT(CASE WHEN status = 'DROPPED' THEN 1 END)
        INTO v_completed_count, v_dropped_count
        FROM enrollment
        WHERE course_code = v_course_code
          AND academic_year = v_academic_year
          AND semester = v_semester;

        DBMS_OUTPUT.PUT_LINE('No currently ENROLLED students found for offering ' ||
                             v_course_code || ' (' || v_academic_year || ' ' || v_semester || ').');
        IF v_completed_count > 0 OR v_dropped_count > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Note: This offering has ' || v_completed_count ||
                                 ' COMPLETED and ' || v_dropped_count || ' DROPPED enrollment(s).');
            DBMS_OUTPUT.PUT_LINE('      Active ENROLLED students are in academic year 2026 (e.g. CS101 2026 Fall).');
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total ENROLLED students processed: ' || v_student_count);
    END IF;
    DBMS_OUTPUT.PUT_LINE('================================================================================');

EXCEPTION
    WHEN OTHERS THEN
        IF c_enrolled_students%ISOPEN THEN
            CLOSE c_enrolled_students;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Error executing attendance report: ' || SQLERRM);
        RAISE;
END;
/

-- Reset substitution variables to prevent state bleed into subsequent scripts
UNDEFINE course_code academic_year semester;

SET FEEDBACK ON
SET VERIFY ON
