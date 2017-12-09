CREATE DATABASE IF NOT EXISTS courses;

USE courses;
--таблицы со связями
CREATE TABLE teachers
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID препода',
	name VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Имя препода',
	addr VARCHAR(150) NOT NULL DEFAULT '' COMMENT 'Адрес препода',
	phone VARCHAR(12) COMMENT 'телефон',
	CONSTRAINT pkId PRIMARY KEY (id),
	CONSTRAINT ixName UNIQUE KEY (name)
) COMMENT 'Таблица преподов';

CREATE TABLE lessons
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID урока',
	teacher VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Имя препода из др.таблицы',
	course VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'название курса из др. таблицы',
	room INT UNSIGNED NOT NULL COMMENT 'аудитория',
	length VARCHAR(15) NOT NULL DEFAULT '1 час 30 мин' COMMENT 'продолжительность',
	lesson_date DATE NOT NULL COMMENT 'дата занятия',
	CONSTRAINT pkIdLess PRIMARY KEY (id),
	INDEX ixT (teacher),
	CONSTRAINT fkTableLessTeachName FOREIGN KEY (teacher) 
		REFERENCES teachers (name),
	INDEX ixC (course),
	CONSTRAINT fkTableLessCourseName FOREIGN KEY (course) 
		REFERENCES courses (title),
	INDEX ixD (lesson_date)
) COMMENT 'Таблица уроков';

CREATE TABLE courses
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID курса',
	title VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'название курса',	
	`length` VARCHAR(15) NOT NULL DEFAULT '12 часов' COMMENT 'продолжительность всего курса',
	description VARCHAR(150) NOT NULL COMMENT 'описание курса',
	category VARCHAR(15) NOT NULL COMMENT 'категория курса',
	previous VARCHAR(15) NOT NULL COMMENT 'какому курсу пришел на смену',
	INDEX ixCat (category),
	CONSTRAINT pkIdCourses PRIMARY KEY (id),
	CONSTRAINT ixTitle UNIQUE KEY (title),

--	CONSTRAINT ixPrev UNIQUE KEY (previous)
	INDEX ixPrev (previous),
	CONSTRAINT fkTableCourses FOREIGN KEY (previous) 
		REFERENCES courses (title)
) COMMENT 'Таблица курсов';


-- Схема БД сервера
USE information_schema;
--получение инфы о внешних связях
SELECT constraint_name, unique_constraint_name, referenced_table_name
	FROM information_schema.referential_constraints
	WHERE table_name = 'lessons';