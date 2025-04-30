CREATE TABLE Сотрудники (
    id serial PRIMARY KEY,
    имя VARCHAR(255),
    зарплата DECIMAL
);
CREATE TABLE Отделы (
    id serial PRIMARY KEY,
    название VARCHAR(255),
    расположение VARCHAR(255)
);
