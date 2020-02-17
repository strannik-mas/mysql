--выбрать информацию о стране с кодом RUS
SELECT Name, Continent, Region, Population, `LifeExpectancy`
    FROM country
    WHERE code='RUS';

--выбрать список стран, население которых > 100 000 000
SELECT Name, Population
    FROM country
    WHERE Population>1e8;

--вывести список городов с населением > 5 000 000, в порядке, обратном алфавитному
SELECT Name
    FROM city
    WHERE Population>5e6
    ORDER BY Name DESC;

--вывести 10 стран, у которых продолжительность жизни населения < 40 лет
SELECT Name, Continent, Region, SurfaceArea
    FROM country
    WHERE LifeExpectancy < 40
    LIMIT 10;
    
--pagination
SELECT Name, Continent, Region
    FROM country
    WHERE LifeExpectancy < 50
    LIMIT 10;
    
SELECT Name, Continent, Region
    FROM country
    WHERE LifeExpectancy < 50
    LIMIT 10, 10;
    
SELECT Name, Continent, Region
    FROM country
    WHERE LifeExpectancy < 50
    LIMIT 10
    OFFSET 10;
    
--найти товары, у которых id 45, 47, 50
SELECT * FROM table2
    WHERE id=45 OR id=47 OR id=50;
    
SELECT * FROM table2
    WHERE id IN (45, 47, 50);
    
DROP TABLE IF EXISTS table3;
CREATE TABLE table3(
    i int
);

INSERT INTO table3 VALUES (45), (48), (54), (57);
SELECT * FROM table3;
    
--вложенный запрос    
SELECT * FROM table2
    WHERE id IN (SELECT * FROM table3);
    
--средняя продолжительность жизни в мире
SELECT AVG(LifeExpectancy)
FROM country;

UPDATE city
SET name = NULL
ORDER BY RAND()
LIMIT 1;

SELECT name
FROM city
WHERE name IS NULL;

--количество российских городов
SELECT COUNT(*)
FROM city
WHERE Countrycode = 'RUS';

--количество человек в городе с максимальным населением
SELECT MAX(Population) FROM city

--количество человек в городе с максимальным населением и его имя
SELECT name, MAX(Population) 
FROM city
GROUP BY name
ORDER BY 2 DESC
LIMIT 1;

SELECT Name, Population
FROM city
WHERE Population IN (SELECT MAX(Population) FROM city);

--площадь страны с минимальной поверхностью
SELECT MIN(SurfaceArea)
FROM country;

--количество стран в регионе
SELECT region, COUNT(*)
FROM country
GROUP BY region;

--уникальные записи
SELECT DISTINCT region
FROM country;

--количество регионов в континентах, количество стран в регионах и промежуточные итоги
SELECT continent, region, COUNT(*) с
FROM country
GROUP BY continent, region WITH ROLLUP;

SELECT continent, region, COUNT(*) с
FROM country
GROUP BY continent, region WITH ROLLUP
HAVING с > 10;

--выбрать все города, которые находятся в РФ
SELECT city.name
FROM city
INNER JOIN country
ON city.countrycode = country.code
WHERE country.name = 'Russian Federation';