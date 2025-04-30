CREATE OR REPLACE FUNCTION get_products_by_price_range(
							min_price NUMERIC, max_price NUMERIC)
RETURNS TABLE(
	product_id INTEGER, 
	product_name TEXT, 
	product_price NUMERIC(10, 2)) AS $$
DECLARE
    sql_query TEXT;
BEGIN
    -- Построение динамического SQL-запроса
    sql_query :=  'SELECT 
						  id, 
						  name, 
						  price 
					 FROM products 
					WHERE price BETWEEN $1 AND $2';
    -- Выполнение динамического SQL-запроса с параметрами
    RETURN QUERY EXECUTE sql_query USING min_price, max_price;
END;
$$ LANGUAGE plpgsql;
--зададим параметры поиска товаров с ценой между 10000 и 100000
SELECT * 
FROM get_products_by_price_range(10000, 100000);
