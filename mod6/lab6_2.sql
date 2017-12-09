-- Создайте просмотр стран Европы (и Западной Европы и Восточной Европы и Южной)
CREATE VIEW countriesEurope AS
	SELECT  Name
		FROM country
		WHERE Continent = 'Europe'
\g
SELECT name FROM countriesEurope;
-- Аналогично сделайте просмотр всех стран Африки и Азии
CREATE VIEW countriesAfr_Asia AS
	SELECT  Name
		FROM country
		WHERE Continent = 'Africa' AND Continent = 'Asia'
\g

-- Используя INFORMATION_SCHEMA, выведите на экран все просмотры в БД world
USE INFORMATION_SCHEMA;
SELECT VIEW_DEFINITION
FROM VIEWS
WHERE TABLE_SCHEMA = 'world';

--Вывести все страны,в которых говорят по русски
SELECT name FROM country, countrylanguage
WHERE country.code = countrylanguage.countrycode AND countrylanguage.language = 'Russian';