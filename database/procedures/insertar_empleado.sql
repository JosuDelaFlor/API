CREATE OR REPLACE PROCEDURE insertar_empleado(nombre VARCHAR, apellido VARCHAR, email VARCHAR, telefono VARCHAR, salario DECIMAL, departamento_id INT) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO empleados (nombre, apellido, email, telefono, salario, departamento_id) VALUES (nombre, apellido, email, telefono, salario, departamento_id);
END; $$;