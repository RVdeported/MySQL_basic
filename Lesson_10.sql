-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
	id SERIAL,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	table_name VARCHAR(255),
	table_row_id BIGINT UNSIGNED NOT NULL,
	name VARCHAR(255))
ENGINE=Archive;

-- 2 Создайте SQL-запрос, который помещает в таблицу users миллион записей.

use shop;
DELIMITER //

DROP PROCEDURE IF EXISTS filltable;
CREATE PROCEDURE filltable()
BEGIN
  SET @i = 0;
  label1: LOOP
    SET @i = @i + 1;
    IF @i < 1000000 THEN
      INSERT INTO users() values();	
      ITERATE label1;
    END IF;
    LEAVE label1;
  END LOOP label1;
END;

CALL filltable();
//
DELIMITER ;