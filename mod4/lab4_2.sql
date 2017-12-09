SELECT *
	FROM lessons
	WHERE room = "БК-19";
	
SELECT MAX(length)
	FROM lessons
	WHERE lesson_date = "2006-09-21";
	
USE world;
SELECT AVG(LifeExpectancy) FROM country;
SELECT COUNT(*) 
	FROM city
	WHERE CountryCode = "RUS";
