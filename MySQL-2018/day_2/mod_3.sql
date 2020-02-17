CREATE TABLE IF NOT EXISTS course (
    id INT PRIMARY KEY,
    idd SERIAL,
    title VARCHAR(255) NOT NULL DEFAULT "php"
) ENGINE=MyISAM;

CREATE TEMPORARY TABLE course2 (
    id INT
);

--посмотреть пользователей в mysql.user
SELECT user
FROM mysql.user;

--создать таблицу на основе SELECT
CREATE TABLE user
SELECT user, host
FROM mysql.user;

--создание таблицы по структуре
CREATE TABLE user2 LIKE user;

--создание таблицы по структуре
CREATE TABLE user3 LIKE mysql.user;

--изменить тип данных колонки user на varchar(50)
ALTER TABLE user MODIFY user varchar(50);

--добавить колонку admin с типом ENUM('Y', 'N') между user и host
ALTER TABLE user
ADD COLUMN admim ENUM('Y', 'N')
AFTER user;

--работа с information_schema
SELECT TABLE_SCHEMA, TABLE_NAME, table_comment, engine
FROM information_schema.tables
WHERE table_schema='bookshop'
\G;

--создание индекса
ALTER TABLE user
ADD INDEX (user);

--создание составного индекса
ALTER TABLE user
ADD INDEX (user, host);

--события
SHOW VARIABLES LIKE '%event%';

-- Каждую секунду
CREATE EVENT infl
    ON SCHEDULE EVERY 5 SECOND
    COMMENT 'Add level .'
	DO UPDATE module3.table2 SET price = price * 1.1;
	
-- Показать все текущие события
SHOW EVENTS\G	
-- Удалить конкретное событие
DROP EVENT infl;	

--смена кодировки таблицы
ALTER TABLE `module3`.`table2` CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;