CREATE OR REPLACE FUNCTION actualizar_presupuesto_departamento() RETURNS TRIGGER AS $$
BEGIN
    UPDATE departamentos SET presupuesto = presupuesto - NEW.monto WHERE id = (SELECT departamento_id FROM empleados WHERE id = NEW.empleado_id);
    RETURN NEW;
END; $$ LANGUAGE plpgsql;