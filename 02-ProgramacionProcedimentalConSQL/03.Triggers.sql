CREATE DATABASE db_triggers;
GO

CREATE TABLE Productos(

    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL (10,2)
);

GO


CREATE TABLE Productos2(

    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    precio DECIMAL (10,2)
);

GO

--EJERCICIO 1. EVENTO INSERT (TRIGGER)

CREATE OR ALTER TRIGGER trg_test_insert -- se crea el trigger
ON Productos -- Tabla a la que se asocia el trigger
AFTER INSERT --Evento con el que se va a disparar
AS
BEGIN
    SELECT * FROM inserted;
    SELECT * FROM Productos;
    SELECt * FROM deleted;
END;

GO

--EVALUAR

INSERT INTO Productos
VALUES(1, 'COCA-COLA', 23);


INSERT INTO Productos
VALUES(2, 'PEPSI', 20)


INSERT INTO Productos
VALUES(3, 'Power', 25)


INSERT INTO Productos
VALUES(4, 'SKY', 30),
(5, 'FUZE TEA', 16)

INSERT INTO Productos
VALUES(6, 'REDBULL', 54),
(7, 'AMPER', 22)

GO
--EVENTO DELETE 

CREATE OR ALTER TRIGGER trg_test_delete
ON Productos
AFTER DELETE
AS
BEGIN
    SELECt * FROM deleted;
    SELECT * FROM inserted;
    SELECT * FROM Productos;    
END;

DELETE Productos WHERE id=3;

GO
--EVENTO UPDATE

CREATE OR ALTER TRIGGER trg_test_update
ON Productos
AFTER UPDATE
AS
BEGIN
    SELECt * FROM deleted;
    SELECT * FROM inserted;
    SELECT * FROM Productos;  
END;

UPDATE Productos SET precio = 20 WHERE id=2;

--REALIZAR UN TRIGGER QUE PERMITA CANCELAR LA OPERACIÓN SI SE INSERTA MÁS DE
-- UN REGISTRO AL MISMO TIEMPO
GO

CREATE OR ALTER TRIGGER trg_un_solo_registro
ON Productos2
AFTER INSERT
AS
BEGIN
    --CONTAR EL NÚMERO DE REGISTROS INSERTADOS

    IF(SELECT COUNT (*) FROM inserted) > 1
    BEGIN
        RAISERROR ('SOLO SE PERMITE INSERTAR UN REGISTRO A LA VEZ', 16,1);
        ROLLBACK TRANSACTION;
    END;
END;

INSERT INTO Productos2
VALUES(1, 'SKY', 30),
(2, 'FUZE TEA', 16)

--REALIZAR UN TRIGGER QUE DETECTE UN CAMBIO EN EL PRECIO Y MANDE UN 
--MENSAJE DE QUE EL PRECIO SE CAMBIO

GO

CREATE OR ALTER TRIGGER trg_validar_cambio
ON Productos2
AFTER UPDATE 
AS
BEGIN
    IF EXISTS (SELECT 1 
    FROM inserted AS i
    INNER JOIN deleted AS d
    ON i.id = d.id
    WHERE i.precio <> d.precio)
    BEGIN
        PRINT 'El precio fue actualizado'
    END;

END;

--TRIGGER QUE EVITE CAMBIAR EL PRECIO DE DETALLE DE VENTA