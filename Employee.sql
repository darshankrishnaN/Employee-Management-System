CREATE TRIGGER AfterSalaryUpdate
AFTER UPDATE ON Salaries
FOR EACH ROW
BEGIN
    INSERT INTO SalaryLog (salary_id, old_base_salary, new_base_salary, updated_at)
    VALUES (NEW.salary_id, OLD.base_salary, NEW.base_salary, NOW())

END;

