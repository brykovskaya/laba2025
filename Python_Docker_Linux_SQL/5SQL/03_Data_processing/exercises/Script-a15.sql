--Упражнение - EXCEPT
--Вывести отделы, в которых нет сотрудников с именем "Иван".
SELECT department FROM employees
EXCEPT 
SELECT department FROM employees WHERE name = 'Иван';
