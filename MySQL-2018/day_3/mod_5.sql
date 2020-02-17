--вывести при помощи UNION список городов России и Украины
SELECT name FROM city WHERE countrycode = 'RUS' 
UNION
SELECT name FROM city WHERE countrycode = 'UKR'
ORDER BY name;

SELECT name FROM city WHERE countrycode = 'RUS' 
UNION ALL
SELECT name FROM city WHERE countrycode = 'UKR';

--найти страну с масимальной площадью поверхности
SELECT name
FROM country
WHERE surfacearea = (
    SELECT MAX(surfacearea) FROM country
);

--найти повторяющийся город в России и Украине
SELECT c1.name, c1.countrycode
FROM city c1
INNER JOIN city c2
ON c1.name = c2.name
WHERE c1.id <> c2.id
AND (c1.countrycode = 'RUS' OR c1.countrycode = 'UKR');

--найти страны с населением большим, населения любой страны с площадью поверхности > 100 000 000 кв. км.
SELECT name 
FROM country
WHERE population > ANY (
    SELECT population FROM country
    WHERE surfacearea > 1e7
);

--Выведите список стран в которых есть города с населением более 1000000 чел
SELECT name
FROM country
WHERE EXISTS (
    SELECT *
    FROM city
    WHERE population > 1e6
    AND city.countrycode = country.code
);

SELECT country.name 
    FROM country 
    INNER JOIN city
    ON city.countrycode = country.code
    WHERE city.population > 1e6 
    GROUP BY country.name;
    
SELECT DISTINCT country.name 
    FROM country 
    INNER JOIN city
    ON city.countrycode = country.code
    WHERE city.population > 1e6;

--Выведите список стран в которых есть города с населением не 1000000 чел
SELECT name
FROM country
WHERE NOT EXISTS (
    SELECT *
    FROM city
    WHERE population > 1e6
    AND city.countrycode = country.code
);

SELECT country.name
FROM  country
WHERE country.code <> ALL (
SELECT city.countrycode
FROM city
WHERE city.population >= 1e6
);

SELECT country.name
FROM  country
WHERE country.code NOT IN (
SELECT city.countrycode
FROM city
WHERE city.population >= 1e6
);

--список кодов стран с городами миллионниками
SELECT city.countrycode
FROM city
WHERE city.population >= 1e6;

--Создайте просмотр стран Европы
DROP VIEW if EXISTS veurope;
CREATE VIEW veurope AS
    SELECT name, population, surfacearea
    FROM country WHERE Continent = 'Europe';
    
--Создайте просмотр стран Азии
DROP VIEW if EXISTS vasia;
CREATE VIEW vasia AS
    SELECT name, population, surfacearea
    FROM country WHERE Continent = 'Asia';
    
--вывести страны, в которых говорят на русском
SELECT name FROM country, countrylanguage
WHERE country.code = countrylanguage.CountryCode
AND countrylanguage.language = 'Russian';
    
    
    
    
    
    
    
    
    
    
    
    
    