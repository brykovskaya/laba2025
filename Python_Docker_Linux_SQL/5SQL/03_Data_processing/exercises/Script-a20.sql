--Упражнение - Операторы сравнения
--Упражнение 7: Написать запросы с использованием разных операторов сравнения для таблиц из предыдущих упражнений.
WITH cte AS (
SELECT *,
	COUNT(order_id) OVER (PARTITION BY customer_id) AS total_orders
FROM orders),
cte2 AS(
SELECT *,
	CASE
		WHEN total_orders > 4 THEN 'VIP'
		WHEN total_orders < 4 THEN 'NEW'
		ELSE 'Regular'
	END AS client_type
FROM cte)
SELECT *
FROM cte2
WHERE unit_price <= 25
  AND id_product = 2
  AND client_type = 'VIP'
  AND quantity > 10;
