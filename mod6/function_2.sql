USE course;
SELECT * FROM teachers;
-- количество символов
SELECT name, CHAR_LENGTH(name) FROM teachers;
-- количество байт
SELECT name, LENGTH(name) FROM teachers;
-- показать как создавалась таблица
SHOW CREATE TABLE teachers;

SELECT name, REPLACE (name, 'Иван', 'Абдула') FROM teachers;

SELECT name
FROM teachers
ORDER BY RAND()
LIMIT 2;

-- выбрать все занятия 2006

SELECT DISTINCT title
FROM courses INNER JOIN lessons
ON lessons.course = courses.id
WHERE YEAR(lesson_date) = 2006;

SELECT lesson_date, UNIX_TIMESTAMP(lesson_date), FROM_UNIXTIME(UNIX_TIMESTAMP(lesson_date))
FROM lessons;