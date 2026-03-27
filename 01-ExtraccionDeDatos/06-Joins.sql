USE NORTHWND;
--Solo muestra la estructura de table sin contenido
SELECT TOP 0 CategoryID, CategoryName
--Crea otra tabla
INTO categoriesnew
FROM Categories;

ALTER TABLE categoriesnew
ADD CONSTRAINT pk_categories_new
PRIMARY KEY (Categoryid)

SELECT TOP 0 productId,ProductName, CategoryID
INTO productsnew
FROM Products;

ALTER TABLE productsnew
ADD CONSTRAINT pk_products_new
PRIMARY KEY (productid);

ALTER TABLE productsnew
ADD CONSTRAINT fk_products_categories2
FOREIGN KEY (categoryid)
REFERENCES categoriesnew (categoryid)
ON DELETE CASCADE;

INSERT INTO categoriesnew
VALUES
('C1'),
('C2'),
('C3'),
('C4');

INSERT INTO productsnew 
VALUES
('P1', 1),
('P2', 1),
('P3', 2),
('P4', 2),
('P5', 4),
('P6', NULL);

SELECT *
FROM categoriesnew;

SELECT * 
FROM productsnew;

SELECT *
 FROM categoriesnew AS c
 INNER JOIN 
 productsnew AS p
 ON p.CategoryID = c.CategoryID;

  SELECT *
 FROM categoriesnew AS c
 LEFT JOIN 
 productsnew AS p
 ON p.CategoryID = c.CategoryID;

 SELECT *
 FROM categoriesnew AS c
 LEFT JOIN 
 productsnew AS p
 ON p.CategoryID = c.CategoryID
 WHERE ProductID is null;

   SELECT *
 FROM categoriesnew AS c
 RIGHT JOIN 
 productsnew AS p
 ON p.CategoryID = c.CategoryID;

    SELECT *
 FROM categoriesnew AS c
 RIGHT JOIN 
 productsnew AS p
 ON p.CategoryID = c.CategoryID
 WHERE c.CategoryID IS NULL;

    SELECT *
 FROM productsnew AS c
 LEFT JOIN 
 categoriesnew AS p
 ON p.CategoryID = c.CategoryID;


 SELECT TOP 0
 CategoryID AS [Número],
 CategoryName AS [Nombre],
 [Description] AS [Descripcion]
 INTO categorias_nuevas
 FROM Categories;

 ALTER TABLE categorias_nuevas
 ADD CONSTRAINT pk_categorias_nuevas
 PRIMARY KEY ([Número]);

 SELECT *
 FROM categorias_nuevas;

 INSERT INTO Categories
 VALUES ('Ropa', 'Ropa de paca', NULL),
 ('Linea Blanca', 'Ropa de no paca', NULL);

 SELECT *
 FROM Categories AS c
 INNER JOIN categorias_nuevas AS cn
 ON c.CategoryID = cn.Número;

 SELECT *
 FROM Categories AS c
 LEFT JOIN categorias_nuevas AS cn
 ON c.CategoryID = cn.Número;

 INSERT INTO categorias_nuevas
 SELECT c.CategoryName,c.Description
 FROM Categories AS c
 LEFT JOIN categorias_nuevas AS cn
 ON c.CategoryID = cn.Número
 WHERE cn.Número IS NULL;

 SELECT c.CategoryName,c.Description
 FROM Categories AS c
 LEFT JOIN categorias_nuevas AS cn
 ON c.CategoryID = cn.Número
 WHERE cn.Número IS NULL;

 SELECT *
 FROM categorias_nuevas;

  INSERT INTO Categories
 VALUES ('Bebidas', 'Bebidas corrientes', NULL),
 ('Deportes', 'jajaj', NULL);

 DELETE FROM categorias_nuevas;

 INSERT categorias_nuevas
 SELECT
 UPPER(c.CategoryName) AS [Categories],
 UPPER(CAST (c.Description AS varchar)) AS [Descripcion]
 FROM Categories AS c
 LEFT JOIN categorias_nuevas AS cn
 ON c.CategoryID = cn.Número
 WHERE cn.Número IS NULL;

 SELECT *
 FROM categorias_nuevas;

 DELETE FROM categorias_nuevas;

 --Reinicia los identity
 DBCC CHECKIDENT ('categorias_nuevas', RESEED,0);

 --El truncate elimina los datos de la tabla al igual 
 --que el delete pero solamente funciona sino
 --tiene integridad referencial 
 -- y ademas reinicia los identity

 TRUNCATE TABLE categorias_nuevas;

 --FULL JOIN
 SELECT *
 FROM categoriesnew AS c
 FULL JOIN
 productsnew AS p
 ON c.CategoryID = p.CategoryID;


 --Cross join
  SELECT *
 FROM categoriesnew AS c
 CROSS JOIN
 productsnew AS p;
