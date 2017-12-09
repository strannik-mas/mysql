-- создать процедуру, отображающую страны по континенту
USE world;
DROP PROCEDURE IF EXISTS sp_getcounries;
DELIMITER |
CREATE DEFINER ='root'@'localhost' PROCEDURE sp_getcounries(IN c VARCHAR(20))
BEGIN
	SELECT name FROM country WHERE continent = c;
END;
|
DELIMITER ;
CALL sp_getcounries("Europe");



-- создать процедуру, меняющую строки местами
DROP PROCEDURE IF EXISTS sp_changestr;
DELIMITER |
CREATE PROCEDURE sp_changestr (INOUT a VARCHAR(20), INOUT b VARCHAR(20))
BEGIN
	DECLARE c VARCHAR(20) DEFAULT '';
	SET c=b;
	SET b=a;
	SET a=c;
END
|
DELIMITER ;
SET @str1 = '1';
SET @str2 = '2';
CALL sp_changestr(@str1, @str2);
SELECT 'str1 = ' AS "Название переменной", @str1 AS "Значение"
UNION  
SELECT 'str2 = ', @str2;

SELECT city.name FROM city INTO OUTFILE "D:\city.txt";

-- получить список городов страны с названием TITLE, у которых население более числа N
DROP PROCEDURE IF EXISTS sp_getcities;
DELIMITER |
CREATE PROCEDURE sp_getcities (IN title_country VARCHAR(52), IN n INT)
BEGIN
	DECLARE done TINYINT DEFAULT 0;
	DECLARE citycode, currentcode CHAR(3);
	DECLARE cityname CHAR(35);
	DECLARE citypop INT(11);
	DECLARE cur1 CURSOR FOR SELECT name, population, countrycode FROM city;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	-- получаем код на основании переданного названия
	SELECT code INTO currentcode FROM country
	WHERE country.name = title_country;
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
	SELECT name FROM tmpcity;
	DROP TEMPORARY TABLE tmpcity;
END
|
DELIMITER ;

CALL sp_getcities('Ukraine', 1e6);
CALL sp_getcities('Russian Federation', 5e6);