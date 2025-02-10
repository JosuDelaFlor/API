CREATE OR REPLACE PROCEDURE pagar_salario(empleado_id INT, monto DECIMAL, fecha_pago DATE) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO pagos_salarios (empleado_id, fecha_pago, monto) VALUES (empleado_id, fecha_pago, monto);
END; $$;