CREATE OR REPLACE VIEW vista_salarios_total AS SELECT departamento_id, SUM(salario) AS total_salarios FROM empleados GROUP BY departamento_id;