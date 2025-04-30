--Создайте триггер, который запрещает устанавливать цену товара ниже 
--его себестоимости (добавьте столбец cost в таблицу products).
--шаг1. Добавляем столбец cost с себестоимостью
ALTER TABLE products
ADD COLUMN cost INT;
--добавим себестоимость рандомно
UPDATE products
SET cost = random()*price;

SELECT * FROM products;

--шаг2Создание функции триггера
CREATE OR REPLACE FUNCTION checkPriceCost()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.price < NEW.COST THEN
		RAISE EXCEPTION 'Цена товара не может быть ниже себестоимости';
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--шаг3 Создание триггера
CREATE TRIGGER price_check
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION checkPriceCost();

--шаг 4 проверим работу триггера. установим цену выше себестоимости
--для id 6|Джинсы    | цена 3000.00 себестоимость 2855
UPDATE products p SET price = 2000
WHERE id = 6;