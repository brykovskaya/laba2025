SELECT city AS "Города и отделы"
FROM clients
UNION
SELECT department
FROM employees;