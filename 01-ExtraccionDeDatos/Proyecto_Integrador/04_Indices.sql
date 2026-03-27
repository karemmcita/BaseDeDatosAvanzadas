
USE ClinicaMedicinaDB;
--INDEX en Citas(fechaHora) para agenda por fecha.
CREATE NONCLUSTERED INDEX idx_ClinicaMedicinaDB_fechaHoraCitas
ON Citas (fechaHoraCitas);

SELECT *
FROM Citas;
--INDEX en Citas(idDoctor, fechaHora) para agenda por doctor.
CREATE NONCLUSTERED INDEX idx_ClinicaMedicinaDB_CitasDoctorFecha
ON Citas (idDoctor, fechaHoraCitas);

--INDEX en Pagos(idFactura) o Facturas(fecha) para saldos e ingresos por periodo.
CREATE NONCLUSTERED INDEX idx_ClinicaMedicinaDB_Pagos
ON Pagos(idFactura);

CREATE NONCLUSTERED INDEX idx_ClinicaMedicinaDB_FacturaFecha
ON Facturas(fecha);

