-- Удаление существующих ограничений и таблиц
alter table buckets drop foreign key FK_User_Bucket;
alter table buckets_products drop foreign key FK_Product_BucketProduct;
alter table buckets_products drop foreign key FK_Bucket_BucketProduct;
alter table orders drop foreign key FK_User_Order;
alter table orders_details drop foreign key FK_Order_OrderDetails;
alter table orders_details drop foreign key FK_Product_OrderDetails;
alter table orders_details drop foreign key FK_Details_OrderDetails;
alter table products_categories drop foreign key FK_Category_ProductsCategories;
alter table products_categories drop foreign key FK_Product_ProductsCategories;
alter table users drop foreign key FK_Bucket_User;

drop table if exists bucket_seq;
drop table if exists buckets;
drop table if exists buckets_products;
drop table if exists category;
drop table if exists category_seq;
drop table if exists order_details_seq;
drop table if exists order_seq;
drop table if exists orders;
drop table if exists orders_details;
drop table if exists product_seq;
drop table if exists products;
drop table if exists products_categories;
drop table if exists user_seq;
drop table if exists users;

-- Создание последовательностей
create table bucket_seq (next_val bigint) engine=InnoDB;
insert into bucket_seq values (1);

create table category_seq (next_val bigint) engine=InnoDB;
insert into category_seq values (1);

create table order_details_seq (next_val bigint) engine=InnoDB;
insert into order_details_seq values (1);

create table order_seq (next_val bigint) engine=InnoDB;
insert into order_seq values (1);

create table product_seq (next_val bigint) engine=InnoDB;
insert into product_seq values (1);

create table user_seq (next_val bigint) engine=InnoDB;
insert into user_seq values (1);

-- Создание таблиц
create table buckets (
                         id bigint not null,
                         user_id bigint,
                         primary key (id)
) engine=InnoDB;

create table buckets_products (
                                  bucket_id bigint not null,
                                  product_id bigint not null,
                                  primary key (bucket_id, product_id)
) engine=InnoDB;

create table category (
                          id bigint not null,
                          title varchar(255),
                          primary key (id)
) engine=InnoDB;

create table orders (
                        id bigint not null,
                        sum decimal(38,2),
                        created datetime(6),
                        updated datetime(6),
                        user_id bigint,
                        address varchar(255),
                        status enum ('APPROVED', 'CANCELED', 'CLOSED', 'NEW', 'PAID'),
                        primary key (id)
) engine=InnoDB;

create table orders_details (
                                id bigint not null,
                                details_id bigint not null,
                                order_id bigint,
                                product_id bigint,
                                amount decimal(38,2),
                                price decimal(38,2),
                                primary key (id)
) engine=InnoDB;

create table products (
                          id bigint not null,
                          title varchar(255),
                          price decimal(38,2),
                          primary key (id)
) engine=InnoDB;

create table products_categories (
                                     category_id bigint not null,
                                     product_id bigint not null,
                                     primary key (category_id, product_id)
) engine=InnoDB;

create table users (
                       id bigint not null,
                       bucket_id bigint,
                       email varchar(255),
                       name varchar(255),
                       password varchar(255),
                       archive bit not null,
                       role enum ('ADMIN', 'CLIENT', 'MANAGER'),
                       primary key (id)
) engine=InnoDB;

-- Добавление ограничений
alter table buckets
    add constraint UQ_User_Bucket unique (user_id),
    add constraint FK_User_Bucket foreign key (user_id) references users (id);

alter table buckets_products
    add constraint FK_Bucket_BucketProduct foreign key (bucket_id) references buckets (id),
    add constraint FK_Product_BucketProduct foreign key (product_id) references products (id);

alter table orders
    add constraint FK_User_Order foreign key (user_id) references users (id);

alter table orders_details
    add constraint FK_Order_OrderDetails foreign key (order_id) references orders (id),
    add constraint FK_Product_OrderDetails foreign key (product_id) references products (id),
    add constraint FK_Details_OrderDetails foreign key (details_id) references orders_details (id),
    add constraint UQ_Details_OrderDetails unique (details_id);

alter table products_categories
    add constraint FK_Category_ProductsCategories foreign key (category_id) references category (id),
    add constraint FK_Product_ProductsCategories foreign key (product_id) references products (id);

alter table users
    add constraint FK_Bucket_User foreign key (bucket_id) references buckets (id),
    add constraint UQ_Bucket_User unique (bucket_id);
