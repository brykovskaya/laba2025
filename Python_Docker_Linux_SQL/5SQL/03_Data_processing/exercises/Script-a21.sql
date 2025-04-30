--Упражнение - EXISTS
--Проверьте, есть ли товары в категории "Электроника", цена которых выше 1000.
--меняю на 6 проверьте есть ли customer_id купившие товар id_product в количестве более 12 штук в одном заказе
SELECT EXISTS(
	SELECT customer_id 
	FROM orders 
	WHERE quantity > 12);

--Проверьте, есть ли товары в категории "Электроника", цена которых выше 1000.
--меняю на : проверьте есть ли customer_id купившие товар id_product в количестве более 20 штук в одном заказе
SELECT EXISTS(
	SELECT customer_id 
	FROM orders 
	WHERE quantity > 20);

