--Database Review6
	Create Database Review6;

--Using 
	use Review6;

------------------------------------------------------------------------------------------------------

/*
1. Basic Employee Management
	
*/

--Create an Employees table with columns: EmployeeID, Name, Age, Department, and Salary.
	 Create Table Employees
	 (
		EmployeeID int primary key,
		Name varchar(25),
		Age int Check(Age > 18),
		Department varchar(25),
		Salary Money
	 );

--Insert 5 sample employee records.
	Insert Into Employees (EmployeeID, Name, Age, Department, Salary) values
	(1, 'Disha', 24, 'Developer', 75000),
	(2, 'Swarali', 27, 'Cleark', 25000),
	(3, 'John Doe', 25, 'Cleark', 22000),
	(4, 'Vijay', 29, 'HR', 95000),
	(5, 'Ritika', 23, 'Manager', 72000);

-- Retrieve all employee records
	select * from Employees;

--Update the salary of an employee with EmployeeID = 3.
	Update Employees
	set Salary = 33000
	where EmployeeID = 3;

--Delete an employee whose Name = 'John Doe'.
	Delete from Employees
	where Name = 'John Doe';
------------------------------------------------------------------------------------------------------

/*
2. Student Management System
*/

--Create a Students table with columns: StudentID, Name, Class, DOB, and Grade.
	Create Table Students
	(
		StudentID int primary key,
		Name varchar(25),
		Class varchar(10),
		DOB date,
		Grade varchar(5)
	);

--Insert records for 10 students.

	Insert Into Students (StudentID, Name, Class, DOB, Grade) Values
	(1, 'Atharv', '10th', '2008-05-12', 'A+'),
	(2, 'Ishaan', '10th', '2008-07-23', 'B'),
	(3, 'Neha', '9th', '2009-03-15', 'A'),
	(4, 'Rohan', '8th', '2010-06-10', 'B+'),
	(5, 'Simran', '11th', '2007-11-30', 'A'),
	(6, 'Vikram', '12th', '2006-09-18', 'A-'),
	(7, 'Kavya', '9th', '2009-01-25', 'B'),
	(8, 'Aryan', '11th', '2007-05-05', 'A+'),
	(9, 'Priya', '12th', '2006-12-14', 'B+'),
	(10, 'Rahul', '8th', '2010-08-22', 'A-');
	
---- Retrieve all students records
	select * from Students;

--Update the Grade of a student with StudentID = 5.
	Update Students
	set Grade = 'B'
	where StudentID = 5;

--Delete all students who belong to Class = '10th'.
	Delete from Students
	where Class = '10th';

------------------------------------------------------------------------------------------------------
/*
	3. Product Inventory

*/

--Create a Products table with columns: ProductID, ProductName, Price, Stock.

	Create Table Products 
	(
		ProductID int primary key,
		ProductName Varchar(50),
		Price decimal(10,2),
		Stock int
	);

--Insert 7 sample products into the table.

	Insert Into Products (ProductID, ProductName, Price, Stock) values
	(1, 'Parle', 500.00, 50),
	(2, 'Lays', 3000.00, 500),
	(3, 'Haldiram', 2000.00, 30),
	(4, 'Chakote', 1500.00, 60),
	(5, 'Balaji', 1000.00, 200),
	(6, 'Bikaji', 350.00, 4),
	(7, 'Santoor', 8000.00, 47);

--Increase the price of all products by 10%.
	Update Products
	Set Price = Price * 1.10;
	

-- Delete products where the stock is below 5.
	Delete from Products
	where Stock < 5;

-- Display all records
	select * from Products;

------------------------------------------------------------------------------------------------------
/*
	4. Users table
	
*/

--Create a Users table with columns: UserID, Username, Email, and Password.
--Apply constraints:
					--Make UserID the primary key.
					--Ensure Email is unique.
					--Ensure Password has a minimum length of 8 characters.
	Create Table Users (
    UserID int Primary Key,
    Username varchar(25) NOT NULL,
    Email varchar(50) Unique NOT NULL,
    Password varchar(50) NOT NULL Check (Len(Password) >= 8)
	);

