do $$
declare 
userid text; --объявляем переменные 
username text;
productprice integer;
begin
	userid := 'c001'; -- присвоили значение переменной
--присвоим результат запроса в переменную username
	select customer_name into username from customers where customer_id = userid; 
	if found then
		raise notice 'Фамилия покупателя:%', username;
	else
		raise notice 'Покупатель не найден';
	end if;
--ищем определенный продукт и выводим для него цену
	select price into productprice from products where product_id = 'pr0001'; 
	--проверка результатов исполнения кода и присвоения значений объявленными переменным
	if found then
		raise notice 'Цена продукта:%',productprice;
	else
		raise notice 'продукт не найден';
	end if;
end $$;
