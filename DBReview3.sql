
create schema Review;

Create Table Review.Customer
(
	CustomerID int primary key identity(1,1),
    CustomerName varchar(25),
);

insert into Review.Customer (CustomerName)
values ('Disha'),
('Vijay'),
('Atharv'),
('Puja');

	select * from Review.Customer;

	create table Review.Orders 
	(
		OrderID int primary key identity(1,1),
		CustomerID int,
		OrderDate date,
		Foreign key (CustomerID) references Review.Customer(CustomerID)
	);

	insert into Review.Orders (CustomerID, OrderDate )
	values (1, '2025-03-09' ),
	(1, '2025-03-10'),
	(3, '2025-03-11'),
	(4, '2025-04-10');

	select * from Review.Orders;

--1)Get each customer’s name and the number of orders they’ve placed

	select c.CustomerName, count(o.OrderID) 'Number of Orders'
	from Review.Customer c
	left join 
	Review.Orders o
	on c.CustomerID	= o.CustomerID
	group by c.CustomerName;

--2)List the top 5 most expensive products by price

	create table Review.Products 
	(
		ProductID int primary key identity(1,1),
		ProductName varchar(25),
		Price dec(7, 2)
	);

	insert into Review.Products(ProductName,Price) 
	values ('laptop', 70000),
	('Mobile', 15000),
	('washing Machine', 6800),
	('Mouse', 70000),
	('Chair', 2000),
	('PenDrive',3000);

	select * from Review.Products;

	select Top 5 *
	from Review.Products
	order by Price desc;

--3)Find products that have never been included in any order.

	create table Review.OrderDetails 
	(
		OrderID int primary key identity(1,1),
		ProductID int,
		Quantity int,
		Foreign key  (OrderID) references Review.Orders(OrderID),
		Foreign key (ProductID) references Review.Products(ProductID)
	);

	insert into Review.OrderDetails (ProductID, Quantity)
	values (1,4),
	(2,1),
	(6,2),
	(5,6);

	select * from Review.OrderDetails;

	select  p.ProductID, p.ProductName
	from Review.Products p
	left join Review.OrderDetails o 
	on p.ProductID = o.ProductID
	where o.ProductID is null;

---4)Get the latest customer who registered (use CustomerID or CreatedDate)

	select Top 1 * 
	from Review.Customer
	order by CustomerID desc;

--5)Fetch the second most recent order placed in the Orders table

	select Top 1 *
	from 
	(
	select top 2 * 
	from Review.Orders
	order by  OrderDate desc
	) as secondOrder
	order by OrderDate;



-- 6)Return all rows except the last 10 from the Products table based on ProductID

	select  *
	from Review.Products
	where ProductID 
	not in (
		select top 10 ProductID
		from Review.Products
		order by ProductID desc	
		);
