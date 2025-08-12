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
