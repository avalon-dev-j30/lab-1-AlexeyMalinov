--Создание таблицы Userinfo
create table userinfo(
id int generated always as identity (start with 1, increment by 1),
name varchar(255) not null,
surname varchar(255) not null,
constraint pk_userinfo primary key (id)
);

--Добавление 3-х записей в таблицу UserInfo
insert into userinfo(name,surname) values
('Alexander','Ivanov'),
('Nickolay','Petrov'),
('Ivan','Sidorov');

--Создание таблицы Roles
create table roles(
id int generated always as identity (start with 1, increment by 1),
name varchar(255) primary key,
constraint uk_id_roles unique (id)
);

--Добавление 3-х записей в таблицу Roles
insert into roles(name) values 'Admin','User','Reader';

--Создание таблицы Users, на схеме указана таблица user, но такую создать нельзя
create table users(
id int generated always as identity (start with 1, increment by 1) unique,
email varchar(255) primary key,
password varchar(255),
info int unique,
role int,
constraint fk_userinfo_id foreign key (info) references userinfo(id),
constraint fk_roles_id foreign key (role) references roles(id) 
);

--Добавление 3-х записей в таблицу Users
insert into Users(email,password,info,role) values
('alexanderivanov@mail.ru','123456',1,1),
('nickolaypetrov@mail.ru','',2,2),
('ivansidorov@mail.ru','',3,2);

--Создание таблицы orders, на схеме указана таблица order, но такую создать нельзя
create table orders(
id int generated always as identity (start with 1, increment by 1) primary key,
user_id int, --в схеме указано поле user, но такое создать нельзя
created timestamp,
constraint fk_users_id foreign key (user_id) references users(id)
);

--Добавление 3-х записей в таблицу Orders
insert into Orders(user_id,created) values 
(1,'2019-05-07 10:10:01'),
(2,'2019-05-06 20:45:00'),
(3,'2019-05-07 11:54:00');

--Создание таблицы supplier
create table supplier(
id int generated always as identity (start with 1, increment by 1) unique,
name varchar(255) primary key,
address varchar(255) not null,
phone varchar(255),
representative varchar(255) not null
);

--Добавление 3-х записей в таблицу Supplier
insert into supplier(name,address,phone,representative) values
('OOO ABC','RF','8-812-555-55-55','Ivanov Ivan'),
('OOO STS','RF',null,'Smirnov Sergey'),
('OOO TNT','RF',null,'Maksimov Leonid');

--Создание таблицы Product
create table Product(
id int generated always as identity (start with 1, increment by 1) unique,
code varchar(255) primary key,
title varchar(255),
supplier int,
initial_price double,
retail_value double,
constraint fk_supplier_id foreign key (supplier) references supplier(id) 
);

--Добавление 3-х записей в таблицу Product
insert into Product(code,title,supplier,initial_price,retail_value) values
('A00001','product A',2,10.99,15.99),
('B00001','product B',1,5.11,7.50),
('C00001','product C',1,15.55, 17.55);

--Создание таблицы Order2Product
create table Order2Product(
order_id int, --в схеме указано поле order, но такое создать нельзя
product int,
constraint fk_orders_id foreign key (order_id) references orders(id),
constraint fk_product_id foreign key (product) references product(id),
constraint pk_order_2_product primary key (order_id, product)
);

--Добавление 3-х записей в таблицу Product
insert into Order2Product(order_id,product) values
(1,1),
(1,3),
(3,2);


/*
--Удаление всех таблиц
drop table Order2Product;
drop table Product;
drop table Supplier;
drop table Orders;
drop table Users;
drop table roles;
drop table userinfo;
*/