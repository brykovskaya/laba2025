--DROP TABLE  OrderItem;
--Address Category  Dates Users Product Orders  Payment OrderItem

--1. создаем табилицы 
CREATE TABLE Address (
    AddressID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
    Street VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(100)
);    
  
CREATE TABLE Category (
    CategoryID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
    CategoryName VARCHAR(255),
    Description TEXT
);    

CREATE TABLE Dates (
    DateID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
    Date DATE,
    Month INT,
    Year INT
);

CREATE TABLE Users (
	UserID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
	UserName VARCHAR (255), 
	Email VARCHAR (255), 
	pass_word VARCHAR (255), 
	Firstname VARCHAR (255), 
	LastName VARCHAR (255), 
	PhoneNumber VARCHAR (255), 
	AddressID INT REFERENCES Address(AddressID)
);

CREATE TABLE Product (
    ProductID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
    Name VARCHAR(255),
    Description TEXT,
    Price DECIMAL(10, 2),
    StockQuantity INT,
    CategoryID INT REFERENCES Category(CategoryID)
);
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
    UserID INT REFERENCES Users (UserID),
    DateID INT REFERENCES Dates (DateID),
    TotalAmount DECIMAL(10, 2),
    Status VARCHAR(50)
);
CREATE TABLE Payment (
    PaymentID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
    OrderID INT REFERENCES Orders (OrderID),
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50)
);
CREATE TABLE OrderItem (
    OrderItemID SERIAL PRIMARY KEY,  -- автоинкрементный идентификатор
    OrderID INT REFERENCES Orders(OrderID),
    ProductID INT REFERENCES Product(ProductID),
    Quantity INT,
    Price DECIMAL(10, 2)
);
