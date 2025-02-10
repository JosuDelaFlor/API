CREATE OR REPLACE PROCEDURE asignar_empleado_proyecto(empleado_id INT, proyecto_id INT) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO asignaciones (empleado_id, proyecto_id) VALUES (empleado_id, proyecto_id);
END; $$;