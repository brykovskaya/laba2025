DROP TABLE employees;
-- создаем таблицу по образу из задания+города сотрудников
CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	department VARCHAR(50),
	salary NUMERIC(8, 2),
	city VARCHAR(50)
);
INSERT INTO employees (name, department,  salary, city)
VALUES 
	('Иван',  'Продажи',   5000, 'Санкт-Петербург'),
	('Петр',  'IT',  	   6000, 'Москва'),
	('Анна',  'Маркетинг', 4500, 'Санкт-Петербург'),
	('Ольга', 'Продажи',   5500, 'Москва')
	--предварительно таблицу employees обновили и добавили города сотрудников
--Упражнение - INTERSECT
--Вывести города, в которых живут клиенты, и где зарплата сотрудников выше 5000.
  
SELECT city FROM clients 
INTERSECT
SELECT city FROM employees
WHERE salary > 5000;