--SELECT * FROM employees e 

CREATE OR REPLACE FUNCTION get_ranked_employees()
RETURNS TABLE (empl_id INT, 
	first_name varchar(50), 
	last_name varchar(50), 
	salary int, 
	rank_num BIGINT) AS $$
BEGIN
  RETURN QUERY
  SELECT e.employee_id AS empl_id, 
		e.first_name, 
		e.last_name, 
		e.salary,
         ROW_NUMBER() OVER (ORDER BY e.salary DESC) AS rank_num
  FROM employees e;  -- Явно указываем таблицу
END;
$$ LANGUAGE plpgsql;
--выведем проранжированных по зп сотрудников
SELECT * FROM  get_ranked_employees();
