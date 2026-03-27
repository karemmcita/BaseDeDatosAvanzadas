USE ClinicaMedicinaDB;
GO

--Especialidades
INSERT INTO Especialidades (nombreEspecialidad) VALUES
('Medicina General'),
('Pediatria'),
('Cardiologia'),
('Dermatologia');
GO

-- Pacientes
INSERT INTO Pacientes (nombrePaciente, fechaNac, sexo, telefono, email) VALUES
('Juan Martinez', '2006-01-10', 'Masculino', '5755023314', 'juanvoll1021@gmail.com'),
('Jose Guadalupe', '1985-08-22', 'Masculino', '5867895614', 'mariagu@gmail.com'),
('Karen Vargas', '2000-11-30', 'Femenino', '5569878364', 'vargas@gmail.com'),
('Elmas Capio', '1995-03-18', 'Femenino', '8965742364', 'elmas@gmail.com'),
('Santigo', '1988-11-30', 'Masculino', '7711000005', 'santi@gmail.com'),
('Katniss Everdeen', '2002-06-14', 'Femenino', '2564896354', 'candasm@gmail.com'),
('Petson', '1975-09-05', 'Masculino', '7854623657', 'pedro@gmail.com'),
('AlfreduKi', '1998-12-25', 'Femenino', '3648962156', 'alfred@gmail.com'),
('Fercho', '1993-04-02', 'Masculino', '8965732452', 'ferr@gmail.com'),
('Chinixa', '1987-07-19', 'Femenino', '565238975', 'chinic@gmail.com'),
('Menchi Guzman', '1991-10-08', 'Masculino', '5589722354', 'oliguzman@gmail.com'),
('Arcadia', '1999-02-11', 'Femenino', '8785624213', 'arca@gmail.com'),
('Chaniscito', '1983-06-27', 'Masculino', '55692417598', 'chanis@gmail.com'),
('Daniela Ramirez', '2001-01-15', 'Femenino', '56280258', 'daniela.r@gmail.com'),
('Cristiano Ronaldo', '1994-09-21', 'Masculino', '5578955697', 'cris@gmail.com'),
('Frida Calo', '1997-05-09', 'Femenino', '7711000016', 'frid@gmail.com'),
('Emiliano Zapata', '1989-12-03', 'Masculino', '8788958967', 'emiliano@gmail.com'),
('Arenita Mejillas', '1996-08-17', 'Femenino', '8897546758', 'arenita@gmail.com'),
('Peso Plumita', '1984-03-29', 'Masculino', '8758745477', 'pesopu@gmail.com'),
('Kim Possible', '2003-11-06', 'Femenino', '5587569874', 'kim@gmail.com');
GO

