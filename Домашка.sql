/*
 урок 7 Практическое задание по теме Тема “Сложные запросы”.
 Задача 1
Описание задания: - Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.


*/

select *
from users
where id in (select user_id from orders  group by user_id)
;

/*
 урок 7 Практическое задание по теме  Тема “Сложные запросы”.
 Задача 2
- Выведите список товаров products и разделов catalogs, который соответствует товару.

*/

select id, name, (select name from catalogs where id = catalog_id) as catalog_name from products;


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

-- рушение задачи

select id, (select lable from cities where name = `from`) as `from`, (select lable from cities where name = `to`) as `to` from flights;