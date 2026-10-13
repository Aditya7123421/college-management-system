-- College Management System - Initial Database Schema
-- Description     : Creates tables and constraints for the College Management System.
--
-- Table Creation & Dependency Order:
--   1. DEPARTMENT      (Base table; created without HOD foreign key to break cycle)
--   2. FACULTY         (References DEPARTMENT via dept_code)
--      [ALTER TABLE DEPARTMENT: Add foreign key fk_department_hod referencing FACULTY]
--   3. STUDENT         (References DEPARTMENT via dept_code)
--   4. COURSE          (References DEPARTMENT via dept_code)
--   5. COURSE_OFFERING (Composite PK; references COURSE and FACULTY)
--   6. ENROLLMENT      (Composite PK; references STUDENT and COURSE_OFFERING)
--   7. ATTENDANCE      (Composite PK; references ENROLLMENT with ON DELETE CASCADE)
--   8. RESULT          (Composite PK; references ENROLLMENT with ON DELETE CASCADE)

CREATE TABLE department (
    dept_code       VARCHAR2(10),
    dept_name       VARCHAR2(100) NOT NULL,
    office_location VARCHAR2(100) NOT NULL,
    hod_emp_id      VARCHAR2(10),
    CONSTRAINT pk_department PRIMARY KEY (dept_code),
    CONSTRAINT uq_department_dept_name UNIQUE (dept_name)
);

CREATE TABLE faculty (
    emp_id       VARCHAR2(10),
    first_name   VARCHAR2(50)  NOT NULL,
    last_name    VARCHAR2(50)  NOT NULL,
    email        VARCHAR2(150) NOT NULL,
    phone        VARCHAR2(15)  NOT NULL,
    designation  VARCHAR2(30)  NOT NULL,
    hire_date    DATE          NOT NULL,
    dept_code    VARCHAR2(10)  NOT NULL,
    CONSTRAINT pk_faculty PRIMARY KEY (emp_id),
    CONSTRAINT uq_faculty_email UNIQUE (email),
    CONSTRAINT uq_faculty_phone UNIQUE (phone),
    CONSTRAINT fk_faculty_department FOREIGN KEY (dept_code) 
        REFERENCES department (dept_code),
    CONSTRAINT chk_faculty_designation CHECK (
        designation IN ('Professor', 'Associate Professor', 'Assistant Professor', 'Lecturer')
    )
);

ALTER TABLE department
    ADD CONSTRAINT fk_department_hod FOREIGN KEY (hod_emp_id)
        REFERENCES faculty (emp_id);


CREATE TABLE student (
    reg_no         VARCHAR2(15),
    first_name     VARCHAR2(50)  NOT NULL,
    last_name      VARCHAR2(50)  NOT NULL,
    dob            DATE          NOT NULL,
    gender         VARCHAR2(10)  NOT NULL,
    email          VARCHAR2(150) NOT NULL,
    phone          VARCHAR2(15)  NOT NULL,
    admission_year NUMBER(4)     NOT NULL,
    status         VARCHAR2(15)  DEFAULT 'ACTIVE' NOT NULL,
    dept_code      VARCHAR2(10)  NOT NULL,
    CONSTRAINT pk_student PRIMARY KEY (reg_no),
    CONSTRAINT uq_student_email UNIQUE (email),
    CONSTRAINT uq_student_phone UNIQUE (phone),
    CONSTRAINT fk_student_department FOREIGN KEY (dept_code) 
        REFERENCES department (dept_code),
    CONSTRAINT chk_student_gender CHECK (
        gender IN ('Male', 'Female', 'Other')
    ),
    CONSTRAINT chk_student_status CHECK (
        status IN ('ACTIVE', 'INACTIVE', 'GRADUATED')
    ),
    CONSTRAINT chk_student_admission_year CHECK (
        admission_year BETWEEN 2000 AND 2100
    )
);

