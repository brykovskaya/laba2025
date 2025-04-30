--Упражнения - INSERT
--Вставить нового сотрудника в отдел "HR" с зарплатой 40000.
INSERT INTO employees (first_name, last_name, department, salary)
VALUES ('Альберт', 'Новенький', 'HR', 40000);

SELECT *
FROM employees e 
WHERE department = 'HR';


--Вставить двух новых сотрудников в отдел "Finance".
INSERT INTO employees (first_name, last_name, department, salary)
VALUES 
	('Мария', 'Богатая', 'Finance', 400000),
	('Золушка', 'Бедная', 'Finance', 70000)
;
-- проверим новеньких
SELECT *
FROM employees e 
WHERE department = 'Finance';