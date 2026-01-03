-- create table categories
CREATE TABLE categories (
    id int NOT NULL,
    name varchar(255) NOT NULL,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- create table users
CREATE TABLE users (
    id int NOT NULL,
    name varchar(255) NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    role ENUM('ADMIN', 'USER') NOT NULL,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- create table items
CREATE TABLE items (
    id int NOT NULL,
    name varchar(255) NOT NULL,
    price decimal(10,2) NOT NULL,
    size ENUM('SMALL', 'MEDIUM', 'LARGE') NOT NULL,
    category_id int NOT NULL,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    PRIMARY KEY (id)
);

-- create table orders
CREATE TABLE orders (
    id int NOT NULL,
    user_id int NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'DISAPPROVED') DEFAULT 'PENDING',
    approved_by int,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (approved_by) REFERENCES users(id),
    PRIMARY KEY (id)
);

-- create table order_items
CREATE TABLE order_items (
    id int NOT NULL,
    order_id int NOT NULL,
    item_id int NOT NULL,
    quantity int NOT NULL,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (item_id) REFERENCES items(id),
    PRIMARY KEY (id)
);

-- insert into categories
insert into categories (id, name) values (1, 'Electronics');
insert into categories (id, name) values (2, 'Clothes');

-- insert into users
insert into users (id, name, email, password, role) values (1, 'Admin1', 'admin1@x.com', 'qwerty123', 'ADMIN');
insert into users (id, name, email, password, role) values (2, 'User1', 'user1@x.com', 'qwerty456', 'USER');
insert into users (id, name, email, password, role) values (3, 'Admin2', 'admin2@x.com', 'qwerty1234', 'ADMIN');
insert into users (id, name, email, password, role) values (4, 'User2', 'user2@x.com', 'qwerty4567', 'USER');

-- insert into items
insert into items (id, name, price, size, category_id) values (1, 'Mouse', 20.00, 'SMALL', 1);
insert into items (id, name, price, size, category_id) values (2, 'Shirt', 50.00, 'MEDIUM', 2);
insert into items (id, name, price, size, category_id) values (3, 'Cloak', 90.00, 'LARGE', 2);
insert into items (id, name, price, size, category_id) values (4, 'Tshirt', 40.00, 'MEDIUM', 2);

-- insert into orders (users place orders)
insert into orders (id, user_id, status) values (1, 2, 'PENDING');
insert into orders (id, user_id, status) values (2, 4, 'PENDING');
insert into orders (id, user_id, status) values (3, 4, 'PENDING');


-- insert into order_items
insert into order_items (id, order_id, item_id, quantity) values (1, 1, 1, 2);
insert into order_items (id, order_id, item_id, quantity) values (2, 2, 2, 4);

-- select all categories
select * from categories;

-- select all items
select * from items;

-- update items
update items 
set name = 'Big Cloak' 
where id = 3;

-- update orders
update orders 
set status = 'APPROVED' 
where id = 1;

-- delete items
delete from items
where id = 4;

-- delete orders
delete from orders
where id = 3;

-- get all items with categories using join
select * from items
join categories on categories.id = items.category_id;