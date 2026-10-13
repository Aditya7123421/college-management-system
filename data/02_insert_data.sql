-- Insertion & Dependency Order:
--   1. DEPARTMENT      (Initial insert with hod_emp_id = NULL)
--   2. FACULTY         (20 faculty members, 2 per department)
--   3. DEPARTMENT HOD  (UPDATE department with valid hod_emp_id)
--   4. STUDENT         (30 students, 3 per department)
--   5. COURSE          (10 courses, 1 per department)
--   6. COURSE_OFFERING (20 offerings across academic years 2025 and 2026)
--   7. ENROLLMENT      (46 enrollments: ENROLLED, COMPLETED, DROPPED)
--   8. ATTENDANCE      (115 records: PRESENT, ABSENT, LATE)
--   9. RESULT          (62 records: INTERNAL_1, INTERNAL_2, MIDTERM, ENDSEM)
--  10. COMMIT & Row Count Verification

--DEPARTMENT (10 rows)

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('CS', 'Department of Computer Science', 'Tech Block A, Room 101', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('IT', 'Department of Information Technology', 'Tech Block A, Room 201', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('ECE', 'Department of Electronics and Communication', 'Engineering Block B, Room 101', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('EEE', 'Department of Electrical and Electronics', 'Engineering Block B, Room 201', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('MECH', 'Department of Mechanical Engineering', 'Mechanical Block C, Room 101', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('CIVIL', 'Department of Civil Engineering', 'Civil Block C, Room 201', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('CHEM', 'Department of Chemical Engineering', 'Science Block D, Room 101', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('BIOTECH', 'Department of Biotechnology', 'Life Sciences Block D, Room 201', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('MATH', 'Department of Mathematics', 'Basic Sciences Block E, Room 101', NULL);

INSERT INTO department (dept_code, dept_name, office_location, hod_emp_id)
VALUES ('PHYS', 'Department of Physics', 'Basic Sciences Block E, Room 201', NULL);

-- FACULTY (20 rows - 2 per department)
-- CS Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC001', 'Alan', 'Turing', 'alan.turing@college.edu', '9876543201', 'Professor', TO_DATE('2015-08-01', 'YYYY-MM-DD'), 'CS');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC002', 'Grace', 'Hopper', 'grace.hopper@college.edu', '9876543202', 'Associate Professor', TO_DATE('2017-01-15', 'YYYY-MM-DD'), 'CS');

-- IT Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC003', 'Tim', 'Berners-Lee', 'tim.bernerslee@college.edu', '9876543203', 'Professor', TO_DATE('2016-07-01', 'YYYY-MM-DD'), 'IT');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC004', 'Ada', 'Lovelace', 'ada.lovelace@college.edu', '9876543204', 'Assistant Professor', TO_DATE('2019-08-20', 'YYYY-MM-DD'), 'IT');

-- ECE Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC005', 'Claude', 'Shannon', 'claude.shannon@college.edu', '9876543205', 'Professor', TO_DATE('2014-06-15', 'YYYY-MM-DD'), 'ECE');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC006', 'John', 'Bardeen', 'john.bardeen@college.edu', '9876543206', 'Associate Professor', TO_DATE('2018-09-01', 'YYYY-MM-DD'), 'ECE');

-- EEE Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC007', 'Nikola', 'Tesla', 'nikola.tesla@college.edu', '9876543207', 'Professor', TO_DATE('2015-01-10', 'YYYY-MM-DD'), 'EEE');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC008', 'Michael', 'Faraday', 'michael.faraday@college.edu', '9876543208', 'Assistant Professor', TO_DATE('2020-02-15', 'YYYY-MM-DD'), 'EEE');

-- MECH Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC009', 'James', 'Watt', 'james.watt@college.edu', '9876543209', 'Professor', TO_DATE('2013-11-01', 'YYYY-MM-DD'), 'MECH');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC010', 'Rudolf', 'Diesel', 'rudolf.diesel@college.edu', '9876543210', 'Lecturer', TO_DATE('2021-08-01', 'YYYY-MM-DD'), 'MECH');

-- CIVIL Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC011', 'Gustave', 'Eiffel', 'gustave.eiffel@college.edu', '9876543211', 'Professor', TO_DATE('2014-03-01', 'YYYY-MM-DD'), 'CIVIL');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC012', 'Isambard', 'Brunel', 'isambard.brunel@college.edu', '9876543212', 'Associate Professor', TO_DATE('2017-10-15', 'YYYY-MM-DD'), 'CIVIL');

-- CHEM Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC013', 'Marie', 'Curie', 'marie.curie@college.edu', '9876543213', 'Professor', TO_DATE('2012-05-01', 'YYYY-MM-DD'), 'CHEM');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC014', 'Dmitri', 'Mendeleev', 'dmitri.mendeleev@college.edu', '9876543214', 'Assistant Professor', TO_DATE('2019-01-10', 'YYYY-MM-DD'), 'CHEM');

-- BIOTECH Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC015', 'Rosalind', 'Franklin', 'rosalind.franklin@college.edu', '9876543215', 'Professor', TO_DATE('2016-04-15', 'YYYY-MM-DD'), 'BIOTECH');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC016', 'Gregor', 'Mendel', 'gregor.mendel@college.edu', '9876543216', 'Associate Professor', TO_DATE('2018-07-01', 'YYYY-MM-DD'), 'BIOTECH');