--Write SQL queries to test these constraints by inserting and updating data.

	-- Inserting entries
	Insert Into Users (UserID, Username, Email, Password) 
	values (1, 'Disha', 'disha@gamil.com', 'Password1');

	Insert Into Users (UserID, Username, Email, Password) 
	values (2, 'Riya', 'Riyab@gmail.com', 'password@123');

	Insert Into Users (UserID, Username, Email, Password) 
	values (3, 'Charlie', 'charlie@gmail.com', '1234');	---Gives Error

	--updating data
	update Users
	set Email = 'disha@gamil.com'
	where Username = 'Riya'; -- Cannot insert duplicate key in object 'dbo.Users'. The duplicate key value is (disha@gamil.com).

	update Users
	set Email = 'riyakamble@gamil.com'
	where Username = 'Riya'; -- Execute Successfully !	

	-- Display recors
	Select * from Users;
------------------------------------------------------------------------------------------------------
/*
	5. Departments table.
*/

--Create a Departments table (DepartmentID, DepartmentName) 
--and an Employees table (EmployeeID, Name, DepartmentID).
--Add a foreign key constraint on DepartmentID in Employees referencing Departments
	
	-- Departments table
		Create Table Departments 
		(
			DepartmentID int primary key,
			DepartmentName varchar(50) NOT NULL
		);

	--Employees table
		Create Table Employees2 
		(
			EmployeeID int primary key,
			Name varchar(100) NOT NULL,
			DepartmentID int,
			Foreign Key (DepartmentID) References Departments(DepartmentID)
			On Update cascade
			On Delete cascade
		);

			   
--Insert valid and invalid records to test the constraint.

-- Insert departments
	INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
	(1, 'IT'),
	(2, 'Medical'),
	(3, 'Computer Science'),
	(4, 'Marketing');

-- Insert valid employees
	INSERT INTO Employees2 (EmployeeID, Name, DepartmentID) VALUES
	(1001, 'Alok', 1),  
	(1002, 'Disha', 1),      
	(1003, 'Charlie', 3),
	(1004, 'Chiku', 4),
	(1005, 'Kittu', 2);

--Display Records	
	Select * from Employees2;
	Select * from Departments;

---- Insert invalid employees
	INSERT INTO Employees2 (EmployeeID, Name, DepartmentID)
	VALUES (1006, 'Amar', 5); --The conflict occurred in database "Review6", table "dbo.Departments", column 'DepartmentID'.

--------------------------------------------------------------------------------------------------------------

/*
	6. Create a Products table with a column Price.
	Add a check constraint to ensure the Price is always greater than 0.
	Test the constraint by inserting valid and invalid data.
*/
	---Create a Products table
	Create Table Products2 
	(
		ProductID int primary key,
		ProductName Varchar(50),
		Price decimal(10,2) Check(Price > 0), -- Check Constraint
		Stock int
	);
	
	--Inserting values
		Insert Into Products2 (ProductID, ProductName, Price, Stock) 
		values(1, 'Parle', 500.00, 50); --Right

		Insert Into Products2 (ProductID, ProductName, Price, Stock) 
		values(2, 'Lays', 3000, 500); --Right
		
		Insert Into Products2 (ProductID, ProductName, Price, Stock) 
		values(3, 'Haldiram', 00, 0); --Error because of Check Constraint
	
------------------------------------------------------------------------------------------------------
/*
	7. Create a Books table with columns: BookID, Title, and Author.
	Add a new column PublicationYear to the table.
	Modify the Author column to have a maximum length of 150 characters.
	

*/

--Create a Books table
	Create Table Books 
	(
		BookID int primary key, 
		Title varchar(25),
		Author varchar(25)
	);

--Add a new column PublicationYear to the table
	Alter Table Books
	Add PublicationYear int;

--Modify the Author column to have a maximum length of 150 characters.
	Alter Table Books
	Alter Column Author varchar(150);

--Drop the PublicationYear column.
	Alter Table Books
	Drop Column PublicationYear ;

-------------------------------------------------------------------------------------------------------
/*
	8. Create a Customers table with columns: CustomerID, Name, and Phone.
	Rename the column Phone to ContactNumber.
	Change the data type of ContactNumber to VARCHAR(15).
*/

