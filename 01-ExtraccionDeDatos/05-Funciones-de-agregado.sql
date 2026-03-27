/*
Funciones de agregado
COUNT(*)
COUNT(CAMPO)
MAX()
MIN()
AVG()
SUM()

GROUP BY
HAVING

Nota: estas funciones por si solas
generan un resultado escalar (solo un registro)
*/


SELECT *
FROM Orders;


--Cuenta los registros
SELECT COUNT(*) AS [Número de ordenes]
FROM Orders;

SELECT COUNT (ShipRegion) AS [Número de regiones ]
FROM Orders;

--Regresa el valor más alto
SELECT MAX(OrderDate) AS [Última fecha de compra]
FROM Orders;

SELECT MAX(UnitPrice) AS [Precio más alto]
FROM Products;

--Regresa el valor minimo
SELECT MIN(UnitsInStock) AS [Stock minimo]
FROM Products;

--Total de ventas realizadas 
SELECT ROUND(SUM(UnitPrice * Quantity - (1-Discount)),2) AS [Importe]
FROM [Order Details];

--Seleccionar el promedio de ventas
SELECT 
ROUND(AVG(UnitPrice * Quantity - (1-Discount)),2) AS [Importe]
FROM [Order Details];

--Seleccionar el número de ordenes realizaa¿das a Alemania
SELECT *
FROM Orders;

SELECT *
FROM Orders
WHERE ShipCountry = 'Germany';


SELECT COUNT(*) AS [TOTAL DE ORDENES]
FROM Orders
WHERE ShipCountry = 'Germany'
AND CustomerID = 'LEHMS';

SELECT *
FROM Customers;

--Seleccionar la suma de las cantidades vendidas por cada ordenID, (Agrupadas)
SELECT 
	OrderID,SUM(Quantity) AS [Total de cantidades]
FROM [Order Details]
GROUP BY OrderID;

--Seleccionar el número de productos por categoria
SELECT CategoryID AS [Categoria],COUNT(ProductID)AS [TOTAL DE CATEGORIAS]
FROM Products
GROUP BY CategoryID;

SELECT c.CategoryName AS [Categoria],
COUNT(*)AS [TOTAL DE CATEGORIAS]
FROM Products AS P
INNER JOIN Categories AS c
ON p.CategoryID = c.CategoryID
WHERE C.CategoryName IN ('Beverages','Meat/Poultry')
GROUP BY c.CategoryName;

SELECT *
FROM Products;

--Obtener el total de pedidos realizados por cada cliente
--obtener el numero total de pedidos que ha atentido cada empleado

SELECT 
	EmployeeID AS [Número de empleado],
	COUNT(*) AS [Total de ordenes]
FROM Orders
GROUP BY EmployeeID
ORDER BY [Total de ordenes];

SELECT 
    e.FirstName,
    e.LastName,
	
	COUNT(*) AS [Total de ordenes]
FROM Orders AS o
INNER JOIN Employees AS e
ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName,
    e.LastName
ORDER BY [Total de ordenes];


SELECT 
   CONCAT(e.FirstName , '', e.LastName) AS [Nombre completo],
	
	COUNT(*) AS [Total de ordenes]
FROM Orders AS o
INNER JOIN Employees AS e
ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName,
    e.LastName
ORDER BY [Total de ordenes];
--ventas totales por producto

SELECT od.ProductID, ROUND(SUM(od.Quantity * od.UnitPrice * (1 - Discount)),2) AS [Ventas Totales] 
FROM [Order Details] AS od
WHERE ProductID IN (10,2,6)
GROUP BY od.ProductID;

SELECT TOP 1 p.ProductName, ROUND(SUM(od.Quantity * od.UnitPrice * (1 - Discount)),2) AS [Ventas Totales] 
FROM [Order Details] AS od
INNER JOIN Products AS p
ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY 2 DESC;

--cuantos pedidos se realizaron por año
SELECT DATEPART(YY, OrderDate) AS [Año]
	,COUNT (*) AS [Número de pedidos]
FROM Orders 
GROUP BY DATEPART (YY, OrderDate);

--cuantos produtos ofrece cada provedor 

SELECT c.CompanyName AS [Cliente],COUNT(*) AS [Número de pedidos]
FROM Orders AS o
INNER JOIN Customers AS c
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
HAVING COUNT(*)>10;

--Seleccionar el número de pedidos por cliente que hayan realizado más de 10

--Seleccionar los empleados qyue hayan gestionado pediddios por un total 
--superior a 10000 en ventas (mostrar el id del empleado, el nombre y el 
-- total de compras)

SELECT 
o.EmployeeID AS [Nombre Empleado],
CONCAT (e.FirstName, '', e.LastName) AS [Nombre Completo],
ROUND (SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)), 2) AS [Total Ventas]
FROM [Order Details] AS od
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
INNER JOIN Employees AS e
ON e.EmployeeID = o.EmployeeID
GROUP BY o.EmployeeID,e.FirstName, e.LastName;