-- Archive
CREATE TABLE country0 ENGINE=ARCHIVE  SELECT * FROM world.country;
-- Пример тормозного запроса	(10.20 sec)
SELECT COUNT(*) 
	FROM country0 c1 
	WHERE EXISTS (SELECT * FROM country0 c2 WHERE c1.name = c2.name);
	
-- Memory
CREATE TABLE country1 ENGINE=MEMORY  SELECT * FROM world.country;
-- Пример тормозного запроса	(10.20 sec)
SELECT COUNT(*) 
	FROM country1 c1 
	WHERE EXISTS (SELECT * FROM country1 c2 WHERE c1.name = c2.name);
	
--процедура из базы module6 на InnoDB
DELIMITER |
DROP PROCEDURE IF EXISTS sp_course_by_dates |

CREATE PROCEDURE sp_course_by_dates 
	(IN date_start DATE, IN date_end DATE, OUT record_count INT)
BEGIN
	-- Создадим временную таблицу с результатами запроса
	CREATE TEMPORARY TABLE course_by_dates_results
		SELECT courses.id, courses.title
			FROM courses
				INNER JOIN lessons ON courses.id = lessons.course
			WHERE lessons.lesson_date BETWEEN date_start AND date_end;
	-- Посчитаем сколько в ней записей в переменную
	SELECT COUNT(*) INTO record_count 
		FROM course_by_dates_results;
	-- Вернем результат
	SELECT * 
		FROM course_by_dates_results;	
	-- Удалим временную таблицу
	DROP TEMPORARY TABLE course_by_dates_results;
END;
|

DELIMITER ;

-- Вызов процедуры
CALL sp_course_by_dates ('2006-09-15', '2006-09-25', @count);
SELECT @count;

--процедура из базы module6 на MEMORY
DELIMITER |
DROP PROCEDURE IF EXISTS sp_course_by_dates |

CREATE PROCEDURE sp_course_by_dates 
	(IN date_start DATE, IN date_end DATE, OUT record_count INT)
BEGIN
	-- Создадим временную таблицу с результатами запроса
	CREATE TEMPORARY TABLE course_by_dates_results ENGINE=MEMORY
		SELECT courses.id, courses.title
			FROM courses
				INNER JOIN lessons ON courses.id = lessons.course
			WHERE lessons.lesson_date BETWEEN date_start AND date_end;
	-- Посчитаем сколько в ней записей в переменную
	SELECT COUNT(*) INTO record_count 
		FROM course_by_dates_results;
	-- Вернем результат
	SELECT * 
		FROM course_by_dates_results;	
	-- Удалим временную таблицу
	DROP TEMPORARY TABLE course_by_dates_results;
END;
|

DELIMITER ;

-- Вызов процедуры
CALL sp_course_by_dates ('2006-09-15', '2006-09-25', @count);
SELECT @count;

--Переключитесь на базу данных test
USE test;

--Создайтедветаблицыcity1иcity2пообразу таблицыcityизбазыданныхworld

CREATE TABLE city1 LIKE world.city;
CREATE TABLE city2 LIKE world.city;

--Удалитеколонкуidизтабдицыcity1
ALTER TABLE city1 DROP COLUMN id;

--Добавьтеновуюколонкуid(безAUTO_INCREMENT!) втаблицуcity1
ALTER TABLE city1 ADD COLUMN id INT;

--Изменитетипхранилищадлятаблицыcity1
ALTER TABLE city1 ENGINE=ARCHIVE;

--Скопируйтеданныевтаблицуcity1изтаблицыcity базыданныхworld

INSERT INTO city1 (id, Name, CountryCode, District, Population)
	SELECT id, Name, CountryCode, District, Population
	FROM world.city;
	
--Изменитетипхранилищадлятаблицыcity2
ALTER TABLE city2 ENGINE=MEMORY;

--Скопируетеданныевтаблицуcity2изтаблицыcity базыданныхworld
INSERT INTO city2 SELECT * FROM world.city;

--выполнить запросы
SELECT name, population
FROM city1
WHERE name LIKE '%os%'
ORDER BY population;

SELECT name, population
FROM city2
WHERE name LIKE '%os%'
ORDER BY population;

--Попробуйтеизменитьтипхранилищатаблицыcity2
ALTER TABLE city2 ENGINE=MyISAM;