-- Doctores
INSERT INTO Doctores (nombre, idEspecialidad, cedula) VALUES
('Dr. House', 1, 'CED123456'),
('Dra. Meredith Grey', 2, 'CED123457'),
('Dr. Jorge Curioso', 3, 'CED123458'),
('Dra. Claudia Sheinbau', 4, 'CED123459'),
('Dr. Jony Bravo', 1, 'CED123460'),
('Dra. Cachirula', 2, 'CED123461');
GO
-- Servicios
INSERT INTO Servicios (nombre, costoBase) VALUES
('Consulta General', 500.00),
('Electrocardiograma', 1200.00),
('Analisis de Sangre', 800.00),
('Ultrasonido', 1500.00),
('Radiografia', 1000.00),
('Aplicacion de Inyeccion', 300.00),
('Curacion', 400.00);
GO
--
-- Medicamentos
INSERT INTO Medicamentos (nombre, presentacion, costo) VALUES
('Paracetamol', 'Tabletas 500mg', 80.00),
('Viagra', 'Tabletas 400mg', 90.00),
('Amoxicilina', 'Capsulas 500mg', 150.00),
('Jarabe para la tos', 'Frasco 120ml', 120.00),
('Vitamina C', 'Tabletas 1g', 70.00),
('Insulina', 'Inyeccion 10ml', 500.00),
('Marihuanol', 'Crema 30g', 200.00),
('Suero Magico', 'Bolsa 1L', 250.00);
GO
-- Citas
INSERT INTO Citas (idPaciente, idDoctor, fechaHoraCitas, estadoCita, motivo) VALUES
(1, 1, '2024-03-10 09:00', 'Atendida', 'Dolor de cabeza'),
(2, 2, '2024-04-15 10:00', 'Atendida', 'Revision pediatrica'),
(3, 3, '2024-05-20 11:00', 'Cancelada', 'Chequeo cardiaco'),
(4, 4, '2024-06-05 12:00', 'NoAsistio', 'Problema dermatologico'),
(5, 1, '2024-07-08 09:00', 'Atendida', 'Consulta general'),
(6, 2, '2024-08-12 10:00', 'Agendada', 'Fiebre'),
(7, 3, '2024-09-18 11:00', 'Atendida', 'Dolor en el pecho'),
(8, 4, '2024-10-22 12:00', 'Cancelada', 'Revision piel'),
(9, 5, '2025-01-14 09:00', 'Atendida', 'Chequeo anual'),
(10, 6, '2025-02-18 10:00', 'NoAsistio', 'Consulta pediatrica'),
(11, 1, '2025-03-22 11:00', 'Atendida', 'Dolor estomacal'),
(12, 2, '2025-04-11 12:00', 'Agendada', 'Vacunacion'),
(13, 3, '2025-05-09 09:00', 'Atendida', 'Arritmia'),
(14, 4, '2025-06-17 10:00', 'Cancelada', 'Dermatitis'),
(15, 5, '2025-07-03 11:00', 'Atendida', 'Revision general'),
(16, 6, '2025-08-29 12:00', 'NoAsistio', 'Control infantil'),
(17, 1, '2025-09-05 09:00', 'Atendida', 'Gripe'),
(18, 2, '2025-10-10 10:00', 'Atendida', 'Consulta pediatrica'),
(19, 3, '2025-11-15 11:00', 'Agendada', 'Chequeo cardiaco'),
(20, 4, '2025-12-01 12:00', 'Atendida', 'Alergia'),
(1, 5, '2025-12-12 09:00', 'Atendida', 'Dolor espalda'),
(2, 6, '2025-12-20 10:00', 'Cancelada', 'Revision general'),
(3, 1, '2026-01-08 11:00', 'Atendida', 'Presion alta'),
(4, 2, '2026-02-14 12:00', 'NoAsistio', 'Fiebre'),
(5, 3, '2026-03-02 09:00', 'Atendida', 'Dolor pecho'),
(6, 4, '2026-04-19 10:00', 'Agendada', 'Consulta piel'),
(7, 5, '2026-05-07 11:00', 'Atendida', 'Chequeo anual'),
(8, 6, '2026-06-01 12:00', 'Atendida', 'Vacunacion'),
(9, 1, '2026-06-10 09:00', 'Cancelada', 'Dolor cabeza'),
(10, 2, '2026-06-15 10:00', 'Atendida', 'Control infantil'),
(11, 3, '2026-07-01 11:00', 'Atendida', 'Arritmia'),
(12, 4, '2026-07-12 12:00', 'NoAsistio', 'Dermatitis'),
(13, 5, '2026-08-03 09:00', 'Atendida', 'Revision general'),
(14, 6, '2026-08-14 10:00', 'Atendida', 'Chequeo'),
(15, 1, '2026-09-09 11:00', 'Agendada', 'Dolor muscular'),
(16, 2, '2026-10-20 12:00', 'Atendida', 'Fiebre'),
(17, 3, '2026-11-05 09:00', 'Cancelada', 'Dolor pecho'),
(18, 4, '2026-12-01 10:00', 'Atendida', 'Alergia');
GO
-- Consultas
INSERT INTO Consultas (idCita, diagnostico, notas, pesoKg, presion, temperatura) VALUES
(1, 'Migrana', 'Dolor leve', 70.50, '120/80', 36.5),
(2, 'Revision infantil', 'Sin complicaciones', 25.00, '110/70', 36.7),
(5, 'Chequeo general', 'Paciente estable', 80.20, '118/79', 36.6),
(7, 'Dolor toracico', 'Requiere estudios', 85.10, '130/85', 37.0),
(9, 'Chequeo anual', 'Todo normal', 78.00, '119/80', 36.4),
(11, 'Gastritis', 'Recomendacion dieta', 75.00, '122/82', 36.8),
(13, 'Arritmia leve', 'Control mensual', 82.30, '135/88', 36.9),
(15, 'Revision general', 'Sin observaciones', 69.00, '118/76', 36.5),
(17, 'Gripe comun', 'Reposo 3 dias', 73.40, '117/75', 37.2),
(18, 'Consulta pediatrica', 'Paciente estable', 30.00, '105/65', 36.6),
(20, 'Alergia', 'Tratamiento antihistaminico', 60.00, '115/70', 36.7),
(21, 'Dolor espalda', 'Recomendacion ejercicios', 82.00, '121/81', 36.6),
(23, 'Presion alta', 'Monitoreo constante', 88.00, '140/90', 37.1),
(25, 'Dolor pecho', 'Estudio cardiaco', 90.00, '138/85', 37.0),
(27, 'Chequeo anual', 'Sin problemas', 76.00, '119/79', 36.5),
(28, 'Vacunacion', 'Aplicada correctamente', 29.00, '108/68', 36.6),
(30, 'Control infantil', 'Desarrollo normal', 28.50, '107/66', 36.6),
(31, 'Arritmia control', 'Seguimiento', 84.00, '132/84', 36.8),
(33, 'Revision general', 'Paciente estable', 74.00, '118/78', 36.5),
(34, 'Chequeo general', 'Sin complicaciones', 79.00, '120/80', 36.6);

