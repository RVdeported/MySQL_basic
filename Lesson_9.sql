-- Практическое задание по теме “Транзакции, переменные, представления”
-- 1 В базе данных shop и sample присутствуют одни и те же таблиц...

START TRANSACTION;
USE sample;

INSERT INTO users(id, name, birthday_at, created_at, updated_at)
SELECT * FROM shop.users WHERE id = 1;

USE shop;
DELETE FROM users WHERE id = 1;

COMMIT;

-- 2 Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW task_2 AS
SELECT 
	products.name AS pr_name, 
	catalogs.name AS cat_name 
FROM products
LEFT JOIN
catalogs 
ON catalogs.id = products.catalog_id; 

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в за...

DROP FUNCTION IF EXISTS hello;

CREATE FUNCTION hello()
RETURNS VARCHAR(20) DETERMINISTIC
BEGIN
SET @hour = HOUR(NOW());

CASE
  WHEN (@hour >= 18 AND @hour <= 23) THEN RETURN "Good evening";
  WHEN (@hour >= 12 AND @hour < 18) THEN RETURN "Good day";
  WHEN (@hour >=  6 AND @hour < 12) THEN RETURN "Good morning";
  WHEN (@hour <   6) THEN RETURN "Good night";
  ELSE RETURN "__";
END CASE;

END

-- 2 В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо...

CREATE TRIGGER products_not_null_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF (new.name IS NULL AND new.description IS NULL) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
  END IF;
END



CREATE TRIGGER products_not_null_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  SET NEW.name = COALESCE(NEW.name, OLD.name);
  SET NEW.description = COALESCE(NEW.description, OLD.description);
END


