
SELECT *
FROM ecommerce_rfm
WHERE price = 15;

--задание1
CREATE OR REPLACE VIEW product_view AS
SELECT 
    product  AS product_name,
    price AS price,
    product_category AS category
FROM ecommerce_rfm
;

SELECT *
FROM product_view
LIMIT 5;

--задание2
--Создайте материализованное представление для отчета о продажах по месяцам.
CREATE MATERIALIZED VIEW monthly_report AS
SELECT 
    DATE_TRUNC('month', date::DATE) AS month,
    SUM(total) AS total_amount
FROM ecommerce_rfm
GROUP BY DATE_TRUNC('month', date::DATE)
ORDER BY DATE_TRUNC('month', date::DATE);

SELECT 
	month::DATE,
    total_amount
FROM monthly_report
LIMIT 5;

--задание3
--Попробуйте обновить данные через созданные вами представления. 
--В каких случаях это возможно, а в каких нет?
UPDATE product_view 
SET customer_id = 'ee47d746-6d2f-4d3c-9622-c31412542920_new'
WHERE customer_id = 'ee47d746-6d2f-4d3c-9622-c31412542920';

UPDATE product_view 
SET price = 16
WHERE price = 15;

--вернем цену назад
UPDATE product_view 
SET price = 15
WHERE price = 16;

