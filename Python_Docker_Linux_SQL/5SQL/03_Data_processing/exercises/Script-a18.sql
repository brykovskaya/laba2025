--Упражнение - HAVING
--Упражнение 3: Выбрать клиентов из таблицы orders с общей суммой заказов более 1000.
WITH cte AS (SELECT *,
	unit_price * quantity AS amount
FROM orders)
SELECT customer_id,
	SUM(amount) AS total_amount
FROM cte
GROUP BY customer_id
HAVING SUM(amount) > 1000
ORDER BY total_amount;

--Упражнение 4: Выбрать категории продуктов из таблицы products со средней ценой более 50.
--меняю условие под таблицу:
--выбрать customer_id со средним количеством quantity в заказе выше 10
SELECT customer_id,
	ROUND(AVG(quantity)) AS avg_quantity
FROM orders
GROUP BY customer_id
HAVING ROUND(AVG(quantity)) > 10
ORDER BY avg_quantity;
