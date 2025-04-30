--создайте таблицу "products" с полями id (serial primary key), name (varchar(50)), price (numeric).
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    price NUMERIC
);
-- Добавьте 3 продукта в таблицу.
INSERT INTO products (name, price)
VALUES 
	('Сноуболрд', 25000),
	('Шлем лыжный', 10000),
	('Костюм для сноуборда', 49000);
	
SELECT * FROM products;

--В рамках одной транзакции:
BEGIN;
--Увеличьте цену первого продукта на 10%. 
UPDATE products
SET price = price * 1.1
WHERE id = 1;
--Создайте точку сохранения "price_update". 
SAVEPOINT price_update;
--Удалите второй продукт. 
DELETE FROM products
WHERE id = 2;
--Откатитесь к точке сохранения "price_update". 
ROLLBACK TO SAVEPOINT price_update;
--Подтвердите транзакцию.
COMMIT;

--Проверьте содержимое таблицы "products".
SELECT * FROM products;