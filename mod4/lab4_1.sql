INSERT INTO courses (title, length, description, category, previous)
	VALUES 
	('PHP', '12 часов', "крутой курс по пхп", 'program', 'PERL'),
	('Photoshop', '24 часа', 'первый курс по фотожабе', 'дизайн', 'Paint');
	
	INSERT INTO lessons (teacher, course, room, length, lesson_date)
	VALUES 
	('Пупкин', 'PHP', 564, '2 часа', '2008-01-02'),
	('Сумкин', 'Photoshop', 356, '3 часа', '2008-01-05');
	
	INSERT INTO teachers (name, addr, phone)
	VALUES 
	('Пупкин', 'prod. street 34', '712-84-86'),
	('Сумкин', 'zhuk. avenue 1', '787-88-05');
	
	
	INSERT INTO lessons (teacher, course, room, lesson_date, length)
	VALUES 
	(2, 5, 'БК-4', '2006-09-21', 8),
	(1, 2, 'БК-3', '2006-09-21', 12),
	(3, 3, 'БК-2', '2006-09-21', 10);