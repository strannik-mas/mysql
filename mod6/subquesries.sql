-- Создание базы данных
CREATE DATABASE IF NOT EXISTS module5;
USE module5;

-- Копия таблиц для демонстрации
CREATE TABLE courses SELECT * FROM course.courses;
CREATE TABLE teachers SELECT * FROM course.teachers;
CREATE TABLE lessons SELECT * FROM course.lessons;

-- Какие курсы читались в аудиториях БК-1, БК-2, БК-3
SELECT courses.title, lessons.room
	FROM courses 
		INNER JOIN lessons ON courses.id = lessons.course
	WHERE lessons.room IN ('БК-1', 'БК-2', 'БК-3')
\g


-- В каких классах были занятия 15-го числа
SELECT room
	FROM lessons 
	WHERE lesson_date BETWEEN '2006-09-15' AND '2006-09-18';
	
	
	

-- Вложенный запрос
SELECT courses.title, lessons.room
	FROM courses 
		INNER JOIN lessons ON courses.id = lessons.course
	WHERE lessons.room IN 
	(
		-- В каких классах были занятия 15-го числа
		SELECT room
			FROM lessons 
			WHERE lesson_date BETWEEN '2006-09-15' AND '2006-09-18'		
	)
\g







-- Использование EXISTS
INSERT INTO lessons (room, teacher, course, lesson_date)
	VALUES ('БК-25', 0, 0, '2006-10-30');

-- Выбрать все курсы, которые хотя бы раз читались преподавтелями
SELECT courses.title
	FROM courses
	WHERE EXISTS 
	(
		SELECT * FROM lessons
			WHERE lessons.course = courses.id
	)
\g	
	
-- Псевдонимы

-- Когда и где читался курс PHP
SELECT l.room, l.lesson_date 
	FROM lessons l
		INNER JOIN courses c ON l.course = c.id
	WHERE c.title LIKE '%php%';
	
	
	
	
	

CREATE TABLE city SELECT * FROM world.city;
	
-- Пример тормозного запроса
SELECT COUNT(*) 
	FROM city c1 
	WHERE EXISTS (SELECT * FROM city c2 WHERE c1.name = c2.name)
\g

ALTER TABLE city ENGINE=MyISAM;	
ALTER TABLE city ENGINE=InnoDB;	
	
	
	