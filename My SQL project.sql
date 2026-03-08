create database project;
use project;
create table customers (Customer_ID int primary key,Name varchar(50),Email varchar(50),Phone int,City varchar(100),Country varchar(100));
create table books (Book_ID int primary key,Title varchar(100),Author varchar(50),Genre varchar(50),Published_Year int,Price decimal(6,4),Stock int);
create table orders(Order_ID int primary key,Customer_ID int,Book_ID int,Order_Date date,Quantity int,Total_Amount float,
                    foreign key(Customer_ID) references customers(Customer_ID),foreign key (Book_ID) references books(Book_ID));
select * from customers;
select * from books;
select * from orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from  books where genre='Fiction';

-- 2) Find books published after the year 1950:
select * from books where Published_Year>1950;

-- 3) List all customers from the Canada:
select * from customers where country='Canada';

-- 4) Show orders placed in November 2023:
select * from orders where Order_Date between '2023-11-1' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as total_stock from books;

-- 6) Find the details of the most expensive book:
select * from books Order by Price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders where total_amount > 20;

-- 9) List all genres available in the Books table:
select distinct genre from books;

-- 10) Find the book with the lowest stock:
select * from books order by stock limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as total_revenue from orders; 

-- 12) Retrieve the total number of books sold for each genre:
select b.genre,sum( o.quantity) as total_books_sold from orders o 
join books b on o.book_id=b.book_id group by b.genre;

-- 13) Find the average price of books in the "Fantasy" genre:
select genre,AVG(price) as average_price from books where genre='Fantasy';

-- 14) List customers who have placed at least 2 orders:
select customer_id,count(Order_id) from orders group by customer_id having count(order_id)>=2 ;

-- 15) Find the most frequently ordered book:
select  book_id,count(order_id) as frequent_order from orders group by book_id 
order by frequent_order desc;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :
select title,genre,price from books where genre='fantasy' order by price desc;

-- 17) Retrieve the total quantity of books sold by each author:
select sum(o.quantity) as Total_books_sold,b.author from orders o join books b
on o.book_id=b.book_id group by b.author; 

-- 18) List the cities where customers who spent over $30 are located:
select c.name,c.city,o.total_amount from customers c join orders o 
on c.customer_id=o.customer_id where o.total_amount>30 ;

-- 19) Find the customer who spent the most on orders:
select c.name,sum(o.total_amount) as most_spent from customers c join orders o 
on c.customer_id=o.customer_id group by c.name 
order by most_spent desc;

-- 20) Calculate the stock remaining after fulfilling all orders:
select b.book_id,b.title,b.stock as total_stock,coalesce(sum(o.quantity),0) as stock_sold,
(b.stock-coalesce(sum(o.quantity),0)) as remaining_stock from books b left join orders o 
on b.book_id=o.book_id group by b.book_id;

  