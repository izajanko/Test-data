drop table dbo.RandomCustomer;
CREATE TABLE dbo.RandomCustomer ( 
    CustomerID INT  NOT NULL, 
    IsClubMember BIT, 
    CustomerFirstName VARCHAR(255), 
	CustomerLastName VARCHAR(255),
    LogInDateTime DATETIME, 
    ClubPoints NUMERIC(16,2) ) 
GO

DECLARE @count INT 
SET @count = 1

WHILE @count <= 1000000000
BEGIN
INSERT INTO dbo.RandomCustomer 
    SELECT    @count, 
            CASE WHEN DATEPART(MILLISECOND, GETDATE()) >= 500 THEN 0 ELSE 1 END [IsClubMember], 
			(SELECT TOP 1 Imie FROM dbo.FirstName ORDER BY NEWID()),
			(SELECT TOP 1 Nazwisko FROM dbo.LastName ORDER BY NEWID()), 
            DATEADD(MILLISECOND, (ABS(CHECKSUM(NEWID())) % 6000) * -1, 
                DATEADD(MINUTE, (ABS(CHECKSUM(NEWID())) % 1000000) * -1, GETDATE())) [LogInDateTime], 
            (ABS(CHECKSUM(NEWID())) % 100001) + ((ABS(CHECKSUM(NEWID())) % 100001) * 0.00001) [ClubPoints]
    SET @count += 1
END

select top(100) * from dbo.RandomCustomer;

select *, 
CASE WHEN DATEPART(MILLISECOND, GETDATE()) >= 500 THEN 0 ELSE 1 END [IsClubMember]
from dbo.RandomCustomer;

drop table dbo.RandomAdress;

CREATE TABLE dbo.RandomAdress ( 
    AdressID INT  NOT NULL, 
    CityName VARCHAR(255),
	StreetName VARCHAR(255),
	StreetNumber INT,
	HomeNumber INT,
    DateofEntry DATETIME, 
     ) 
GO

DECLARE @count INT 
SET @count = 1

WHILE @count <= 100
BEGIN
INSERT INTO dbo.RandomAdress
			SELECT	@count,
			(SELECT TOP 1 Miasto FROM dbo.City ORDER BY NEWID()), 
			(SELECT TOP 1 Ulica FROM dbo.Street ORDER BY NEWID()), 
			RAND()*100 -rand()*0.3,
			RAND()*100 -rand()*0.3,
            GETDATE()
    SET @count += 1
END

select top(100) * from RandomAdress;

--SELECT ISNULL(CHOOSE(cast(ceiling(rand() * 3) as int),  'bg-blue', 'bg-blue-madison', 'bg-blue-hoki'), 'default_value');

--select cast(ceiling(rand() * 3) as int)
--SELECT rand();

drop table dbo.RandomProduct;

CREATE TABLE dbo.RandomProduct ( 
    ProductID INT  NOT NULL,  
    ProductName VARCHAR(255),
    ProductNumber int,
	Color VARCHAR(255),
	ProductWeight int,
	ProductCategoryID int,
	SellStartDate DATETIME,
	SellEndDate DATETIME
	 
	 ) 
GO

DECLARE @count INT 
SET @count = 1

WHILE @count <= 100
BEGIN
INSERT INTO dbo.RandomProduct
			SELECT	@count,
			(SELECT ISNULL(CHOOSE(cast(ceiling(rand() * 3) as int),  'Iphone', 'MacBook', 'Airpods'), 'AppleWatch')), 
            RAND()*1000-rand()*0.87,
			(SELECT ISNULL(CHOOSE(cast(ceiling(rand() * 6) as int),  'white', 'grey', 'black', 'green', 'blue', 'spacegrey'), 'goldrose')), 
			RAND()*100 -rand()*0.3,
			RAND()*100 -rand()*0.56, 
			GETDATE(),
			GETDATE()
    SET @count += 1
END

select top(100) * from RandomProduct;




--drop table dbo.RandomProductCategory;

CREATE TABLE dbo.RandomProductCategory ( 
    CategoryID INT  NOT NULL,  
    CategoryName VARCHAR(255),
    CategoryNumber int,
	 
	 ) 
GO

DECLARE @count INT 
SET @count = 1

WHILE @count <= 100
BEGIN
INSERT INTO dbo.RandomProductCategory
			SELECT	@count,
			CONVERT(varchar(255), NEWID()), 
            RAND()*1000-rand()*0.87

    SET @count += 1
END

select top(100) * from RandomProductCategory;





drop table dbo.RandomSale;

CREATE TABLE dbo.RandomSale ( 
    SaleID INT  NOT NULL, 
    ProductID INT,
	CustomerID INT,
	ShipAdress INT,
	UnitPrice INT,
	Discount float,
    Quantity INT, 
     ) 
GO

DECLARE @count INT 
SET @count = 1

WHILE @count <= 1000000000
BEGIN
INSERT INTO dbo.RandomSale
			SELECT	@count,
			ceiling(RAND()*1000000),
			ceiling(RAND()*1000000),
			ceiling(RAND()*1000000),
			ceiling(RAND()*10000),
			ceiling(RAND()*10)/100,
			ceiling(RAND()*10)
            
    SET @count += 1
END

select top(100) * from RandomSale;





drop table dbo.RandomProductDescription;

CREATE TABLE dbo.RandomProductDescription ( 
    ProductDescriptionID INT  NOT NULL,  
    ProductID INT,
    ProductDescription varchar(255)
	 ) 
GO

DECLARE @count INT 
SET @count = 1

WHILE @count <= 1000000
BEGIN
INSERT INTO dbo.RandomProductDescription
			SELECT	@count,
			ceiling(RAND()*1000000),
			CONVERT(varchar(255), NEWID())
    SET @count += 1
END

select top(100) * from RandomProductDescription;

