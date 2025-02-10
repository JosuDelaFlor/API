CREATE OR REPLACE PROCEDURE eliminar_empleado(id INT) LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM empleados WHERE id = id;
END; $$;