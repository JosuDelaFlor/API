CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    presupuesto DECIMAL(10,2) NOT NULL
);

-- Crear tabla de empleados
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    salario DECIMAL(10,2) NOT NULL,
    departamento_id INT REFERENCES departamentos(id) ON DELETE SET NULL
);
CREATE INDEX idx_empleados_departamento ON empleados(departamento_id);

-- Crear tabla de proyectos
CREATE TABLE proyectos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    departamento_id INT REFERENCES departamentos(id) ON DELETE CASCADE
);
CREATE INDEX idx_proyectos_departamento ON proyectos(departamento_id);

-- Crear tabla de asignaciones de empleados a proyectos
CREATE TABLE asignaciones (
    id SERIAL PRIMARY KEY,
    empleado_id INT REFERENCES empleados(id) ON DELETE CASCADE,
    proyecto_id INT REFERENCES proyectos(id) ON DELETE CASCADE,
    fecha_asignacion DATE NOT NULL DEFAULT CURRENT_DATE
);
CREATE INDEX idx_asignaciones_empleado ON asignaciones(empleado_id);
CREATE INDEX idx_asignaciones_proyecto ON asignaciones(proyecto_id);

-- Crear tabla de pagos de salarios
CREATE TABLE pagos_salarios (
    id SERIAL PRIMARY KEY,
    empleado_id INT REFERENCES empleados(id) ON DELETE CASCADE,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL
);
CREATE INDEX idx_pagos_salarios_empleado ON pagos_salarios(empleado_id);

-- Insertar datos de ejemplo
INSERT INTO departamentos (nombre, presupuesto) VALUES ('Recursos Humanos', 50000.00), ('Desarrollo', 150000.00);

INSERT INTO empleados (nombre, apellido, email, telefono, salario, departamento_id) VALUES 
('Juan', 'Pérez', 'juan.perez@empresa.com', '123456789', 3000.00, 2),
('Ana', 'Gómez', 'ana.gomez@empresa.com', '987654321', 2800.00, 1);

INSERT INTO proyectos (nombre, fecha_inicio, fecha_fin, departamento_id) VALUES 
('Proyecto A', '2024-01-01', '2024-12-30', 2),
('Proyecto B', '2024-06-01', '2024-12-31', 1);

INSERT INTO asignaciones (empleado_id, proyecto_id) VALUES (1, 1), (2, 2);

INSERT INTO pagos_salarios (empleado_id, fecha_pago, monto) VALUES 
(1, '2024-02-01', 3000.00),
(2, '2024-02-01', 2800.00);