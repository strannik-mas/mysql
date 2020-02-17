--создать процедуру, отображающую страны по континенту
DROP PROCEDURE IF EXISTS getCountries;
delimiter |
CREATE DEFINER = 'root'@'localhost' PROCEDURE getCountries(IN c VARCHAR(20))
BEGIN
    SELECT name FROM  country
    WHERE continent = c;
END;
|
delimiter ;

CALL getCountries('Asia');
CALL getCountries('Europe');

--получить список городов снраны с названием TITLE у которых население более числа N
DROP PROCEDURE IF EXISTS getCities;
delimiter |
CREATE PROCEDURE getCities(IN title CHAR(35), IN n INTEGER)
BEGIN
    DECLARE done TINYINT DEFAULT 0;
    DECLARE cityname CHAR(35);
    DECLARE citycode, currentcode CHAR(3);
    DECLARE citypop INT;
    DECLARE cur1 CURSOR FOR SELECT name, population, countrycode FROM city;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
    
    SELECT code INTO currentcode FROM country
    WHERE country.name = title;

    DROP TEMPORARY TABLE IF EXISTS tmpcity;
    CREATE TEMPORARY TABLE tmpcity(
        name CHAR(35)
    );
    
    OPEN cur1;
    
    REPEAT
    FETCH cur1 INTO cityname, citypop, citycode;
    IF NOT done THEN
        IF citypop > n AND citycode = currentcode THEN
            INSERT INTO tmpcity VALUES (cityname);
        END IF;
    END IF;
    
    UNTIL done END REPEAT;
    
    CLOSE cur1;
    
    SELECT * FROM tmpcity;
    
    DROP TEMPORARY TABLE tmpcity;
END;
|
delimiter ;

CALL getCities('Russian Federation', 7e6);


--Функции
SELECT * FROM teachers;
SELECT name, CHAR_LENGTH(name) FROM teachers;
SELECT name, LENGTH(name) FROM teachers;
SELECT name, REPLACE(name, 'Иван', 'Пётр') FROM teachers;
SELECT name, SOUNDEX(name) FROM teachers;
SELECT name FROM teachers ORDER BY RAND() LIMIT 2;

--выбрать все занятия, которые были в  2006 году
SELECT DISTINCT title FROM courses INNER JOIN lessons ON lessons.course = courses.id
WHERE YEAR(lesson_date) = 2006;

--конвертация времени во временную метку
SELECT lesson_date, UNIX_TIMESTAMP(lesson_date), FROM_UNIXTIME(UNIX_TIMESTAMP(lesson_date))
FROM lessons;

--проверка кодировки
SHOW CREATE TABLE teachers;

--Обеспечить целостность данных БД world, используя триггеры
-- 1. При удалении страны, удалять все города и записи в countrylanguage относящиеся к этой стране
DELIMITER |
DROP TRIGGER IF EXISTS tg_countrycitylang_delete |
CREATE TRIGGER tg_countrycitylang_delete AFTER DELETE ON country
FOR EACH ROW BEGIN
	DELETE FROM city WHERE city.countrycode = OLD.Code;
    DELETE FROM countrylanguage WHERE countrylanguage.countrycode = OLD.Code;
END;
|
DELIMITER ;
DELETE FROM country WHERE Code = 'UKR';
SELECT Name FROM city WHERE countrycode = 'UKR';

-- 2. При обновлении кода страны, обновлять соответствующие коды в city и countrylanguage

DELIMITER |
DROP TRIGGER IF EXISTS tg_codecountry_update |
CREATE TRIGGER tg_codecountry_update AFTER UPDATE ON country
FOR EACH ROW BEGIN
	-- Если код изменился...
	IF OLD.Code <> NEW.Code THEN
		-- Обновим таблицы
		UPDATE city SET countrycode = NEW.Code WHERE countrycode = OLD.Code;
		UPDATE countrylanguage SET countrycode = NEW.Code WHERE countrycode = OLD.Code;
	END IF;
END;
|
DELIMITER ;

UPDATE country SET Code = 'GOV' WHERE Code = 'UKP';
SELECT Name FROM city WHERE countrycode = 'UKP';

-- 3. При вставке города, у которого нету кода страны countrycode, менять новый код на RUS 
DELIMITER |
DROP TRIGGER IF EXISTS tg_cityname_insert |
CREATE TRIGGER tg_cityname_insert BEFORE INSERT ON city
FOR EACH ROW BEGIN
	IF NEW.countrycode = '' OR NEW.countrycode = NULL THEN
        SET NEW.countrycode = 'RUS';
    END IF;
END;
|
DELIMITER ;

INSERT INTO city (name) VALUES ('Kharkov');
