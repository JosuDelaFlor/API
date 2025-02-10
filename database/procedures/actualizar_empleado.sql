CREATE OR REPLACE PROCEDURE actualizar_empleado(id INT, nuevo_salario DECIMAL) LANGUAGE plpgsql AS $$
BEGIN
    UPDATE empleados SET salario = nuevo_salario WHERE id = id;
END; $$;