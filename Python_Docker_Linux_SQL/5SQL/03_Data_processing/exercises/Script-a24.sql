 --Создайте таблицу products с колонками id, name, price, description.
CREATE TABLE products_null (
  	id serial PRIMARY KEY,
  	name VARCHAR(255),
  	price DECIMAL, 
  	description VARCHAR(255));
  	
 --Добавьте несколько записей, оставив некоторые значения price и description пустыми (NULL).
 INSERT INTO products_null (name, price, description)
VALUES 
	('крем', 499.79, 'Для рук, для всех возрастов'),
	('мыло', 69.99, 'Для тела, для чувствительной кожи'),
	('шампунь',NULL, 'женский, с ароматом розы'),
	('мочалка',NULL, 'японская массажная'),
	('вехотка',99, NULL),
	('зубная паста',199, NULL),
	(NULL,NULL, NULL),
	('бальзам',NULL, NULL),
	(NULL,199, NULL);
--посмотрим на результат создания таблицы
SELECT *
FROM products_null;
	
--Напишите запрос, который выводит названия продуктов, у которых не указана цена.
SELECT name
FROM products_null
WHERE price ISNULL;

--Напишите запрос, который выводит описания продуктов, у которых цена указана.
SELECT description
FROM products_null
WHERE price IS NOT NULL;

--Напишите запрос, который выводит названия продуктов и их цены. Если цена не указана, 
--то вместо нее должно отображаться "Нет в наличии".	
SELECT name,
COALESCE(price::TEXT,'Нет в наличии') AS price
FROM products_null;