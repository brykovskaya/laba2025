-- задание1. найти 3 самых продаваемых продукта в каждой категории
--посчитаем сколько продано каждого продукта всего
WITH cte AS (
SELECT product_category,
	SUM(quantity) OVER (PARTITION BY product) AS total_quantity,
	product
FROM ecommerce_rfm),
--проранжируем продукты (в каждой категории) где 1 рангу у продукта с наибольшим кол-вом продаж в штуках. 
--используем rank() можно и dense_rank()т.к. больше вводных нет. то итоговое решение что выбрать принимаем сами
--ищем внутри каждой категории  по total_quantity
cte2 AS (
SELECT 
	product_category,
	rank() OVER (PARTITION BY product_category ORDER BY total_quantity DESC) AS rank_quantity,
	total_quantity,
	product
FROM cte
GROUP BY product, product_category, total_quantity
)
--выведем топ-3 самых продаваемых товара в каждой категории
SELECT *
FROM cte2
WHERE rank_quantity <=3
ORDER BY product_category, rank_quantity;


--задание2. 2. Рассчитать кумулятивную сумму продаж по дням. 
-- в этой таблице столбец total = quantity*price искать выручку будем по нему

--шаг1.посчитаем общую выручку за все дни )для самопроверки
SELECT SUM(total) AS all_revenue
FROM ecommerce_rfm
--all_revenue = 3914736.2

--шаг2.посчитаем кумулятивную выручку по дням.
WITH cte AS(
SELECT 
	date::DATE AS date_amount,
	SUM(total) OVER (ORDER BY date::DATE) AS total_amount
FROM ecommerce_rfm)
--шаг3.выведем данные без дубликатов
SELECT *
FROM cte
GROUP BY date_amount, total_amount
ORDER BY date_amount;

--задание3
--план:
--определить средний чек для каждого пользователя, ранжировать пользователей по среднему чеку.
--пользователь = customer_id    
--средний чек посчитаем по так. посчитаем общую сумму по всем заказам(order_id) 
--для каждого customer_id   = это будет total_revenue_customer
--посчитаем для каждого customer_id   количество уникальных заказов order_id
--разделим общую выручку пользователя на общее количество заказов пользователя = получим его средний чек.
--проранжируем покупателей где ранг 1 у самого высокого среднего чека 
WITH cte AS(
SELECT 
	customer_id, 
	SUM(total) OVER (PARTITION BY order_id) AS total_revenue,
order_id
FROM ecommerce_rfm
),
--в подзапроcе cte1 избавимся от дублей строк
--это даст возможность найти средний чек
cte1 AS (
SELECT 
	 customer_id,
	-- SUM(total_revenue) / COUNT(order_id)  AS AVG_amount
	--т.к. упр на оконки - то используем оконную агр функцию 
	AVG(total_revenue) OVER (PARTITION BY customer_id) AS avg_amount
FROM (SELECT *
		FROM cte
		GROUP BY 
			order_id, 
			customer_id, 
			total_revenue
	  ) AS tab)
--избавимся от дубликатов. отсортирукем вывод по убыванию ср.чека	  
SELECT 
	customer_id,
	ROUND(avg_amount) AS avg_amount,
	dense_rank() OVER (ORDER BY avg_amount DESC) AS rank_customer_avg_amount
FROM cte1
GROUP BY 
	customer_id, 
	AVG_amount  
ORDER BY avg_amount DESC;



















