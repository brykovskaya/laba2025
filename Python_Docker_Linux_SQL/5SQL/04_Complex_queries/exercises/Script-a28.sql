-- Создадим таблицу студентов
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    major VARCHAR(255)
);

-- Заполним таблицу студентов данными
INSERT INTO students (student_name, major) VALUES
('Иван Иванов', 'Информатика'),
('Петр Петров', 'Математика'),
('Светлана Сидорова', 'Информатика'),
('Анна Кузнецова', 'Физика'),
('Алексей Смирнов', 'Математика');

-- Создадим таблицу курсов
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT
);

-- Заполним таблицу курсов данными
INSERT INTO courses (course_name, credits) VALUES
('Базы данных', 3),
('Алгоритмы', 4),
('Физика 1', 4),
('Линейная алгебра', 3);

-- Создадим таблицу зачислений
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade INT
);

-- Заполним таблицу зачислений данными
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 4),
(1, 2, 5),
(2, 2, 3),
(3, 1, 5),
(4, 3, 4),
(5, 4, 5);

--проверим созданные таблицы
SELECT *
FROM students

SELECT *
FROM courses

SELECT *
FROM enrollments

WITH
  -- Первый CTE: выбираем студентов и их специальности
  StudentsWithMajors AS (
    SELECT
      s.student_id,
      s.student_name,
      s.major
    FROM
      students s
  ),
  -- Второй CTE: считаем средний балл для каждого студента
  StudentAverageGrades AS (
    SELECT
      e.student_id,
      AVG(e.grade) AS average_grade
    FROM
      enrollments e
    GROUP BY
      e.student_id
  ),
  -- Третий CTE: считаем количество курсов для каждого студента
  StudentCourseCounts AS (
    SELECT
      e.student_id,
      COUNT(DISTINCT e.course_id) AS course_count
    FROM
      enrollments e
    GROUP BY
      e.student_id
  )
-- Выбираем информацию из всех трех CTE
SELECT
  sm.student_name,
  sm.major,
  ROUND(sag.average_grade,1) AS avd_grade,
  scc.course_count
FROM
  StudentsWithMajors sm
JOIN
  StudentAverageGrades sag ON sm.student_id = sag.student_id
JOIN
  StudentCourseCounts scc ON sm.student_id = scc.student_id;