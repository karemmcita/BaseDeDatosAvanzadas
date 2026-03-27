
CREATE DATABASE bdstored;
GO
USE bdstored;
GO

--Stored Procedures
CREATE OR ALTER PROC spu_PersonaSaludar
    @nombre VARCHAR(50) -- Parametro de entrada
-- AS
BEGIN
    PRINT 'Hola ' + @nombre;
END;

EXEC spu_PersonaSaludar 'Mario';

GO

SELECT CustomerID, CompanyName, City, Country
INTO customers
FROM NORTHWND.[dbo].[Customers]

SELECT * FROM customers;

GO

CREATE OR ALTER PROC spu_cliente_consultarporid
    @Id CHAR(10)
AS
BEGIN

DECLARE @valor INT 
SET @valor = (SELECT 1
FROM customers
WHERE CustomerID = @Id)

IF @valor = 1
BEGIN
    PRINT 'El cliente existe';
     SELECT CustomerID AS [Número],
    CompanyName AS [Cliente],
    City AS [Ciudad], 
    Country AS [País]
    FROM customers
    WHERE CustomerID = RTRIM(@Id);
END
ELSE 
BEGIN
    PRINT 'El cliente no existe'; 
END 
END;

GO
EXEC spu_cliente_consultarporid 'ANTON';

GO

CREATE OR ALTER PROC spu_cliente_consultarporId2
    @id CHAR(10)
AS
BEGIN 
    IF LEN(@id) > 5
    BEGIN

    RAISERROR('El ID DEL CLIENTE DEBE SER MENOR O IGUAL A 5', 16,1);
    RETURN;
END;
    IF EXISTS(SELECT 1 FROM customers WHERE CustomerID = @id)
    BEGIN
        SELECT CustomerID AS [Número],
               CompanyName AS [Cliente],
               City AS [Ciudad], 
               Country AS [País]
        FROM customers
        WHERE CustomerID = @id;
    END
    ELSE
    BEGIN
        PRINT 'El cliente no existe';
    END
END

GO

EXEC spu_cliente_consultarporId2 'ANTOhN';
GO

/*SELECT * FROM customers
WHERE EXISTS (SELECT 1
FROM customers
WHERE CustomerID = 'ANTON');

GO

DECLARE @valor INT 
SET @valor = (SELECT 1
FROM customers
WHERE CustomerID = 'ANTON')

IF @valor = 1
BEGIN
    PRINT 'El cliente existe';
END
ELSE 
BEGIN
    PRINT 'El cliente no existe'; 
END */

/*===========================PARAMETROS OUTPUT==============================*/

CREATE OR ALTER PROC spu_operacion_sumar
@a int,
@b AS INT, 
@resultado INT OUTPUT
AS 
BEGIN 
    SET @resultado = @a + @b;
END;

DECLARE @res INT;
EXEC spu_operacion_sumar 4,5, @res OUTPUT;
SELECT @res AS Suma
GO

--Craer un sp con parametros de entrada y saluda para calcular el area de un triangulo
CREATE OR ALTER PROC spu_operacion_area_triangulo
@base FLOAT,
@altura FLOAT, 
@resultado FLOAT OUTPUT
AS 
BEGIN 
    SET @resultado = (@base * @altura) / 2;
END;

DECLARE @res FLOAT;
EXEC spu_operacion_area_triangulo 5,10, @res OUTPUT;
SELECT @res AS área
GO

/*================================LÓGICA DENTRO DEL SP====================================*/

--Crear un sp que evalue la edad de una persona

CREATE OR ALTER PROC usp_Persona_EvaluarEdad
    @edad INT
AS
BEGIN
    IF @edad>=18 AND @edad <=45
    BEGIN
        PRINT ('Eres un adulto sin pensión');
    END 
    ELSE
    BEGIN
        PRINT ('Eres menor de edad');
    END;
END;
GO

EXEC usp_Persona_EvaluarEdad 22;
EXEC usp_Persona_EvaluarEdad @edad=50;
GO

CREATE OR ALTER PROC usp_Valores_Imprimir
    @n AS INT 

