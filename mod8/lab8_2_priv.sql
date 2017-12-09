-- Пользователь fedya
CREATE USER 'santer'@'localhost';
SET PASSWORD FOR 'santer'@'localhost' = PASSWORD('otshelnik');

CREATE USER 'vasya'@'%' IDENTIFIED BY 'password';


GRANT SELECT, INSERT 
	ON world.city
	TO 'santer'@'localhost';