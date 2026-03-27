# Fundamentos Programables

1. ¿Qué es la parte programable de T-SQL?

Es todo lo que permite:

- Usar varaibles
- Control de flujo
- Crear procedimientos almacenados (Store Procedures)
- Manejar errores 
- Crear funciones
- Usar transacciones
- Disparadores (Triggers)

**Nota: convertir SQL en un lenguaje casi como C/ java pero dentro del engine**

2. Variable
Una variable almacena un valor temporal
```sql
/*========================= Ejercicios con variables ===========================*/

/* 1. Declarar una variable llamada precio
	2. Asignarle el valor de 150
	3. Calcular el IVA del 16%
	4. Mostrar el total*/

DECLARE @Precio MONEY = 150 -- Se le asigna una valor inicial
DECLARE @Total MONEY 
SET @Total = @Precio * 1.16

SELECT @Total AS [Total]
```

3. IF/ELSE
Permite ejecutar código segun una condicion 
```sql
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
```

4. While 
``` sql

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

```
## Procedimientos Almacenados (Store Procedures)

5. ¿Qué es un Store Procedure?

Es un block de código guardado en la base de datos que se puede ejecutar
cuando se necesite 

```sql
CREATE PROCEDURE usp_objeto_acccion
[Parameters]
AS 
BEGIN
	--Body
END;

CREATE PROC usp_objeto_acccion
[Parameters]
AS 
BEGIN
	--Body
END;

CREATE OR ALTER PROCEDURE usp_objeto_acccion
[Parameters]
AS 
BEGIN
	--Body
END;

CREATE OR ALTER PROC usp_objeto_acccion
[Parameters]
AS 
BEGIN
	--Body
END;
```

