USE vk;

-- 1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

SET @target_id = 1;

SELECT from_user_id, COUNT(*) as Messages_q
FROM messages
WHERE to_user_id = @target_id
GROUP BY from_user_id
ORDER BY Messages_q
LIMIT 1;


-- 2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..
SELECT COUNT(*)
FROM likes
WHERE (TIMESTAMPDIFF (YEAR,
	(SELECT birthday FROM profiles WHERE profiles.user_id = likes.user_id),
	created_at) < 10);

-- 3 Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT 
	(SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender, 
	COUNT(*) AS 'count' 
FROM likes 
GROUP BY gender 
ORDER BY `count` DESC;