-- выведем список стран в которых есть города с населением более 1000000 чел
USE world; 
SELECT DISTINCT country.Name
From country
INNER JOIN city
ON country.Code = city.Countrycode
WHERE city.Population > 1000000;

-- Выведите список стран в которых нет городов с населением 1000000 чел
SELECT country.Name
FROM country
WHERE country.code NOT IN (
SELECT DISTINCT CountryCode
FROM city
WHERE Population >= 1000000);

-- список кодов стран с городами миллионниками
SELECT DISTINCT CountryCode
FROM city
WHERE Population >= 1000000;