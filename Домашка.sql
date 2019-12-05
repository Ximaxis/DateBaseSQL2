/*
 урок 9 Практическое задание по теме Тема “Транзакции, переменные, представления”
.
 Задача 1
Описание задания: - В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

*/


start transaction;
insert into sample.users (select * from shop.users where shop.users.id = 1);
commit;



/*
 урок 9 Практическое задание по теме  Тема “Транзакции, переменные, представления”
 Задача 2
- Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

*/

create view cat as 
select p.name , c.name as catalog_name 
from products p 
join catalogs c on p.catalog_id = c.id
order by p.name;



/*
 урок 9 Практическое задание по теме  Тема “Хранимые процедуры и функции, триггеры".
 Задача 1
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

*/
DELIMITER //

drop function if exists hello //
create function hello ()
returns text deterministic
begin
  return case
      when 060000 <= curtime() + 0 and curtime() + 0 < 120000 then "Доброе утро"
      when 120000 <= curtime() + 0 and curtime() + 0 < 180000 then "Добрый день"
      when 180000 <= curtime() + 0 and curtime() + 0 <= 235959 then "Добрый вечер"
      else "Доброй ночи"
    end;
end //

DELIMITER ;

select hello ();

/*
 урок 9 Практическое задание по теме  Тема “Хранимые процедуры и функции, триггеры".
 Задача 2
В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

*/
DELIMITER //

drop trigger if exists insert_products//
create trigger insert_products before insert on products for each row
begin
  if new.name is null and new.description is null
    then signal sqlstate '45001' set message_text = "values can not be null"; 
  end if;
end; //

drop trigger if exists update_products//
create trigger update_products before update on products for each row
begin
  if new.name is null and new.description is null
    then signal sqlstate '45001' set message_text = "values can not be null"; 
  end if;
end; //


DELIMITER ;

