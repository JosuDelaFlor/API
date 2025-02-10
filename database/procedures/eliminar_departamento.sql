CREATE OR REPLACE PROCEDURE eliminar_departamento(id INT) LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM departamentos WHERE id = id;
END; $$;