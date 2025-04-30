--Напишите функцию, которая возвращает общую стоимость всех товаров на складе.
--будем считать, что перечень товаров  в таблице products -это товары на складе
--DROP FUNCTION gettotalcost();
--шаг 1 Создаем функцию
CREATE OR REPLACE FUNCTION GetTotalCost()
RETURNS TEXT AS $$
DECLARE
	total_amount DECIMAL;
	result TEXT;
BEGIN
	SELECT SUM(price) 
	INTO total_amount 
	FROM products;
	result:='Стоимость всех товаров на складе: '||(total_amount::TEXT);
	RETURN result;
END;
$$ LANGUAGE plpgsql;
--шаг 2 Выполняем для проверки

SELECT GetTotalCost();
