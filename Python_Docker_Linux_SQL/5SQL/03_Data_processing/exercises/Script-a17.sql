--Упражнение - WHERE
--Упражнение 1: Выбрать все продукты из таблицы products 
--с ценой (меняю услвоия)выше 10 тыс и ниже 50 тыс
SELECT * 
FROM products
WHERE price BETWEEN 10001 AND 50000;

--Упражнение 2: Выбрать всех сотрудников из таблицы employees с должностью 'Manager' и зарплатой выше 50000.
--меняю под свою таблицу условия выборки:   department 'Продажи' и зарплатой выше 5000.
SELECT * 
FROM employees
WHERE department = 'Продажи'
  AND salary > 5000;