AS
BEGIN

    IF @n<=0
    BEGIN
        PRINT ('ERROR: VALOR DE N NO VALIDO');
        RETURN;
    END
    DECLARE @i AS INT 
    SET @i=1;

    WHILE (@i<=@n)
    BEGIN
        PRINT CONCAT ('Este es el número: ', @i)
        SET @i=@i+1;
    END
END;    

EXEC usp_Valores_Imprimir @n=-2 ;
GO

CREATE OR ALTER PROC usp_Valores_Imprimir
    @n AS INT 

AS
BEGIN

 DECLARE @i AS INT 
    SET @i=1;
 DECLARE @j INT = 1;   

    WHILE (@i<=@n)
    BEGIN
        WHILE(@j<=10) 
        BEGIN 
        PRINT (CONCAT (@i, '*', @j, '=', @i*@j));
        SET @j=@j+1;
        END 
        PRINT CHAR(13) + CHAR(10);
        SET @i=@i+1;
        SET @j=1;
    END
  END  
GO  

EXEC usp_Valores_Imprimir @n=5 ;

GO

/*========================== CASE =========================*/

--Sirve para evaluar condiciones como switch o if mutiple

CREATE OR ALTER PROC usp_Calificacion_Evaluar
    @calificacion FLOAT
AS
BEGIN
    SELECT
    CASE
        WHEN @calificacion >= 90 THEN 'EXCELENTE'
        WHEN @calificacion >= 70 THEN 'APROBADO'
        WHEN @calificacion >= 60 THEN 'REGULAR'
        ELSE 'NO ACREDITADO'
     END AS Resultado   
END;
GO

EXEC usp_Calificacion_Evaluar @calificacion=89;

USE NORTHWND;

GO

SELECT ProductName, UnitPrice,
CASE
    WHEN UnitPrice >=200 THEN 'CARO'
    WHEN UnitPrice >=100 THEN 'MEDIO'
    ELSE 'BARATO'
END AS Precio
FROM products;

GO

CREATE OR ALTER PROC usp_comision_ventas
    @idCliente NCHAR(10)
AS
BEGIN 
    IF LEN(@idCliente) > 5
    BEGIN
        PRINT('El tamaño del id del cliente debe ser de 5');
        RETURN;
    END

    IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID = @idCliente)
    BEGIN 
        PRINT('El cliente no existe');
        RETURN;
    END

    DECLARE @comision DECIMAL(10,2);
    DECLARE @total MONEY
    SET @total= (SELECT (UnitPrice*Quantity) FROM [Order Details] AS od
    INNER JOIN Orders AS o
    ON  od.OrderID = o.OrderID
    WHERE o.CustomerID = @idCliente);
    
    SET @comision =
    CASE 
     WHEN @total >= 19000 THEN 5000
     WHEN @total >= 15000 THEN 2000
     WHEN @total >= 10000 THEN 1000
     ELSE 500
     END;

     PRINT CONCAT('VENTA TOTAL: ', @total, CHAR(13) + CHAR(10), 'Comisión: ', @comision,
     CHAR(13) + CHAR(10),'Ventas más comisión: ' , (@total + @comision));
END;

GO

EXEC usp_comision_ventas 'CACTU';

SELECT *
FROM Customers;
GO

/*================================== CRUD ===============================*/

USE bdstored;

CREATE TABLE productos(
    id INT IDENTITY,
    nombre VARCHAR(50),
    precio DECIMAL(10,2),

);

GO

/*SP PARA INSERT*/

CREATE OR ALTER PROC usp_insertar_cliente
    @nombre VARCHAR(50),
    @precio DECIMAL(10,2)

 AS
 BEGIN

    INSERT INTO productos(nombre, precio)
    VALUES (@nombre, @precio);

 END;

 GO   

 EXEC usp_insertar_cliente 'Coca-cola', 15.50;

 GO

--SP PARA UPDATE

CREATE OR ALTER PROC usp_Actualizar_precio
    @id INT,
    @precio DECIMAL (10,2)

    AS
    BEGIN

    IF EXISTS (SELECT 1 FROM productos WHERE id = @id)
    BEGIN
    UPDATE productos
    SET precio = @precio
    WHERE id = @id
    RETURN 
    END 

        PRINT 'El ID DEL PRODUCTO NO EXISTE, NO SE REALIZO LA MODIFICACIÓN';
    END;

