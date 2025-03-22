/*
	1)Use a stored procedure PlaceOrder that adds a new order and updates the product stock.

*/

create schema Product;

--table creation
	create table Product.Products 
	(
		ProductID int primary key identity(1,1),
		ProductName varchar(25),
		Price dec(10,2),
		Stock int
	);

	insert into Product.Products (ProductName, Price, Stock) values 
    ('Laptop', 75000.00, 10),
    ('Smartphone', 50000.00, 15)
    ;

	select * from Product.Products ;

--Order table
	create table Product.Orders 
	(
		OrderID int primary key identity(1,1),
		CustomerID int ,
		ProductID int ,
		Quantity int ,
		OrderDate  date
		foreign key (ProductID) references Product.Products(ProductID)  
		on update cascade
		on delete cascade
	);

	select * from Product.Orders ;

	insert into Product.Orders (CustomerID, ProductID, Quantity, OrderDate) values 
    (1, 1, 2, '2025-03-22'), 
    (2, 1, 1, '2025-03-22'), 
    (3, 2, 3, '2025-03-22');

-- creation of Sp
	Create or alter procedure SP_PlaceOrder
	(
		@customerId int,
		@productId int,
		@quantity int,
		@orderDate date
	)
	as
	begin
		declare @available_Stock int;

		select @available_Stock =  Stock from Product.Products 
		where ProductID = @productId;

		if @available_Stock < @Quantity
			begin
				print ' stock is Insufficient !';
				return;
			end
		

		insert into Product.Orders (CustomerID, ProductID, Quantity, OrderDate)
		values (@customerId, @productId, @quantity, @orderDate);

		update Product.Products 
		set Stock = Stock - @quantity
		where ProductID = @productID;

		print 'order is placed.';

	end

--Excecute
	exec SP_PlaceOrder
	@customerID = 1, 
	@productId = 2, 
	@quantity = 3,
	@orderDate = '2025-03-22';


------------------------------------------------------------------------------

/*
	2) Write a stored procedure ProcessPayment that:
	Accepts payment details (customer ID, amount, date).
	Checks if the customer exists.
	Updates the customer’s balance after the payment.

*/

--Schema Creation
	create schema Customer;

--Customer table creation
	Create table Customer.Customers 
	(
		CustomerID int primary key identity(1,1),
		Name varchar(100) NOT NULL,
		Email varchar(100) unique NOT NULL,
		Phone varchar(15) unique NOT NULL,
		BankBalance dec(10,2) NOT NULL default 0.00
	);

--Inserting few records
	insert into Customer.Customers (Name, Email, Phone, BankBalance) values 
	('Riya kamble', 'rk@gmail.com', '9876543210', 5000.00),
	('Atharv Kamble', 'ak@gmail.com', '9123456789', 1000.00);

select * from Customer.Customers ;

--Payment table creation

	Create Table Customer.Payment
	(
		PaymentID	int primary key identity,
		CustomerID	int unique,
		Amount	dec(10,2),
		PaymentDate	date,
		Foreign key (CustomerID) references Customer.Customers(CustomerID) 
		on  update cascade
		on  delete cascade
	);
	
-- Inserting few records
	insert into Customer.Payment (CustomerID, Amount, PaymentDate) values 
	(1, 500, '2025-03-21'),
	(2, 300, '2025-03-22' );

	select * from Customer.Payment

--stored procedure ProcessPayment

	create or alter procedure SP_ProcessPayment
		(	@customerId int,
			@amount dec(10,2),
			@date date
		)
	as
	Begin
		if exists(Select * from Customer.Customers
					where CustomerID = @customerId)
			Begin
				print 'Id is already available in table. ';
				--Insert into Customer.Payment (CustomerID, Amount, PaymentDate) 
				--values (@customerId, @amount, @date);
				--print 'So, New payment record inserted into payment table ';

				Update Customer.Customers
				set BankBalance = BankBalance - @amount
				where CustomerID = @customerId;

				print 'Bank Balance Updated successfully !';
			End

			else
			begin
				print 'Customer does not exist !!!!';
			
			end
	End

--Execute sp
	exec SP_ProcessPayment
	@customerId= 1, @amount= 100, @date='2025-03-22';

-------------------------------------------------------------------------------
/*
	3)Create a trigger on the Employees table that logs any INSERT, UPDATE, or DELETE operations into an EmployeeAudit table, storing old and new values.

*/

select * from Employees;

