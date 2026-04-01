
CREATE TYPE productosType AS TABLE(

    idCliente NVARCHAR(5),
    cantidad int NOT NULL,
    idProductos INT NOT NULL

);

GO

CREATE OR ALTER PROC usp_venta_registro_multiple
    @productos productosType READONLY
AS
BEGIN
    BEGIN TRY

        IF EXISTS(SELECT 1 FROM @productos AS p 
        WHERE NOT EXISTS(SELECT 1 FROM cliente AS c WHERE c.idCliente = p.idCliente))
            
        BEGIN
            THROW 50001, 'Uno o más clientes no existen', 1;
        END
        
        IF EXISTS(SELECT 1 FROM @productos AS p 
        WHERE NOT EXISTS(SELECT 1 FROM producto AS pr WHERE pr.idProducto = p.idProductos))
        BEGIN
            THROW 50001, 'Uno o más productos no existen', 1;
        END
        
        IF EXISTS(SELECT 1 FROM @productos AS p
            INNER JOIN producto AS pr ON pr.idProducto = p.idProductos
            WHERE p.cantidad > pr.existencia
        )

        BEGIN
            THROW 50001, 'No hay suficiente stock para uno o más productos', 1;
        END
        
        BEGIN TRANSACTION;
        
        DECLARE @fecha DATE = GETDATE();
        DECLARE @idVenta INT;

        INSERT INTO venta (fecha, cliente)
        VALUES (@fecha, (SELECT TOP 1 idCliente FROM @productos));
        
        SET @idVenta = SCOPE_IDENTITY();

        INSERT INTO detalleVenta (idVenta, idProducto, precioVenta, cantidad)
        SELECT 
            @idVenta,
            p.idProductos,
            pr.precio,
            p.cantidad
        FROM @productos  AS p
        INNER JOIN producto pr ON pr.idProducto = p.idProductos;
        
        UPDATE pr
        SET existencia = pr.existencia - p.cantidad
        FROM producto pr
        INNER JOIN @productos p ON pr.idProducto = p.idProductos;
        
        COMMIT;
        
        PRINT('Venta registrada correctamente');
        
    END TRY
    
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
        
        PRINT('Error al registrar la venta');
        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROC usp_consultar_productos
AS 
BEGIN
    SELECT *
    FROM producto;
END;


GO

CREATE OR ALTER PROC usp_consultar_clientes
AS 
BEGIN
    SELECT *
    FROM cliente;
END;

