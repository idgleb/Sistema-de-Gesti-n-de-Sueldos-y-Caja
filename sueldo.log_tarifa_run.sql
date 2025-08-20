CREATE TABLE IF NOT EXISTS sueldo.log_tarifa_run (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  run_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  fecha_param DATE NOT NULL,
  filas_afectadas BIGINT NULL,
  status ENUM('OK','ERROR') NOT NULL,
  err_sqlstate CHAR(5) NULL,
  err_code INT NULL,
  mensaje TEXT NULL
);
