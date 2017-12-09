--Средняя продолжительность жизни по региону
USE world;
SELECT Region, AVG(LifeExpectancy)
	FROM country
	GROUP BY Region
	ORDER BY 2 DESC;
	
SELECT room, SUM(length) 
	FROM lessons
	GROUP BY room;
	
SELECT lesson_date, SUM(length)
	FROM lessons
	GROUP BY lesson_date;
	
SELECT lesson_date, room, SUM(length)
	FROM lessons
	WHERE room = "БК-19"
	GROUP BY lesson_date, room;
	
