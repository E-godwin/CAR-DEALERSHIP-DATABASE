-- Create the Database
DROP SCHEMA IF EXISTS car_dealership;
CREATE SCHEMA car_dealership;
USE car_dealership;


-- Create Tables
-- Roles Table
CREATE TABLE roles (
	id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    level INT NOT NULL
);


-- Offices Table
CREATE TABLE offices (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(120) NOT NULL,
    type ENUM('Head Office', 'Branch Office', 'CEO House') NOT NULL,
    UNIQUE(name, address)
);


-- Employees Table
CREATE TABLE employees (
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(80) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    role_id INT NOT NULL,
    department_id INT NOT NULL,
    office_id INT NOT NULL,
    reports_to INT DEFAULT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (office_id) REFERENCES offices(id),
    FOREIGN KEY (reports_to) REFERENCES employees(id)
);


-- Payroll Table
CREATE TABLE payroll (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    month_year DATE NOT NULL,     -- payroll period (store as '2025-08-01' for August 2025)
    base_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0.00,
    statutory_deduction DECIMAL(10,2) DEFAULT 0.00,
    net_pay DECIMAL(10,2) AS (base_salary + bonus - statutory_deduction) STORED,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);


-- Attendance Table
CREATE TABLE attendance (
	id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    date DATE NOT  NULL,
    status ENUM('Present', 'Absent', 'Late', 'On Leave') NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);


CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255)
);


-- Insert Data Into Roles Table
INSERT INTO roles (title, level) VALUES
('CEO', 1),
('Executive Director', 2),
('General Manager', 3),
('Finance Manager', 4),
('Sales Manager', 4),
('HR', 4),
('Facility Manager', 4),
('Assistant Finance Manager', 5),
('Assistant Sales Manager', 5),
('Executive Assistant', 5),
('Protocol Manager', 5),
('Chief Security Officer', 5),
('Personal Assistant', 6),
('Sales Executive', 6),
('Security', 6),
('Office Assistant', 6),
('Car Wash', 6),
('Cook', 6),
('Cleaner', 6),
('Driver', 7),
('Gardener', 7);


-- Insert Data Into Offices Table
INSERT INTO offices (name, address, type) VALUES
('Head Office', '23 Allen Avenue, Ikeja, Lagos', 'Head Office'),
('Branch Office', '7 Admiralty Way, Lekki, Lagos', 'Branch Office'),
('CEO House', '1 Banana Island Road, Ikoyi, Lagos', 'CEO House');


-- Insert Data Into Departments Table
INSERT INTO departments (name, description) VALUES
('Executive Management', 'Top-level company leadership including CEO and General Manager'),
('Finance', 'Manages company finances, budgeting, and accounts'),
('Sales & Marketing', 'Handles sales operations and marketing activities'),
('Human Resources', 'Responsible for employee recruitment and welfare'),
('Administration', 'General administrative support and protocol'),
('Security', 'Protects company assets and ensures safety'),
('Operations', 'Manages daily operational tasks and logistics'),
('Media & Communications', 'Handles media relations and internal communications');


-- Insert Data Into Employees Table
-- Executive Management
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
-- CEO
('John', 'Doe', 'Male', 'john@bestcars.com', '+2348012345678', '1970-05-15', 1, 1, 3, NULL),

-- Executive Director
('Grace', 'Johnson', 'Female', 'grace@bestcars.com', '+2348012345679', '1975-08-20', 2, 1, 1, 1),

-- General Manager
('Michael', 'Brown', 'Male', 'michael@bestcars.com', '+2348012345680', '1980-03-10', 3, 1, 1, 1);


-- Finance Department
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
-- Finance Manager
('Peter', 'White', 'Male', 'peter@bestcars.com', '+2348012345681', '1982-07-12', 4, 2, 1, 3),

-- Assistant Finance Manager
('Mary', 'Green', 'Female', 'mary@bestcars.com', '+2348012345682', '1985-11-25', 8, 2, 1, 4);


-- Sales and Marketing
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
-- Sales Manager (Head Office)
('James', 'Black', 'Male', 'james@bestcars.com', '+2348012345683', '1983-06-18', 5, 3, 1, 3),

-- Assistant Sales Manager (Branch Office)
('Sandra', 'Young', 'Female', 'sandra@bestcars.com', '+2348012345684', '1986-02-05', 9, 3, 2, 5),

