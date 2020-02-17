-- Создание базы данных
CREATE DATABASE IF NOT EXISTS module4;
USE module4;

-- Таблица с данными
CREATE TABLE courses1 ENGINE=MyISAM SELECT * FROM course.courses;

-- Создадим полнотекстовый индекс
CREATE FULLTEXT INDEX ixFullText ON courses1 (title, description);

-- Поиск в режиме естественного языка
SELECT title, length 
	FROM courses1
	WHERE MATCH (title, description) 
		AGAINST ('mysql' IN NATURAL LANGUAGE MODE);
		
-- Поиск в режиме естественного языка
SELECT title, length 
	FROM courses1
	WHERE MATCH (title, description) 
		AGAINST ('сервер' IN NATURAL LANGUAGE MODE);

-- Поиск в режиме логического сравнения
SELECT title, length 
	FROM courses1
	WHERE MATCH (title, description) 
		AGAINST ('-mysql +программирования' IN BOOLEAN MODE);

-- Поиск в режиме логического сравнения
SELECT title, length 
	FROM courses1
	WHERE MATCH (title, description) 
		AGAINST ('-mysql +программ*' IN BOOLEAN MODE);		
		
-- Поиск в смешанном режиме (сортировка в режиме естественного языка, фильтрация в режиме логичесом)
-- Логический режим с сортировкой по релевантности
SELECT title, length, 
		MATCH (title, description) AGAINST ('php'  IN NATURAL LANGUAGE MODE) AS score  
	FROM courses
	WHERE MATCH (title, description) 
		AGAINST ('php' IN BOOLEAN MODE)
	ORDER BY score DESC;
		
		
-- Переиндексация
REPAIR TABLE courses1 QUICK;

--переменная ограничивающая слова в полнотекстовом индексе ft_min_word_len=4
		