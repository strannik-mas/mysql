--Создайте хранимую процедуру в БД world, которая выводит список всех таблиц и количество записей в каждой из них

-- нельзя используя эту базу писать для неё процедуру
USE INFORMATION_SCHEMA; 

DELIMITER |
DROP PROCEDURE IF EXISTS sp_table_count_zap |
CREATE PROCEDURE sp_table_count_zap 
	(IN name_base VARCHAR(20)) 
BEGIN
	SELECT INFORMATION_SCHEMA.tables.table_name, INFORMATION_SCHEMA.tables.table_rows
		FROM INFORMATION_SCHEMA.tables
		WHERE INFORMATION_SCHEMA.tables.table_schema = name_base;	
END;
|

DELIMITER ;
CALL sp_table_count_zap ('world');

-- Создайте хранимую процедуру, которая возвращает список индексов для каждой таблицы БД

DELIMITER |
DROP PROCEDURE IF EXISTS sp_countedindextables |
CREATE PROCEDURE sp_countedindextables (IN name_base VARCHAR(20))
BEGIN
	SELECT INFORMATION_SCHEMA.tables.table_name,  INFORMATION_SCHEMA.tables.index_length
		FROM INFORMATION_SCHEMA.tables
		WHERE INFORMATION_SCHEMA.tables.table_schema = name_base;
END
|
DELIMITER ;
CALL sp_countedindextables ('world');


SELECT * FROM columns
WHERE table_schema = 'world'
AND table_name = 'city'\G

-- города любой страны
DROP PROCEDURE IF EXISTS sp_getcities;
DELIMITER |
CREATE DEFINER ='root'@'localhost' PROCEDURE sp_getcities(IN country VARCHAR(52))
BEGIN
	SELECT city.name FROM city, country
	WHERE country.name = country
		AND city.countrycode = country.code;
END;
|
DELIMITER ;
CALL sp_getcities("Russian Federation");