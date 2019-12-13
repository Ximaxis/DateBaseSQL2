/*
 урок 11 Практическое задание по теме Тема  “Оптимизация запросов”

 Задача 1
Описание задания: - Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается: 
время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.


*/

use shop;

drop table if exists logs;
create table logs(
	created_at DATETIME default now(),
	name_table VARCHAR(255) not null,
	id_write INT, unsigned not null 
	content_name VARCHAR(255) 
) engine=arhive ;



drop trigger if exists insert_users;
create trigger insert_users before insert on users for each row
begin
	insert into shop.logs
	set 
	name_table = 'users',
    id_write = NEW.id,
    content_name = NEW.name;
end;

drop trigger if exists insert_catalogs;
create trigger insert_catalogs before insert on catalogs for each row
begin
	insert into shop.logs
	set 
	name_table = 'catalogs',
    id_write = NEW.id,
    content_name = NEW.name;
end;

drop trigger if exists insert_products;
create trigger insert_products before insert on products for each row
begin
	insert into shop.logs
	set 
	name_table = 'products',
    id_write = NEW.id,
    content_name = NEW.name;
end;




/*
 урок 11 Практическое задание по теме  Тема “NoSQL”
 Задача 1
В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

*/

HSET ipaddr 127.0.0.1 1

/*
 урок 11 Практическое задание по теме  Тема “NoSQL”
 Задача 2
При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

*/

set Maxim mail@mail.ru
set mail@mail Maxim
get Maxim
get mail@mail.ru

/*
 урок 11 Практическое задание по теме  Тема “NoSQL”
 Задача 3
Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

*/

shop.products.insert({name: "Intel Core i3-8100", description: "Процессор для настольных персональных компьютеров, основанных на платформе Intel.", price: 7890.00, catalog: "Процессоры" })