CREATE TABLE course (
    course_code VARCHAR2(10),
    course_name VARCHAR2(100) NOT NULL,
    credits     NUMBER(2)     NOT NULL,
    dept_code   VARCHAR2(10)  NOT NULL,
    CONSTRAINT pk_course PRIMARY KEY (course_code),
    CONSTRAINT fk_course_department FOREIGN KEY (dept_code) 
        REFERENCES department (dept_code),
    CONSTRAINT chk_course_credits CHECK (
        credits > 0
    )
);

CREATE TABLE course_offering (
    course_code   VARCHAR2(10),
    academic_year NUMBER(4),
    semester      VARCHAR2(10),
    emp_id        VARCHAR2(10) NOT NULL,
    max_seats     NUMBER(3)    NOT NULL,
    CONSTRAINT pk_course_offering PRIMARY KEY (course_code, academic_year, semester),
    CONSTRAINT fk_offering_course FOREIGN KEY (course_code) 
        REFERENCES course (course_code),
    CONSTRAINT fk_offering_faculty FOREIGN KEY (emp_id) 
        REFERENCES faculty (emp_id),
    CONSTRAINT chk_offering_semester CHECK (
        semester IN ('Winter', 'Summer', 'Fall')
    ),
    CONSTRAINT chk_offering_academic_year CHECK (
        academic_year BETWEEN 2000 AND 2100
    ),
    CONSTRAINT chk_offering_max_seats CHECK (
        max_seats > 0
    )
);


CREATE TABLE enrollment (
    reg_no          VARCHAR2(15),
    course_code     VARCHAR2(10),
    academic_year   NUMBER(4),
    semester        VARCHAR2(10),
    enrollment_date DATE         DEFAULT SYSDATE NOT NULL,
    status          VARCHAR2(15) DEFAULT 'ENROLLED' NOT NULL,
    CONSTRAINT pk_enrollment PRIMARY KEY (reg_no, course_code, academic_year, semester),
    CONSTRAINT fk_enrollment_student FOREIGN KEY (reg_no) 
        REFERENCES student (reg_no),
    CONSTRAINT fk_enrollment_offering FOREIGN KEY (course_code, academic_year, semester) 
        REFERENCES course_offering (course_code, academic_year, semester),
    CONSTRAINT chk_enrollment_status CHECK (
        status IN ('ENROLLED', 'DROPPED', 'COMPLETED')
    )
);

CREATE TABLE attendance (
    reg_no          VARCHAR2(15),
    course_code     VARCHAR2(10),
    academic_year   NUMBER(4),
    semester        VARCHAR2(10),
    attendance_date DATE,
    status          VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_attendance PRIMARY KEY (reg_no, course_code, academic_year, semester, attendance_date),
    CONSTRAINT fk_attendance_enrollment FOREIGN KEY (reg_no, course_code, academic_year, semester) 
        REFERENCES enrollment (reg_no, course_code, academic_year, semester) 
        ON DELETE CASCADE,
    CONSTRAINT chk_attendance_status CHECK (
        status IN ('PRESENT', 'ABSENT', 'LATE')
    )
);

CREATE TABLE result (
    reg_no        VARCHAR2(15),
    course_code   VARCHAR2(10),
    academic_year NUMBER(4),
    semester      VARCHAR2(10),
    exam_type     VARCHAR2(15),
    exam_date     DATE         NOT NULL,
    marks         NUMBER(5,2)  NOT NULL,
    max_marks     NUMBER(5,2)  NOT NULL,
    CONSTRAINT pk_result PRIMARY KEY (reg_no, course_code, academic_year, semester, exam_type),
    CONSTRAINT fk_result_enrollment FOREIGN KEY (reg_no, course_code, academic_year, semester) 
        REFERENCES enrollment (reg_no, course_code, academic_year, semester) 
        ON DELETE CASCADE,
    CONSTRAINT chk_result_exam_type CHECK (
        exam_type IN ('INTERNAL_1', 'INTERNAL_2', 'MIDTERM', 'ENDSEM')
    ),
    CONSTRAINT chk_result_marks_min CHECK (
        marks >= 0
    ),
    CONSTRAINT chk_result_max_marks_min CHECK (
        max_marks > 0
    ),
    CONSTRAINT chk_result_marks_le_max CHECK (
        marks <= max_marks
    )
);