-- MATH Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC017', 'Carl', 'Gauss', 'carl.gauss@college.edu', '9876543217', 'Professor', TO_DATE('2011-09-01', 'YYYY-MM-DD'), 'MATH');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC018', 'Leonhard', 'Euler', 'leonhard.euler@college.edu', '9876543218', 'Lecturer', TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'MATH');

-- PHYS Faculty
INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC019', 'Albert', 'Einstein', 'albert.einstein@college.edu', '9876543219', 'Professor', TO_DATE('2010-08-01', 'YYYY-MM-DD'), 'PHYS');

INSERT INTO faculty (emp_id, first_name, last_name, email, phone, designation, hire_date, dept_code)
VALUES ('FAC020', 'Niels', 'Bohr', 'niels.bohr@college.edu', '9876543220', 'Associate Professor', TO_DATE('2016-12-01', 'YYYY-MM-DD'), 'PHYS');


-- 3. Assign Valid HODs to DEPARTMENT

UPDATE department SET hod_emp_id = 'FAC001' WHERE dept_code = 'CS';
UPDATE department SET hod_emp_id = 'FAC003' WHERE dept_code = 'IT';
UPDATE department SET hod_emp_id = 'FAC005' WHERE dept_code = 'ECE';
UPDATE department SET hod_emp_id = 'FAC007' WHERE dept_code = 'EEE';
UPDATE department SET hod_emp_id = 'FAC009' WHERE dept_code = 'MECH';
UPDATE department SET hod_emp_id = 'FAC011' WHERE dept_code = 'CIVIL';
UPDATE department SET hod_emp_id = 'FAC013' WHERE dept_code = 'CHEM';
UPDATE department SET hod_emp_id = 'FAC015' WHERE dept_code = 'BIOTECH';
UPDATE department SET hod_emp_id = 'FAC017' WHERE dept_code = 'MATH';
UPDATE department SET hod_emp_id = 'FAC019' WHERE dept_code = 'PHYS';



-- 4. STUDENT (30 rows - 3 per department)

-- CS Students (ACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU001', 'John', 'Doe', TO_DATE('2004-05-12', 'YYYY-MM-DD'), 'Male', 'john.doe@student.college.edu', '9811100001', 2022, 'ACTIVE', 'CS');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU002', 'Jane', 'Smith', TO_DATE('2004-09-18', 'YYYY-MM-DD'), 'Female', 'jane.smith@student.college.edu', '9811100002', 2022, 'ACTIVE', 'CS');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU003', 'Alex', 'Taylor', TO_DATE('2005-03-22', 'YYYY-MM-DD'), 'Other', 'alex.taylor@student.college.edu', '9811100003', 2023, 'ACTIVE', 'CS');

-- IT Students (ACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU004', 'David', 'Miller', TO_DATE('2003-11-05', 'YYYY-MM-DD'), 'Male', 'david.miller@student.college.edu', '9811100004', 2022, 'ACTIVE', 'IT');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU005', 'Emily', 'Davis', TO_DATE('2004-02-14', 'YYYY-MM-DD'), 'Female', 'emily.davis@student.college.edu', '9811100005', 2022, 'ACTIVE', 'IT');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU006', 'Jordan', 'Lee', TO_DATE('2005-07-30', 'YYYY-MM-DD'), 'Other', 'jordan.lee@student.college.edu', '9811100006', 2023, 'ACTIVE', 'IT');

-- ECE Students (ACTIVE, INACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU007', 'Michael', 'Brown', TO_DATE('2004-04-10', 'YYYY-MM-DD'), 'Male', 'michael.brown@student.college.edu', '9811100007', 2022, 'ACTIVE', 'ECE');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU008', 'Sarah', 'Wilson', TO_DATE('2004-12-01', 'YYYY-MM-DD'), 'Female', 'sarah.wilson@student.college.edu', '9811100008', 2022, 'ACTIVE', 'ECE');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU009', 'Chris', 'Evans', TO_DATE('2003-08-19', 'YYYY-MM-DD'), 'Male', 'chris.evans@student.college.edu', '9811100009', 2021, 'INACTIVE', 'ECE');

-- EEE Students (ACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU010', 'Robert', 'Johnson', TO_DATE('2004-06-25', 'YYYY-MM-DD'), 'Male', 'robert.johnson@student.college.edu', '9811100010', 2022, 'ACTIVE', 'EEE');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU011', 'Jessica', 'White', TO_DATE('2004-10-11', 'YYYY-MM-DD'), 'Female', 'jessica.white@student.college.edu', '9811100011', 2022, 'ACTIVE', 'EEE');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU012', 'Sam', 'Harris', TO_DATE('2005-01-15', 'YYYY-MM-DD'), 'Other', 'sam.harris@student.college.edu', '9811100012', 2023, 'ACTIVE', 'EEE');

