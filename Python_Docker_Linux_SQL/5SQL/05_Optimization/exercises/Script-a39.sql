--Разделите таблицу orders на партиции по месяцам (т.к. год один у меня), 
--используя столбец с датой
--шаг1 определю какие периоды есть и на сколько месяцев делить
SELECT min(order_date::DATE), max(order_date::DATE)
FROM orders;

-- соберем  таблицу orders_range берем не все столбцы секционированной по диапазону дат. 
CREATE TABLE orders_range (
       order_id     varchar(50),
       customer_id  int4,
       order_date   varchar(50),
       id_product   int4,
       unit_price   int4,
       quantity     int4,
       amount       int4,
       product_type varchar(50),
       product      varchar(50)
       ) PARTITION BY RANGE(order_date);

--Отдельные секции на каждый месяц:
CREATE TABLE orders_ranget_y2025m01 PARTITION OF orders_range
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

CREATE TABLE orders_range_y2025m02 PARTITION OF orders_range
    FOR VALUES FROM ('2025-02-01') TO ('2025-03-01');

CREATE TABLE orders_range_y2025m04 PARTITION OF orders_range
    FOR VALUES FROM ('2025-03-01') TO ('2025-04-01');

INSERT INTO orders_range SELECT * FROM orders;
--За декларативным синтаксисом по-прежнему скрываются наследуемые таблицы, 
--поэтому распределение строк по секциям можно посмотреть запросом:
SELECT tableoid::regclass, count(*) FROM orders_range GROUP BY tableoid;

--А в родительской таблице данных нет
SELECT * FROM ONLY orders_range;