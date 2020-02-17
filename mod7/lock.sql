-- Создание базы данных
CREATE DATABASE IF NOT EXISTS module7;
USE module7;
-- Копия таблиц для демонстрации
CREATE TABLE courses SELECT * FROM courses.courses;
CREATE TABLE teachers SELECT * FROM courses.teachers;
CREATE TABLE lessons SELECT * FROM courses.lessons;


LOCK TABLES teachers READ;

SELECT name FROM teachers;

INSERT INTO teachers (id, name) VALUES (10, 'Новый преподаватель23');
INSERT DELAYED INTO teachers (id, name) VALUES (10, 'Новый преподаватель');

UNLOCK TABLES;

LOCK TABLES teachers WRITE;

SELECT name FROM teachers;

DELETE FROM teachers WHERE id = 10;

UNLOCK TABLES;

-- "Блокировка" записей
SELECT GET_LOCK('abc', 10);
SELECT RELEASE_LOCK('abc');





