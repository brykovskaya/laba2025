--2. Проанализируйте план выполнения запроса ДО создания индекса
--SELECT * FROM products WHERE price > 1000 до создания индекса.
EXPLAIN ANALYZE 
SELECT * 
FROM products 
WHERE price > 1000;
--1. Создайте индекс для столбца price в таблице products.
CREATE INDEX idx_price ON products(price);

--2. Проанализируйте план выполнения запроса ПОСЛЕ  создания индекса
EXPLAIN ANALYZE 
SELECT * 
FROM products 
WHERE price > 1000;
--3. Напишите запрос, который вернет товары из категории 
--"Электроника" с использованием JOIN.
SELECT p.*
FROM products AS p
JOIN categories AS c ON p.category_id = c.id
WHERE c.name = 'Электроника';
