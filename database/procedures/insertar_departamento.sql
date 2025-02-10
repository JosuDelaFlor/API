CREATE OR REPLACE PROCEDURE insertar_departamento(nombre VARCHAR, presupuesto DECIMAL) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO departamentos (nombre, presupuesto) VALUES (nombre, presupuesto);
END; $$;