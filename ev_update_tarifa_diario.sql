-- Activar Event Scheduler(temporalmente haste reinicio)
-- Necesita root (o un usuario con SUPER en MariaDB 10.4)
SET GLOBAL event_scheduler = ON;
-- Para dejarlo permanente, en C:\xampp\mysql\bin\my.ini agrega
-- En la sección [mysqld]: event_scheduler=ON


-- Usá la TZ local para calcular STARTS
SET time_zone = '-03:00';

DROP EVENT IF EXISTS sueldo.ev_update_tarifa_diario;
DELIMITER $$

CREATE EVENT sueldo.ev_update_tarifa_diario

-- Solo para test
ON SCHEDULE EVERY 1 SECOND
STARTS NOW() + INTERVAL 2 SECOND
--

/*
ON SCHEDULE EVERY 1 DAY
STARTS TIMESTAMP(
  IF(TIME(NOW()) < '03:00:00',
     CURRENT_DATE + INTERVAL 3 HOUR,                        -- hoy 03:00
     CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 3 HOUR)       -- mañana 03:00
)
*/

DO
BEGIN
  SET time_zone = '-03:00';
  CALL sueldo.sp_actualizar_tarifa_experiencia(CURDATE());
END $$
DELIMITER ;
