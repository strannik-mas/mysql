--использование базы
USE module3;

--удаление таблицы
DROP TABLE [IF EXISTS] 	table1;

--создание таблицы с помощью описания
CREATE TABLE table1
(
	id INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Код товара',
	name VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Название товара',
	price FLOAT  NOT NULL DEFAULT 0 COMMENT 'цена товара'
) COMMENT 'Таблица товаров'

--просмотр таблицы (структура, не содержимое)

DESCRIBE table;