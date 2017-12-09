--вывести при помощи UNION список городов России и Украины

SELECT name FROM city WHERE countrycode='RUS'
UNION ALL
SELECT name FROM city WHERE countrycode='UKR';


--Выведите список стран в которых есть города с населением более 1000000 чел

SELECT country.Name
FROM country
WHERE EXISTS (SELECT city.name FROM city WHERE city.Population > 1e6 AND country.Code = city.Countrycode);

--Выведите список стран в которых нет городов с населением 1000000 чел
SELECT country.Name
FROM country
WHERE NOT EXISTS (SELECT city.name FROM city WHERE city.Population > 1e6 AND country.Code = city.Countrycode);

--список городов Дании и Финляндии объединением запросов

SELECT name FROM city WHERE countrycode='DNK'
UNION ALL
SELECT name FROM city WHERE countrycode='FIN';