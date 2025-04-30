--Выбрать всех сотрудников с зарплатой больше 250000--.
SELECT * FROM employees
WHERE employees.salary > 250000;

--Выбрать имя и фамилию сотрудников, чья фамилия начинается на "С".
SELECT first_name,
	last_name
FROM employees
WHERE employees.last_name LIKE ('С%');

--Выбрать количество сотрудников в каждом отделе.\
SELECT e.department, 
	COUNT(e.department) AS "количество сотрудников"
FROM employees e 
GROUP BY e.department
;
