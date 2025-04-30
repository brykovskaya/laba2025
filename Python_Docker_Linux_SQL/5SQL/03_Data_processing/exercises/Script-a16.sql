--Упражнение - IN и NOT IN
--Вывести клиентов, которые не являются сотрудниками (в нашем случае по совпадению имени ищем)
SELECT * FROM clients 
WHERE name NOT IN (
					SELECT name 
					FROM employees
                   );
