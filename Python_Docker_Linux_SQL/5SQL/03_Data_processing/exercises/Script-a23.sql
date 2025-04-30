--добавим в таблицу комментарии о скидке
WITH cte AS (
SELECT *,
	CASE 
		WHEN id_product = 1 THEN 'Скидка' ELSE 'Нет скидки'
	END AS discount
FROM orders
)
SELECT order_id, discount
FROM cte
WHERE discount LIKE 'Скидка'

--добавим в таблицу артикул 
WITH cte AS (
SELECT *,
	CASE --латинские буквы!
		WHEN id_product = 1 THEN 'AA001A' -- соотв условию
		WHEN id_product = 2 THEN 'AA001B'
		WHEN id_product = 3 THEN '9A001A'
		WHEN id_product = 4 THEN 'C6001A'
		WHEN id_product = 5 THEN 'BB005A' -- соотв условию
	END AS article
FROM orders
)
--т.к. таблица большая то сгруппируем по артиклу и продукту и посчитаем кол-во заказов
SELECT product, article, count(order_id) AS total_orders
FROM cte
WHERE article ~ '^[A-Za-z]{2}[0-9]{3}A$'
GROUP BY product, article;
