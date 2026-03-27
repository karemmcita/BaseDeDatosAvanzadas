/*
Una vista (view) es una tabla virtual basada en una consulta 
sirve para reutilizar logica, simplicar consultas y controlar accesos
Existe dos tipos de vistas:
- Vistas almacenadas 
- Vistas Materializadas (SQL SERVER: Vistas Indexadas)

Sintaxis:
- CREATE OR ALTER VIEW vw_nombre
AS
Definicion de la  vista
*/

--Seleccionar todas la ventas por cliente 
--fecha de venta y estado

--Buenas practicas 
--Nombre de las  vistas vw_
--Evitar el select * dentro de la vista
--Si se necesita ordenar hazlo al consultar la vista


CREATE OR ALTER VIEW vw_ventas_totales
AS 
SELECT v.VentaId,
		v.ClienteId,
		v.FechaVenta,
		v.Estado,
		SUM (dv.Cantidad * dv.PrecioUnit * (1-dv.Descuento/100)) AS [Suma]
FROM Ventas AS v
INNER JOIN DetalleVenta AS dv
ON v.VentaId = dv.VentaId
GROUP BY v.VentaId,
		v.ClienteId,
		v.FechaVenta,
		v.Estado;

--trabajar con la vista

SELECT
vt.ClienteId,
vt.ClienteId,
c.Nombre
Suma,
DATEPART(MONTH, vt.FechaVenta) AS [Mes]
FROM vw_ventas_totales AS vt
INNER JOIN Clientes AS c
ON vt.ClienteId = c.ClienteId
WHERE DATEPART(MONTH, FechaVenta) = 1
AND Suma >= 3130;

--Realizar una vista que se llame vw_detalle_extendido
--que muestre la ventaid, cliente (Nombre), producto,
--categoria (Nombre), cantidad vendida, precio de la venta,
-- desceunto y bel total de cada linea (transaccion)

--En la vista seleccionen 50 lineas ordenadas por la vendaid de la forma
--asc

CREATE VIEW vw_detalle_extendido
AS
SELECT *
FROM 