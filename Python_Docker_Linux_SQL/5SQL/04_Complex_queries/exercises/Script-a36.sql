--т.к. функция только на увеличение то заложим увеличение в процентах (на сколько увеличиваем)
CREATE OR REPLACE FUNCTION update_product_price(product_id INTEGER, percent NUMERIC(10,2))
RETURNS VOID AS $$
DECLARE
    current_price NUMERIC(10, 2);
BEGIN
    -- Получение текущей цены товара
    SELECT p.price
    INTO current_price
    FROM products p
    WHERE p.id = product_id;
    -- Проверка на случай, если товар не найден
    IF current_price IS NULL THEN
        RAISE EXCEPTION 'Товар с ID "%" не найден', product_id;
    END IF;

    -- Обновление цены товара
    UPDATE products
    SET price = current_price * (1 + percent / 100)
    WHERE id = product_id;
END;
$$ LANGUAGE plpgsql;

SELECT update_product_price(1, 10); -- Увеличиваем цену товара с ID 1 на 10%
--телефон быс с ценой 20000 - новая цена должна быть 22000
--проверяем:
SELECT * 
FROM products 
WHERE id = 1; 