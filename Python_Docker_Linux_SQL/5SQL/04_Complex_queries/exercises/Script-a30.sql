--найдем все заказы, общее кол-во товара в которых 
--превышает среднее число товара в  заказах

SELECT id_order, quantity
FROM orders
WHERE quantity > (
  SELECT avg(quantity)  FROM orders
)
ORDER BY quantity DESC;