-- Sales Executive 1 (Head Office)
('Chris', 'Adams', 'Male', 'chris@bestcars.com', '+2348012345685', '1990-09-22', 14, 3, 1, 5),

-- Sales Executive 2 (Head Office)
('Emma', 'Clark', 'Female', 'emma@bestcars.com', '+2348012345686', '1992-01-14', 14, 3, 1, 5),

-- Sales Executive 3 (Branch Office)
('Daniel', 'Lewis', 'Male', 'daniel@bestcars.com', '+2348012345687', '1991-04-19', 14, 3, 2, 9);


-- Human Resource (HR)
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
-- HR Manager
('Linda', 'Walker', 'Female', 'linda@bestcars.com', '+2348012345688', '1984-12-09', 6, 4, 1, 3);


-- Office Administration
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
-- Executive Assistant to CEO
('Robert', 'Hall', 'Male', 'robert@bestcars.com', '+2348012345689', '1987-03-15', 10, 5, 1, 1),

-- Personal Assistant 1 (CEO’s House)
('Anna', 'King', 'Female', 'anna@bestcars.com', '+2348012345690', '1989-07-28', 13, 5, 3, 1),

-- Personal Assistant 2 (Branch Office)
('Sophia', 'Scott', 'Female', 'sophia@bestcars.com', '+2348012345691', '1990-10-12', 13, 5, 2, 2),

-- Office Assistant 1 (Head Office)
('Paul', 'Hill', 'Male', 'paul@bestcars.com', '+2348012345692', '1993-02-21', 16, 5, 1, 6),

-- Office Assistant 2 (Head Office)
('Nancy', 'Allen', 'Female', 'nancy@bestcars.com', '+2348012345693', '1994-06-08', 16, 5, 1, 6),

-- Office Assistant 3 (Branch Office)
('Henry', 'Wright', 'Male', 'henry@bestcars.com', '+2348012345694', '1995-09-17', 16, 5, 2, 6),

-- Protocol Manager
('Diana', 'Lopez', 'Female', 'diana@bestcars.com', '+2348012345695', '1988-11-29', 11, 5, 1, 3);



-- Chief Security Officer (Head Office) and Securities
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
('Victor', 'Adebayo', 'Male', 'victor@bestcars.com', '+2348012345735', '1972-06-20', 12, 5, 1, 3),

-- Securities (Head Office)
('Samuel', 'Okonkwo', 'Male', 'samuel@bestcars.com', '+2348012345736', '1982-07-15', 15, 5, 1, 12),
('Abdul', 'Mohammed', 'Male', 'abdul@bestcars.com', '+2348012345737', '1985-11-25', 15, 5, 1, 12),
('Tunde', 'Oluwole', 'Male', 'tunde@bestcars.com', '+2348012345738', '1988-08-30', 15, 5, 1, 12),
('Chike', 'Eze', 'Male', 'chike@bestcars.com', '+2348012345739', '1983-12-19', 15, 5, 1, 12),

-- Securities (Branch Office)
('Yusuf', 'Bello', 'Male', 'yusuf@bestcars.com', '+2348012345740', '1986-04-18', 15, 5, 2, 12),
('Ifeanyi', 'Okafor', 'Male', 'ifeanyi@bestcars.com', '+2348012345741', '1984-09-07', 15, 5, 2, 12),

-- Securities (CEO House)
('Emeka', 'Chukwu', 'Male', 'emeka@bestcars.com', '+2348012345742', '1981-02-03', 15, 5, 3, 12),
('Bashir', 'Abubakar', 'Male', 'bashir@bestcars.com', '+2348012345743', '1980-10-12', 15, 5, 3, 12);



-- Facility and Support
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
('Olumide', 'Fashola', 'Male', 'olumide@bestcars.com', '+2348012345744', '1976-05-14', 7, 6, 1, 3),

-- Office Assistants
('Janet', 'Afolabi', 'Female', 'janet@bestcars.com', '+2348012345745', '1990-06-25', 16, 6, 1, 7),
('Bola', 'Adeyemi', 'Female', 'bola@bestcars.com', '+2348012345746', '1992-03-16', 16, 6, 1, 7),
('Ngozi', 'Umeh', 'Female', 'ngozi@bestcars.com', '+2348012345747', '1989-12-28', 16, 6, 1, 7),
('Halima', 'Lawal', 'Female', 'halima@bestcars.com', '+2348012345748', '1991-08-21', 16, 6, 2, 7),

