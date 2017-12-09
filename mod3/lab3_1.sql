CREATE DATABASE IF NOT EXISTS courses;

USE courses;

CREATE TABLE teachers
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID препода',
	name VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Имя препода',
	addr VARCHAR(150) NOT NULL DEFAULT '' COMMENT 'Адрес препода',
	phone VARCHAR(12) COMMENT 'телефон',
	PRIMARY KEY (id)
) COMMENT 'Таблица преподов с первичным ключом';

CREATE TABLE lessons
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID урока',
	teacher VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Имя препода из др.таблицы',
	course VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'название курса из др. таблицы',
	room INT UNSIGNED NOT NULL COMMENT 'аудитория',
	`length` VARCHAR(15) NOT NULL DEFAULT '1 час 30 мин' COMMENT 'продолжительность',
	lesson_date DATE NOT NULL COMMENT 'дата занятия',
	PRIMARY KEY (id)
) COMMENT 'Таблица уроков с первичным ключом';

CREATE TABLE courses
(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID курса',
	title VARCHAR(15) NOT NULL DEFAULT '' COMMENT 'название курса',	
	`length` VARCHAR(15) NOT NULL DEFAULT '12 часов' COMMENT 'продолжительность всего курса',
	description VARCHAR(150) NOT NULL COMMENT 'описание курса',
	category VARCHAR(15) NOT NULL COMMENT 'категория курса',
	previous VARCHAR(15) NOT NULL COMMENT 'какому курсу пришел на смену',
	PRIMARY KEY (id)
) COMMENT 'Таблица курсов с первичным ключом';