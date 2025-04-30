--Упражнения - UPDATE
--посмотрим на за до уменьшения
SELECT *
FROM employees e 
WHERE department = 'Отдел Продаж'
ORDER BY salary DESC ;

--Уменьшить зарплату всем сотрудникам отдела "Sales" на 5%.
UPDATE employees SET salary = salary * 0.95 
WHERE department = 'Отдел Продаж'

--посмотрим на за ПОСЛЕ уменьшения
SELECT *
FROM employees e 
WHERE department = 'Отдел Продаж'
ORDER BY salary DESC ;
--Изменить фамилию сотрудника с id = 1 на "Смирнов".
--фамилия до изменения
SELECT *
FROM employees e 
WHERE id = 1;

UPDATE employees SET last_name = 'Смирнова' 
WHERE id = 1;

--фамилия после изменения
SELECT *
FROM employees e 
WHERE id = 1;