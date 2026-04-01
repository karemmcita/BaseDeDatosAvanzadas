
CREATE DATABASE STORED1;
GO
USE STORED1;
GO
SELECT ProductID AS idProducto, ProductName AS nombre, UnitPrice AS precio, UnitsInStock AS existencia
INTO producto
FROM NORTHWND.[dbo].[Products];

GO

ALTER TABLE producto
ADD PRIMARY KEY (idProducto);

GO

SELECT CustomerID AS idCliente, ContactName AS nombre, Country AS pais, city AS ciudad
INTO cliente
FROM NORTHWND.[dbo].[Customers]
GO

ALTER TABLE cliente
ADD PRIMARY KEY (idCliente);

GO

CREATE TABLE venta (

    idVenta int PRIMARY KEY IDENTITY(1,1) NOT NULL,
    fecha DATE NOT NULL,
    cliente NCHAR(5) NOT NULL,
    CONSTRAINT fk_venta_cliente
    FOREIGN KEY (cliente)
    REFERENCES cliente (idCliente)
);


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

GO
CREATE OR ALTER PROC usp_venta_registro
    @nombreCliente NVARCHAR(30),
    @nombreProducto NVARCHAR(40),
    @cantidadProductos INT
AS
BEGIN

    BEGIN TRY

    DECLARE @idCliente NVARCHAR(5)
    SET @idCliente = (SELECT idCliente FROM cliente WHERE nombre = @nombreCliente) 

    IF NOT EXISTS(SELECT 1 FROM cliente WHERE idCliente = @idCliente)
       BEGIN
        THROW 50001, 'Cliente no encontrado', 1;
        
       END 
    
    IF NOT EXISTS(SELECT 1 FROM producto WHERE nombre = @nombreProducto)
       BEGIN 
        THROW 50001,'Producto no encontrado',1;
       END 
       

    IF (@cantidadProductos > (SELECT existencia FROM producto WHERE nombre = @nombreProducto))
       BEGIN 
        THROW 50001,'No hay suficiente stock',1;
       END 

    BEGIN TRANSACTION;

    DECLARE @precio money
    SET @precio = (SELECT precio FROM producto WHERE nombre = @nombreProducto)

    DECLARE @fecha DATE
    SET @fecha = GETDATE()

    INSERT INTO venta
    VALUES (@fecha, @idCliente)

    DECLARE @idVenta int
    SET @idVenta = SCOPE_IDENTITY()

    DECLARE @idProducto int
    SET @idProducto = (SELECT idProducto FROM producto WHERE nombre = @nombreProducto)

    INSERT INTO detalleVenta (idVenta, idProducto, precioVenta, cantidad)
    VALUES (@idVenta, @idProducto, @precio, @cantidadProductos)

    UPDATE producto
    SET existencia = existencia-@cantidadProductos
    WHERE idProducto = @idProducto;

    COMMIT
    PRINT('Venta registrada correctamente');
    END TRY

    BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK;
        PRINT 'Error: ' + ERROR_MESSAGE();
    END CATCH

END; 
GO

EXEC usp_venta_registro 'Pedro Afonso', 'Tofu', 10;

SELECT * FROM producto;


GO
CREATE OR ALTER TRIGGER trg_validar_cambioPrecioVenta
ON [dbo].[detalleVenta]
AFTER UPDATE 
AS
BEGIN
    IF EXISTS (SELECT 1 
    FROM inserted AS i
    INNER JOIN deleted AS d
    ON i.idVenta = d.idVenta
    WHERE i.precioVenta <> d.precioVenta)
    BEGIN
        PRINT 'El precio de venta no se puede actualizar'
        ROLLBACK TRANSACTION;
    END;

END;
GO

UPDATE detalleVenta
SET precioVenta = 100
WHERE idVenta = 2 AND idProducto = 2;

GO

CREATE OR ALTER TRIGGER trg_validar_cambioCantidad
ON [dbo].[detalleVenta]
AFTER UPDATE 
AS
BEGIN
    IF EXISTS (SELECT 1 
    FROM inserted AS i
    INNER JOIN deleted AS d
    ON i.idVenta = d.idVenta
    WHERE i.cantidad<> d.cantidad)
    BEGIN
        PRINT 'El precio de venta no se puede actualizar'
        ROLLBACK TRANSACTION;
    END;

END;

UPDATE detalleVenta
SET cantidad = 100
WHERE idVenta = 2 AND idProducto = 2;



