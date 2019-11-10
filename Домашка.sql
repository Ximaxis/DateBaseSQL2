/*
 урок NN
 Задача NN
Описание задания
*/

drop database if exists vk;
create database vk;
use vk;

drop table if exists users;
create table users (
	id SERIAL primary key,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    email VARCHAR(100) unique,
    `password hash` VARCHAR(100),
    phone VARCHAR(12), 
    INDEX users_phone_idx(phone),
    INDEX (firstname, lastname)
);

drop table if exists `profiles`;
create table `profiles` (
	user_id SERIAL primary key,
    gender CHAR(1),
    birthday DATE,
	photo_id bigint unsigned null,
    created_at datetime default now(),
    hometown VARCHAR(100)
);
alter table profiles
add constraint fk_user_id
foreign key (user_id) references users(id)
	on update cascade 
	on delete restrict 
/*foreign key (photo_id) references media(id)*/
;


drop table if exists messages;
create table messages (
	id SERIAL primary key,
	from_user_id bigint unsigned not null,
    to_user_id bigint unsigned not null,
    body TEXT,
    created_at datetime default now(),
    
    index (from_user_id),
    index (to_user_id),
    foreign key (from_user_id) references users(id),
    foreign key (to_user_id) references users(id)
);

drop table if exists friend_requests;
create table friend_requests (
	initiator_user_id bigint unsigned not null,
    target_user_id bigint unsigned not null,
    `status` ENUM('requested', 'approved', 'unfriended', 'declined'),
	requested_at datetime default NOW(),
	confirmed_at datetime,
	
    primary key (initiator_user_id, target_user_id),
	INDEX (initiator_user_id),
    INDEX (target_user_id),
    foreign key (initiator_user_id) references users(id),
    foreign key (target_user_id) references users(id)
);

drop table if exists communities;
create table communities(
	id serial primary key,
	name VARCHAR(200),

	index (name)
);

drop table if exists users_communities;
create table users_communities(
	user_id bigint unsigned not null,
	community_id bigint unsigned not null,
  
	primary key (user_id, community_id),
    foreign key (user_id) references users(id),
    foreign key (community_id) references communities(id)
);

drop table if exists media_types;
create table media_types(
	id serial primary key,
    name VARCHAR(200),
    created_at datetime default NOW(),
    updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

drop table if exists media;
create table media(
	id serial primary key,
    media_type_id bigint unsigned not null,
    user_id bigint unsigned not null,
  	body text,
    filename VARCHAR(255),
    `size` INT,
	metadata JSON,
    created_at datetime default now(),
    updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,

    index (user_id),
    foreign key (user_id) references users(id),
    foreign key (media_type_id) references media_types(id)
);

drop table if exists `photo_albums`;
create table `photo_albums` (
	`id` serial,
	`name` varchar(200) default null,
    `user_id` bigint unsigned not null,

    foreign key (user_id) references users(id),
  	primary key (`id`)
);

drop table if exists `photos`;
create table `photos` (
	id SERIAL primary key,
	`album_id` bigint unsigned not null,
	`media_id` bigint unsigned not null,

	foreign key (album_id) references photo_albums(id),
    foreign key (media_id) references media(id)
);


drop table if exists likes_media;
create table likes_media(
	id serial,
    user_id bigint unsigned not null,
    media_id bigint unsigned not null,
    created_at datetime default now(),
  	foreign key (user_id) references users(id),
    foreign key (media_id) references media(id),
    primary key (id)
);


drop table if exists likes_users;
create table likes_users (
	id serial,
	from_user_id bigint unsigned not null,
    to_user_id bigint unsigned not null,
    created_at datetime default now(),
    index (from_user_id),
    index (to_user_id),
    foreign key (from_user_id) references users(id),
    foreign key (to_user_id) references users(id),
    primary key (id)
);

drop table if exists posts;
create table posts (
	id serial primary key,
	user_id bigint unsigned not null,
    body TEXT,
    created_at datetime default now(),
    updated_at datetime default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

drop table if exists likes_posts;
create table likes_posts (
	id serial,
    user_id bigint unsigned not null,
    post_id bigint unsigned not null,
    created_at datetime default now(),
    foreign key (user_id) references users(id),
    foreign key (post_id) references posts(id),
    primary key (id)
);


-- Создание таблиц

-- Наполнение нужных данных

-- Скрипт самого задания