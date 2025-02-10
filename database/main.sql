-- Archivo principal de la base de datos 
 
-- Tablas 
DROP TABLE IF EXISTS pagos_salarios;
DROP TABLE IF EXISTS asignaciones;
DROP TABLE IF EXISTS proyectos;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS departamentos;

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
-- Procedimientos almacenados 
CREATE OR REPLACE PROCEDURE actualizar_departamento(id INT, nuevo_nombre VARCHAR, nuevo_presupuesto DECIMAL) LANGUAGE plpgsql AS $$
BEGIN
    UPDATE departamentos SET nombre = nuevo_nombre, presupuesto = nuevo_presupuesto WHERE id = id;
END; $$; 
CREATE OR REPLACE PROCEDURE actualizar_empleado(id INT, nuevo_salario DECIMAL) LANGUAGE plpgsql AS $$
BEGIN
    UPDATE empleados SET salario = nuevo_salario WHERE id = id;
END; $$; 
CREATE OR REPLACE PROCEDURE asignar_empleado_proyecto(empleado_id INT, proyecto_id INT) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO asignaciones (empleado_id, proyecto_id) VALUES (empleado_id, proyecto_id);
END; $$; 
CREATE OR REPLACE PROCEDURE eliminar_departamento(id INT) LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM departamentos WHERE id = id;
END; $$; 
CREATE OR REPLACE PROCEDURE eliminar_empleado(id INT) LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM empleados WHERE id = id;
END; $$; 
CREATE OR REPLACE PROCEDURE insertar_departamento(nombre VARCHAR, presupuesto DECIMAL) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO departamentos (nombre, presupuesto) VALUES (nombre, presupuesto);
END; $$; 
CREATE OR REPLACE PROCEDURE insertar_empleado(nombre VARCHAR, apellido VARCHAR, email VARCHAR, telefono VARCHAR, salario DECIMAL, departamento_id INT) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO empleados (nombre, apellido, email, telefono, salario, departamento_id) VALUES (nombre, apellido, email, telefono, salario, departamento_id);
END; $$; 
CREATE OR REPLACE PROCEDURE insertar_proyecto(nombre VARCHAR, fecha_inicio DATE, fecha_fin DATE, departamento_id INT) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO proyectos (nombre, fecha_inicio, fecha_fin, departamento_id) VALUES (nombre, fecha_inicio, fecha_fin, departamento_id);
END; $$; 
CREATE OR REPLACE PROCEDURE pagar_salario(empleado_id INT, monto DECIMAL, fecha_pago DATE) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO pagos_salarios (empleado_id, fecha_pago, monto) VALUES (empleado_id, fecha_pago, monto);
END; $$; 
 
-- Funciones 
CREATE OR REPLACE FUNCTION actualizar_presupuesto_departamento() RETURNS TRIGGER AS $$
BEGIN
    UPDATE departamentos SET presupuesto = presupuesto - NEW.monto WHERE id = (SELECT departamento_id FROM empleados WHERE id = NEW.empleado_id);
    RETURN NEW;
END; $$ LANGUAGE plpgsql; 
 
-- Vistas 
CREATE OR REPLACE VIEW vista_asignaciones AS SELECT * FROM asignaciones; 
CREATE OR REPLACE VIEW vista_asignaciones_detalle AS SELECT a.*, e.nombre AS empleado, p.nombre AS proyecto FROM asignaciones a JOIN empleados e ON a.empleado_id = e.id JOIN proyectos p ON a.proyecto_id = p.id; 
CREATE OR REPLACE VIEW vista_departamentos AS SELECT * FROM departamentos; 
CREATE OR REPLACE VIEW vista_empleados AS SELECT * FROM empleados; 
CREATE OR REPLACE VIEW vista_empleados_departamento AS SELECT e.*, d.nombre AS departamento FROM empleados e JOIN departamentos d ON e.departamento_id = d.id; 
CREATE OR REPLACE VIEW vista_pagos_detalle AS SELECT ps.*, e.nombre AS empleado FROM pagos_salarios ps JOIN empleados e ON ps.empleado_id = e.id; 
CREATE OR REPLACE VIEW vista_pagos_salarios AS SELECT * FROM pagos_salarios; 
CREATE OR REPLACE VIEW vista_proyectos AS SELECT * FROM proyectos; 
CREATE OR REPLACE VIEW vista_proyectos_departamento AS SELECT p.*, d.nombre AS departamento FROM proyectos p JOIN departamentos d ON p.departamento_id = d.id; 
CREATE OR REPLACE VIEW vista_salarios_total AS SELECT departamento_id, SUM(salario) AS total_salarios FROM empleados GROUP BY departamento_id; 
 
-- Triggers 
CREATE OR REPLACE TRIGGER trg_actualizar_presupuesto
AFTER INSERT ON pagos_salarios
FOR EACH ROW
EXECUTE FUNCTION actualizar_presupuesto_departamento(); 
