-- Создание базы данных
CREATE DATABASE IF NOT EXISTS module6;
USE module6;

-- Копия таблиц для де монстрации
CREATE TABLE courses SELECT * FROM courses.courses;
CREATE TABLE teachers SELECT * FROM courses.teachers;
CREATE TABLE lessons SELECT * FROM courses.lessons;

-- Создание процедуры
DELIMITER |
DROP PROCEDURE IF EXISTS sp_sample_1 |
CREATE PROCEDURE sp_sample_1()
BEGIN
	SELECT 'Список предодавателей' AS ' ';
	SELECT name FROM teachers ORDER BY name;
END;
|
DELIMITER ;

-- Вызов процедуры
CALL sp_sample_1();


-- Процедуры с параметрами
DELIMITER |
DROP PROCEDURE IF EXISTS sp_course_by_date |

CREATE PROCEDURE sp_course_by_date (IN teacher_id INT, IN course_date DATE)
BEGIN
	SELECT courses.id, courses.title
		FROM courses
			INNER JOIN lessons ON courses.id = lessons.course
		WHERE lessons.lesson_date = course_date
		  AND lessons.teacher = teacher_id;
END;
|

DELIMITER ;

-- Вызов процедуры
CALL sp_course_by_date (1, '2006-09-15');
CALL sp_course_by_date (2, '2006-09-15');



-- Какие занятия были в указанный месяц и год
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

-- Коды ошибок
-- http://dev.mysql.com/doc/refman/5.1/en/error-messages-server.html



-- Какие занятия были в указанный месяц и год
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
	
	-- Проверим, сколько записей удалось выбрать
	IF record_count = 0 THEN
		-- Данных нет. Вернем предупреждающую таблицу
		SELECT 0 AS id, 'Данных нет' AS title;
	ELSE
		-- Вернем результат
		SELECT * 
			FROM course_by_dates_results;	
	END IF;
	
	-- Удалим временную таблицу
	DROP TEMPORARY TABLE course_by_dates_results;	
END;
|

DELIMITER ;

-- Вызов процедуры
CALL sp_course_by_dates ('2006-09-15', '2006-09-25', @count);
SELECT @count;

-- Вызов процедуры
CALL sp_course_by_dates ('2009-09-15', '2009-09-25', @count);
SELECT @count;

