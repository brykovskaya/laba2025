SELECT * 
FROM products;

--шаг1 создание хранимой процедуры
CREATE OR REPLACE PROCEDURE IncreasePriceByCategory(
	IN category_name VARCHAR(50),
	IN percentage_increase NUMERIC(10, 2)
) AS $$
BEGIN
	UPDATE products
	SET price = price * (1 + percentage_increase / 100)
	FROM categories 
    WHERE categories.id = products.category_id 
		AND categories.name = category_name;
END;
$$ LANGUAGE plpgsql;

--шаг 2. выполним хранимую процедуру
-- для категори товаров Электроника увеличим цену нва 15%
CALL IncreasePriceByCategory('Электроника', 15);

-- шаг 3. проверяем цены на электронику
SELECT 
	p.name, 
	price 
FROM products AS p
JOIN categories AS c ON p.category_id=c.id
WHERE c.name = 'Электроника'
