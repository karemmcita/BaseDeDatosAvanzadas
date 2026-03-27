USE NORTHWND;

/*========================= Variables ===========================*/
DECLARE @Edad INT
SET @Edad = 42

SELECT @Edad AS Edad
--Print arroja un mensaje en consola
PRINT CONCAT ('La edad es: ', '', @Edad)

/*========================= Ejercicios con variables ===========================*/

/* 1. Declarar una variable llamada precio
	2. Asignarle el valor de 150
	3. Calcular el IVA del 16%
	4. Mostrar el total*/

DECLARE @Precio MONEY = 150 -- Se le asigna una valor inicial
DECLARE @Total MONEY 
SET @Total = @Precio * 1.16

SELECT @Total AS [Total]

/*========================= IF/ELSE ===========================*/
DECLARE @Edad2 INT
SET @Edad2 = 18

IF @Edad2 >=18
BEGIN
	PRINT 'Es mayor de edad' 
	PRINT 'Felicidades'
  END 
ELSE 
	PRINT 'Es menor'

/*========================= Ejercicio de IF/ELSE ===========================*/
/*
	1. Crear una variable calificacion
	2. Evaluar si es mayor a 70 imprimir "Aprobado", sino "Reprobado"
*/

DECLARE @Calificacion INT
SET @Calificacion = 100

IF @Calificacion >=70
BEGIN
	PRINT 'Aprobado'
  END 
ELSE 
	PRINT 'Reprobado'


/*========================= Ejercicio con WHILE ===========================*/

DECLARE @contador INT
DECLARE @contador2 INT = 1
SET @contador = 1

WHILE @contador <= 5
BEGIN 
	WHILE @contador2 <=5
	BEGIN
	PRINT CONCAT (@contador, '-' , @contador2)
	SET @contador2 = @contador2 +1
	END
	SET @contador2 = 1
	SET @contador = @contador + 1
END
GO

-- Imprime los numeros del 10 al 1

DECLARE @contador INT
SET @contador = 10

WHILE @contador >= 0
BEGIN
	PRINT @contador
	
	SET @contador = @contador - 1
END
GO
/*========================= Store Procedures ===========================*/
CREATE PROCEDURE usp_mensajeSaludar
AS
BEGIN 
	PRINT ('Hola Mundo Transact-SQL');
END
GO 

--Elimina un SP
--DROP PROC usp_mensajeSaludar;

EXEC usp_mensajeSaludar;

/*========================= Ejercicios de SP ===========================*/
--Crear un SP que imprima la fecha actual
GO

CREATE OR ALTER PROCEDURE usp_fechaActual
AS
BEGIN 
 SELECT GETDATE() AS [Fecha Actual]
END	
GO	

EXEC usp_fechaActual;
GO

CREATE OR ALTER PROCEDURE usp_fechaActual
AS
BEGIN 
 PRINT CAST (GETDATE() AS DATE)
END	
GO	

--Crear un SP  que muestre el nombre de la base de datos actual

CREATE OR ALTER PROCEDURE usp_nombreDB_mostrar
AS
BEGIN
 SELECT DB_NAME() AS [Nombre de la Base de Datos]
END
GO

EXEC usp_nombreDB_mostrar;