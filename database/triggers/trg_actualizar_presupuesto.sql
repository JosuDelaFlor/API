CREATE OR REPLACE TRIGGER trg_actualizar_presupuesto
AFTER INSERT ON pagos_salarios
FOR EACH ROW
EXECUTE FUNCTION actualizar_presupuesto_departamento();