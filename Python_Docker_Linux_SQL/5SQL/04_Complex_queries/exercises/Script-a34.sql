--DROP TABLE products;
--DROP TABLE categories;

-- Таблица категорий
CREATE TABLE categories (
    id serial PRIMARY KEY,
    name TEXT NOT NULL);
-- Таблица товаров
CREATE TABLE products (
    id INT generated always as identity (start 1) primary key,
    name TEXT NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    category_id INTEGER,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Заполним таблицы данными
INSERT INTO categories (name) VALUES 
	('Электроника'), 	
	('Книги'), 
	('Одежда');

INSERT INTO products (name, price, category_id) VALUES
    ('Телефон', 20000, 1),
    ('Ноутбук', 50000, 1),
    ('Фантастика', 500, 2),
    ('Детектив', 300, 2),
    ('Футболка', 1000, 3),
    ('Джинсы', 3000, 3)
    
SELECT * FROM categories;
SELECT * FROM products;

-- функция get_product_info(product_id INTEGER), 
--которая принимает ID товара и возвращает его название, 
--цену и название категории в виде строки.

CREATE OR REPLACE FUNCTION get_product_info(product_id INT)
RETURNS text AS $$
DECLARE
	product_name text;
	product_price NUMERIC (10, 2);
	category_name TEXT;
    result TEXT;
BEGIN
	SELECT 
		p.name,
		p.price,
		c.name      
	INTO 
		product_name,
		product_price,
		category_name
	FROM products AS p
	INNER JOIN categories AS c ON c.id = p.category_id
	WHERE p.id = product_id;
-- сли такого продукта нет
	IF product_name IS NULL THEN
		RETURN 'родукта с таким product_id нет!';
    END IF;
	result:= 'Результат: "'||product_name||', '
			||product_price||', '||category_name||'"';
	RETURN result;
END;
$$ LANGUAGE plpgsql;

SELECT get_product_info(1);
