--задание1
--Создайте таблицу для хранения информации о фильмах. Добавьте поле details типа JSONB 
--для хранения дополнительных данных о фильме (режиссер, актеры, жанр).

--шаг1 Создание таблицы с JSON полем
CREATE TABLE movies (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    details JSONB
);
-- шаг 2 Вставка данных с JSON
INSERT INTO movies (title, release_year, details)
VALUES (
        'Inception',
        2010,
        '{"director": "Christopher Nolan", "actors": ["Leonardo DiCaprio", "Joseph Gordon-Levitt", "Elliot Page"], "genre": "Sci-Fi"}'
    ),
    (
        'The Godfather',
        1972,
        '{"director": "Francis Ford Coppola", "actors": ["Marlon Brando", "Al Pacino", "James Caan"], "genre": "Crime"}'
    ),
    (
        'Pulp Fiction',
        1994,
        '{"director": "Quentin Tarantino", "actors": ["John Travolta", "Uma Thurman", "Samuel L. Jackson"], "genre": "Crime"}'
    ),
    (
        'The Shawshank Redemption',
        1994,
        '{"director": "Frank Darabont", "actors": ["Tim Robbins", "Morgan Freeman"], "genre": "Drama"}'
    ),
    (
        'The Dark Knight',
        2008,
        '{"director": "Christopher Nolan", "actors": ["Christian Bale", "Heath Ledger", "Aaron Eckhart"], "genre": "Action"}'
    ),
    (
        'Forrest Gump',
        1994,
        '{"director": "Robert Zemeckis", "actors": ["Tom Hanks", "Robin Wright"], "genre": "Drama"}'
    ),
    (
        'The Matrix',
        1999,
        '{"director": "Lana Wachowski, Lilly Wachowski", "actors": ["Keanu Reeves", "Laurence Fishburne", "Carrie-Anne Moss"], "genre": "Sci-Fi"}'
    ),
    (
        'Fight Club',
        1999,
        '{"director": "David Fincher", "actors": ["Brad Pitt", "Edward Norton", "Helena Bonham Carter"], "genre": "Drama"}'
    ),
    (
        'The Lord of the Rings: The Fellowship of the Ring',
        2001,
        '{"director": "Peter Jackson", "actors": ["Elijah Wood", "Ian McKellen", "Orlando Bloom"], "genre": "Fantasy"}'
    ),
    (
        'Gladiator',
        2000,
        '{"director": "Ridley Scott", "actors": ["Russell Crowe", "Joaquin Phoenix", "Connie Nielsen"], "genre": "Action"}'
    );

--задание2
--Напишите запрос, который выводит название фильма, год выпуска и имя режиссера для всех фильмов в базе данных.
SELECT title,
    release_year,
    details->>'director' AS director
FROM movies;

--задание3
--Найдите все фильмы, снятые определенным режиссером.
SELECT title,
    release_year,
    details->>'director' AS director
FROM movies
WHERE details->>'director' = 'David Fincher';

-- задание 4
--Выведите список всех жанров фильмов, хранящихся в базе данных.
SELECT 
	ROW_NUMBER() OVER () AS num, -- добавим нумерацию
	details->>'genre' AS genre
FROM movies
GROUP BY genre; -- уберем дубликаты