-- Car Wash Team
('Peter', 'Ojo', 'Male', 'peter@bestcars.com', '+2348012345749', '1993-04-02', 17, 6, 1, 7),
('Sunday', 'Emeh', 'Male', 'sunday@bestcars.com', '+2348012345750', '1994-09-14', 17, 6, 1, 7),
('Bright', 'Okorie', 'Male', 'bright@bestcars.com', '+2348012345751', '1992-11-30', 17, 6, 1, 7);



-- Home
INSERT INTO employees (
    first_name, last_name, gender, email, phone_number, date_of_birth,
    role_id, department_id, office_id, reports_to
) VALUES
-- Gardener
('Musa', 'Shittu', 'Male', 'musa@bestcars.com', '+2348012345752', '1978-03-05', 21, 7, 3, 7),

-- Cooks
('Stella', 'Amadi', 'Female', 'stella@bestcars.com', '+2348012345753', '1985-07-18', 18, 7, 3, 7),
('Funke', 'Balogun', 'Female', 'funke@bestcars.com', '+2348012345754', '1987-01-23', 18, 7, 3, 7),

-- Cleaners
('Chinwe', 'Iheanacho', 'Female', 'chinwe@bestcars.com', '+2348012345755', '1991-05-11', 19, 7, 1, 7),
('Rose', 'Ibrahim', 'Female', 'rose@bestcars.com', '+2348012345756', '1992-08-09', 19, 7, 1, 7),
('Mercy', 'Oladipo', 'Female', 'mercy@bestcars.com', '+2348012345757', '1993-06-04', 19, 7, 2, 7),
('Grace', 'Oti', 'Female', 'grace1@bestcars.com', '+2348012345758', '1994-12-15', 19, 7, 3, 7),

-- Drivers
('Johnson', 'Ogunleye', 'Male', 'johnson@bestcars.com', '+2348012345759', '1980-04-28', 20, 8, 1, 7),
('Segun', 'Adedeji', 'Male', 'segun@bestcars.com', '+2348012345760', '1982-11-06', 20, 8, 1, 7),
('Ibrahim', 'Yahaya', 'Male', 'ibrahim@bestcars.com', '+2348012345761', '1984-09-19', 20, 8, 2, 7),
('Chris', 'Obi', 'Male', 'chris@bestcars.com', '+2348012345762', '1983-02-17', 20, 8, 3, 7),
('Lawrence', 'Etim', 'Male', 'lawrence@bestcars.com', '+2348012345763', '1981-07-29', 20, 8, 1, 7),
('Kelvin', 'Eze', 'Male', 'kelvin@bestcars.com', '+2348012345764', '1985-12-03', 20, 8, 1, 7),
('Emmanuel', 'Okon', 'Male', 'emmanuel@bestcars.com', '+2348012345765', '1986-05-22', 20, 8, 1, 7);


-- Now I'll populate the payroll table
INSERT INTO payroll (employee_id, month_year, base_salary, bonus, statutory_deduction) VALUES
-- 1. CEO
(1, '2025-08-01', 2500000.00, 200000.00, 50000.00),

-- 2. Executive Director
(2, '2025-08-01', 2000000.00, 150000.00, 40000.00),

-- 3. General Manager
(3, '2025-08-01', 1500000.00, 100000.00, 35000.00),

-- 4. Finance Manager
(4, '2025-08-01', 1200000.00, 80000.00, 30000.00),

-- 5. Sales Manager
(5, '2025-08-01', 1200000.00, 70000.00, 30000.00),

-- 6. HR
(6, '2025-08-01', 1100000.00, 60000.00, 25000.00),

-- 7. Facility Manager
(7, '2025-08-01', 1100000.00, 60000.00, 25000.00),

-- 8. Assistant Finance Manager
(8, '2025-08-01', 900000.00, 50000.00, 20000.00),

-- 9. Assistant Sales Manager
(9, '2025-08-01', 900000.00, 50000.00, 20000.00),

-- 10. Executive Assistant
(10, '2025-08-01', 850000.00, 40000.00, 18000.00);