-- MECH Students (ACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU013', 'William', 'Clark', TO_DATE('2003-03-17', 'YYYY-MM-DD'), 'Male', 'william.clark@student.college.edu', '9811100013', 2022, 'ACTIVE', 'MECH');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU014', 'Olivia', 'Martin', TO_DATE('2004-08-08', 'YYYY-MM-DD'), 'Female', 'olivia.martin@student.college.edu', '9811100014', 2022, 'ACTIVE', 'MECH');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU015', 'Daniel', 'Lewis', TO_DATE('2005-05-20', 'YYYY-MM-DD'), 'Male', 'daniel.lewis@student.college.edu', '9811100015', 2023, 'ACTIVE', 'MECH');

-- CIVIL Students (ACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU016', 'James', 'Walker', TO_DATE('2004-01-28', 'YYYY-MM-DD'), 'Male', 'james.walker@student.college.edu', '9811100016', 2022, 'ACTIVE', 'CIVIL');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU017', 'Sophia', 'Hall', TO_DATE('2004-07-19', 'YYYY-MM-DD'), 'Female', 'sophia.hall@student.college.edu', '9811100017', 2022, 'ACTIVE', 'CIVIL');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU018', 'Benjamin', 'Allen', TO_DATE('2005-09-03', 'YYYY-MM-DD'), 'Male', 'benjamin.allen@student.college.edu', '9811100018', 2023, 'ACTIVE', 'CIVIL');

-- CHEM Students (ACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU019', 'Lucas', 'Young', TO_DATE('2004-03-31', 'YYYY-MM-DD'), 'Male', 'lucas.young@student.college.edu', '9811100019', 2022, 'ACTIVE', 'CHEM');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU020', 'Chloe', 'King', TO_DATE('2004-11-23', 'YYYY-MM-DD'), 'Female', 'chloe.king@student.college.edu', '9811100020', 2022, 'ACTIVE', 'CHEM');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU021', 'Henry', 'Wright', TO_DATE('2005-04-14', 'YYYY-MM-DD'), 'Male', 'henry.wright@student.college.edu', '9811100021', 2023, 'ACTIVE', 'CHEM');

-- BIOTECH Students (ACTIVE, GRADUATED)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU022', 'Ethan', 'Scott', TO_DATE('2004-06-09', 'YYYY-MM-DD'), 'Male', 'ethan.scott@student.college.edu', '9811100022', 2022, 'ACTIVE', 'BIOTECH');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU023', 'Mia', 'Green', TO_DATE('2004-12-28', 'YYYY-MM-DD'), 'Female', 'mia.green@student.college.edu', '9811100023', 2022, 'ACTIVE', 'BIOTECH');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU024', 'Harper', 'Adams', TO_DATE('2001-09-15', 'YYYY-MM-DD'), 'Female', 'harper.adams@student.college.edu', '9811100024', 2020, 'GRADUATED', 'BIOTECH');

-- MATH Students (ACTIVE)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU025', 'Alexander', 'Baker', TO_DATE('2004-02-18', 'YYYY-MM-DD'), 'Male', 'alexander.baker@student.college.edu', '9811100025', 2022, 'ACTIVE', 'MATH');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU026', 'Ava', 'Gonzalez', TO_DATE('2004-08-25', 'YYYY-MM-DD'), 'Female', 'ava.gonzalez@student.college.edu', '9811100026', 2022, 'ACTIVE', 'MATH');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU027', 'Morgan', 'Nelson', TO_DATE('2005-10-12', 'YYYY-MM-DD'), 'Other', 'morgan.nelson@student.college.edu', '9811100027', 2023, 'ACTIVE', 'MATH');

-- PHYS Students (INACTIVE and GRADUATED - Zero ACTIVE students to test Query 6)
INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU028', 'Mason', 'Carter', TO_DATE('2003-05-05', 'YYYY-MM-DD'), 'Male', 'mason.carter@student.college.edu', '9811100028', 2021, 'INACTIVE', 'PHYS');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU029', 'Isabella', 'Mitchell', TO_DATE('2001-04-12', 'YYYY-MM-DD'), 'Female', 'isabella.mitchell@student.college.edu', '9811100029', 2020, 'GRADUATED', 'PHYS');

INSERT INTO student (reg_no, first_name, last_name, dob, gender, email, phone, admission_year, status, dept_code)
VALUES ('STU030', 'Logan', 'Perez', TO_DATE('2001-10-30', 'YYYY-MM-DD'), 'Male', 'logan.perez@student.college.edu', '9811100030', 2020, 'GRADUATED', 'PHYS');


-- 5. COURSE (10 rows - 1 per department)

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('CS101', 'Introduction to Computer Science', 4, 'CS');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('IT101', 'Web Development and Internet Systems', 3, 'IT');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('ECE101', 'Digital Electronics and Circuit Design', 4, 'ECE');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('EEE101', 'Electrical Networks and Machines', 4, 'EEE');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('MECH101', 'Engineering Thermodynamics', 3, 'MECH');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('CIVIL101', 'Structural Mechanics', 3, 'CIVIL');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('CHEM101', 'Chemical Process Principles', 3, 'CHEM');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('BIO101', 'Molecular Biology and Genetics', 4, 'BIOTECH');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('MATH101', 'Linear Algebra and Calculus', 4, 'MATH');

INSERT INTO course (course_code, course_name, credits, dept_code)
VALUES ('PHYS101', 'Classical and Quantum Mechanics', 4, 'PHYS');


-- 6. COURSE_OFFERING (20 rows - 2 per course, across 2025 and 2026)

