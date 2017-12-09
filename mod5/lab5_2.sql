USE world;
SELECT Name
	FROM country 
		INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
	WHERE countrylanguage.Language LIKE 'Fre%';
	
USE module10;

SELECT *
	FROM lessons
	INNER JOIN teachers ON teachers.id = lessons.teacher
WHERE teachers.name = 'Иванов Иван Иванович';	

SELECT *
	FROM lessons
	LEFT JOIN teachers ON teachers.id = lessons.teacher;

--запрос, выводящий все занятия, в том числе и преподавателя Иванов Иван Иванович
SELECT DISTINCT courses.title
	FROM courses
		LEFT JOIN lessons ON courses.id =  lessons.course
		LEFT JOIN teachers ON teachers.id = lessons.teacher;
		
-- Какие курсы читает преподаватель Петр Петров
SELECT DISTINCT courses.title
	FROM courses
		INNER JOIN lessons ON courses.id =  lessons.course
		INNER JOIN teachers ON teachers.id = lessons.teacher
	WHERE teachers.name = 'Петров Петр Петрович';
	

	

	

	
