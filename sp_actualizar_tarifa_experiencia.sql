-- Contexto:
-- Este procedimiento calcula y actualiza las tarifas por experiencia
-- de los empleados basándose en las horas trabajadas registradas en
-- la tabla sueldo.turno_trabajo. La consulta interna calcula las horas
-- totales por empleado usando TIMESTAMPDIFF entre fecha_hora_inicio y
-- fecha_hora_cierra, pero solo considera turnos cerrados
-- (donde fecha_hora_cierra no es NULL). Si el usuario proporciona una fecha
-- (p_fecha), el cálculo se limita a los turnos cerrados hasta esa fecha;
-- si no se proporciona fecha (p_fecha es NULL), se usan todas las horas
-- de turnos cerrados hasta la fecha actual

DELIMITER $$

DROP PROCEDURE IF EXISTS sueldo.sp_actualizar_tarifa_experiencia $$
CREATE PROCEDURE sueldo.sp_actualizar_tarifa_experiencia(IN p_fecha DATE)
BEGIN
  -- Declaraciones
  DECLARE v_fecha DATE;
  DECLARE v_afectadas BIGINT DEFAULT 0;

  -- Para capturar detalles del error
  DECLARE v_sqlstate CHAR(5) DEFAULT '00000';
  DECLARE v_errno INT DEFAULT 0;
  DECLARE v_msg TEXT;

  -- Handler de errores: ROLLBACK -> LOG ERROR -> SIGNAL
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    GET DIAGNOSTICS CONDITION 1
      v_sqlstate = RETURNED_SQLSTATE,
      v_errno    = MYSQL_ERRNO,
      v_msg      = MESSAGE_TEXT;

    ROLLBACK;

    -- >>> AQUÍ se loguea el ERROR <<<
    INSERT INTO sueldo.log_tarifa_run
      (fecha_param, filas_afectadas, status, err_sqlstate, err_code, mensaje)
    VALUES
      (v_fecha, NULL, 'ERROR', v_sqlstate, v_errno, v_msg);

    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'sp_actualizar_tarifa_experiencia: fallo en la transacción';
  END;

  -- Inicialización
  SET v_fecha := IFNULL(p_fecha, CURDATE());

  START TRANSACTION;

  /* =========================================================
     Inserta/actualiza la fila efectiva para v_fecha SOLO si
     la tarifa (por horas decimales) cambió respecto del último
     registro (<= v_fecha). NO cuenta turnos abiertos.
     ========================================================= */
  INSERT INTO sueldo.fecha_tarifa_por_experiencia (
    tarifa_por_experiencia_id_tarifa_por_experiencia,
    empleado_id_empleado,
    fecha_desde
  )
  SELECT
    ( SELECT tpe.id_tarifa_por_experiencia
      FROM sueldo.tarifa_por_experiencia tpe
      WHERE tpe.cantidad_horas <= h.horas_dec
      ORDER BY tpe.cantidad_horas DESC
      LIMIT 1 ) AS tarifa_id,
    h.empleado_id,
    v_fecha
  FROM (
    SELECT
      t.empleado_id_empleado AS empleado_id,
      ROUND(
        SUM(GREATEST(TIMESTAMPDIFF(MINUTE, t.fecha_hora_inicio, t.fecha_hora_cierra), 0)) / 60, 2
      ) AS horas_dec
    FROM sueldo.turno_trabajo t
    WHERE t.fecha_hora_cierra IS NOT NULL
      AND t.fecha_hora_cierra > t.fecha_hora_inicio
      -- Condición dinámica según si p_fecha fue proporcionada
      AND (p_fecha IS NULL OR DATE(t.fecha_hora_cierra) <= v_fecha)
    GROUP BY t.empleado_id_empleado
  ) AS h
  WHERE EXISTS (
    SELECT 1
    FROM sueldo.tarifa_por_experiencia te
    WHERE te.cantidad_horas <= h.horas_dec
  )
  AND NOT EXISTS (
    SELECT 1
    FROM sueldo.fecha_tarifa_por_experiencia f
    WHERE f.empleado_id_empleado = h.empleado_id
      AND f.fecha_desde = (
        SELECT MAX(f2.fecha_desde)
        FROM sueldo.fecha_tarifa_por_experiencia f2
        WHERE f2.empleado_id_empleado = h.empleado_id
          AND f2.fecha_desde <= v_fecha
      )
      AND f.tarifa_por_experiencia_id_tarifa_por_experiencia = (
        SELECT tpe2.id_tarifa_por_experiencia
        FROM sueldo.tarifa_por_experiencia tpe2
        WHERE tpe2.cantidad_horas <= h.horas_dec
        ORDER BY tpe2.cantidad_horas DESC
        LIMIT 1
      )
  )
  ON DUPLICATE KEY UPDATE
    tarifa_por_experiencia_id_tarifa_por_experiencia =
      VALUES(tarifa_por_experiencia_id_tarifa_por_experiencia);

  SET v_afectadas := ROW_COUNT();

  COMMIT;

  -- >>> AQUÍ se loguea el ÉXITO <<<
  INSERT INTO sueldo.log_tarifa_run
    (fecha_param, filas_afectadas, status, mensaje)
  VALUES
    (v_fecha, v_afectadas, 'OK', 'ejecución diaria');

  -- Resumen para quien llamó
  SELECT v_fecha AS fecha_procesada, v_afectadas AS filas_afectadas;
END $$
DELIMITER ;
