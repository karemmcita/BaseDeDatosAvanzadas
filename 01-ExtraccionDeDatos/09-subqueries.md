# Subqueries (subconsultas)
Una subconsulta es una consulta anidada dentro de otra consulta que 
permite resolver problemas en varios niveles de información

Dependiendo de dónde se coloque y que retorne, cambia su comportamiento.

**Clasficación**
1. Subconsultas escalares 
2. Subconsultas con IN, ANY, ALL
3. Subconsultas correlacionadas
4. Subconsultas en SELECT 
5. Subconsultas FROM (Tablas Derivadas)

## Escalares 
Devuelven un único valor, es por ello que se pueden utilizar con operadores =, >, <

Ejemplo:

```sql
--Subconsulta 

SELECT 
MAX (total)
FROM pedidos;

--Consulta principal
SELECT *
FROM pedidos
WHERE total = (SELECT MAX (total) FROM pedidos);
```

Orden de ejeccución:
1. Se ejecuta la subconsulta
2. Devuelve 1500
3. La consulta principal ocupa ese valor

## Subconsultas de una columna (IN, ANY, ALL)
**Intrucción IN**
```sql
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

```

Devuelve varios valores pero en una sola columna 
1. Clientes que han hecho pedidos 

```sql
SELECT *
FROM clientes
WHERE id_cliente IN (SELECT id_cliente
FROM pedidos);
```

**Instruccion Any**
>Compara una valor de una lista **Lista**. La condición se cumple si almenos uno se cumple

```sql

valor > ANY (subconsulta)

```
Es como decir :
"Mayor que al menos uno de los valores"