--Create a Customers table
	Create Table Customers 
	(
		CustomerID int primary key, 
		Name varchar(25),
		Phone BigInt
	);

--Rename the column Phone to ContactNumber.
	SP_Rename 'Customers.Phone', 'ContactNumber', 'COLUMN';

--Change the data type of ContactNumber to VARCHAR(15).
	Alter Table Customers
	Alter Column ContactNumber varchar(15);

---------------------------------------------------------------------------------------------------------

/*
	9. Create an Employees table with columns: EmployeeID, Name, Age, and Salary.
	Write queries to:
	Retrieve all employees with a salary greater than 50,000.
	Retrieve all employees whose names start with the letter ‘A’.
	Retrieve employees aged between 25 and 35.

*/

----Create an Employees table 
	 Create Table Employees3
	 (
		EmployeeID int primary key,
		Name varchar(25),
		Age int Check(Age > 18),
		Salary Money
	 );

--Insert employee records.
	Insert Into Employees3 (EmployeeID, Name, Age, Salary) values
	(1, 'Disha', 24,  75000),
	(2, 'Swarali', 36, 25000),
	(3, 'Atharv', 25,  22000),
	(4, 'Vijay', 39, 95000),
	(5, 'Ritika', 23,  32000);

--Retrieve all employees with a salary greater than 50,000.
	Select * from Employees3
	where Salary > 50000;

--Retrieve all employees whose names start with the letter ‘A’.
	Select * from Employees3
	where Name like 'A%';

--Retrieve employees aged between 25 and 35.
	Select * from Employees3
	where Age between 25 And 35;

------------------------------------------------------------------------------------------------------
/*
	10. Create a Sales table with columns: SaleID, ProductID, Quantity, and SaleDate.
	Write queries to:
	Group sales by ProductID and calculate total quantity sold for each product.
	Filter out products with total sales less than 50 using the HAVING clause.
*/

--Create a Sales table
	Create Table Sales 
	(
		SaleID int Primary Key,
		ProductID int,
		Quantity int not null,
		SaleDate date,
    );

	Insert Into Sales (SaleID, ProductID, Quantity, SaleDate) values
	(1, 101, 20, '2025-03-01'),
	(2, 102, 35, '2025-03-02'),
	(3, 103, 15, '2025-03-03'),
	(4, 101, 40, '2025-03-04'),
	(5, 104, 50, '2025-03-05'),
	(6, 102, 25, '2025-03-06'),
	(7, 105, 45, '2025-03-07'),
	(8, 101, 30, '2025-03-08');


--Group sales by ProductID and calculate total quantity sold for each product.
	Select ProductID, Sum(Quantity) as 'Total Quantity Sold'
	from Sales
	Group By ProductID;

---Filter out products with total sales less than 50 using the HAVING clause.
	Select ProductID, Sum(Quantity) as 'Total Quantity Sold'
	from Sales
	Group By ProductID
	Having Sum(Quantity) < 50 ;


-------------------------------------------------------------------------------------------------------
/*
	11. Create an Orders table with columns: OrderID, CustomerID, OrderAmount, OrderDate.
	Retrieve all orders sorted by OrderAmount in descending order.
	Retrieve the top 5 most recent orders.

*/

--Create an Orders table
	Create Table Orders
	(
		OrderID int primary key,
		CustomerID int,
		OrderAmount decimal(10,2), 
		OrderDate date
	);

	Insert Into Orders (OrderID, CustomerID, OrderAmount, OrderDate) values
	(101, 1, 2500, '2025-03-01'),
	(102, 2, 500, '2025-03-02'),
	(103, 3, 1200.00, '2025-03-03'),
	(104, 1, 300.00, '2025-03-04'),
	(105, 2, 450.00, '2025-03-05'),
	(106, 4, 6000, '2025-03-06'),
	(107, 3, 150, '2025-03-07');

--Retrieve all orders sorted by OrderAmount in descending order.
	Select * from Orders
	Order By OrderAmount DESC;

--Retrieve the top 5 most recent orders.
	Select Top 5 * from Orders
	Order By OrderDate DESC;

