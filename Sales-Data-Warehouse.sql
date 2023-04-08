-- by Farzam Salimi
-- Datawarehouse for store Sales



CREATE TABLE Product (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Category VARCHAR(50),
  Price DECIMAL(10,2)
);

CREATE TABLE Time (
  Date DATE PRIMARY KEY,
  Month INT,
  Quarter INT,
  Year INT
);

CREATE TABLE Store (
  StoreID INT PRIMARY KEY,
  StoreName VARCHAR(50),
  Location VARCHAR(50),
  Manager VARCHAR(50)
);

CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(50),
  Age INT,
  Gender CHAR(1)
);

CREATE TABLE Sales (
  SalesID INT PRIMARY KEY,
  ProductID INT,
  Date DATE,
  StoreID INT,
  CustomerID INT,
  QuantitySold INT,
  TotalSales DECIMAL(10,2),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (Date) REFERENCES Time(Date),
  FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Inventory (
  InventoryID INT PRIMARY KEY,
  ProductID INT,
  Date DATE,
  StoreID INT,
  QuantityOnHand INT,
  ReorderLevel INT,
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (Date) REFERENCES Time(Date),
  FOREIGN KEY (StoreID) REFERENCES Store(StoreID)
);



-- Load fact tables


INSERT INTO Sales (SalesID, ProductID, Date, StoreID, CustomerID, QuantitySold, TotalSales)
SELECT s.SalesID, p.ProductID, t.Date, st.StoreID, c.CustomerID, s.QuantitySold, s.QuantitySold * p.Price
FROM StagingSales s
JOIN Product p ON s.ProductName = p.ProductName
JOIN Time t ON s.Date = t.Date
JOIN Store st ON s.StoreName = st.StoreName
JOIN Customer c ON s.CustomerName = c.CustomerName;





INSERT INTO Inventory (InventoryID, ProductID, Date, StoreID, QuantityOnHand, ReorderLevel)
SELECT i.InventoryID, p.ProductID, t.Date, st.StoreID, i.QuantityOnHand, i.ReorderLevel
FROM StagingInventory i
JOIN Product p ON i.ProductName = p.ProductName
JOIN Time t ON i.Date = t.Date
JOIN Store st ON i.StoreName = st.StoreName;
