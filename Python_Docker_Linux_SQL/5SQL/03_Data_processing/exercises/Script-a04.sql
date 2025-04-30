CREATE TABLE items (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255)
);

INSERT INTO items (name) VALUES ('Item A'),('Item B'), ('Item C'), ('Item D');

SELECT * FROM items;

TRUNCATE TABLE items;

INSERT INTO items (name) VALUES ('Item A'),('Item B'), ('Item C'), ('Item D');

SELECT * FROM items;

TRUNCATE TABLE items RESTART IDENTITY;
INSERT INTO items (name) VALUES ('Item A'),('Item B'), ('Item C'), ('Item D');
SELECT * FROM items;