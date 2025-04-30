--DROP FUNCTION get_user_products(text);

CREATE OR REPLACE FUNCTION get_user_products(user_id_param text)
RETURNS TABLE (product_id varchar(50), product_name varchar(50)) AS $$
DECLARE
  user_name text;
BEGIN
  -- Получение имени пользователя по customer_id у меня он текстовый формат
  SELECT customer_name INTO user_name FROM customers WHERE customer_id = user_id_param;
  -- Возврат продуктов, связанных с пользователем
  RETURN QUERY
  SELECT p.product_id, p.product
  FROM products p
  JOIN orders o ON p.product_id = o.product_id
  WHERE o.customer_id = user_id_param;
  -- Вывод сообщения с именем пользователя
  RAISE NOTICE 'Продукты пользователя %:', user_name;
END;
$$ LANGUAGE plpgsql;
--вызовем функцию для id покупателя 
SELECT * FROM get_user_products('c015');