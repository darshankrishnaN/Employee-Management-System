CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

CREATE TABLE Salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    base_salary DECIMAL(10, 2) NOT NULL,
    bonus DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    hire_date DATE NOT NULL,
    department_id INT,
    salary_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    FOREIGN KEY (salary_id) REFERENCES Salaries(salary_id)
);

CREATE TABLE Projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL
);

CREATE TABLE EmployeeProjects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

INSERT INTO Departments (department_name) VALUES ('HR'), ('IT'), ('Finance');

INSERT INTO Salaries (base_salary, bonus) VALUES (50000, 5000), (70000, 7000), (90000, 10000);

INSERT INTO Employees (first_name, last_name, gender, date_of_birth, hire_date, department_id, salary_id)
VALUES
('John', 'Doe', 'Male', '1985-06-15', '2020-01-01', 1, 1),
('Jane', 'Smith', 'Female', '1990-04-25', '2019-03-15', 2, 2);

INSERT INTO Projects (project_name) VALUES ('Project A'), ('Project B');

INSERT INTO EmployeeProjects (employee_id, project_id) VALUES (1, 1), (2, 2);

INSERT INTO Employees (first_name, last_name, gender, date_of_birth, hire_date, department_id, salary_id)
VALUES ('Alice', 'Johnson', 'Female', '1992-07-12', '2022-10-01', 3, 1);

UPDATE Employees
SET last_name = 'Brown', department_id = 2
WHERE employee_id = 1;


DELETE FROM Employees
WHERE employee_id = 3;


DELIMITER //
CREATE PROCEDURE CalculateCompensation()
BEGIN
    SELECT e.first_name, e.last_name, (s.base_salary + s.bonus) AS total_compensation
    FROM Employees e
    JOIN Salaries s ON e.salary_id = s.salary_id;
END //
DELIMITER ;


CREATE TRIGGER AfterSalaryUpdate
AFTER UPDATE ON Salaries
FOR EACH ROW
BEGIN
    INSERT INTO SalaryLog (salary_id, old_base_salary, new_base_salary, updated_at)
    VALUES (NEW.salary_id, OLD.base_salary, NEW.base_salary, NOW())

END;