-- Adding the second batch
INSERT INTO payroll (employee_id, month_year, base_salary, bonus, statutory_deduction) VALUES
-- 11. Protocol Manager
(11, '2025-08-01', 850000.00, 40000.00, 18000.00),

-- 12. Chief Security Officer
(12, '2025-08-01', 800000.00, 35000.00, 15000.00),

-- 13. Personal Assistant
(13, '2025-08-01', 750000.00, 30000.00, 15000.00),

-- 14. Sales Executive
(14, '2025-08-01', 700000.00, 25000.00, 12000.00),

-- 15. Security
(15, '2025-08-01', 600000.00, 20000.00, 10000.00),

-- 16. Office Assistant
(16, '2025-08-01', 550000.00, 15000.00, 9000.00),

-- 17. Car Wash
(17, '2025-08-01', 500000.00, 15000.00, 8000.00),

-- 18. Cook
(18, '2025-08-01', 500000.00, 15000.00, 8000.00),

-- 19. Cleaner
(19, '2025-08-01', 450000.00, 10000.00, 7000.00),

-- 20. Driver
(20, '2025-08-01', 450000.00, 10000.00, 7000.00);

-- Payrool for the Gardener
INSERT INTO payroll (employee_id, month_year, base_salary, bonus, statutory_deduction) VALUES
-- 21. Gardener
(21, '2025-08-01', 400000.00, 8000.00, 5000.00);



-- Now Adding Sample Attendance Inserts
INSERT INTO attendance (employee_id, date, status) VALUES
-- Day 1 (Aug 1, 2025)
(1, '2025-08-01', 'Present'),
(2, '2025-08-01', 'Present'),
(3, '2025-08-01', 'Absent'),
(4, '2025-08-01', 'Present'),
(5, '2025-08-01', 'On Leave'),

-- Day 2 (Aug 2, 2025)
(1, '2025-08-02', 'Present'),
(2, '2025-08-02', 'Present'),
(3, '2025-08-02', 'Present'),
(4, '2025-08-02', 'Absent'),
(5, '2025-08-02', 'Present'),

-- Day 3 (Aug 3, 2025)
(1, '2025-08-03', 'On Leave'),
(2, '2025-08-03', 'Present'),
(3, '2025-08-03', 'Present'),
(4, '2025-08-03', 'Present'),
(5, '2025-08-03', 'Present'),

-- Day 4 (Aug 4, 2025)
(1, '2025-08-04', 'Present'),
(2, '2025-08-04', 'Absent'),
(3, '2025-08-04', 'Present'),
(4, '2025-08-04', 'Present'),
(5, '2025-08-04', 'Present'),

-- Day 5 (Aug 5, 2025)
(1, '2025-08-05', 'Present'),
(2, '2025-08-05', 'Present'),
(3, '2025-08-05', 'On Leave'),
(4, '2025-08-05', 'Present'),
(5, '2025-08-05', 'Absent');


INSERT INTO attendance (employee_id, date, status) VALUES
-- August 6 (Wednesday)
(1, '2025-08-06', 'Present'),
(2, '2025-08-06', 'Present'),
(3, '2025-08-06', 'Late'),
(4, '2025-08-06', 'Present'),
(5, '2025-08-06', 'Absent'),

-- August 7 (Thursday)
(1, '2025-08-07', 'Present'),
(2, '2025-08-07', 'Late'),
(3, '2025-08-07', 'Present'),
(4, '2025-08-07', 'Present'),
(5, '2025-08-07', 'Present'),

-- August 8 (Friday)
(1, '2025-08-08', 'Present'),
(2, '2025-08-08', 'Present'),
(3, '2025-08-08', 'Late'),
(4, '2025-08-08', 'Present'),
(5, '2025-08-08', 'Present'),

-- August 9 (Saturday)
(1, '2025-08-09', 'On Leave'),
(2, '2025-08-09', 'On Leave'),
(3, '2025-08-09', 'On Leave'),
(4, '2025-08-09', 'On Leave'),
(5, '2025-08-09', 'On Leave'),

-- August 10 (Sunday)
(1, '2025-08-10', 'On Leave'),
(2, '2025-08-10', 'On Leave'),
(3, '2025-08-10', 'On Leave'),
(4, '2025-08-10', 'On Leave'),
(5, '2025-08-10', 'On Leave');