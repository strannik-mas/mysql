-- Создание базы данных
CREATE DATABASE IF NOT EXISTS module6;
USE module6;

-- Копия таблиц для демонстрации
CREATE TABLE courses SELECT * FROM course.courses;
CREATE TABLE teachers SELECT * FROM course.teachers;
CREATE TABLE lessons SELECT * FROM course.lessons;


-- Используем функцию
SELECT room, lesson_date
	FROM lessons
	ORDER BY room;




-- Функция возвращает номер аудитории  'БК-1' в виде числа
DELIMITER |
DROP FUNCTION IF EXISTS sp_room_number |
CREATE FUNCTION sp_room_number (room VARCHAR(5)) RETURNS INT
BEGIN
	RETURN SUBSTR(room, 4) * 1;
END;
|
DELIMITER ;

-- Вызов процедуры
SELECT sp_room_number('БК-10');

-- Используем функцию
SELECT room, lesson_date
	FROM lessons
	ORDER BY sp_room_number(room);
