WITH DepartmentAvgSalaries AS (
    -- CTE для расчета средней зарплаты по каждому отделу
    SELECT 
	d.department_name,
    ROUND(AVG(e.salary)) AS avg_salary
	FROM employees e
	JOIN department d ON e.department_id = d.id
	GROUP BY d.department_name
),
OverallAvgSalary AS (
    -- CTE для расчета средней зарплаты по всем отделам
    SELECT ROUND(AVG(avg_salary)) AS overall_avg_salary 
    FROM DepartmentAvgSalaries -- 77682 средняя зп по всем отделам в целом
)
-- Выбираем отделы со средней зп по отделу  выше средней зп по всем отделам в целом
SELECT
    das.department_name,
    das.avg_salary
FROM DepartmentAvgSalaries das
JOIN OverallAvgSalary oas ON das.avg_salary > oas.overall_avg_salary;
   