GO

EXEC usp_Actualizar_precio 12, 78.6;

EXEC usp_Actualizar_precio 1, 78.6;

SELECT *
FROM productos;

--SP PARA DELETE
GO

CREATE OR ALTER PROC usp_Eliminar
    @id INT 
AS
BEGIN
    DELETE productos
    WHERE id = @id;
END;

GO 
EXEC usp_Eliminar 1;
GO

/*================================== MANEJO DE ERRORES ===============================*/

--Sin manejo de errores

SELECT 10/0;

--Esto genera un error o una excepción y detiene la ejecución

BEGIN TRY

    SELECT 10/0;

END TRY

BEGIN CATCH 

    PRINT 'Ocurrio el error'

END CATCH

GO

BEGIN TRY

    SELECT 10/0;

END TRY

BEGIN CATCH 

    PRINT 'Mensaje: ' + ERROR_MESSAGE();
    PRINT 'Número: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Línea: ' + CAST(ERROR_LINE() AS VARCHAR);

END CATCH

GO

--USO CON INSERT 

CREATE TABLE productos2(
     id int primary key,
     nombre varchar(50),
     precio decimal)

GO
DROP TABLE productos2;

GO

INSERT INTO productos2
VALUES(1, 'Pepsi', 359.0)

GO

--EEjemplo de uso de transacción
USE bdstored;

BEGIN TRANSACTION;

INSERT INTO productos2
VALUES(2, 'Pitufina', 56.8);

SELECT * FROM productos2;

ROLLBACK; --Cancela la transaccion, permite que la bd no quede inconsistente
COMMIT; --Confirma la transaacion, por que todo fue atomico o se cumplio

/*===================================== Uso de transacciones =====================================*/

--EJERCICIO PARA VERIFICAR EN DONDE EL TRY CATCH SE VUELVE PODEROSO


BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO productos2
    VALUES (3, 'Charro Negro', 123.0);

     INSERT INTO productos2
    VALUES (3, 'Pantera Rosa', 345.6);

        COMMIT;

END TRY

BEGIN CATCH

    ROLLBACK;
    PRINT 'Se hizo un ROLLBACK con error'
    PRINT 'ERROR: ' + ERROR_MESSAGE()

END CATCH;

--VALIDAR SI UNA TRANSACCIÓN ESTA ACTIVA 
BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO productos2
    VALUES (3, 'Charro Negro', 123.0);

     INSERT INTO productos2
    VALUES (3, 'Pantera Rosa', 345.6);

        COMMIT;

END TRY

BEGIN CATCH

IF @@TRANCOUNT > 0 --INVESTIGAR
ROLLBACK

    PRINT 'Se hizo un ROLLBACK con error'
    PRINT 'ERROR: ' + ERROR_MESSAGE()

END CATCH;

/*======================= EJERCICIO =======================*/

CREATE DATABASE EJERCICIO1;
USE EJERCICIO1;
GO
SELECT ProductID AS idProducto, ProductName AS nombre, UnitPrice AS precio, UnitsInStock AS existencia
INTO producto
FROM NORTHWND.[dbo].[Products]

GO
SELECT * FROM producto;

GO
CREATE TABLE venta (

    idVenta int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    fecha DATE NOT NULL,
    cliente VARCHAR(50) NOT NULL
);

DROP TABLE venta;

GO

CREATE table detalleVenta(

    idVenta int NOT NULL,
    idProducto int NOT NULL,
    precioVenta money NOT NULL,
    cantidad int NOT NULL,
    CONSTRAINT PK_DetalleVenta
    PRIMARY KEY (idVenta, idProducto),
    CONSTRAINT fk_dv_venta
    FOREIGN KEY (idVenta)
    REFERENCES venta (idVenta),

    CONSTRAINT fk_dv_producto
    FOREIGN KEY(idProducto)
    REFERENCES producto (idProducto)

);


USE NORTHWND;

SELECT * FROM Products;