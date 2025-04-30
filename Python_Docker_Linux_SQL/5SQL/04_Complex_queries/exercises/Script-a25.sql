WITH AverageSalary AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT 
	employee_id, 
	last_name, 
	first_name, 
	salary
FROM employees
WHERE salary > (
	SELECT avg_salary 	
	FROM AverageSalary)
ORDER BY 
	salary,
	last_name