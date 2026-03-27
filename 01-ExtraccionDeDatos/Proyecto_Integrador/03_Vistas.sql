USE ClinicaMedicinaDB;
--vw_CitasAgenda: cita + paciente + doctor + especialidad (operativa).
CREATE OR ALTER VIEW vw_CitasAgenda
	AS
	SELECT   p.nombrePaciente AS [Paciente],
    c.motivo AS [Motivo],
    p.sexo AS [Sexo], 
    c.estadoCita [Estatus],
    c.fechaHoraCitas AS [Fecha],    
    d.nombre AS [Nombre del doctor],
    e.nombreEspecialidad [Especialidad Del Doctor]
	FROM Citas AS c
	INNER JOIN Pacientes AS p
	ON c.idPaciente = p.idPaciente
	INNER JOIN Doctores AS d
	ON c.idDoctor = d.idDoctor
	INNER JOIN Especialidades AS e
	ON d.idEspecialidad = e.idEspecialidad;

--vw_IngresosMensuales: por mes: total facturado, numFacturas, ticketPromedio (analitica).	

	CREATE OR ALTER VIEW vw_IngresosMensuales
AS
SELECT 
    YEAR(f.fecha) AS [Año],
    MONTH(f.fecha) AS [Mes],
    SUM(df.subtotalCalculado) AS [Total Facturado],
    COUNT(DISTINCT f.idFactura) AS [Número de Facturas],
    AVG(df.subtotalCalculado) AS TicketPromedio
FROM Facturas AS f
INNER JOIN DetalleFactura AS df 
    ON f.idFactura = df.idFactura
GROUP BY 
    YEAR(f.fecha),
    MONTH(f.fecha);

--vw_PacientesFrecuentes: paciente, numCitas, gastoTotal, ultimaCita.

CREATE OR ALTER VIEW vw_PacientesFrecuentes
AS
SELECT 
    p.idPaciente,
    p.nombrePaciente,
    COUNT(DISTINCT c.idCita) AS NumCitas,
    SUM(df.subtotalCalculado) AS GastoTotal,
    MAX(c.fechaHoraCitas) AS UltimaCita
FROM Pacientes p
LEFT JOIN Citas AS c
    ON p.idPaciente = c.idPaciente
LEFT JOIN Facturas AS f
    ON p.idPaciente = f.idPaciente
LEFT JOIN DetalleFactura AS df
    ON f.idFactura = df.idFactura
    
GROUP BY 
    p.idPaciente,
    p.nombrePaciente;
