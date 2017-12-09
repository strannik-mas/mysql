--вывести при помощи UNION список городов России и Украины

SELECT name FROM city WHERE countrycode='RUS'
UNION ALL
SELECT name FROM city WHERE countrycode='UKR';

(SELECT name FROM city WHERE countrycode='RUS')
UNION
(SELECT name FROM city WHERE countrycode='UKR')
ORDER BY name;

--найти страну с макс. площадью через подзапрос
SELECT name
FROM country
WHERE surfacearea = (
	SELECT MAX(surfacearea)
	FROM country
);

--найти города в России и Украине, чьи имена повторяются
SELECT c1.Name, c1.Countrycode 
FROM city c1 INNER JOIN city c2
ON c1.name = c2.name
WHERE c1.id <> c2.id
AND (c1.Countrycode = 'RUS' OR c1.Countrycode = 'UKR');

--второй вариант (не работает пока что)
SELECT Name, Countrycode
FROM city
WHERE Countrycode = 'RUS' OR Countrycode = 'UKR' 
--AND Name IN (SELECT Name FROM city) AND ID <> SOME (SELECT ID FROM city)
GROUP BY Name, Countrycode;

--найти страны с населением большим, любой страны с площадью поверхности > 1000000 кв км.
SELECT name
FROM country
WHERE Population > ANY (SELECT Population FROM country WHERE SurfaceArea > 1e6);