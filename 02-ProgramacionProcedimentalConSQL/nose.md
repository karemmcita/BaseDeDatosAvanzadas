## Guía Completa de Transact-SQL (SQL Server)
**Introducción**
Transact-SQL (T-SQL) es el lenguaje que utiliza SQL Server para trabajar con bases de datos. Permite crear tablas, consultar información, hacer cálculos, tomar decisiones, repetir procesos, manejar errores y crear procedimientos automáticos.

1. Declaración de Variables

En SQL Server las variables se declaran con la palabra DECLARE.

```sql
Sintaxis
DECLARE @nombreVariable TIPO_DE_DATO;
Ejemplo
DECLARE @edad INT;
SET @edad = 20;

PRINT @edad;

También se puede asignar valor al momento de declararla:

DECLARE @nombre VARCHAR(50) = 'Karen';
```
**Importante:**

Las variables siempre comienzan con @.

Solo funcionan dentro del bloque donde se declaran.

2. Tipos de Datos en SQL Server

Los tipos de datos indican qué tipo de información se puede almacenar.

2.1 Tipos Numéricos

INT → Números enteros
BIGINT → Enteros grandes
DECIMAL(p,s) → Números con decimales exactos
FLOAT → Decimales aproximados

Ejemplo:
```sql
DECLARE @precio DECIMAL(10,2);
2.2 Tipos de Texto

CHAR(n) → Texto de tamaño fijo

VARCHAR(n) → Texto de tamaño variable

VARCHAR(MAX) → Texto largo

Ejemplo:

DECLARE @mensaje VARCHAR(100);
2.3 Tipos de Fecha

DATE → Solo fecha

TIME → Solo hora

DATETIME → Fecha y hora

DATETIME2 → Más precisión

Ejemplo:

DECLARE @fecha DATE = GETDATE();
2.4 Tipo Booleano

SQL Server no tiene BOOLEAN como tal, pero usa:

BIT → 0 (falso) y 1 (verdadero)
```

3. Operadores
3.1 Operadores Aritméticos

→ Suma
→ Resta
→ Multiplicación
/ → División
% → Residuo

Ejemplo:
```sql
SELECT 10 + 5;
```

3.2 Operadores Relacionales

= → Igual
<> → Diferente
→ Mayor
< → Menor
= → Mayor o igual
<= → Menor o igual

Ejemplo:
```sql
SELECT * FROM clientes
WHERE edad > 18;
```

3.3 Operadores Lógicos

AND → Ambas condiciones deben cumplirse
OR → Al menos una condición debe cumplirse
NOT → Niega una condición

Ejemplo:
```sql
SELECT * FROM clientes
WHERE edad > 18 AND ciudad = 'Querétaro';
```

4. Estructuras de Control
Permiten tomar decisiones o repetir procesos.

4.1 IF...ELSE
```sql
DECLARE @edad INT = 20;

IF @edad >= 18
    PRINT 'Mayor de edad';
ELSE
    PRINT 'Menor de edad';

```
4.2 WHILE (Ciclo)
```sql
DECLARE @contador INT = 1;

WHILE @contador <= 5
BEGIN
    PRINT @contador;
    SET @contador = @contador + 1;
END
```
5. Manejo de Excepciones (Errores)
En SQL Server se usa TRY...CATCH.
```sql
BEGIN TRY
    SELECT 10 / 0;
END TRY
BEGIN CATCH
    PRINT 'Ocurrió un error';
END CATCH;

Para ver el mensaje del error:

SELECT ERROR_MESSAGE() AS MensajeError;
```

6. Transacciones
Una transacción permite agrupar varias operaciones como un solo bloque.
Si algo falla, todo se cancela.

**Comandos**

BEGIN TRAN → Inicia la transacción
COMMIT → Guarda los cambios
ROLLBACK → Cancela los cambios

Ejemplo
```sql
BEGIN TRAN;

UPDATE cuentas
SET saldo = saldo - 100
WHERE id = 1;

UPDATE cuentas
SET saldo = saldo + 100
WHERE id = 2;

COMMIT;

Si ocurre un error:

ROLLBACK;
```

7. Funciones Creadas por el Usuario

Son funciones personalizadas.

**Función Escalar**
Devuelve un solo valor.
```sql
CREATE FUNCTION fn_Sumar
(
    @a INT,
    @b INT
)
RETURNS INT
AS
BEGIN
    RETURN @a + @b;
END;

Uso:

SELECT dbo.fn_Sumar(5,3);
```

8. Stored Procedures
Son procedimientos almacenados que ejecutan varias instrucciones.

```sql
CREATE PROCEDURE sp_Saludar
AS
BEGIN
    PRINT 'Hola mundo';
END;

Ejecutar:

EXEC sp_Saludar;

Con parámetros:

CREATE PROCEDURE sp_Sumar
    @a INT,
    @b INT
AS
BEGIN
    SELECT @a + @b;
END;
```
9. Triggers
Son procesos automáticos que se ejecutan cuando ocurre un INSERT, UPDATE o DELETE.

Ejemplo:
```sql
CREATE TRIGGER trg_InsertCliente
ON clientes
AFTER INSERT
AS
BEGIN
    PRINT 'Se insertó un cliente';
END;
```
10. Funciones de Cadena

UPPER() → Convierte a mayúsculas
LOWER() → Convierte a minúsculas
LEN() → Cuenta caracteres
SUBSTRING() → Extrae parte del texto
REPLACE() → Reemplaza texto

Ejemplo:
```sql
SELECT UPPER('hola');
```

11. Funciones de Fecha

GETDATE() → Fecha actual
YEAR() → Año
MONTH() → Mes
DAY() → Día
DATEDIFF() → Diferencia entre fechas

Ejemplo:
```sql
SELECT YEAR(GETDATE());
```

12. Funciones de Valores Nulos
ISNULL()

Reemplaza valores NULL.
```sql
SELECT ISNULL(nombre, 'Sin nombre')
FROM clientes;
COALESCE()

Devuelve el primer valor que no sea NULL.

SELECT COALESCE(NULL, NULL, 'Hola');
```

13. FORMAT

Permite dar formato a fechas y números.

Ejemplo con fecha:
```sql
SELECT FORMAT(GETDATE(), 'dd/MM/yyyy');

Ejemplo con número:

SELECT FORMAT(1500, 'C', 'es-MX');
```

14. CASE
Permite tomar decisiones dentro de una consulta.

```sql
SELECT nombre,
CASE
    WHEN edad >= 18 THEN 'Mayor de edad'
    ELSE 'Menor de edad'
END AS Estado
FROM clientes;

Forma simple:

CASE ciudad
    WHEN 'Querétaro' THEN 'QRO'
    ELSE 'Otro'
END
```

Conclusión

Transact-SQL permite no solo consultar información, sino también crear lógica dentro de la base de datos. Con él se pueden declarar variables, usar operadores, controlar procesos con condiciones y ciclos, manejar errores, trabajar con transacciones y crear funciones automáticas como procedimientos y triggers.

Es una herramienta muy completa que facilita el control y administración de la información dentro de SQL Server.