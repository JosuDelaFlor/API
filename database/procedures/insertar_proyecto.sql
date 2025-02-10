CREATE OR REPLACE PROCEDURE insertar_proyecto(nombre VARCHAR, fecha_inicio DATE, fecha_fin DATE, departamento_id INT) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO proyectos (nombre, fecha_inicio, fecha_fin, departamento_id) VALUES (nombre, fecha_inicio, fecha_fin, departamento_id);
END; $$;