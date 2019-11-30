/*
 урок 7 Практическое задание по теме Тема “Сложные запросы”.
 Задача 1
Описание задания: - Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

*/

select users.*
from users
join  orders ON users.id = orders.user_id
group by users.id
;

/*
 урок 7 Практическое задание по теме  Тема “Сложные запросы”.
 Задача 2
- Выведите список товаров products и разделов catalogs, который соответствует товару.

*/

select p.id, p.name, c.name as catalog_name 
from products p
join catalogs c on p.catalog_id = c.id
;


/*
 урок 7 Практическое задание по теме  Тема “Сложные запросы”.
 Задача 3
Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/


-- Создание БД

drop database if exists test;
create database test;
use test;

drop table if exists flights;
create table flights (
	id serial primary key,
	`from` VARCHAR(100),
    `to` VARCHAR(100)
);

drop table if exists cities;
create table cities (
	name VARCHAR(100),
    lable VARCHAR(100)
);

-- наполнение БД

INSERT INTO flights (`from`, `to`) values
('moscow', 'omsk'),
('nongorod', 'kazan'),
('irkutsk', 'moscow' ),
('omsk', 'irkutsk'),
('moscow', 'kazan')
;

INSERT INTO cities (name, lable) values
('moscow', 'Москва'),
('nongorod', 'Новгород'),
('irkutsk', 'Иркутск'),
('omsk', 'Омск'),
('kazan', 'Казань')
;

-- решение задачи

select f.id, c.lable as `from`, z.lable as `to` 
from flights f
join cities c on f.`from` = c.name
join cities z on f.`to` = z.name
order by f.id
;
