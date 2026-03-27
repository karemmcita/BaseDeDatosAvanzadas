
CREATE DATABASE ClinicaMedicinaDB;
USE ClinicaMedicinaDB;

--Creacion de tablas


-- Tabla Especialidades
CREATE TABLE Especialidades (
idEspecialidad INT IDENTITY(1,1) PRIMARY KEY,
nombreEspecialidad VARCHAR(100) NOT NULL);
GO

-- Tabla Pacentes
CREATE TABLE Pacientes (
idPaciente INT IDENTITY(1,1) PRIMARY KEY,
nombrePaciente VARCHAR(150) NOT NULL,
fechaNac DATE NOT NULL,
sexo VARCHAR(15) NOT NULL 
CHECK (sexo IN ('Masculino','Femenino','Otro')),
telefono VARCHAR(20) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE
);
GO

-- Tabla Doctores
CREATE TABLE Doctores (
idDoctor INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(150) NOT NULL,
idEspecialidad INT NOT NULL,
cedula VARCHAR(50) NOT NULL UNIQUE,
CONSTRAINT FK_Doctor_Especialidad
FOREIGN KEY (idEspecialidad)
REFERENCES Especialidades(idEspecialidad)
);
GO

-- Tabla Citas
CREATE TABLE Citas (
idCita INT IDENTITY(1,1) PRIMARY KEY,
idPaciente INT NOT NULL,
idDoctor INT NOT NULL,
fechaHoraCitas DATETIME NOT NULL,
estadoCita VARCHAR(20) NOT NULL
CHECK (estadoCita IN ('Agendada','Atendida','Cancelada','NoAsistio')),
motivo VARCHAR(255) NOT NULL,
CONSTRAINT FK_Cita_Paciente
FOREIGN KEY (idPaciente)
REFERENCES Pacientes(idPaciente),
CONSTRAINT FK_Cita_Doctor
FOREIGN KEY (idDoctor)
REFERENCES Doctores(idDoctor),
CONSTRAINT UQ_Cita_Paciente_Fecha
UNIQUE (idPaciente, fechaHoraCitas)
);
GO

-- Tabla Consulta
CREATE TABLE Consultas (
idConsulta INT IDENTITY(1,1) PRIMARY KEY,
idCita INT NOT NULL UNIQUE,
diagnostico VARCHAR(500) NOT NULL,
notas VARCHAR(1000),
pesoKg DECIMAL(5,2),
presion VARCHAR(20),
temperatura DECIMAL(4,2),
CONSTRAINT FK_Consulta_Cita
FOREIGN KEY (idCita)
REFERENCES Citas(idCita)
);
GO
-- Tabla Recetas (AGREGADA)
CREATE TABLE Recetas (
idReceta INT IDENTITY(1,1) PRIMARY KEY,
idConsulta INT NOT NULL UNIQUE,
fecha DATE NOT NULL,
CONSTRAINT FK_Receta_Consulta
FOREIGN KEY (idConsulta)
REFERENCES Consultas(idConsulta)
);
GO
-- Tabla Servicios
CREATE TABLE Servicios (
    idServicio INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    costoBase DECIMAL(10,2) NOT NULL
        CHECK (costoBase > 0)
);
GO

-- Tabla DetalleServiciosConsulta
CREATE TABLE DetalleServiciosConsulta (
idConsulta INT NOT NULL,
idServicio INT NOT NULL,
cantidad INT NOT NULL CHECK (cantidad > 0),
costoUnit DECIMAL(10,2) NOT NULL CHECK (costoUnit > 0),
subtotalCalculado AS (cantidad * costoUnit) PERSISTED,
PRIMARY KEY (idConsulta, idServicio),
CONSTRAINT FK_DSC_Consulta
FOREIGN KEY (idConsulta)
REFERENCES Consultas(idConsulta),
CONSTRAINT FK_DSC_Servicio
FOREIGN KEY (idServicio)
REFERENCES Servicios(idServicio)
);
GO
-- Tabla Medicamentos
CREATE TABLE Medicamentos (
idMedicamento INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(150) NOT NULL,
presentacion VARCHAR(100) NOT NULL,
costo DECIMAL(10,2) NOT NULL
CHECK (costo > 0)
);
GO

-- Tabla DetalleReceta
CREATE TABLE DetalleReceta (
idReceta INT NOT NULL,
idMedicamento INT NOT NULL,
dosis VARCHAR(100) NOT NULL,
frecuencia VARCHAR(100) NOT NULL,
dias INT NOT NULL CHECK (dias > 0),
PRIMARY KEY (idReceta, idMedicamento),
CONSTRAINT FK_DR_Receta
FOREIGN KEY (idReceta)
REFERENCES Recetas(idReceta),
CONSTRAINT FK_DR_Medicamento
FOREIGN KEY (idMedicamento)
REFERENCES Medicamentos(idMedicamento)
);
GO

-- Tabla Facturas
CREATE TABLE Facturas (
idFactura INT IDENTITY(1,1) PRIMARY KEY,
idPaciente INT NOT NULL,
fecha DATE NOT NULL,
estatus VARCHAR(20) NOT NULL
CHECK (estatus IN ('Emitida','Pagada','Cancelada')),
CONSTRAINT FK_Factura_Paciente
FOREIGN KEY (idPaciente)
REFERENCES Pacientes(idPaciente)
);
GO

-- Tabla DetalleFactura
CREATE TABLE DetalleFactura (
idDetalle INT IDENTITY(1,1) PRIMARY KEY,
idFactura INT NOT NULL,
concepto VARCHAR(255) NOT NULL,
cantidad INT NOT NULL CHECK (cantidad > 0),
precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
subtotalCalculado AS (cantidad * precio) PERSISTED,
CONSTRAINT FK_DetalleFactura_Factura
FOREIGN KEY (idFactura)
        REFERENCES Facturas(idFactura)
);
GO

-- Tabla Pagos
CREATE TABLE Pagos (
idPago INT IDENTITY(1,1) PRIMARY KEY,
idFactura INT NOT NULL,
fechaPago DATE NOT NULL,
metodo VARCHAR(50) NOT NULL,
monto DECIMAL(10,2) NOT NULL CHECK (monto > 0),
CONSTRAINT FK_Pago_Factura
FOREIGN KEY (idFactura)
REFERENCES Facturas(idFactura)
);

GO
ALTER TABLE Facturas
ADD idConsulta INT;

GO
ALTER TABLE Facturas
ADD CONSTRAINT FK_Factura_Consulta
FOREIGN KEY (idConsulta)
REFERENCES Consultas(idConsulta);

GO
UPDATE f
SET idConsulta = co.idConsulta
FROM Facturas f
CROSS APPLY (
    SELECT TOP 1 co.idConsulta
    FROM Consultas co
    INNER JOIN Citas c ON co.idCita = c.idCita
    WHERE c.idPaciente = f.idPaciente
    AND c.fechaHoraCitas <= f.fecha
    ORDER BY c.fechaHoraCitas DESC
) co;

SELECT * FROM Consultas; 