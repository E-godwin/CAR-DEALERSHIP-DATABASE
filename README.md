# Car Dealership Management Database

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Database Schema](#database-schema)
- [SQL Files](#sql-files)
- [Interesting Query Statements](#some-interesting-query-statements-that-helped)
- [Tech Stack](#tech-stack)
---
## Project Overview
A fully structured **MySQL database** for managing a car dealership's core operations, including **employees, payroll, attendance, departments, offices, and roles**.  
The project also includes an **ERD diagram**, ready for portfolio showcasing.

---

## Features
- **Roles & Departments** – Clearly define organizational structure.
- **Offices** – Multiple locations (Head Office, Branch, CEO House).
- **Employees** – Complete employee records with email, phone, and reporting structure.
- **Payroll** – Automated `net_pay` calculation using generated columns.
- **Attendance** – Track daily presence, absence, lateness, or leave.
- **Data Integrity** – Foreign key relationships ensure relational consistency.

---

## Database Schema
**Tables:**
1. `roles` – Stores job titles and hierarchy levels.
2. `departments` – Stores functional departments (e.g., Executive Management, Finance).
3. `offices` – Stores office locations and types.
4. `employees` – Stores employee details, including role, department, office, and reporting manager.
5. `payroll` – Stores monthly payroll data, including base salary, bonuses, and deductions.
6. `attendance` – Tracks employee attendance for each date.


---

## SQL Files
- `all_create_table.sql` – Contains all **CREATE TABLE** statements with constraints.
- `all_insert_data.sql` – Contains **INSERT** statements for roles, departments, offices, employees, payroll, and attendance.

---

## Some Interesting Query Statements That Helped
I encountered some errors before finally arriving at this uploaded full schema. This one I uploaded is the third attempt after two failed attempts.
I forgot to add the departments table after I had created employees table. This means that I will have to add a foreign key to the employees table but I didn't want to alter employees table and make a mess.
So I executed the query statement below:

```sql
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS employees;
SET FOREIGN_KEY_CHECKS = 1;
```

---

```sql
SET FOREIGN_KEY_CHECKS = 0
```
The above statement temporarily disables foreign key constraint checks in MySQL.
I did that because the employees table is referenced by other tables via foreign keys, dropping it would normally cause an error. Disabling the checks allowed me to bypass this restriction.

```sql
DROP TABLE IF EXISTS employees;
```
The above statement permanently removes/ deletes the employees table from the database.
```sql
SET FOREIGN_KEY_CHECKS = 1;
```
The above statement re-enables foreign key constraint checks, restoring the integrity enforcement of foreign key relationships after the potentially disruptive operation.

---

## Tech Stack
- Database: MySQL 8+
- Modeling Tool: MySQL Workbench
