WITH Recursive EmployeeHierarchy AS (
    -- Начальный запрос: выборка всех менеджеров (кто без руководителей)
    SELECT employee_id, first_name, last_name, manager_id
    FROM employees
    WHERE manager_id IS NULL      
    UNION ALL
    -- Рекурсивный запрос: добавление подчинённых к каждому менеджеру
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
    FROM employees e
    JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM EmployeeHierarchy;