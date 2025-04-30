--обновила таблицу заказы из csv файла - добавила столбцы и дату
SELECT *
FROM orders;
--Упражнение - ANY, ALL
--Найдите все заказы, дата которых совпадает с датой любого заказа клиента с customer_id 15634602.
SELECT * 
FROM orders 
WHERE order_date = ANY ( 
	SELECT order_date 
	FROM orders 
	WHERE customer_id = 15634602 );

--Найдите все заказы, сумма которых больше суммы всех заказов, сделанных в январе 2025.
--бедимся что код рабочий по частям
SELECT SUM(amount) AS total_month_amount
	FROM orders
	WHERE date_trunc('month', order_date::DATE)::DATE = '2025-01-01';	
--
SELECT *
FROM orders;

-- теперь целевой запрос полностью
SELECT *
FROM orders
WHERE amount > ALL(
	SELECT SUM(amount) AS total_month_amount
	FROM orders
	WHERE date_trunc('month', order_date::DATE)::DATE = '2025-01-01'	      
);