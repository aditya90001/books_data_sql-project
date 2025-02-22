create table books(
	book_id serial primary key,
	title varchar(100),
	author varchar(100),
	genre varchar(100),
	published_year int,
	price numeric(10,2),
	stock int
);
select * from books;
create table customer(
	customer_id serial primary key,
	name varchar(50),
	email varchar(50),
	phone varchar(15),
	city varchar(50),
	country varchar(100)
);	
select * from customer;
create table orders(
	order_id serial primary key,
	customer_id int references customer(customer_id),
	book_id int references books(book_id),
	order_date date,
	quantity int,
	total_amount numeric(10,2)
);
select * from orders;
copy books(book_id,title,author,genre,published_year,price,stock)
from 'C:\Program Files\PostgreSQL\17\Books.csv'
    csv header ;
copy customer(customer_id,name,email,phone,city,country)
from 'C:\Program Files\PostgreSQL\17\Customers.csv'
csv header;
alter table customer
alter column country  type varchar(100);
copy orders(order_id,customer_id,book_id,order_date,quantity,total_amount)
from 'C:\Program Files\PostgreSQL\17\Orders.csv'
csv header;
--retrive all books in fiction genre
select * from books 
where genre='Fiction';
--find the book published after 1950
select * from books 
where published_year>=1950 order by published_year asc;
--list all customer who are from canada
select * from customer
where country='Canada';
--show order placed in 2023
select * from orders
where extract (month from order_date)=11 and extract (year from order_date) =2023;
--retrive the total stock of book availaible
select sum(stock) as total_stock from books ;
--find the detail of most expensive books
select * from books
order by price desc
limit  1;
--show all customer who order are more than one chracter
select * from orders
where quantity>1;
--retrive all order where total amount exceeds 20
select * from orders
where total_amount>20;
--list all genre avaibaille
select distinct genre from books;
-- find the books with lowest stock
select * from books
order by stock asc
limit 1;
--calculated the total revenue generated from all orders
select sum(total_amount)  as total_revnue from orders;
--advance question
--retrive the total amount of books  sold of each genre
select distinct genre,
sum(stock) over(partition by genre order by stock)
from books;
--ye humne stock nikala hain
select sum(o.quantity),b.genre
from orders o
join books b
on o.book_id=b.book_id
group by genre;
--find the average price of fiction genre
select avg(price) from books
where genre='Fantasy';
--list customer who have placed at least 2 orders
select c.name, o.customer_id,count(o.order_id) as total_order
from orders o
join customer c on c.customer_id=o.customer_id
group by o.customer_id,c.name
having count(order_id)>=2;
--find the most frequently ordered books
select b.title, o.book_id,count(o.order_id) as total_order 
from orders o
join books b on b.book_id=o.book_id
group by b.title,o.book_id
 order by  total_order desc
limit 1 ;
--show the top 3 most expwnsive books of fiction genre
select title,price from books 
where genre='Fantasy'
order by price desc
limit 3;
--retrive the total quantity of books sold by each author
select b.author ,sum(o.quantity) as total_quantity
from books b
join orders o on b.book_id=o.book_id 
group by b.author;
--list the cities where customer spent over 30 
select distinct c.city,total_amount
from customer c
join orders o on c.customer_id=o.customer_id
where o.total_amount>30;
--find the customer who spent the most on order
select c.name,sum(o.total_amount) as total_price
from customer c 
join orders o on c.customer_id=o.customer_id
group by c.name
order by total_price desc
limit 1;
--calculate the stock remaining after fulfill of orders




















































