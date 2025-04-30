-- количество неоплаченных заказов для каждого города здесь
EXPLAIN ANALYZE
SELECT city_name,
       COUNT(DISTINCT o.order_id) AS fail_orders
FROM orders AS o
LEFT JOIN cities AS c ON o.city_id=c.city_id
WHERE order_id NOT IN (
                        SELECT order_id
                        FROM order_statuses
                        WHERE status_id = 2
                        )
GROUP BY city_name
ORDER BY fail_orders DESC;

--Упражнение 6: Управление метаданными
--Создадим таблицу внутри базы данных для хранения метаданных. 
--Это будет наш "каталог данных". 
--Создадим таблицу metadata_catalog для документирования таблиц и их атрибутов.
CREATE TABLE metadata_catalog (
table_name VARCHAR(255) NOT NULL,
column_name VARCHAR(255),
data_type VARCHAR(50),
is_primary_key BOOLEAN DEFAULT FALSE,
is_foreign_key BOOLEAN DEFAULT FALSE,
foreign_table VARCHAR(255),
description TEXT,
source TEXT,
last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--Добавим метаданные для схемы rest_orders 
-- (таблицы cities, dishes,  statuses).
-- Таблица cities
INSERT INTO metadata_catalog (table_name, column_name, data_type, is_primary_key, description, source)
VALUES
('cities', NULL, NULL, FALSE, 'Справочник голродов', 'Внутренний справочник'),
('cities', 'city_id', 'SERIAL', TRUE, 'Уникальный идентификатор города', 'Внутренний справочник'),
('cities', 'city_name', 'VARCHAR(50)', FALSE, 'название города', 'Внутренний справочник');
-- Таблица dishes
INSERT INTO metadata_catalog (table_name, column_name, data_type, is_primary_key, description, source)
VALUES
('dishes', NULL, NULL, FALSE, 'Справочник с информацией о блюдах', 'Внутренний справочник'),
('dishes', 'object_id', 'SERIAL', TRUE, 'Уидентификатор блюда (первичный ключ)', 'Внутренний справочник'),
('dishes', 'name', 'varchar(128)', FALSE, 'название блюда', 'Внутренний справочник'),
('dishes', 'spicy', 'varchar(128)', FALSE, 'маркер, указывающий, является ли блюдо острым(1 — острое, 0 — не острое)', 'Внутренний справочник'),
('dishes', 'fish', 'INT', FALSE, 'маркер, указывающий, содержит ли блюдо рыбные ингредиенты(1 — содержит,0 — не содержит)', 'Внутренний справочник'),
('dishes', 'meat', 'INT', FALSE, 'маркер, указывающий, содержит ли блюдо мясные ингредиенты(1 — содержит,0 — не содержит)', 'Внутренний справочник')
;
-- Таблица statuses 
INSERT INTO metadata_catalog (table_name, column_name, data_type, is_primary_key, is_foreign_key, foreign_table, description, source)
VALUES
('statuses ', NULL, NULL, FALSE, FALSE, NULL, 'содержит информацию о названиях статусов.', 'Система управления заказами'),
('statuses ', 'status_id', 'SERIAL', TRUE, FALSE, NULL, 'идентификатор статуса (первичный ключ)', 'Система управления заказами'),
('statuses ', 'status_name', 'INT', FALSE, TRUE, 'category', 'Ссылка на категорию товара', 'Система управления заказами'),
('statuses ', 'status', 'VARCHAR(50)', FALSE, FALSE, NULL, 'название статуса:1 — создан;2 — оплачен;
3 — подтверждён рестораном;4 — приготовлен;
5 — передан курьеру;6 — доставлен', 'Система управления товарами');


SELECT
table_name,
column_name,
data_type,
CASE WHEN is_primary_key THEN 'Yes' ELSE 'No' END AS primary_key,
CASE WHEN is_foreign_key THEN foreign_table ELSE 'N/A' END AS foreign_key,
description,
source
FROM
metadata_catalog
ORDER BY
table_name, column_name;

--т.к. очень большой объем таблиц то  по dishes_prices, order_items, order_statuses, orders, statuses, users--
--не добавляла
