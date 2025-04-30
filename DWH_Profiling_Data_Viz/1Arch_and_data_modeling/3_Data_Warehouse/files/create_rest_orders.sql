-- 1 dishes
CREATE TABLE dishes (
object_id SERIAL PRIMARY KEY,
name VARCHAR(128) NOT NULL,
spicy INT NOT NULL,
fish INT NOT NULL,
meat INT NOT NULL
);
-- 2 dishes_prices
CREATE TABLE dishes_prices  (
dishes_id INT REFERENCES dishes(object_id),
price DECIMAL(14, 2) NOT NULL,
date_begin timestamp NOT NULL,
date_edn timestamp
);
--3 cities
CREATE TABLE cities (
city_id SERIAL PRIMARY KEY,
city_name VARCHAR(50) NOT NULL
);
-- 4 statuses
CREATE TABLE statuses (
status_id SERIAL PRIMARY KEY,
status_name VARCHAR(50) NOT NULL
);

-- 5 users
CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
city_id INT NOT NULL,
gender VARCHAR(50), 
birth_date DATE,
registration_date DATE 
);
--6 orders
CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
order_dt timestamp NOT NULL,
user_id INT REFERENCES users (user_id),
device_type VARCHAR(50) NOT NULL,
city_id INT REFERENCES users (user_id),
total_cost DECIMAL(14, 2) NOT NULL,
discount numeric(14,2),
final_cost numeric(14,2)
);
-- 7 order_statuses
CREATE TABLE order_statuses (
order_id INT REFERENCES orders(order_id),
status_id INT REFERENCES statuses(status_id),
status_dt timestamp
);
-- 8 order_items
CREATE TABLE oorder_items (
order_id INT REFERENCES orders(order_id),
item INT REFERENCES dishes (object_id),
status_dt timestamp
);