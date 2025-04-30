--Добавить колонку shipping_cost к таблице orders если в заказе от 14 quantity 
--для остальных доставка 200
SELECT *,
	CASE
		WHEN quantity > 13 THEN 0  ELSE 200
	END AS shipping_cost
FROM orders;

--Классифицировать клиентов в таблице orders по количеству заказов: "New", "Regular" и "VIP".
--если заказов менее 4 это New   если заказов  4 нэто Regular   если заказов более 4 это VIP
WITH cte as(
SELECT *,
	COUNT(order_id) OVER (PARTITION BY customer_id) AS total_orders
FROM orders)
SELECT *,
	CASE
		WHEN total_orders > 4 THEN 'VIP'
		WHEN total_orders < 4 THEN 'NEW'
		ELSE 'Regular'
	END AS client_type
FROM cte;
