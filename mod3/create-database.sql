CREATE DATABASE module3 COLLATE utf8_general_ci;

--обратный апостроф нужен, чтобы в имени указать спец. символ или пробел
CREATE DATABASE `module 3`;
CREATE DATABASE module3;

CREATE DATABASE IF NOT EXISTS module3;

--удаление
DROP DATABASE module3;
DROP DATABASE IF EXISTS module3;