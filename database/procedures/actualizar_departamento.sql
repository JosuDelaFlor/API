CREATE OR REPLACE PROCEDURE actualizar_departamento(id INT, nuevo_nombre VARCHAR, nuevo_presupuesto DECIMAL) LANGUAGE plpgsql AS $$
BEGIN
    UPDATE departamentos SET nombre = nuevo_nombre, presupuesto = nuevo_presupuesto WHERE id = id;
END; $$;