-- CS101 Offerings (2025 capacity reached: max_seats = 3)
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('CS101', 2025, 'Fall', 'FAC001', 3);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('CS101', 2026, 'Fall', 'FAC002', 4);

-- IT101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('IT101', 2025, 'Fall', 'FAC003', 4);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('IT101', 2026, 'Fall', 'FAC004', 5);

-- ECE101 Offerings (2025 capacity reached: max_seats = 2)
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('ECE101', 2025, 'Fall', 'FAC005', 2);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('ECE101', 2026, 'Fall', 'FAC006', 4);

-- EEE101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('EEE101', 2025, 'Fall', 'FAC007', 4);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('EEE101', 2026, 'Fall', 'FAC008', 4);

-- MECH101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('MECH101', 2025, 'Fall', 'FAC009', 4);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('MECH101', 2026, 'Fall', 'FAC010', 4);

-- CIVIL101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('CIVIL101', 2025, 'Fall', 'FAC011', 3);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('CIVIL101', 2026, 'Fall', 'FAC012', 4);

-- CHEM101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('CHEM101', 2025, 'Fall', 'FAC013', 4);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('CHEM101', 2026, 'Fall', 'FAC014', 3);

-- BIO101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('BIO101', 2025, 'Fall', 'FAC015', 4);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('BIO101', 2026, 'Fall', 'FAC016', 4);

-- MATH101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('MATH101', 2025, 'Fall', 'FAC017', 4);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('MATH101', 2026, 'Fall', 'FAC018', 5);

-- PHYS101 Offerings
INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('PHYS101', 2025, 'Fall', 'FAC019', 4);

INSERT INTO course_offering (course_code, academic_year, semester, emp_id, max_seats)
VALUES ('PHYS101', 2026, 'Fall', 'FAC020', 4);


-- 7. ENROLLMENT (46 rows)
-- Statuses: ENROLLED, COMPLETED, DROPPED

-- CS101 (2025 Fall): Capacity 3. Occupied: 3 (STU001, STU002, STU004). Dropped: STU005.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU002', 'CS101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU004', 'CS101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU005', 'CS101', 2025, 'Fall', TO_DATE('2025-07-22', 'YYYY-MM-DD'), 'DROPPED');

-- CS101 (2026 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU003', 'CS101', 2026, 'Fall', TO_DATE('2026-07-15', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU006', 'CS101', 2026, 'Fall', TO_DATE('2026-07-16', 'YYYY-MM-DD'), 'ENROLLED');

-- IT101 (2025 Fall): Capacity 4. Occupied: 3.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU002', 'IT101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU004', 'IT101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU005', 'IT101', 2025, 'Fall', TO_DATE('2025-07-22', 'YYYY-MM-DD'), 'COMPLETED');

-- IT101 (2026 Fall): Capacity 5. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU003', 'IT101', 2026, 'Fall', TO_DATE('2026-07-15', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU006', 'IT101', 2026, 'Fall', TO_DATE('2026-07-16', 'YYYY-MM-DD'), 'ENROLLED');

-- ECE101 (2025 Fall): Capacity 2. Occupied: 2 (STU007, STU008). Reached capacity!
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU007', 'ECE101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU008', 'ECE101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

-- ECE101 (2026 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU007', 'ECE101', 2026, 'Fall', TO_DATE('2026-07-18', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU010', 'ECE101', 2026, 'Fall', TO_DATE('2026-07-19', 'YYYY-MM-DD'), 'ENROLLED');

-- EEE101 (2025 Fall): Capacity 4. Occupied: 3.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU010', 'EEE101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU011', 'EEE101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU012', 'EEE101', 2025, 'Fall', TO_DATE('2025-07-22', 'YYYY-MM-DD'), 'COMPLETED');

-- EEE101 (2026 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU011', 'EEE101', 2026, 'Fall', TO_DATE('2026-07-17', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU012', 'EEE101', 2026, 'Fall', TO_DATE('2026-07-18', 'YYYY-MM-DD'), 'ENROLLED');

-- MECH101 (2025 Fall): Capacity 4. Occupied: 2. Dropped: STU015.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU013', 'MECH101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU014', 'MECH101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU015', 'MECH101', 2025, 'Fall', TO_DATE('2025-07-22', 'YYYY-MM-DD'), 'DROPPED');

-- MECH101 (2026 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU014', 'MECH101', 2026, 'Fall', TO_DATE('2026-07-20', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU015', 'MECH101', 2026, 'Fall', TO_DATE('2026-07-21', 'YYYY-MM-DD'), 'ENROLLED');

-- CIVIL101 (2025 Fall): Capacity 3. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU016', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU017', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

-- CIVIL101 (2026 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU017', 'CIVIL101', 2026, 'Fall', TO_DATE('2026-07-19', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU018', 'CIVIL101', 2026, 'Fall', TO_DATE('2026-07-20', 'YYYY-MM-DD'), 'ENROLLED');

-- CHEM101 (2025 Fall): Capacity 4. Occupied: 3.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU019', 'CHEM101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU020', 'CHEM101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU021', 'CHEM101', 2025, 'Fall', TO_DATE('2025-07-22', 'YYYY-MM-DD'), 'COMPLETED');

