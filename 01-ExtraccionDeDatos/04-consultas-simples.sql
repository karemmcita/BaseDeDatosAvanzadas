USE NORTHWND;

SELECT *
FROM Employees;
GO

SELECT *
FROM Customers;
GO

SELECT *
FROM Orders;
GO

SELECT *
FROM [Order Details];
GO

SELECT *
FROM Shippers;
GO

SELECT *
FROM Suppliers;
GO

SELECT *
FROM Products;
GO

--PROYECCIÓN DE LA TABLA 
SELECT ProductName, UnitsInStock, UnitPrice
FROM Products;

--ALIAS DE COLUMNA 
SELECT ProductName AS NombreProducto, 
UnitsInStock 'Unidades Medida',
UnitPrice AS [Precio Unitario]
FROM Products;

--CAMPO CALCULADO Y ALIAS DE TABLA
SELECT 
	OrderID AS [Numero de orden], 
	Products.ProductID AS [Numero de producto], 
	ProductName AS 'Nombre de producto', 
	Quantity AS Cantidad,  
	Products.UnitPrice AS Precio, (Quantity * [Order Details].UnitPrice) AS Subtotal
FROM [Order Details]
INNER JOIN 
Products
ON Products.ProductID = [Order Details].ProductID;


SELECT 
	OrderID AS [Numero de orden], 
	pr.ProductID AS [Numero de producto], 
	ProductName AS 'Nombre de producto', 
	Quantity AS Cantidad,  
	od.UnitPrice AS Precio, (Quantity * od.UnitPrice) AS Subtotal
FROM [Order Details] AS od 
INNER JOIN 
Products AS pr
ON pr.ProductID = od.ProductID;

--Operadores Relaciones (<, >, <=, >=, =, != o <>)
--Mostrar todos los productos con un precio mayor a 20
SELECT *
FROM Customers
WHERE Country <> 'Mexico';

--Seleccionar todas aquellas ordenes  realizadas en 1997 
SELECT 
OrderID AS [Número de orden],
OrderDate AS [Fecha de Orden],
YEAR (OrderDate) AS [Año con Year],
DATEPART (YEAR, OrderDate) AS [Año de DATEPART]
FROM Orders
WHERE YEAR (OrderDate) = 1997;

SELECT 
OrderID AS [Número de orden],
OrderDate AS [Fecha de Orden],
YEAR (OrderDate) AS [Año con Year],
DATEPART (YEAR, OrderDate) AS [Año de DATEPART],
DATEPART (QUARTER, OrderDate) AS Trimestre,
DATEPART (WEEKDAY, OrderDate) AS [Día semana],
DATENAME (WEEKDAY, OrderDate) AS [Nombre Día Semana]
FROM Orders
WHERE YEAR (OrderDate) = 1997;

set Language Spanish

--Operadores lógicos (AND, OR, NOT)

--Seleccionar los productos que un precio mayor a 20 
--y un stock mayor a 30

SELECT 
ProductID AS [Número Producto],
ProductName AS [Nombre del Producto],
UnitPrice AS [Existencia],
(UnitPrice * UnitsInStock) AS [Costo inventario]
FROM Products
WHERE UnitPrice > 20
AND UnitsInStock > 30;

SELECT *
FROM Customers;

--Seleccionar los clientes de Estados Unidos o Canada
SELECT 
ContactName AS [Nombre del contacto]
FROM Customers
WHERE Country = 'USA'
OR country = 'canada';

--Seleccionar los clientes de Brasil, rio de Janeiro y que tengan región
SELECT *
FROM Customers
WHERE Country = 'Brazil' AND City = 'Rio de Janeiro' AND Region IS NOT NULL;

--OPERADOR IN
-- Seleccionar todos los clientes de USA, Alemania y Francia
SELECT *
FROM Customers
WHERE Country= 'USA'
OR Country  = 'France'
OR Country  = 'Germany';

SELECT *
FROM Customers
WHERE Country IN ('USA', 'Germany', 'France')
ORDER BY Country DESC;

--Seleccionar los  nombre de tres categorias especificas 
SELECT *
FROM Categories
WHERE CategoryName IN ('Beverages','Produce','Seafood');
--seleccionar los pedidos de tres empleados especificos
SELECT *
FROM Customers;

SELECT 
OrderID,
EmployeeID,
ShipName
FROM Orders
WHERE EmployeeID IN ('5','3','4');

SELECT e.EmployeeID,
CONCAT(e.FirstName, e.LastName) AS FullName,
o.OrderDate
FROM Orders AS o
INNER JOIN Employees e
ON o.EmployeeID = e.EmployeeID
WHERE o.EmployeeID IN (5,6,7)
ORDER BY 2 DESC;

--Pedidos de tres empleados

--Seleccionar todos los clientes que no sean de Alemania, Mexico y Argentina
SELECT *
FROM Customers
WHERE Country NOT IN ('Mexico','Germany','Argentina') 
ORDER BY Country;

--OPERADOR BETEEN
--Seleccionar todos los productos que su precio esten entre 10 y 30
SELECT 
	ProductName,
	UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 10 AND 30
ORDER BY 2 DESC; 

--Seleeccionar todas las ordenes de 1995 a 1997

SELECT *
FROM Orders
WHERE YEAR (OrderDate)  BETWEEN 1995 AND 1997;


--SELECCIONAR TODOS LOS PRODUCTOS QUE NO ESTEN EN UN PRECIO 
--ENTRE 10 Y 20

SELECT *
FROM Products
WHERE UnitPrice NOT BETWEEN 10 AND 20;

--OPERADOR LIKE 
--WILDCARDS (%, _, [], [^])
--Seleccionar todos los clientes en donde su nombre comience con A

SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%';


SELECT *
FROM Customers
WHERE CompanyName LIKE 'an%';

--Seleccionar todos los clientes de una ciudad 
--que comienza con L, seguido de cualquier caracter , 
--despues nd y que terminen con dos caracteres cualesquiera

SELECT *
FROM Customers
WHERE City LIKE 'L_nd__';

--Seleccionar todos lops clientes que su nombre terminen con A
SELECT *
FROM Customers
WHERE CompanyName LIKE '%a';

--Devolver todos los clientes que en la ciudad contengan la letra 
--"L"
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE City Like '%l%';

--Delver todos los clientes que comienzan 
-- con A o comienzan con B

SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName Like 'A%' OR CompanyName like 'B%';

--Devolver todos los clientes que  comiencen con ´'B'
--y terminen con s
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE 'B%S';

--Devolver todos los clientes que compiencen con "A"
--y que tengan al menos tres caracteres de longitud
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE 'A__%';

--Devolver todos los clientes que tiene r en la segunda posicion
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE '_R%';

--Devolver todos los clientes que contengan a, b, c al inicio
SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE '[^abc]%';

SELECT CustomerID, CompanyName, City
FROM Customers
WHERE CompanyName LIKE '[a-f]%';

--Seleccionar todos los clientes de Berlin mostrando 
-- solo los tres primeros

SELECT TOP 3 *
FROM Customers
WHERE Country= 'USA';

--Seleccionar todos los clientes ordenados de forma ascendente
--por su numero de cliente pero saltando las primeras 5 filas(offset)

SELECT *
FROM Customers
ORDER BY CustomerID ASC
OFFSET 5 ROWS;

--Seleccionar todos los clientes ordenados de forma ascendente
--por su numero de cliente pero saltando las primeras 5 filas(OFFSET y FETCH)
--y mostrar las siguientes 10
SELECT *
FROM Customers
ORDER BY CustomerID ASC
OFFSET 5 ROWS
FETCH NEXT 10 ROWS ONLY;



