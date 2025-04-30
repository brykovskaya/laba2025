--создали таблицу posts
CREATE TABLE posts (
	id SERIAL PRIMARY KEY,
	table1 VARCHAR(50) NOT NULL,
	table2 VARCHAR(50) NOT NULL,
	table3 VARCHAR(50),
	table14 NUMERIC(8, 2)
);
INSERT INTO posts (table1, table2, table3,  table14)
VALUES 
(	'1'	,	'2', '3',	4)	

SELECT * FROM posts LIMIT 5;

--создали таблицу users
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	tab_1 VARCHAR(50) NOT NULL,
	tab_2 VARCHAR(50) NOT NULL
	);
INSERT INTO users (tab_1, tab_2)
VALUES ('one',	'two')	;

SELECT *
FROM posts;
SELECT *
FROM users;

--Упражнения — DCL (psql)
-- Создайте пользователя `editor` и дайте ему права на чтение и запись данных в таблицу `posts`/
CREATE USER editor WITH PASSWORD '123456';
GRANT SELECT, INSERT, UPDATE ON posts TO editor;

-- Создайте роль `admin` и дайте ей все права на базу данных.
CREATE ROLE admin WITH PASSWORD 'admin';
GRANT ALL PRIVILEGES ON DATABASE aston TO admin; 

-- У пользователя `editor` отнимите право на удаление данных из таблицы `posts`.
REVOKE DELETE ON posts FROM editor;

-- У пользователя `admin` отнимите право на передачу другим пользователям права на изменение данных в таблице `users`
REVOKE GRANT OPTION FOR UPDATE ON users FROM ADMIN;
-- Удалите пользователя `editor` вместе со всеми его привилегиями.
REVOKE ALL PRIVILEGES ON posts FROM editor;
DROP USER editor;