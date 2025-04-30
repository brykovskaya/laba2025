--таблица employees уже есть - посмотрим что там
SELECT * FROM employees e ;
-- ничего нет пустая. дромнем и создадим новую
DROP TABLE employees;

-- создаем таблицу по образу из задания
CREATE TABLE employees (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	department VARCHAR(50),
	salary NUMERIC(8, 2)
);
INSERT INTO employees (name, department,  salary)
VALUES 
	('Иван',  'Продажи',   5000),
	('Петр',  'IT',  	   6000),
	('Анна',  'Маркетинг', 4500),
	('Ольга', 'Продажи',   5500)
	
SELECT * FROM employees e ;

--таблица с клиентами - имя клиента и айди != сотруднику! 
--это отдельная таблица без связи с сотрудниками
CREATE TABLE clients (
	id SERIAL PRIMARY KEY,
	Name VARCHAR(50),
	city  VARCHAR(50)
);

INSERT INTO clients (Name, city)
VALUES
	('Иван',  'Москва'),
	('Елена',  'Санкт-Петербург'),
	('Петр',  'Москва');

SELECT * FROM clients;