GO


-- Recetas
INSERT INTO Recetas (idConsulta, fecha) VALUES
(1,  '2024-03-10'),
(2,  '2024-04-15'),
(3,  '2024-07-08'),
(4,  '2024-09-18'),
(5,  '2025-01-14'),
(6, '2025-03-22'),
(7, '2025-05-09'),
(8, '2025-07-03'),
(9, '2025-09-05'),
(10, '2025-10-10'),
(11, '2025-12-01'),
(12, '2025-12-12'),
(13, '2026-01-08'),
(14, '2026-03-02'),
(15, '2026-05-07'),
(16, '2026-06-01'),
(17, '2026-06-15'),
(18, '2026-07-01'),
(19, '2026-08-03'),
(20, '2026-08-14');
GO

-- DetalleReceta
INSERT INTO DetalleReceta (idReceta, idMedicamento, dosis, frecuencia, dias) VALUES
(1, 1, '1 tableta', 'Cada 8 horas', 5),
(1, 5, '1 tableta', 'Cada 24 horas', 7),
(2, 5, '1 tableta', 'Cada 24 horas', 5),
(3, 3, '1 capsula', 'Cada 8 horas', 7),
(4, 7, 'Aplicar', 'Cada 12 horas', 5),
(5, 1, '1 tableta', 'Cada 8 horas', 3),
(6, 8, '500 ml', 'Una vez', 1),
(7, 6, '10 unidades', 'Diario', 30),
(8, 2, '1 tableta', 'Cada 8 horas', 5);
GO