-------------------------------------------------------------------------------------------------------
/*
	12. Create two tables: Customers (CustomerID, Name) 
	and Orders (OrderID, CustomerID, OrderDate, Amount).
	Write an inner join query to retrieve all orders along with the customer names.

*/

-- Customers  Table
	Create Table Customers1 
	(
		CustomerID int primary key, 
		Name varchar(25),
	);

--Inserting value
	Insert Into Customers1 (CustomerID, name) values
	(1, 'Disha'),
	(2, 'Rutuja'),
	(3, 'Pawan'),
	(4, 'Sonu');

-- Orders Table
	Create Table Orders1
	(
		OrderID int primary key,
		CustomerID int,
		Amount decimal(10,2), 
		OrderDate date,
		Foreign key (CustomerID) References Customers1(CustomerID)
		on update cascade
		on delete cascade
	);

--Inserting values
	Insert Into Orders1 (OrderID, CustomerID, Amount, OrderDate) values
	(101, 1, 2500, '2025-03-01'),
	(102, 2, 500, '2025-03-02'),
	(103, 3, 1200.00, '2025-03-03'),
	(104, 1, 300.00, '2025-03-04'),
	(105, 2, 450.00, '2025-03-05'),
	(106, 4, 6000, '2025-03-06'),
	(107, 3, 150, '2025-03-07');

--Write an inner join query to retrieve all orders along with the customer names.
	Select  o.OrderID, o.CustomerID, o.Amount, o.OrderDate , c.name
	from Orders1 o
	Inner Join Customers1 c
	on o.CustomerID = c.CustomerID;

------------------------------------------------------------------------------------------------------

/*
	13. Create two tables: Products (ProductID, ProductName)
	OrderDetails (OrderDetailID, ProductID, Quantity).
	Write a left join query to retrieve all products, including those that have no orders.

*/

-- Product table
	Create Table Products3 
	(
		ProductID int primary key,
		ProductName Varchar(50)
	);

--Inserting values
	Insert Into Products3 (ProductID, ProductName) values
	(1, 'Parle'),
	(2, 'Lays'),
	(3, 'Haldiram'),
	(4, 'Chakote');

--OrderDetails Table
	Create Table OrderDetails
	(
		OrderDetailID int primary key, 
		ProductID int, 
		Quantity int,
		Foreign key (ProductID) References Products3(ProductID)
		on update cascade
		on delete cascade
	);

--Inserting values
	Insert Into OrderDetails (OrderDetailID , ProductID, Quantity ) values
	(101, 1, 20),
	(102, 3, 50),
	(103, 1, 10),
	(104, 3, 15),
	(105, 3, 60),
	(106, 1, 5);
	
--Write a left join query to retrieve all products, including those that have no orders.
	
	Select o.OrderDetailID , o.ProductID, o.Quantity, p.ProductName 
	from Products3 p
	Left Join OrderDetails o
	on p.ProductID = o.ProductID;

-------------------------------------------------------------------------------------------------------

/*
	14)Create two tables: Employees (EmployeeID, Name) and 
	Projects (ProjectID, EmployeeID, ProjectName).
	Write a right join query to retrieve all projects and their assigned employees.
*/

--Employee Table creation
	Create Table Employees4
		(
			EmployeeID int primary key,
			Name varchar(100) NOT NULL,
		);

--Inserting values
	Insert Into Employees4 values	(1, 'Disha'),
									(2, 'Alok'),
									(3, 'Bhagyawan'),
									(4, 'Charlie');

----Projects Table creation
	Create Table Projects 
	(
		ProjectID int primary key, 
		EmployeeID int, 
		ProjectName varchar(30)
		Foreign Key (EmployeeID) References Employees4(EmployeeID)
		On Update cascade
		On Delete cascade
	);

--Inserting values
	Insert Into Projects (ProjectID , EmployeeID, ProjectName) values
	(101, 1, 'Database Project' ),
	(102, 1, 'SQL Project' ),
	(103, 4, 'Testing Project' );

-- Write a right join query to retrieve all projects and their assigned employees.
	Select p.ProjectID, p.ProjectName, p.EmployeeID, e.Name  
	from Projects p
	Right Join Employees4 e
	on p.EmployeeID = e.EmployeeID;

-------------------------------------------------------------------------------------------------------