SELECT employee_id, 
	first_name, 
	last_name
FROM employees
WHERE department_id = (
	SELECT department_id
  	FROM employees
  	GROUP BY department_id
  	ORDER BY COUNT(*) DESC
  	LIMIT 1
);
SELECT employee_id, 
	first_name, 
	last_name
FROM employees
WHERE department_id = (
	SELECT department_id
  	FROM employees
  	GROUP BY department_id
  	ORDER BY COUNT(*) DESC
  	LIMIT 1
);