-- DetalleServiciosConsulta
INSERT INTO DetalleServiciosConsulta (idConsulta, idServicio, cantidad, costoUnit) VALUES
(1, 1, 1, 500.00),
(1, 3, 1, 800.00),
(2, 1, 1, 500.00),
(2, 6, 1, 300.00),
(3, 1, 1, 500.00),
(3, 2, 1, 1200.00),
(4, 1, 1, 500.00),
(4, 5, 1, 1000.00),
(5, 1, 1, 500.00),
(5, 4, 1, 1500.00),
(6, 1, 1, 500.00),
(6, 3, 1, 800.00),
(7, 1, 1, 500.00),
(7, 2, 1, 1200.00),
(8, 1, 1, 500.00),
(8, 6, 1, 300.00),
(9, 1, 1, 500.00),
(9, 7, 1, 400.00),
(10, 1, 1, 500.00),
(10, 3, 1, 800.00),
(11, 1, 1, 500.00),
(11, 4, 1, 1500.00),
(12, 1, 1, 500.00),
(12, 5, 1, 1000.00),
(13, 1, 1, 500.00),
(13, 2, 1, 1200.00),
(14, 1, 1, 500.00),
(14, 6, 1, 300.00),
(15, 1, 1, 500.00),
(15, 3, 1, 800.00),
(16, 1, 1, 500.00),
(16, 4, 1, 1500.00),
(17, 1, 1, 500.00),
(17, 2, 1, 1200.00),
(18, 1, 1, 500.00),
(18, 5, 1, 1000.00),
(19, 1, 1, 500.00),
(19, 6, 1, 300.00),
(20, 1, 1, 500.00),
(20, 3, 1, 800.00);
GO
-- Facturas
INSERT INTO Facturas (idPaciente, fecha, estatus) VALUES
(1,  '2024-03-10', 'Emitida'),
(2,  '2024-04-15', 'Pagada'),
(3,  '2024-07-08', 'Emitida'),
(4,  '2024-09-18', 'Pagada'),
(5,  '2025-01-14', 'Emitida'),
(6,  '2025-03-22', 'Pagada'),
(7,  '2025-05-09', 'Emitida'),
(8,  '2025-07-03', 'Emitida'),
(9,  '2025-09-05', 'Pagada'),
(10, '2025-10-10', 'Emitida'),
(11, '2026-01-08', 'Emitida'),
(12, '2026-03-02', 'Pagada'),
(13, '2026-05-07', 'Emitida'),
(14, '2026-06-01', 'Emitida'),
(15, '2026-06-15', 'Pagada'),
(16, '2026-07-01', 'Emitida'),
(17, '2026-08-03', 'Emitida'),
(18, '2026-08-14', 'Pagada'),
(19, '2026-09-09', 'Emitida'),
(20, '2026-10-20', 'Emitida');
GO

-- DetalleFactura
INSERT INTO DetalleFactura (idFactura, concepto, cantidad, precio) VALUES
(1, 'Consulta General', 1, 500.00),
(1, 'Analisis de Sangre', 1, 800.00),
(2, 'Consulta General', 1, 500.00),
(2, 'Electrocardiograma', 1, 1200.00),
(3, 'Consulta General', 1, 500.00),
(4, 'Consulta General', 1, 500.00),
(5, 'Consulta General', 1, 500.00),
(6, 'Consulta General', 1, 500.00),
(7, 'Consulta General', 1, 500.00),
(8, 'Consulta General', 1, 500.00),
(9, 'Consulta General', 1, 500.00),
(10, 'Consulta General', 1, 500.00),
(11, 'Consulta General', 1, 500.00),
(12, 'Consulta General', 1, 500.00),
(13, 'Consulta General', 1, 500.00),
(14, 'Consulta General', 1, 500.00),
(15, 'Consulta General', 1, 500.00),
(16, 'Consulta General', 1, 500.00),
(17, 'Consulta General', 1, 500.00),
(18, 'Consulta General', 1, 500.00),
(19, 'Consulta General', 1, 500.00),
(20, 'Consulta General', 1, 500.00);
GO
-- Pagos 
INSERT INTO Pagos (idFactura, fechaPago, metodo, monto) VALUES
(1,  '2024-03-12', 'Efectivo', 300.00),
(1,  '2024-04-01', 'Tarjeta', 1000.00),
(2,  '2024-04-20', 'Tarjeta', 1700.00),
(3,  '2024-08-01', 'Efectivo', 200.00),
(4,  '2024-09-18', 'Efectivo', 500.00),
(5,  '2025-01-20', 'Transferencia', 200.00),
(6,  '2025-03-25', 'Efectivo', 500.00),
(7,  '2025-06-01', 'Tarjeta', 250.00),
(8,  '2025-07-10', 'Efectivo', 300.00),
(9,  '2025-09-10', 'Transferencia', 500.00),
(10, '2025-11-01', 'Efectivo', 200.00),
(12, '2026-03-05', 'Tarjeta', 500.00),
(15, '2026-06-20', 'Transferencia', 500.00),
(18, '2026-08-20', 'Efectivo', 500.00);
GO

SELECT * FROM Recetas;