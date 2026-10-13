-- ============================================================================
-- College Management System - Explicit Cursor: Student Attendance Report
-- Target Database : Oracle Database 11g XE (11.2.0.2.0)
-- Script          : plsql/C01_student_attendance_report.sql
-- Description     : Uses an explicit cursor to display all students currently
--                   ENROLLED in a specified course offering along with their
--                   attendance percentage computed via GET_ATTENDANCE_PERCENTAGE.
--
-- Input Substitution Variables:
--   &course_code   : Course code identifier (e.g., 'CS101')
--   &academic_year : Academic year (e.g., 2026)
--   &semester      : Term identifier ('Fall', 'Winter', 'Summer')
--
-- Execution Examples in SQL*Plus:
--   Option A (Interactive Prompt):
--     @plsql/C01_student_attendance_report.sql
--     (SQL*Plus will prompt for course_code, academic_year, and semester)
--
--   Option B (Pre-defined Variables):
--     DEFINE course_code = 'CS101';
--     DEFINE academic_year = 2026;
--     DEFINE semester = 'Fall';
--     @plsql/C01_student_attendance_report.sql
-- ============================================================================

SET SERVEROUTPUT ON SIZE 1000000
SET VERIFY OFF
SET FEEDBACK OFF

DECLARE
    v_course_code   course_offering.course_code%TYPE   := UPPER('&course_code');
    v_academic_year course_offering.academic_year%TYPE := &academic_year;
    v_semester      course_offering.semester%TYPE      := INITCAP('&semester');

    -- Explicit cursor querying ENROLLED students for the target offering
    CURSOR c_enrolled_students IS
        SELECT e.reg_no,
               s.first_name || ' ' || s.last_name AS full_name,
               e.enrollment_date
        FROM enrollment e
        JOIN student s ON e.reg_no = s.reg_no
        WHERE e.course_code = v_course_code
          AND e.academic_year = v_academic_year
          AND e.semester = v_semester
          AND e.status = 'ENROLLED'
        ORDER BY e.reg_no;

    -- Local fetch variables
    v_reg_no          student.reg_no%TYPE;
    v_full_name       VARCHAR2(101);
    v_enrollment_date DATE;
    v_attendance_pct  NUMBER;
    v_student_count   PLS_INTEGER := 0;

BEGIN
    -- Report Header
    DBMS_OUTPUT.PUT_LINE('================================================================================');
    DBMS_OUTPUT.PUT_LINE('STUDENT ATTENDANCE REPORT (CURRENTLY ENROLLED)');
    DBMS_OUTPUT.PUT_LINE('Course Offering : ' || v_course_code || ' (' || v_academic_year || ' ' || v_semester || ')');
    DBMS_OUTPUT.PUT_LINE('Generated On    : ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('================================================================================');
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
    OPEN c_enrolled_students;
    LOOP
        FETCH c_enrolled_students INTO v_reg_no, v_full_name, v_enrollment_date;
        EXIT WHEN c_enrolled_students%NOTFOUND;

        v_student_count := v_student_count + 1;

        -- Compute attendance rate using the stored function
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
        DBMS_OUTPUT.PUT_LINE('No currently ENROLLED students found for offering ' ||
                             v_course_code || ' (' || v_academic_year || ' ' || v_semester || ').');
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

SET FEEDBACK ON
SET VERIFY ON