-- CHEM101 (2026 Fall): Capacity 3. Occupied: 2. Dropped: STU020.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU019', 'CHEM101', 2026, 'Fall', TO_DATE('2026-07-20', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU021', 'CHEM101', 2026, 'Fall', TO_DATE('2026-07-21', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU020', 'CHEM101', 2026, 'Fall', TO_DATE('2026-07-22', 'YYYY-MM-DD'), 'DROPPED');

-- BIO101 (2025 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU022', 'BIO101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU023', 'BIO101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

-- BIO101 (2026 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU022', 'BIO101', 2026, 'Fall', TO_DATE('2026-07-19', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU023', 'BIO101', 2026, 'Fall', TO_DATE('2026-07-20', 'YYYY-MM-DD'), 'ENROLLED');

-- MATH101 (2025 Fall): Capacity 4. Occupied: 3.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU001', 'MATH101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU025', 'MATH101', 2025, 'Fall', TO_DATE('2025-07-21', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU026', 'MATH101', 2025, 'Fall', TO_DATE('2025-07-22', 'YYYY-MM-DD'), 'COMPLETED');

-- MATH101 (2026 Fall): Capacity 5. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU026', 'MATH101', 2026, 'Fall', TO_DATE('2026-07-18', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU027', 'MATH101', 2026, 'Fall', TO_DATE('2026-07-19', 'YYYY-MM-DD'), 'ENROLLED');

-- PHYS101 (2025 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU010', 'PHYS101', 2025, 'Fall', TO_DATE('2025-07-20', 'YYYY-MM-DD'), 'COMPLETED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU025', 'PHYS101', 2025, 'Fall', TO_DATE('2025-07-22', 'YYYY-MM-DD'), 'COMPLETED');

-- PHYS101 (2026 Fall): Capacity 4. Occupied: 2.
INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU001', 'PHYS101', 2026, 'Fall', TO_DATE('2026-07-20', 'YYYY-MM-DD'), 'ENROLLED');

INSERT INTO enrollment (reg_no, course_code, academic_year, semester, enrollment_date, status)
VALUES ('STU013', 'PHYS101', 2026, 'Fall', TO_DATE('2026-07-21', 'YYYY-MM-DD'), 'ENROLLED');


-- 8. ATTENDANCE (115 rows - 5 sessions across 23 student-offering enrollments)
-- Statuses: PRESENT, ABSENT, LATE

-- CS101 (2025 Fall)
-- STU001 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-08-10', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-08-17', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-08-24', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-08-31', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'CS101', 2025, 'Fall', TO_DATE('2025-09-07', 'YYYY-MM-DD'), 'PRESENT');

