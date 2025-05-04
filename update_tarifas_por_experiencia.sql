-- Este script tiene como objetivo actualizar la tabla 
-- fecha_tarifa_por_experiencia para cada empleado según 
-- las horas trabajadas.
-- Este script garantiza que, si el empleado ya tiene un 
-- registro con la misma fecha de inicio, el registro se elimine antes 
-- de insertar el nuevo. Además, asegura que el empleado reciba 
-- la tarifa correcta según las horas trabajadas, sin insertar duplicados.

-- Paso 1: Eliminar los registros existentes con el mismo empleado y fecha
DELETE FROM fecha_tarifa_por_experiencia
WHERE (empleado_id_empleado, fecha_desde) IN (
    SELECT e.id_empleado, CURDATE() -- Fecha actual de la consulta
    FROM empleado e
    JOIN turno_trabajo t ON e.id_empleado = t.empleado_id_empleado
    JOIN tarifa_por_experiencia tpe ON (
        tpe.cantidad_horas <= (
            SELECT SUM(TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra))
            FROM turno_trabajo t
            WHERE t.empleado_id_empleado = e.id_empleado
        )
    )
    WHERE tpe.cantidad_horas = (
        SELECT MAX(cantidad_horas)
        FROM tarifa_por_experiencia
        WHERE cantidad_horas <= (
            SELECT SUM(TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra))
            FROM turno_trabajo t
            WHERE t.empleado_id_empleado = e.id_empleado
        )
    )
);

-- Inserción sin duplicados
INSERT IGNORE INTO fecha_tarifa_por_experiencia (
    tarifa_por_experiencia_id_tarifa_por_experiencia,
    empleado_id_empleado,
    fecha_desde
)
SELECT
    tpe.id_tarifa_por_experiencia, -- Tarifa asociada a la cantidad de horas
    e.id_empleado, -- ID del empleado
    CURDATE() -- Fecha actual de la consulta
FROM
    empleado e
JOIN
    turno_trabajo t ON e.id_empleado = t.empleado_id_empleado
JOIN
    tarifa_por_experiencia tpe ON (
        tpe.cantidad_horas <= (
            SELECT SUM(TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra))
            FROM turno_trabajo t
            WHERE t.empleado_id_empleado = e.id_empleado
        )
    )
WHERE
    tpe.cantidad_horas = (
        SELECT MAX(cantidad_horas)
        FROM tarifa_por_experiencia
        WHERE cantidad_horas <= (
            SELECT SUM(TIMESTAMPDIFF(HOUR, t.fecha_hora_inicio, t.fecha_hora_cierra))
            FROM turno_trabajo t
            WHERE t.empleado_id_empleado = e.id_empleado
        )
    )
GROUP BY
    e.id_empleado;
