USE ClinicaMedicinaDB;

-- 1. Agenda del dia por doctor: citas con paciente
-- y especialidad (JOIN + ORDER BY).
	SELECT *
	FROM vw_CitasAgenda
	ORDER BY [Nombre del Doctor];

-- 2. Citas por estatus por mes (GROUP BY)
    SELECT 
    YEAR(fechaHoraCitas) AS [Año],
    MONTH(fechaHoraCitas) AS [Mes],
    estadoCita,
    COUNT(*) AS [Total Citas]
    FROM Citas
    GROUP BY 
    YEAR(fechaHoraCitas),
    MONTH(fechaHoraCitas),
    estadoCita
    ORDER BY 
    Año, Mes, estadoCita;

   -- 3. Doctores con mas consultas 
   --atendidas en el mes (GROUP BY + HAVING).
     SELECT d.nombre AS [Nombre del Doctor],
     YEAR(c.fechaHoraCitas) AS [Año],
     MONTH (c.fechaHoraCitas) AS [Mes],
     COUNT (*) AS [Total de citas]
     FROM Consultas AS co
     INNER JOIN Citas AS c
     ON co.idCita = c.idCita
     INNER JOIN Doctores AS d
     ON c.idDoctor = d.idDoctor
     GROUP BY d.nombre,
     YEAR(c.fechaHoraCitas) ,
     MONTH (c.fechaHoraCitas)
     HAVING COUNT(*) >= 1
ORDER BY [Total de citas] DESC;



-- 4. Pacientes con mas de N citas (HAVING).
      SELECT p.nombrePaciente, 
      COUNT (*) AS [Total de citas]
      FROM Pacientes AS p
      INNER JOIN Citas AS c
      ON p.idPaciente = c.idPaciente
      GROUP BY p.nombrePaciente
      HAVING COUNT(*) >= 1
      ORDER BY [Total de Citas] DESC;

-- 5. Ingresos por especialidad en 
--un periodo (JOIN + SUM + GROUP BY).
    SELECT 
    e.nombreEspecialidad AS [Especialidad],
    SUM(df.subtotalCalculado) AS [Total de Ingresos]
FROM Facturas f
INNER JOIN DetalleFactura AS df 
    ON f.idFactura = df.idFactura
INNER JOIN Consultas AS co
    ON f.idConsulta = co.idConsulta
INNER JOIN Citas AS c
    ON co.idCita = c.idCita
INNER JOIN Doctores AS d
    ON c.idDoctor = d.idDoctor
INNER JOIN Especialidades AS e
    ON d.idEspecialidad = e.idEspecialidad
WHERE f.fecha >= '2024-01-01'
AND f.fecha < '2026-12-31'
AND f.estatus = 'Pagada'
GROUP BY e.nombreEspecialidad
ORDER BY [Total de Ingresos] DESC;

-- 6. Servicios mas solicitados (COUNT/SUM por servicio).
        SELECT 
        s.nombre,
        COUNT(df.idDetalle) AS [Veces Solicitado]
    FROM DetalleFactura AS df
    INNER JOIN Servicios AS s 
        ON df.idDetalle = s.idServicio
    GROUP BY s.nombre
    ORDER BY [Veces Solicitado] DESC;
-- 7. Medicamentos mas recetados (JOIN recetas + detalle 
-- + medicamentos, GROUP BY).
SELECT 
    m.nombre,
    COUNT(dr.idReceta) AS [Veces Recetado]
FROM Recetas r
INNER JOIN DetalleReceta AS dr
    ON r.idReceta = dr.idReceta
INNER JOIN Medicamentos AS m
    ON dr.idMedicamento = m.idMedicamento
GROUP BY m.nombre
ORDER BY [Veces Recetado] DESC;

-- 8. Facturas con saldo pendiente: total - SUM(pagos) 
-- y mostrar solo saldo > 0 (HAVING).

SELECT 
    f.idFactura,
    p.nombrePaciente,
    SUM(df.subtotalCalculado) AS [Total Factura],
    ISNULL(SUM(pa.monto), 0) AS [Total Pagado],
    SUM(df.subtotalCalculado) - ISNULL(SUM(pa.monto),0) AS [Saldo Pendiente]
FROM Facturas f
INNER JOIN Pacientes AS p 
    ON f.idPaciente = p.idPaciente
INNER JOIN DetalleFactura AS df 
    ON f.idFactura = df.idFactura
LEFT JOIN Pagos AS pa 
    ON f.idFactura = pa.idFactura
GROUP BY f.idFactura, p.nombrePaciente
HAVING SUM(df.subtotalCalculado) - ISNULL(SUM(pa.monto),0) > 0
ORDER BY [Saldo Pendiente] DESC;

-- 9. Top 5 pacientes por gasto total (SUM).
SELECT TOP 5
    p.nombrePaciente,
    SUM(df.subtotalCalculado) AS [Gasto Total]
FROM Pacientes AS p
INNER JOIN Facturas AS f 
    ON p.idPaciente = f.idPaciente
INNER JOIN DetalleFactura AS df 
    ON f.idFactura = df.idFactura
GROUP BY p.nombrePaciente
ORDER BY [Gasto Total] DESC;

-- 10. LEFT JOIN: pacientes sin citas en los ultimos X dias.
SELECT 
    p.nombrePaciente
FROM Pacientes p
LEFT JOIN Citas c 
    ON p.idPaciente = c.idPaciente
    AND c.fechaHoraCitas >= DATEADD(DAY, -10, GETDATE())
WHERE c.idCita IS NULL;

-- 11. Consulta a vw_IngresosMensuales filtrando por anio y ordenado por mes.
SELECT *
FROM vw_IngresosMensuales
WHERE Año = 2025
ORDER BY Mes;
-- 12. Consulta con campo calculado: edad aproximada del paciente y clasificacion por rango (CASE).
SELECT 
    nombrePaciente,
    DATEDIFF(YEAR, fechaNac, GETDATE()) AS edadAproximada,
    
    CASE 
        WHEN DATEDIFF(YEAR, fechaNac, GETDATE()) < 18 THEN 'Menor de edad'
        WHEN DATEDIFF(YEAR, fechaNac, GETDATE()) BETWEEN 18 AND 40 THEN 'Adulto joven'
        WHEN DATEDIFF(YEAR, fechaNac, GETDATE()) BETWEEN 41 AND 60 THEN 'Adulto'
        ELSE 'Adulto mayor'
    END AS clasificacionEdad
FROM Pacientes;