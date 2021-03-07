USE vk;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

ALTER TABLE users
ADD created_at DATETIME,
ADD updated_at DATETIME;

UPDATE `users` 
SET
`created_at` = NOW(),
`updated_at` = NOW();

-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
-- ====================

ALTER TABLE users 
RENAME COLUMN `created_at` TO `old_created_at`,
RENAME COLUMN `updated_at` TO `old_updated_at`,
ADD created_at DATETIME,
ADD updated_at DATETIME;

-- filling with incorrect data
ALTER TABLE users
MODIFY COLUMN `old_created_at` VARCHAR(255),
MODIFY COLUMN `old_updated_at` VARCHAR(255);

UPDATE users 
SET `old_created_at` = "20.10.2017",
`old_updated_at` = "25.08.2014";

-- correcting to wright format
UPDATE users
SET created_at = CAST(old_created_at AS datetime),
    updated_at = CAST(old_updated_at AS datetime);

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей. 
-- ==============
DROP TABLE IF EXISTS storehouse_products;
CREATE TABLE storehouse_products(value int);
INSERT INTO `storehouse_products` VALUES (0),(2500),(0),(30),(500),(1);

SELECT * FROM storehouse_products 
ORDER BY 
CASE WHEN value = 0 then 
	1 else 0 
END, 
value;


-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
-- ==============
SELECT id,firstname, lastname, birthday 
FROM profiles 
LEFT JOIN users 
ON profiles.user_id = users.id 
WHERE   
	MONTH(birthday) = 5  
	OR  
	MONTH(birthday) = 8;

-- Data aggregation tasks
-- Подсчитайте средний возраст пользователей в таблице users

SELECT YEAR(NOW())-AVG(YEAR(birthday)) 
FROM profiles;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
-- ==============

SELECT WEEKDAY(
	CAST(CONCAT(n'2021-',
		MONTH(birthday),'-',
		DAY(birthday)) 
	as date)) as `Weekday`, 
	count(*)
FROM profiles
GROUP BY `Weekday`
ORDER BY `Weekday`;



