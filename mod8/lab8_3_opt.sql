SELECT name, population 
FROM city 
WHERE id IN ( 
SELECT id FROM city 
WHERE population > 1000000) 
ORDER BY population;

EXPLAIN SELECT name, population 
FROM city 
WHERE id IN ( 
SELECT id FROM city 
WHERE population > 1000000) 
ORDER BY population \G