-- STU002 (3/5 = 60.0% < 75%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'CS101', 2025, 'Fall', TO_DATE('2025-08-10', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'CS101', 2025, 'Fall', TO_DATE('2025-08-17', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'CS101', 2025, 'Fall', TO_DATE('2025-08-24', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'CS101', 2025, 'Fall', TO_DATE('2025-08-31', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'CS101', 2025, 'Fall', TO_DATE('2025-09-07', 'YYYY-MM-DD'), 'PRESENT');

-- STU004 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'CS101', 2025, 'Fall', TO_DATE('2025-08-10', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'CS101', 2025, 'Fall', TO_DATE('2025-08-17', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'CS101', 2025, 'Fall', TO_DATE('2025-08-24', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'CS101', 2025, 'Fall', TO_DATE('2025-08-31', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'CS101', 2025, 'Fall', TO_DATE('2025-09-07', 'YYYY-MM-DD'), 'PRESENT');

-- IT101 (2025 Fall)
-- STU002 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'IT101', 2025, 'Fall', TO_DATE('2025-08-11', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'IT101', 2025, 'Fall', TO_DATE('2025-08-18', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'IT101', 2025, 'Fall', TO_DATE('2025-08-25', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'IT101', 2025, 'Fall', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU002', 'IT101', 2025, 'Fall', TO_DATE('2025-09-08', 'YYYY-MM-DD'), 'PRESENT');

-- STU004 (4/5 = 80.0%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'IT101', 2025, 'Fall', TO_DATE('2025-08-11', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'IT101', 2025, 'Fall', TO_DATE('2025-08-18', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'IT101', 2025, 'Fall', TO_DATE('2025-08-25', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'IT101', 2025, 'Fall', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU004', 'IT101', 2025, 'Fall', TO_DATE('2025-09-08', 'YYYY-MM-DD'), 'PRESENT');

-- STU005 (2/5 = 40.0% < 75%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU005', 'IT101', 2025, 'Fall', TO_DATE('2025-08-11', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU005', 'IT101', 2025, 'Fall', TO_DATE('2025-08-18', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU005', 'IT101', 2025, 'Fall', TO_DATE('2025-08-25', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU005', 'IT101', 2025, 'Fall', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU005', 'IT101', 2025, 'Fall', TO_DATE('2025-09-08', 'YYYY-MM-DD'), 'ABSENT');

-- ECE101 (2025 Fall)
-- STU007 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU007', 'ECE101', 2025, 'Fall', TO_DATE('2025-08-12', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU007', 'ECE101', 2025, 'Fall', TO_DATE('2025-08-19', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU007', 'ECE101', 2025, 'Fall', TO_DATE('2025-08-26', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU007', 'ECE101', 2025, 'Fall', TO_DATE('2025-09-02', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU007', 'ECE101', 2025, 'Fall', TO_DATE('2025-09-09', 'YYYY-MM-DD'), 'PRESENT');

-- STU008 (3/5 = 60.0% < 75%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU008', 'ECE101', 2025, 'Fall', TO_DATE('2025-08-12', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU008', 'ECE101', 2025, 'Fall', TO_DATE('2025-08-19', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU008', 'ECE101', 2025, 'Fall', TO_DATE('2025-08-26', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU008', 'ECE101', 2025, 'Fall', TO_DATE('2025-09-02', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU008', 'ECE101', 2025, 'Fall', TO_DATE('2025-09-09', 'YYYY-MM-DD'), 'PRESENT');

-- EEE101 (2025 Fall)
-- STU010 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-13', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-20', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-27', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'EEE101', 2025, 'Fall', TO_DATE('2025-09-03', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'EEE101', 2025, 'Fall', TO_DATE('2025-09-10', 'YYYY-MM-DD'), 'LATE');

-- STU011 (2/5 = 40.0% < 75%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU011', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-13', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU011', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-20', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU011', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-27', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU011', 'EEE101', 2025, 'Fall', TO_DATE('2025-09-03', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU011', 'EEE101', 2025, 'Fall', TO_DATE('2025-09-10', 'YYYY-MM-DD'), 'PRESENT');

-- STU012 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU012', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-13', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU012', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-20', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU012', 'EEE101', 2025, 'Fall', TO_DATE('2025-08-27', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU012', 'EEE101', 2025, 'Fall', TO_DATE('2025-09-03', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU012', 'EEE101', 2025, 'Fall', TO_DATE('2025-09-10', 'YYYY-MM-DD'), 'PRESENT');

-- MECH101 (2025 Fall)
-- STU013 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU013', 'MECH101', 2025, 'Fall', TO_DATE('2025-08-14', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU013', 'MECH101', 2025, 'Fall', TO_DATE('2025-08-21', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU013', 'MECH101', 2025, 'Fall', TO_DATE('2025-08-28', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU013', 'MECH101', 2025, 'Fall', TO_DATE('2025-09-04', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU013', 'MECH101', 2025, 'Fall', TO_DATE('2025-09-11', 'YYYY-MM-DD'), 'PRESENT');

-- STU014 (4/5 = 80.0%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU014', 'MECH101', 2025, 'Fall', TO_DATE('2025-08-14', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU014', 'MECH101', 2025, 'Fall', TO_DATE('2025-08-21', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU014', 'MECH101', 2025, 'Fall', TO_DATE('2025-08-28', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU014', 'MECH101', 2025, 'Fall', TO_DATE('2025-09-04', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU014', 'MECH101', 2025, 'Fall', TO_DATE('2025-09-11', 'YYYY-MM-DD'), 'PRESENT');

-- CIVIL101 (2025 Fall)
-- STU016 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU016', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-08-15', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU016', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-08-22', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU016', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-08-29', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU016', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-09-05', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU016', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-09-12', 'YYYY-MM-DD'), 'PRESENT');

-- STU017 (4/5 = 80.0%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU017', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-08-15', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU017', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-08-22', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU017', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-08-29', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU017', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-09-05', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU017', 'CIVIL101', 2025, 'Fall', TO_DATE('2025-09-12', 'YYYY-MM-DD'), 'PRESENT');

-- CHEM101 (2025 Fall)
-- STU019 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU019', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-16', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU019', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-23', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU019', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-30', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU019', 'CHEM101', 2025, 'Fall', TO_DATE('2025-09-06', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU019', 'CHEM101', 2025, 'Fall', TO_DATE('2025-09-13', 'YYYY-MM-DD'), 'LATE');

-- STU020 (4/5 = 80.0%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU020', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-16', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU020', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-23', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU020', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-30', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU020', 'CHEM101', 2025, 'Fall', TO_DATE('2025-09-06', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU020', 'CHEM101', 2025, 'Fall', TO_DATE('2025-09-13', 'YYYY-MM-DD'), 'PRESENT');

-- STU021 (2/5 = 40.0% < 75%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU021', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-16', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU021', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-23', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU021', 'CHEM101', 2025, 'Fall', TO_DATE('2025-08-30', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU021', 'CHEM101', 2025, 'Fall', TO_DATE('2025-09-06', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU021', 'CHEM101', 2025, 'Fall', TO_DATE('2025-09-13', 'YYYY-MM-DD'), 'ABSENT');

-- BIO101 (2025 Fall)
-- STU022 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU022', 'BIO101', 2025, 'Fall', TO_DATE('2025-08-17', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU022', 'BIO101', 2025, 'Fall', TO_DATE('2025-08-24', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU022', 'BIO101', 2025, 'Fall', TO_DATE('2025-08-31', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU022', 'BIO101', 2025, 'Fall', TO_DATE('2025-09-07', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU022', 'BIO101', 2025, 'Fall', TO_DATE('2025-09-14', 'YYYY-MM-DD'), 'PRESENT');

-- STU023 (4/5 = 80.0%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU023', 'BIO101', 2025, 'Fall', TO_DATE('2025-08-17', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU023', 'BIO101', 2025, 'Fall', TO_DATE('2025-08-24', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU023', 'BIO101', 2025, 'Fall', TO_DATE('2025-08-31', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU023', 'BIO101', 2025, 'Fall', TO_DATE('2025-09-07', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU023', 'BIO101', 2025, 'Fall', TO_DATE('2025-09-14', 'YYYY-MM-DD'), 'LATE');

-- MATH101 (2025 Fall)
-- STU001 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'MATH101', 2025, 'Fall', TO_DATE('2025-08-18', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'MATH101', 2025, 'Fall', TO_DATE('2025-08-25', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-08', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU001', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-15', 'YYYY-MM-DD'), 'PRESENT');

-- STU025 (4/5 = 80.0%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'MATH101', 2025, 'Fall', TO_DATE('2025-08-18', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'MATH101', 2025, 'Fall', TO_DATE('2025-08-25', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-08', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-15', 'YYYY-MM-DD'), 'PRESENT');

-- STU026 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU026', 'MATH101', 2025, 'Fall', TO_DATE('2025-08-18', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU026', 'MATH101', 2025, 'Fall', TO_DATE('2025-08-25', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU026', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU026', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-08', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU026', 'MATH101', 2025, 'Fall', TO_DATE('2025-09-15', 'YYYY-MM-DD'), 'PRESENT');

-- PHYS101 (2025 Fall)
-- STU010 (5/5 = 100%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'PHYS101', 2025, 'Fall', TO_DATE('2025-08-19', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'PHYS101', 2025, 'Fall', TO_DATE('2025-08-26', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'PHYS101', 2025, 'Fall', TO_DATE('2025-09-02', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'PHYS101', 2025, 'Fall', TO_DATE('2025-09-09', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU010', 'PHYS101', 2025, 'Fall', TO_DATE('2025-09-16', 'YYYY-MM-DD'), 'PRESENT');

-- STU025 (3/5 = 60.0% < 75%)
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'PHYS101', 2025, 'Fall', TO_DATE('2025-08-19', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'PHYS101', 2025, 'Fall', TO_DATE('2025-08-26', 'YYYY-MM-DD'), 'PRESENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'PHYS101', 2025, 'Fall', TO_DATE('2025-09-02', 'YYYY-MM-DD'), 'LATE');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'PHYS101', 2025, 'Fall', TO_DATE('2025-09-09', 'YYYY-MM-DD'), 'ABSENT');
INSERT INTO attendance (reg_no, course_code, academic_year, semester, attendance_date, status)
VALUES ('STU025', 'PHYS101', 2025, 'Fall', TO_DATE('2025-09-16', 'YYYY-MM-DD'), 'PRESENT');

-- ----------------------------------------------------------------------------
-- 9. RESULT (62 rows)
-- Examination Types: INTERNAL_1, INTERNAL_2, MIDTERM, ENDSEM
-- ----------------------------------------------------------------------------
-- CS101 (2025 Fall)
-- STU001 (Total: 185/200 = 92.50% - Highest performer)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'CS101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-15', 'YYYY-MM-DD'), 23.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'CS101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 24.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'CS101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-05', 'YYYY-MM-DD'), 46.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'CS101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-10', 'YYYY-MM-DD'), 92.00, 100.00);

-- STU002 (Total: 148/200 = 74.00%)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'CS101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-15', 'YYYY-MM-DD'), 19.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'CS101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 18.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'CS101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-05', 'YYYY-MM-DD'), 37.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'CS101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-10', 'YYYY-MM-DD'), 74.00, 100.00);

-- STU004 (Total: 168/200 = 84.00%)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'CS101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-15', 'YYYY-MM-DD'), 21.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'CS101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-15', 'YYYY-MM-DD'), 22.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'CS101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-05', 'YYYY-MM-DD'), 42.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'CS101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-10', 'YYYY-MM-DD'), 83.00, 100.00);

-- IT101 (2025 Fall)
-- STU002 (Total: 173/200 = 86.50%)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'IT101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-16', 'YYYY-MM-DD'), 22.50, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'IT101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-16', 'YYYY-MM-DD'), 21.50, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'IT101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-06', 'YYYY-MM-DD'), 43.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU002', 'IT101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-11', 'YYYY-MM-DD'), 86.00, 100.00);

-- STU004 (Total: 188/200 = 94.00% - Highest performer)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'IT101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-16', 'YYYY-MM-DD'), 23.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'IT101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-16', 'YYYY-MM-DD'), 24.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'IT101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-06', 'YYYY-MM-DD'), 47.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU004', 'IT101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-11', 'YYYY-MM-DD'), 94.00, 100.00);

-- STU005 (Total: 70/100 = 70.00% - Missing ENDSEM)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU005', 'IT101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-16', 'YYYY-MM-DD'), 18.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU005', 'IT101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-16', 'YYYY-MM-DD'), 17.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU005', 'IT101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-06', 'YYYY-MM-DD'), 35.00, 50.00);

-- ECE101 (2025 Fall)
-- STU007 (Total: 176/200 = 88.00% - Tied for rank 1)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU007', 'ECE101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-17', 'YYYY-MM-DD'), 22.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU007', 'ECE101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-17', 'YYYY-MM-DD'), 22.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU007', 'ECE101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-07', 'YYYY-MM-DD'), 44.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU007', 'ECE101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-12', 'YYYY-MM-DD'), 88.00, 100.00);

-- STU008 (Total: 176/200 = 88.00% - Tied for rank 1 to demonstrate RANK() handling ties)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU008', 'ECE101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-17', 'YYYY-MM-DD'), 22.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU008', 'ECE101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-17', 'YYYY-MM-DD'), 22.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU008', 'ECE101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-07', 'YYYY-MM-DD'), 44.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU008', 'ECE101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-12', 'YYYY-MM-DD'), 88.00, 100.00);

-- EEE101 (2025 Fall)
-- STU010 (Total: 182/200 = 91.00% - Highest performer)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU010', 'EEE101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-18', 'YYYY-MM-DD'), 24.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU010', 'EEE101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-18', 'YYYY-MM-DD'), 23.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU010', 'EEE101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-08', 'YYYY-MM-DD'), 45.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU010', 'EEE101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-13', 'YYYY-MM-DD'), 90.00, 100.00);

-- STU011 (Total: 145/200 = 72.50%)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU011', 'EEE101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-18', 'YYYY-MM-DD'), 18.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU011', 'EEE101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-18', 'YYYY-MM-DD'), 19.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU011', 'EEE101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-08', 'YYYY-MM-DD'), 36.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU011', 'EEE101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-13', 'YYYY-MM-DD'), 72.00, 100.00);

-- STU012 (Total: 85/100 = 85.00% - Missing ENDSEM)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU012', 'EEE101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-18', 'YYYY-MM-DD'), 22.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU012', 'EEE101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-18', 'YYYY-MM-DD'), 21.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU012', 'EEE101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-08', 'YYYY-MM-DD'), 42.00, 50.00);

-- MECH101 (2025 Fall)
-- STU013 (Total: 177/200 = 88.50% - Highest performer)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU013', 'MECH101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-19', 'YYYY-MM-DD'), 22.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU013', 'MECH101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-19', 'YYYY-MM-DD'), 23.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU013', 'MECH101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-09', 'YYYY-MM-DD'), 44.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU013', 'MECH101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-14', 'YYYY-MM-DD'), 88.00, 100.00);

-- STU014 (Total: 161/200 = 80.50%)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU014', 'MECH101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-19', 'YYYY-MM-DD'), 20.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU014', 'MECH101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-19', 'YYYY-MM-DD'), 21.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU014', 'MECH101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-09', 'YYYY-MM-DD'), 40.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU014', 'MECH101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-14', 'YYYY-MM-DD'), 80.00, 100.00);

-- MATH101 (2025 Fall)
-- STU001 (Total: 197/200 = 98.50% - Highest performer)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'MATH101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-20', 'YYYY-MM-DD'), 25.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'MATH101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-20', 'YYYY-MM-DD'), 25.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'MATH101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-10', 'YYYY-MM-DD'), 49.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU001', 'MATH101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-15', 'YYYY-MM-DD'), 98.00, 100.00);

-- STU025 (Total: 164/200 = 82.00%)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU025', 'MATH101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-20', 'YYYY-MM-DD'), 21.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU025', 'MATH101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-20', 'YYYY-MM-DD'), 20.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU025', 'MATH101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-10', 'YYYY-MM-DD'), 41.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU025', 'MATH101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-15', 'YYYY-MM-DD'), 82.00, 100.00);

-- STU026 (Total: 184/200 = 92.00%)
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU026', 'MATH101', 2025, 'Fall', 'INTERNAL_1', TO_DATE('2025-09-20', 'YYYY-MM-DD'), 23.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU026', 'MATH101', 2025, 'Fall', 'INTERNAL_2', TO_DATE('2025-10-20', 'YYYY-MM-DD'), 24.00, 25.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU026', 'MATH101', 2025, 'Fall', 'MIDTERM', TO_DATE('2025-11-10', 'YYYY-MM-DD'), 46.00, 50.00);
INSERT INTO result (reg_no, course_code, academic_year, semester, exam_type, exam_date, marks, max_marks)
VALUES ('STU026', 'MATH101', 2025, 'Fall', 'ENDSEM', TO_DATE('2025-12-15', 'YYYY-MM-DD'), 91.00, 100.00);


-- 10. COMMIT & Row Count Verification

COMMIT;

SET LINESIZE 60 PAGESIZE 50
COLUMN table_name FORMAT A20
COLUMN row_count FORMAT 9999

SELECT 'DEPARTMENT' AS table_name, COUNT(*) AS row_count FROM department
UNION ALL
SELECT 'FACULTY', COUNT(*) FROM faculty
UNION ALL
SELECT 'STUDENT', COUNT(*) FROM student
UNION ALL
SELECT 'COURSE', COUNT(*) FROM course
UNION ALL
SELECT 'COURSE_OFFERING', COUNT(*) FROM course_offering
UNION ALL
SELECT 'ENROLLMENT', COUNT(*) FROM enrollment
UNION ALL
SELECT 'ATTENDANCE', COUNT(*) FROM attendance
UNION ALL
SELECT 'RESULT', COUNT(*) FROM result;
