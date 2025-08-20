-- Horas decimales por empleado (todas las fechas)
SELECT
  t.empleado_id_empleado AS empleado_id,
  ROUND(SUM(GREATEST(TIMESTAMPDIFF(MINUTE, t.fecha_hora_inicio, t.fecha_hora_cierra), 0)) / 60, 2) AS horas_dec
FROM turno_trabajo t
WHERE
  t.fecha_hora_cierra IS NOT NULL
  AND t.fecha_hora_cierra > t.fecha_hora_inicio
GROUP BY t.empleado_id_empleado
ORDER BY empleado_id;