USE shop;

-- 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
SELECT * FROM users
WHERE (SELECT COUNT(*) FROM orders WHERE users.id = orders.user_id) > 0;

-- 2 Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT * FROM products 
LEFT JOIN 
catalogs 
ON catalogs.id = products.catalog_id;

-- 3 Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. 

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  `id` SERIAL PRIMARY KEY,
  `from` VARCHAR(255),
  `to` VARCHAR(255)
);


INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  `label` VARCHAR(255),
  `name` VARCHAR(255)
);

INSERT INTO cities VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');


SELECT 
	id,
	(SELECT name FROM cities WHERE cities.label = flights.from) AS 'from',
	(SELECT name FROM cities WHERE cities.label = flights.to) AS 'to'
FROM flights;