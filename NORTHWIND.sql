CREATE TABLE Employees(
EmployeeID INT NOT NULL PRIMARY KEY,
EmployeeName VARCHAR(50),
Title VARCHAR(50),
City VARCHAR(50),
Country VARCHAR(50),
ReportsTo INT
);
SELECT * FROM Orders;
SELECT * FROM Employees;

CREATE TABLE Orders(
OrderID	INT NOT NULL PRIMARY KEY,
CustomerID VARCHAR(50),
EmployeeID INT,
OrderDate	DATE,
RequiredDate DATE,	
ShippedDate DATE,
ShipperID INT,
Freight DECIMAL(10,5),
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE VIEW Employee_Orders AS
SELECT a.employeeid, employeename, orderid, (shippeddate - orderdate) "Days to Ship", 
(requireddate - orderdate) "Delivery deadline",orderdate, requireddate, shippeddate, 
freight,
CASE
WHEN Shippeddate IS NULL THEN 'Pending'
WHEN (shippeddate - orderdate) > (requireddate - orderdate) THEN 'Late Shipment'
ELSE 'On-Time' 
END AS "Delivery Status"
FROM Employees a
INNER JOIN orders b
ON a.employeeid= b.employeeid;