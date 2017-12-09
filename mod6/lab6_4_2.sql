-- Создание базы данных
DROP DATABASE IF EXISTS world_2;
CREATE DATABASE IF NOT EXISTS world_2;
USE world_2;

-- Копия таблиц для де монстрации
CREATE TABLE city SELECT * FROM world.city;
CREATE TABLE country SELECT * FROM world.country;
CREATE TABLE countrylanguage SELECT * FROM world.countrylanguage;


-- Тaблица журнала операций
DROP TABLE IF EXISTS insert_log;
CREATE TABLE insert_log
(
	date DATETIME COMMENT 'Дата и время операции',
	user VARCHAR(50) COMMENT 'Кто сделал изменения',
	name_city CHAR(35),
	ccode CHAR(3),
	dis CHAR(20),
	pop INT(11)
);

		
		
-- при вставке города с несуществующим кодом менять новый код на RUS
DELIMITER |
DROP TRIGGER IF EXISTS tg_incorrectcode_insert |
CREATE TRIGGER tg_incorrectcode_insert BEFORE INSERT ON city
FOR EACH ROW BEGIN
	IF NOT EXISTS (SELECT code FROM country WHERE NEW.countrycode = code) THEN
		
		INSERT INTO insert_log VALUES (NOW(), USER(), NEW.name, NEW.countrycode, NEW.district, NEW.population);
		SET NEW.countrycode = 'RUS';
	END IF;
END;
|
DELIMITER ;


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

INSERT INTO city (name, countrycode, district, population) VALUES ('Zapupinsk', 'RUS', 'pupik', 40);
INSERT INTO city (name, countrycode, district, population) VALUES ('Zrewwrwe', 'Rrr', 'prrpik', 466);
INSERT INTO city (name, countrycode, district, population) VALUES ('rrrr', 'wwe', 'prrprrrik', 466);
INSERT INTO city VALUES (5000, 'Zasransk', 'ZZZ', 'ZASr', 10);

SELECT * FROM city WHERE name = 'rrrr';
SELECT * FROM city WHERE name = 'Zasransk';
SELECT * FROM city WHERE name = 'Zrewwrwe';


SELECT * FROM insert_log;