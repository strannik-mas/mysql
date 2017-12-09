-- Создание базы данных
DROP DATABASE IF EXISTS course_1;
CREATE DATABASE IF NOT EXISTS course_1;
USE course_1;

-- Копия таблиц для де монстрации
CREATE TABLE courses SELECT * FROM course.courses;
CREATE TABLE teachers SELECT * FROM course.teachers;
CREATE TABLE lessons SELECT * FROM course.lessons;

-- Создайте триггер для таблицы teachers, удаляющий все записи о занятиях при удалении преподавателя
DELIMITER |
DROP TRIGGER IF EXISTS tg_teacherlesson_delete |
CREATE TRIGGER tg_teacherlesson_delete AFTER DELETE ON teachers
FOR EACH ROW BEGIN
	DELETE FROM lessons WHERE teacher = OLD.id;
END;
|
DELIMITER ;

-- Создайте триггер, удаляющий все записи о занятиях при удалении курса

DELIMITER |
DROP TRIGGER IF EXISTS tg_lessononcourse_delete |
CREATE TRIGGER tg_lessononcourse_delete AFTER DELETE ON courses
FOR EACH ROW BEGIN
	DELETE FROM lessons WHERE course = OLD.id;
END;
|
DELIMITER ;

-- Создайте триггер, обновляющий код курса в таблице lessons при его обновлении кода в таблице course

DELIMITER |
DROP TRIGGER IF EXISTS tg_codecourse_update |
CREATE TRIGGER tg_codecourse_update AFTER UPDATE ON courses
FOR EACH ROW BEGIN
	-- Если код изменился...
	IF OLD.id <> NEW.id THEN
		-- Обновим таблицы
		UPDATE lessons SET course = NEW.id WHERE course = OLD.id;
	END IF;
END;
|
DELIMITER ;

UPDATE couses SET id = 61 WHERE id = 6;

-- Аналогично создайте триггер обновления кода преподавателя

DELIMITER |
DROP TRIGGER IF EXISTS tg_codeteacher_update |
CREATE TRIGGER tg_codeteacher_update AFTER UPDATE ON teachers
FOR EACH ROW BEGIN
	-- Если код изменился...
	IF OLD.id <> NEW.id THEN
		-- Обновим таблицы
		UPDATE lessons SET teacher = NEW.id WHERE teacher = OLD.id;
	END IF;
END;
|
DELIMITER ;

UPDATE teachers SET id = 13 WHERE id = 2;


















-- при обновлении кода страны обновлять соответствующие коды в city и countrylanguage

DELIMITER |
DROP TRIGGER IF EXISTS tg_codecountry_update |
CREATE TRIGGER tg_codecountry_update AFTER UPDATE ON country
FOR EACH ROW BEGIN
	-- Если код изменился...
	IF OLD.code <> NEW.code THEN
		-- Обновим таблицы
		UPDATE city SET countrycode = NEW.code WHERE countrycode = OLD.code;
		UPDATE countrylanguage SET countrycode = NEW.code WHERE countrycode = OLD.code AND language LIKE CONCAT(SUBSTRING(OLD.name, 1, 3), '%');
	END IF;
END;
|
DELIMITER ;

-- Меняем коды
UPDATE country SET code = 'USR' WHERE name = "Russian Federation";


-- при вставке города с несуществующим кодом менять новый код на RUS
DELIMITER |
DROP TRIGGER IF EXISTS tg_incorrectcode_insert |
CREATE TRIGGER tg_incorrectcode_insert AFTER INSERT ON city
FOR EACH ROW BEGIN
	IF NOT EXISTS (SELECT code FROM country WHERE NEW.countrycode = code) THEN
		-- UPDATE city SET countrycode = 'RUS' WHERE countrycode = NEW.countrycode;
		INSERT INTO city (name, countrycode, district, population) VALUES (NEW.name, 'RUS', NEW.district, NEW.population);
	END IF;
END;
|
DELIMITER ;
-- при удалении страны удалять все города и записи в countrylanguage, относящиеся к этой стране
DELIMITER |
DROP TRIGGER IF EXISTS tg_country_delete |
CREATE TRIGGER tg_country_delete AFTER DELETE ON country
FOR EACH ROW BEGIN
	DELETE FROM city WHERE countrycode = OLD.code;
	DELETE FROM countrylanguage 
		WHERE countrycode = OLD.code
		AND language LIKE CONCAT(SUBSTRING(OLD.name, 1, 3), '%');
END;
|
DELIMITER ;

-- Производим разные изменения
UPDATE country SET code = 'URO' WHERE name = "Ukraine";
DELETE FROM country WHERE name = "Ukraine";

INSERT INTO city (name, countrycode, district, population) VALUES ('Urupinck', 'RUS', 'CUrup', 200);
INSERT INTO city (name, countrycode, district, population) VALUES ('Zasransk', 'ZZZ', 'ZASr', 10);