--Creating audit table on employee
	Create table EmployeeAudit
	(
		ID int primary key identity(1,1),
		EmployeeID int,
		OldName varchar(25), 
		NewName varchar(25),
		OldAge varchar(25),
		NewAge varchar(25),
		OldDepartment varchar(25),
		NewDepartment varchar(25),
		OldSalary dec(10,2),
		NewSalary dec(10,2),
		Operation varchar(25), 
		Date_Time  datetime

	);

--creating update trigger

	Create or alter Trigger TGR_EmployeeAudit
	on Employees
	After Update
	as
	Begin
		set NoCount on;
		insert into EmployeeAudit (	EmployeeID, 
									OldName,
									NewName ,
									OldAge ,
									NewAge ,
									OldDepartment ,
									NewDepartment ,
									OldSalary ,
									NewSalary ,
									Operation,
									Date_Time )
		Select	d.EmployeeID, 
				d.Name,
				i.Name,
				d.Age ,
				i.Age,
				d.Department,
				i.Department,
				d.Salary,
				i.Salary,
				'Update',
				GETDATE()
		from deleted d
		inner join inserted i
		on d.EmployeeID = i.EmployeeID;

	End

--Updating record from Employees
	update Employees
	set Name = 'Rinku',
		age = 30,
		Salary = 50000,
		Department = 'IT'
	where EmployeeID = 10;

--To verify
	Select * from EmployeeAudit;

------------------------------------------------------------------------------------------------------------------

/*
	4)Use a cursor to iterate through the Payments table and update the CustomerBalance column in the Customers table based on the payments.

*/


--Customer table creation
	Create table Customer.Customers 
	(
		CustomerID int primary key identity(1,1),
		Name varchar(100) NOT NULL,
		Email varchar(100) unique NOT NULL,
		Phone varchar(15) unique NOT NULL,
		BankBalance dec(10,2) NOT NULL default 0.00
	);

--Inserting few records
	insert into Customer.Customers (Name, Email, Phone, BankBalance) values 
	('Riya kamble', 'rk@gmail.com', '9876543210', 5000.00),
	('Atharv Kamble', 'ak@gmail.com', '9123456789', 1000.00);

select * from Customer.Customers ;

--Payment table creation

	Create Table Customer.Payment
	(
		PaymentID	int primary key identity,
		CustomerID	int unique,
		Amount	dec(10,2),
		PaymentDate	date,
		Foreign key (CustomerID) references Customer.Customers(CustomerID) 
		on  update cascade
		on  delete cascade
	);
	
-- Inserting few records
	insert into Customer.Payment (CustomerID, Amount, PaymentDate) values 
	(1, 500, '2025-03-21'),
	(2, 300, '2025-03-22' );

	select * from Customer.Payment

--Cursor 
	
	Declare @customerId int,
			@amount dec(10,2);

	Declare Cursor_UpdatePayment Cursor
	for
	select CustomerID, Amount from Customer.Payment

	Open Cursor_UpdatePayment;
	 
	Fetch next from Cursor_UpdatePayment into
	@customerId, @amount;

	while @@FETCH_STATUS = 0
		Begin
			Update Customer.Customers
			set BankBalance = BankBalance - @amount
			where CustomerID = @customerId;

			Fetch next from Cursor_UpdatePayment into
			@customerId, @amount;

			print 'Bank balance Updated Sucessfully !!'
		end
	Close Cursor_UpdatePayment;
	Deallocate Cursor_UpdatePayment;

------------------------------------------------------------------------------------------------------------------
/*
	5)Write a scalar-valued function CalculateAge that takes a date of birth as input and returns the age in years
*/

	Create or Alter Function UDF_CalculateAge (@DOB date)
	Returns int
	as
	Begin
		Declare @Age int;
		Set @Age = DATEDIFF(YEAR, @DOB, GETDATE())
		--return Concat('Age : ', ' ', @Age);
		return @Age;
	End

--To verify function
	select dbo.UDF_CalculateAge('2002-07-07') as Age
	select dbo.UDF_CalculateAge('1988-07-27') as Age

-------------------------------------------------------------------------------------------------------------------
/*
	6)Write a function IsValidEmail that accepts an email address and returns 1 if it is valid, 0 otherwise.
*/

	Create Function UDF_IsValidEmail(@Email varchar(150))
	Returns int
	As
	Begin
		if @Email like '%[A-Za-z0-9._%+-]@[A-Za-z0-9.-]%.[A-Za-z][A-Za-z]%'
			Begin
				return 1;
			End
	
			return 0;
	End

--To verify function
	select dbo.UDF_IsValidEmail('disha@gmail.com')
	select dbo.UDF_IsValidEmail('@gmail.com')
