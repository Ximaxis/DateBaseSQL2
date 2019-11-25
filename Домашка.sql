/*
 урок 6 Практическое задание по теме  “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”.
 Задача 1
Описание задания: - Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

*/

select from_user_id, count(from_user_id) as total
from messages
where to_user_id = 1 -- выбраный юзер
group by from_user_id
order by from_user_id desc limit 1
;

/*
 урок 6 Практическое задание по теме  “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”.
 Задача 2
- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

*/

select count(id) as total
from likes
where user_id IN ( 
	select user_id from profiles where (YEAR(CURDATE())-YEAR(birthday)) < 10
)
;

/*
 урок 6 Практическое задание по теме  “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”.
 Задача 3
- Определить кто больше поставил лайков (всего) - мужчины или женщины?
*/

select profiles.gender, count(profiles.gender) as total
from likes
inner join profiles on profiles.user_id = likes.user_id
group by gender
order by total desc limit 1;
