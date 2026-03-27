
CREATE DATABASE bdsubqueries;

CREATE TABLE clientes(
id_cliente int not null identity (1,1) primary key,
nombre varchar(50) not null,
ciudad varchar(50) not null,
);

CREATE TABLE pedidos(
id_pedido int not null identity (1,1) primary key,
id_cliente int not null,
total money not null,
fecha date not null
CONSTRAINT fk_pedidos_clientes
FOREIGN KEY (id_cliente)
REFERENCES clientes (id_cliente)
ON DELETE CASCADE
);

INSERT INTO clientes (nombre, ciudad) 
VALUES ('Ana', 'CDMX'), 
('Luis', 'Guadalajara'), 
('Marta', 'CDMX'), 
('Pedro', 'Monterrey'), 
('Sofia', 'Puebla'), 
('Carlos', 'CDMX'), 
('Artemio', 'Pachuca'), 
('Roberto', 'Veracruz'); 

INSERT INTO pedidos (id_cliente, total, fecha) 
VALUES (1, 1000.00, '2024-01-10'), 
(1, 500.00, '2024-02-10'), 
(2, 300.00, '2024-01-05'), 
(3, 1500.00, '2024-03-01'), 
(3, 700.00, '2024-03-15'), 
(1, 1200.00, '2024-04-01'), 
(2, 800.00, '2024-02-20'), 
(3, 400.00, '2024-04-10')

--Subconsulta 

SELECT 
MAX (total)
FROM pedidos;

--Consulta principal
SELECT *
FROM pedidos
WHERE total = (SELECT MAX (total) FROM pedidos);

SELECT TOP 1 *
FROM
pedidos 
ORDER BY total DESC;

--Seleccionar el cliente que hizo el pedido m�s caro
--Subconsulta
SELECT id_cliente
FROM pedidos
WHERE total = (SELECT MAX(TOTAL) FROM pedidos);

--Consulta principal
SELECT TOP 1 *
FROM pedidos
WHERE id_cliente = (SELECT id_cliente
FROM pedidos
WHERE total = (SELECT MAX(TOTAL) FROM pedidos)
);

SELECT TOP 1 p.id_pedido, c.nombre, p.total, p.fecha, MAX(p.total) AS [M�ximo]
FROM pedidos AS p
INNER JOIN 
clientes AS c
ON p.id_cliente = c.id_cliente
GROUP BY p.id_pedido, c.nombre, p.total, p.fecha
ORDER BY total DESC;

--Seleccionar los pedidos mayores al promedio

--Subconsulta
SELECT AVG(total) 
FROM pedidos;

--Consulta principal
SELECT *
FROM pedidos
WHERE total > (SELECT AVG(total)
FROM pedidos
);

--Mostar el cliente con menor id
SELECT MIN(id_cliente)
FROM pedidos;

SELECT p.fecha, p.id_pedido, c.nombre, p.fecha
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente = c.id_cliente
WHERE p.id_cliente = (SELECT MIN(id_cliente)
FROM pedidos
);

--Mostrar el �ltimo pedido realizado

SELECT MAX (fecha)
FROM pedidos;

SELECT p.id_pedido, c.nombre, p.fecha, P.total
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente = c.id_cliente
WHERE fecha = (SELECT MAX (fecha)
FROM pedidos);

--Mostrar el pedido con el total m�s bajo
SELECT MIN (total)
FROM pedidos;

SELECT *
FROM pedidos
WHERE total = (SELECT MIN (total)
FROM pedidos
);

--Seleccionar los pedidos con el nombre del cliente cuyo total
--de la carga (Freight) sea mayor al promedio general de Freight

SELECT AVG(Freight)
FROM Orders;

SELECT o.OrderID, c.CompanyName, o.Freight
FROM Orders AS o
INNER JOIN Customers AS c
ON o.CustomerID = c.CustomerID
WHERE o.Freight > (
SELECT AVG(Freight)
FROM Orders)
ORDER BY Freight DESC;

--Clientes que han hecho pedidos

SELECT id_cliente
FROM pedidos;

SELECT *
FROM clientes
WHERE id_cliente IN (SELECT id_cliente
FROM pedidos);

SELECT DISTINCT c.id_cliente, c.nombre, c.ciudad
FROM clientes AS c
INNER JOIN pedidos AS p
ON c.id_cliente = p.id_cliente;

--Seleccionar clientes de CDMX que han hecho pedidos
SELECT id_cliente
FROM clientes;

SELECT *
FROM clientes
WHERE ciudad = 'CDMX' AND id_cliente IN (SELECT id_cliente
FROM clientes);

--Seleccionar los pedidos de los clientes que viven en LA CDMX

SELECT  id_cliente
 FROM clientes
 WHERE ciudad = 'CDMX';

 --Consulta principal
 SELECT p.id_cliente, c.ciudad, p.fecha, c.nombre, p.total
 FROM pedidos AS p
 INNER JOIN clientes AS c
 ON p.id_cliente = c.id_cliente
 WHERE p.id_cliente IN (SELECT  id_cliente
 FROM pedidos
 WHERE ciudad = 'CDMX');

 --Seleccionar todos aquellos clientes que no han hecho pedidos
 
 --Subconsulta 
 SELECT id_cliente
 FROM pedidos 

 SELECT *
 FROM clientes
 WHERE id_cliente NOT IN (SELECT id_cliente
 FROM pedidos );

 SELECT DISTINCT p.id_cliente, c.nombre, c.ciudad
 FROM clientes AS c
 INNER JOIN pedidos AS p
 ON c.id_cliente = p.id_cliente;

 
 SELECT DISTINCT c.id_cliente, c.nombre, c.ciudad
 FROM clientes AS c
 LEFT JOIN pedidos AS p
 ON c.id_cliente = p.id_cliente
 WHERE p.id_cliente IS NULL;

 SELECT *
 FROM clientes
 WHERE id_cliente IN (SELECT id_cliente
 FROM pedidos );


 --Instruccion ANY
 --Seleccionar todos los pedidos con un total mayor
 --de algun pedido de luis
 
 SELECT total
 FROM pedidos
 WHERE id_cliente = 2;

 SELECT *
 FROM pedidos
 WHERE total > ANY ( SELECT total
 FROM pedidos
 WHERE id_cliente = 2);

 --Seleccionar todos los pedidos en donde el total sea
 --mayor a algun pedido de ANa

 SELECT total
 FROM pedidos
 WHERE id_cliente = 1;

 SELECT *
 FROM pedidos 
 WHERE total > ANY (SELECT total
 FROM pedidos
 WHERE id_cliente = 1)