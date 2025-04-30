--Упражнения - UPDATE
--посмотрим на табл до удаления 
SELECT *
FROM employees e 
ORDER BY salary;
--Удалить всех сотрудников с зарплатой меньше 100000.
DELETE FROM employees WHERE salary < 100000;

--посмотрим на табл ПОСЛЕ удаления 
SELECT *
FROM employees e 
ORDER BY salary;

--Удалить все записи из таблицы employees.
DELETE FROM employees;