-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sueldo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sueldo` ;

-- -----------------------------------------------------
-- Schema sueldo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sueldo` DEFAULT CHARACTER SET utf8 ;
USE `sueldo` ;

-- -----------------------------------------------------
-- Table `ciudad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ciudad` ;

CREATE TABLE IF NOT EXISTS `ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_ciudad`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_ciudad_UNIQUE` ON `ciudad` (`id_ciudad` ASC);


-- -----------------------------------------------------
-- Table `direccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `direccion` ;

CREATE TABLE IF NOT EXISTS `direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `ciudad_id_ciudad` INT NOT NULL,
  `calle` VARCHAR(45) NULL,
  `edificio` VARCHAR(45) NULL,
  `depto` VARCHAR(45) NULL,
  PRIMARY KEY (`id_direccion`),
  CONSTRAINT `fk_direccion_ciudad1`
    FOREIGN KEY (`ciudad_id_ciudad`)
    REFERENCES `ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_direccion_UNIQUE` ON `direccion` (`id_direccion` ASC);

CREATE INDEX `fk_direccion_ciudad1_idx` ON `direccion` (`ciudad_id_ciudad` ASC);


-- -----------------------------------------------------
-- Table `rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rol` ;

CREATE TABLE IF NOT EXISTS `rol` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre_rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_rol_UNIQUE` ON `rol` (`id_rol` ASC);

CREATE UNIQUE INDEX `nombre_rol_UNIQUE` ON `rol` (`nombre_rol` ASC);


-- -----------------------------------------------------
-- Table `empleado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `empleado` ;

CREATE TABLE IF NOT EXISTS `empleado` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `num_pass` VARCHAR(45) NULL,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `direccion_id_direccion` INT NOT NULL,
  `rol_id_rol` INT NOT NULL,
  PRIMARY KEY (`id_empleado`),
  CONSTRAINT `fk_empleado_direccion1`
    FOREIGN KEY (`direccion_id_direccion`)
    REFERENCES `direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_rol1`
    FOREIGN KEY (`rol_id_rol`)
    REFERENCES `rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `num_pass_UNIQUE` ON `empleado` (`num_pass` ASC);

CREATE UNIQUE INDEX `id_empleado_UNIQUE` ON `empleado` (`id_empleado` ASC);

CREATE INDEX `fk_empleado_direccion1_idx` ON `empleado` (`direccion_id_direccion` ASC);

CREATE INDEX `fk_empleado_rol1_idx` ON `empleado` (`rol_id_rol` ASC);

CREATE INDEX `idx_empleado_nombre` ON `empleado` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `archivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `archivo` ;

CREATE TABLE IF NOT EXISTS `archivo` (
  `id_archvo` INT NOT NULL AUTO_INCREMENT,
  `empleado_id_empleado` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `enlace` VARCHAR(45) NULL,
  PRIMARY KEY (`id_archvo`),
  CONSTRAINT `fk_archivo_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_archvo_UNIQUE` ON `archivo` (`id_archvo` ASC);

CREATE INDEX `fk_archivo_empleado1_idx` ON `archivo` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `contrato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contrato` ;

CREATE TABLE IF NOT EXISTS `contrato` (
  `id_contr` INT NOT NULL AUTO_INCREMENT,
  `empleado_id_empleado` INT NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_termin` DATE NULL,
  `caracter` VARCHAR(255) NULL,
  `puntos` INT NULL,
  PRIMARY KEY (`id_contr`),
  CONSTRAINT `fk_contrato_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_contr_UNIQUE` ON `contrato` (`id_contr` ASC);

CREATE INDEX `fk_contrato_empleado1_idx` ON `contrato` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `sucursal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sucursal` ;

CREATE TABLE IF NOT EXISTS `sucursal` (
  `id_sucursal` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `direccion_id_direccion` INT NULL,
  PRIMARY KEY (`id_sucursal`),
  CONSTRAINT `fk_sucursal_direccion1`
    FOREIGN KEY (`direccion_id_direccion`)
    REFERENCES `direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_sucursal_UNIQUE` ON `sucursal` (`id_sucursal` ASC);

CREATE INDEX `fk_sucursal_direccion1_idx` ON `sucursal` (`direccion_id_direccion` ASC);

CREATE INDEX `idx_sucursal_nombre` ON `sucursal` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `caja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `caja` ;

CREATE TABLE IF NOT EXISTS `caja` (
  `id_caja` INT NOT NULL AUTO_INCREMENT,
  `sucursal_id_sucursal` INT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_caja`),
  CONSTRAINT `fk_caja_sucursal1`
    FOREIGN KEY (`sucursal_id_sucursal`)
    REFERENCES `sucursal` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_caja_UNIQUE` ON `caja` (`id_caja` ASC);

CREATE INDEX `fk_caja_sucursal1_idx` ON `caja` (`sucursal_id_sucursal` ASC);


-- -----------------------------------------------------
-- Table `turno_trabajo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `turno_trabajo` ;

CREATE TABLE IF NOT EXISTS `turno_trabajo` (
  `id_turno_trabajo` INT NOT NULL AUTO_INCREMENT,
  `empleado_id_empleado` INT NOT NULL,
  `caja_id_caja` INT NOT NULL,
  `fecha_hora_inicio` DATETIME NULL,
  `fecha_hora_cierra` DATETIME NULL,
  PRIMARY KEY (`id_turno_trabajo`),
  CONSTRAINT `fk_turno_trabajo_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turno_trabajo_caja1`
    FOREIGN KEY (`caja_id_caja`)
    REFERENCES `caja` (`id_caja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_turno_trabajo_UNIQUE` ON `turno_trabajo` (`id_turno_trabajo` ASC);

CREATE INDEX `fk_turno_trabajo_empleado1_idx` ON `turno_trabajo` (`empleado_id_empleado` ASC);

CREATE INDEX `fk_turno_trabajo_caja1_idx` ON `turno_trabajo` (`caja_id_caja` ASC);


-- -----------------------------------------------------
-- Table `horario_turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `horario_turno` ;

CREATE TABLE IF NOT EXISTS `horario_turno` (
  `id_horario_turno` INT(11) NOT NULL AUTO_INCREMENT,
  `empleado_id_empleado` INT NOT NULL,
  `caja_id_caja` INT NOT NULL,
  `fecha_hora_inicio` DATETIME NULL,
  `fecha_hora_cierra` DATETIME NULL,
  PRIMARY KEY (`id_horario_turno`),
  CONSTRAINT `fk_horario_turno_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_turno_caja1`
    FOREIGN KEY (`caja_id_caja`)
    REFERENCES `caja` (`id_caja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `id_horario_turno_UNIQUE` ON `horario_turno` (`id_horario_turno` ASC);

CREATE INDEX `fk_horario_turno_empleado1_idx` ON `horario_turno` (`empleado_id_empleado` ASC);

CREATE INDEX `fk_horario_turno_caja1_idx` ON `horario_turno` (`caja_id_caja` ASC);


-- -----------------------------------------------------
-- Table `nomina_sueldo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nomina_sueldo` ;

CREATE TABLE IF NOT EXISTS `nomina_sueldo` (
  `id_nomina_sueldos` INT NOT NULL AUTO_INCREMENT,
  `empleado_id_empleado` INT NOT NULL,
  `periodo` DATE NOT NULL,
  `pagado` FLOAT NULL,
  PRIMARY KEY (`id_nomina_sueldos`),
  CONSTRAINT `fk_nomina_sueldo_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_nomina_sueldos_UNIQUE` ON `nomina_sueldo` (`id_nomina_sueldos` ASC);

CREATE INDEX `fk_nomina_sueldo_empleado1_idx` ON `nomina_sueldo` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `tarifa_individual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarifa_individual` ;

CREATE TABLE IF NOT EXISTS `tarifa_individual` (
  `id_tarifa_individual` INT NOT NULL AUTO_INCREMENT,
  `tarifa_por_hora` FLOAT NULL,
  `porcentaje_de_ventas` INT NULL,
  PRIMARY KEY (`id_tarifa_individual`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_tarifa_individual_UNIQUE` ON `tarifa_individual` (`id_tarifa_individual` ASC);


-- -----------------------------------------------------
-- Table `servicio_prod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `servicio_prod` ;

CREATE TABLE IF NOT EXISTS `servicio_prod` (
  `id_servicio_o_prod` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  PRIMARY KEY (`id_servicio_o_prod`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `servicio_prod` (`nombre` ASC);

CREATE UNIQUE INDEX `id_servicio_o_prod_UNIQUE` ON `servicio_prod` (`id_servicio_o_prod` ASC);

CREATE INDEX `idx_servicio_prod_nombre` ON `servicio_prod` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `porcentaje_servisio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `porcentaje_servisio` ;

CREATE TABLE IF NOT EXISTS `porcentaje_servisio` (
  `id_porcentaje_servisio` INT NOT NULL AUTO_INCREMENT,
  `servicio_prod_id_servicio_o_prod` INT NOT NULL,
  `porcentaje` INT NULL,
  PRIMARY KEY (`id_porcentaje_servisio`),
  CONSTRAINT `fk_porcentaje_servisio_servicio_prod1`
    FOREIGN KEY (`servicio_prod_id_servicio_o_prod`)
    REFERENCES `servicio_prod` (`id_servicio_o_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_porcentaje_servisio_UNIQUE` ON `porcentaje_servisio` (`id_porcentaje_servisio` ASC);

CREATE INDEX `fk_porcentaje_servisio_servicio_prod1_idx` ON `porcentaje_servisio` (`servicio_prod_id_servicio_o_prod` ASC);


-- -----------------------------------------------------
-- Table `multa_premio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `multa_premio` ;

CREATE TABLE IF NOT EXISTS `multa_premio` (
  `id_multa_premio` INT NOT NULL AUTO_INCREMENT,
  `empleado_id_empleado` INT NOT NULL,
  `fecha` DATE NULL,
  `monto` FLOAT NULL,
  `coment` VARCHAR(255) NULL,
  PRIMARY KEY (`id_multa_premio`),
  CONSTRAINT `fk_multa_premio_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_multa_premio_UNIQUE` ON `multa_premio` (`id_multa_premio` ASC);

CREATE INDEX `fk_multa_premio_empleado1_idx` ON `multa_premio` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `movimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movimiento` ;

CREATE TABLE IF NOT EXISTS `movimiento` (
  `id_movimiento` INT NOT NULL AUTO_INCREMENT,
  `caja_id_caja` INT NOT NULL,
  `fecha_hora` DATETIME NOT NULL,
  PRIMARY KEY (`id_movimiento`),
  CONSTRAINT `fk_movimiento_caja1`
    FOREIGN KEY (`caja_id_caja`)
    REFERENCES `caja` (`id_caja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_movimiento_UNIQUE` ON `movimiento` (`id_movimiento` ASC);

CREATE INDEX `fk_movimiento_caja1_idx` ON `movimiento` (`caja_id_caja` ASC);


-- -----------------------------------------------------
-- Table `tipo_gasto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tipo_gasto` ;

CREATE TABLE IF NOT EXISTS `tipo_gasto` (
  `id_tipo_gasto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipo_gasto`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `tipo_gasto` (`nombre` ASC);

CREATE UNIQUE INDEX `id_tipo_gasto_UNIQUE` ON `tipo_gasto` (`id_tipo_gasto` ASC);


-- -----------------------------------------------------
-- Table `gasto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gasto` ;

CREATE TABLE IF NOT EXISTS `gasto` (
  `movimiento_id_movimiento` INT NOT NULL,
  `tipo_gasto_id_tipo_gasto` INT NOT NULL,
  `discript` VARCHAR(255) NULL,
  PRIMARY KEY (`movimiento_id_movimiento`),
  CONSTRAINT `fk_gasto_movimiento1`
    FOREIGN KEY (`movimiento_id_movimiento`)
    REFERENCES `movimiento` (`id_movimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gasto_tipo_gasto1`
    FOREIGN KEY (`tipo_gasto_id_tipo_gasto`)
    REFERENCES `tipo_gasto` (`id_tipo_gasto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_gasto_tipo_gasto1_idx` ON `gasto` (`tipo_gasto_id_tipo_gasto` ASC);


-- -----------------------------------------------------
-- Table `depositos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `depositos` ;

CREATE TABLE IF NOT EXISTS `depositos` (
  `movimiento_id_movimiento` INT NOT NULL,
  `discript` VARCHAR(255) NULL,
  PRIMARY KEY (`movimiento_id_movimiento`),
  CONSTRAINT `fk_depositos_movimiento1`
    FOREIGN KEY (`movimiento_id_movimiento`)
    REFERENCES `movimiento` (`id_movimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `detalle_de_pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detalle_de_pago` ;

CREATE TABLE IF NOT EXISTS `detalle_de_pago` (
  `id_detalle_de_pago` INT NOT NULL AUTO_INCREMENT,
  `empleado_id_empleado` INT NOT NULL,
  `tarjeta` VARCHAR(45) NULL,
  `banco` VARCHAR(45) NULL,
  `nombre_destino` VARCHAR(45) NULL,
  `por_defecto` TINYINT(1) NULL,
  PRIMARY KEY (`id_detalle_de_pago`),
  CONSTRAINT `fk_detalle_de_pago_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_detalle_de_pago_UNIQUE` ON `detalle_de_pago` (`id_detalle_de_pago` ASC);

CREATE INDEX `fk_detalle_de_pago_empleado1_idx` ON `detalle_de_pago` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `metodo_de_pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `metodo_de_pago` ;

CREATE TABLE IF NOT EXISTS `metodo_de_pago` (
  `id_metodo_de_pago` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_metodo_de_pago`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `metodo_de_pago` (`nombre` ASC);

CREATE UNIQUE INDEX `id_metodo_de_pago_UNIQUE` ON `metodo_de_pago` (`id_metodo_de_pago` ASC);


-- -----------------------------------------------------
-- Table `cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cliente` ;

CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_cliente_UNIQUE` ON `cliente` (`id_cliente` ASC);

CREATE INDEX `idx_cliente_nombre` ON `cliente` (`nombre` ASC);


-- -----------------------------------------------------
-- Table `venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `venta` ;

CREATE TABLE IF NOT EXISTS `venta` (
  `movimiento_id_movimiento` INT NOT NULL,
  `cliente_id_cliente` INT NOT NULL,
  `empleado_id_empleado` INT NOT NULL,
  PRIMARY KEY (`movimiento_id_movimiento`),
  CONSTRAINT `fk_venta_movimiento1`
    FOREIGN KEY (`movimiento_id_movimiento`)
    REFERENCES `movimiento` (`id_movimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_cliente1`
    FOREIGN KEY (`cliente_id_cliente`)
    REFERENCES `cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_venta_cliente1_idx` ON `venta` (`cliente_id_cliente` ASC);

CREATE INDEX `fk_venta_empleado1_idx` ON `venta` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `sacar_dinero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sacar_dinero` ;

CREATE TABLE IF NOT EXISTS `sacar_dinero` (
  `movimiento_id_movimiento` INT NOT NULL,
  `empleado_id_empleado` INT NOT NULL,
  PRIMARY KEY (`movimiento_id_movimiento`),
  CONSTRAINT `fk_sacar_dinero_movimiento1`
    FOREIGN KEY (`movimiento_id_movimiento`)
    REFERENCES `movimiento` (`id_movimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sacar_dinero_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_sacar_dinero_empleado1_idx` ON `sacar_dinero` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `tarifa_por_experiencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tarifa_por_experiencia` ;

CREATE TABLE IF NOT EXISTS `tarifa_por_experiencia` (
  `id_tarifa_por_experiencia` INT NOT NULL AUTO_INCREMENT,
  `cantidad_horas` INT NULL,
  `tarifa_por_hora` FLOAT NULL,
  `porcentaje_de_ventas` INT NULL,
  PRIMARY KEY (`id_tarifa_por_experiencia`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_tarifa_por_experiencia_UNIQUE` ON `tarifa_por_experiencia` (`id_tarifa_por_experiencia` ASC);


-- -----------------------------------------------------
-- Table `fecha_tarifa_individual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fecha_tarifa_individual` ;

CREATE TABLE IF NOT EXISTS `fecha_tarifa_individual` (
  `tarifa_individual_id_tarifa_individual` INT NOT NULL,
  `empleado_id_empleado` INT NOT NULL,
  `fecha_desde` DATE NULL,
  PRIMARY KEY (`tarifa_individual_id_tarifa_individual`, `empleado_id_empleado`),
  CONSTRAINT `fk_nomina_sueldo_has_tarifa_individual_tarifa_individual1`
    FOREIGN KEY (`tarifa_individual_id_tarifa_individual`)
    REFERENCES `tarifa_individual` (`id_tarifa_individual`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fecha_tarifa_individual_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_nomina_sueldo_has_tarifa_individual_tarifa_individual1_idx` ON `fecha_tarifa_individual` (`tarifa_individual_id_tarifa_individual` ASC);

CREATE INDEX `fk_fecha_tarifa_individual_empleado1_idx` ON `fecha_tarifa_individual` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `fecha_tarifa_por_experiencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fecha_tarifa_por_experiencia` ;

CREATE TABLE IF NOT EXISTS `fecha_tarifa_por_experiencia` (
  `tarifa_por_experiencia_id_tarifa_por_experiencia` INT NOT NULL,
  `empleado_id_empleado` INT NOT NULL,
  `fecha_desde` DATE NOT NULL,
  PRIMARY KEY (`tarifa_por_experiencia_id_tarifa_por_experiencia`, `empleado_id_empleado`, `fecha_desde`),
  CONSTRAINT `fk_nomina_sueldo_has_tarifa_por_experiencia_tarifa_por_experi1`
    FOREIGN KEY (`tarifa_por_experiencia_id_tarifa_por_experiencia`)
    REFERENCES `tarifa_por_experiencia` (`id_tarifa_por_experiencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fecha_tarifa_por_experiencia_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_nomina_sueldo_has_tarifa_por_experiencia_tarifa_por_expe_idx` ON `fecha_tarifa_por_experiencia` (`tarifa_por_experiencia_id_tarifa_por_experiencia` ASC);

CREATE INDEX `fk_fecha_tarifa_por_experiencia_empleado1_idx` ON `fecha_tarifa_por_experiencia` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `fecha_porcentaje_servisio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fecha_porcentaje_servisio` ;

CREATE TABLE IF NOT EXISTS `fecha_porcentaje_servisio` (
  `porcentaje_servisio_id_porcentaje_servisio` INT NOT NULL,
  `empleado_id_empleado` INT NOT NULL,
  `fecha_desde` DATE NULL,
  PRIMARY KEY (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`),
  CONSTRAINT `fk_nomina_sueldo_has_porcentaje_servisio_porcentaje_servisio1`
    FOREIGN KEY (`porcentaje_servisio_id_porcentaje_servisio`)
    REFERENCES `porcentaje_servisio` (`id_porcentaje_servisio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fecha_porcentaje_servisio_empleado1`
    FOREIGN KEY (`empleado_id_empleado`)
    REFERENCES `empleado` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_nomina_sueldo_has_porcentaje_servisio_porcentaje_servisi_idx` ON `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio` ASC);

CREATE INDEX `fk_fecha_porcentaje_servisio_empleado1_idx` ON `fecha_porcentaje_servisio` (`empleado_id_empleado` ASC);


-- -----------------------------------------------------
-- Table `detalle_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `detalle_venta` ;

CREATE TABLE IF NOT EXISTS `detalle_venta` (
  `venta_movimiento_id_movimiento` INT NOT NULL,
  `servicio_prod_id_servicio_o_prod` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `precio_unitario` FLOAT NOT NULL,
  PRIMARY KEY (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`),
  CONSTRAINT `fk_venta_has_servicio_prod_venta1`
    FOREIGN KEY (`venta_movimiento_id_movimiento`)
    REFERENCES `venta` (`movimiento_id_movimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venta_has_servicio_prod_servicio_prod1`
    FOREIGN KEY (`servicio_prod_id_servicio_o_prod`)
    REFERENCES `servicio_prod` (`id_servicio_o_prod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_venta_has_servicio_prod_servicio_prod1_idx` ON `detalle_venta` (`servicio_prod_id_servicio_o_prod` ASC);

CREATE INDEX `fk_venta_has_servicio_prod_venta1_idx` ON `detalle_venta` (`venta_movimiento_id_movimiento` ASC);


-- -----------------------------------------------------
-- Table `combo_metodos_pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `combo_metodos_pago` ;

CREATE TABLE IF NOT EXISTS `combo_metodos_pago` (
  `movimiento_id_movimiento` INT NOT NULL,
  `metodo_de_pago_id_metodo_de_pago` INT NOT NULL,
  `monto` FLOAT NOT NULL,
  PRIMARY KEY (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`),
  CONSTRAINT `fk_movimiento_has_metodo_de_pago_movimiento1`
    FOREIGN KEY (`movimiento_id_movimiento`)
    REFERENCES `movimiento` (`id_movimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movimiento_has_metodo_de_pago_metodo_de_pago1`
    FOREIGN KEY (`metodo_de_pago_id_metodo_de_pago`)
    REFERENCES `metodo_de_pago` (`id_metodo_de_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_movimiento_has_metodo_de_pago_metodo_de_pago1_idx` ON `combo_metodos_pago` (`metodo_de_pago_id_metodo_de_pago` ASC);

CREATE INDEX `fk_movimiento_has_metodo_de_pago_movimiento1_idx` ON `combo_metodos_pago` (`movimiento_id_movimiento` ASC);


-- -----------------------------------------------------
-- Table `hora`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hora` ;

CREATE TABLE IF NOT EXISTS `hora` (
  `id_hora` INT NOT NULL AUTO_INCREMENT,
  `hora` TIME NOT NULL,
  PRIMARY KEY (`id_hora`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_hora_UNIQUE` ON `hora` (`id_hora` ASC);

CREATE UNIQUE INDEX `hora_UNIQUE` ON `hora` (`hora` ASC);


-- -----------------------------------------------------
-- Table `dia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dia` ;

CREATE TABLE IF NOT EXISTS `dia` (
  `id_dia` INT NOT NULL AUTO_INCREMENT,
  `dia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_dia`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_dia_UNIQUE` ON `dia` (`id_dia` ASC);

CREATE UNIQUE INDEX `dia_UNIQUE` ON `dia` (`dia` ASC);


-- -----------------------------------------------------
-- Table `orario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orario` ;

CREATE TABLE IF NOT EXISTS `orario` (
  `dia_id_dia` INT NOT NULL,
  `hora_desde` INT NOT NULL,
  `hora_hasta` INT NOT NULL,
  PRIMARY KEY (`dia_id_dia`, `hora_desde`, `hora_hasta`),
  CONSTRAINT `fk_dia`
    FOREIGN KEY (`dia_id_dia`)
    REFERENCES `dia` (`id_dia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hora_desde`
    FOREIGN KEY (`hora_desde`)
    REFERENCES `hora` (`id_hora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hora_hasta`
    FOREIGN KEY (`hora_hasta`)
    REFERENCES `hora` (`id_hora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_hora_desde_idx` ON `orario` (`hora_desde` ASC);

CREATE INDEX `fk_dia_idx` ON `orario` (`dia_id_dia` ASC);

CREATE INDEX `fk_hora_hasta_idx` ON `orario` (`hora_hasta` ASC);


-- -----------------------------------------------------
-- Table `sucursal_orario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sucursal_orario` ;

CREATE TABLE IF NOT EXISTS `sucursal_orario` (
  `sucursal_id_sucursal` INT NOT NULL,
  `orario_dia_id_dia` INT NOT NULL,
  `orario_hora_desde` INT NOT NULL,
  `orario_hora_hasta` INT NOT NULL,
  PRIMARY KEY (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`),
  CONSTRAINT `fk_sucursal_has_orario_sucursal1`
    FOREIGN KEY (`sucursal_id_sucursal`)
    REFERENCES `sucursal` (`id_sucursal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sucursal_has_orario_orario1`
    FOREIGN KEY (`orario_dia_id_dia` , `orario_hora_desde` , `orario_hora_hasta`)
    REFERENCES `orario` (`dia_id_dia` , `hora_desde` , `hora_hasta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_sucursal_has_orario_orario1_idx` ON `sucursal_orario` (`orario_dia_id_dia` ASC, `orario_hora_desde` ASC, `orario_hora_hasta` ASC);

CREATE INDEX `fk_sucursal_has_orario_sucursal1_idx` ON `sucursal_orario` (`sucursal_id_sucursal` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ciudad`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `ciudad` (`id_ciudad`, `nombre`) VALUES (1, 'Buenos Aires');
INSERT INTO `ciudad` (`id_ciudad`, `nombre`) VALUES (2, 'Rosario');
INSERT INTO `ciudad` (`id_ciudad`, `nombre`) VALUES (3, 'La Plata');
INSERT INTO `ciudad` (`id_ciudad`, `nombre`) VALUES (4, 'Bariloche');

COMMIT;


-- -----------------------------------------------------
-- Data for table `direccion`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (1, 1, 'Lavalle', '1544', '2f');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (2, 1, 'Guemes', '2450', '1');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (3, 1, 'Libertad', '345', '6');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (4, 1, 'Corrientes', '1500', '3');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (5, 2, 'Lenina', '34', '3');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (6, 1, 'Pacheco', '55', '4');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (7, 1, 'Lavelle', '356', '6');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (8, 1, 'Libertad', '4', '5');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (9, 3, 'Malinovscogo', '5', '40');
INSERT INTO `direccion` (`id_direccion`, `ciudad_id_ciudad`, `calle`, `edificio`, `depto`) VALUES (10, 4, 'Pasco', '1', '2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rol`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES (1, 'Administrador');
INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES (2, 'Cajero');
INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES (3, 'Jefe');
INSERT INTO `rol` (`id_rol`, `nombre_rol`) VALUES (4, 'Recaudador');

COMMIT;


-- -----------------------------------------------------
-- Data for table `empleado`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (1, '2325325', 'Goga Andrey', '1166994323', 9, 2);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (2, '434314314', 'Alisa Milei', '1133455666', 1, 2);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (3, '1435245', 'Mijael Shumajer', '1166923759', 2, 2);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (4, '477878', 'Mujamed Ali', '1166093345', 1, 3);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (5, '245245', 'Pasha Volya', '79148778766', 8, 2);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (6, '7833', 'Kristina Kishner', '11078349875', 3, 4);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (7, '46352', 'Jorg Bush', '32446534767', 4, 2);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (8, '5658900', 'Messi Glebovich', '11345456777', 5, 3);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (9, '0467774', 'Sabrina Lugo', '11456456777', 6, 2);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (10, '345356', 'Donald Tramp', '16475875844', 7, 1);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (11, '64379212', 'Gleb Ursol', '1166927347', 10, 1);
INSERT INTO `empleado` (`id_empleado`, `num_pass`, `nombre`, `telefono`, `direccion_id_direccion`, `rol_id_rol`) VALUES (12, '579765722', 'Eva Peron', '11057857353', 10, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `contrato`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (1, 1, '2024-09-01', '2024-10-01', 'bien', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (2, 2, '2024-09-01', '2024-11-01', 'mas o menos', 7);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (3, 3, '2024-09-01', '2024-10-01', 'tonto', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (4, 4, '2024-09-01', '2024-10-01', 'fumador', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (5, 5, '2024-09-01', NULL, 'bien', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (6, 6, '2024-09-01', NULL, 'bien', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (7, 7, '2024-09-01', NULL, 'siempre llega tarde', 8);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (8, 8, '2024-09-01', NULL, 'bien', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (9, 9, '2024-09-01', NULL, 'bien', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (10, 10, '2024-09-01', NULL, 'bien', 10);
INSERT INTO `contrato` (`id_contr`, `empleado_id_empleado`, `fecha_inicio`, `fecha_termin`, `caracter`, `puntos`) VALUES (11, 11, '2024-09-01', NULL, 'bien', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sucursal`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `sucursal` (`id_sucursal`, `nombre`, `telefono`, `email`, `direccion_id_direccion`) VALUES (1, 'Congreso', '1100334049', 'mail@big.com', 1);
INSERT INTO `sucursal` (`id_sucursal`, `nombre`, `telefono`, `email`, `direccion_id_direccion`) VALUES (2, 'Tigre', '11039399', 'fregat@mail.ru', 2);
INSERT INTO `sucursal` (`id_sucursal`, `nombre`, `telefono`, `email`, `direccion_id_direccion`) VALUES (3, 'Lavalle', '11668983735', 'lavalle@mail.ru', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `caja`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `caja` (`id_caja`, `sucursal_id_sucursal`, `nombre`) VALUES (1, 1, 'caja congreso');
INSERT INTO `caja` (`id_caja`, `sucursal_id_sucursal`, `nombre`) VALUES (2, 2, 'caja tigre');
INSERT INTO `caja` (`id_caja`, `sucursal_id_sucursal`, `nombre`) VALUES (3, NULL, 'caja3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `turno_trabajo`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (1, 1, 1, '2025-03-01 09:20:04', '2025-03-01 19:00:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (2, 1, 1, '2025-03-02 09:10:04', '2025-03-02 19:10:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (3, 1, 1, '2025-03-03 09:09:04', '2025-03-03 20:09:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (4, 1, 1, '2025-03-04 09:10:04', '2025-03-04 19:10:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (5, 1, 1, '2025-03-05 09:10:04', '2025-03-05 19:10:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (6, 1, 1, '2025-03-06 09:10:04', '2025-03-06 19:10:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (7, 1, 1, '2025-03-07 09:10:04', '2025-03-07 19:10:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (8, 2, 1, '2025-03-08 09:10:04', '2025-03-08 19:10:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (9, 2, 1, '2025-03-09 09:10:04', '2025-03-09 19:10:04');
INSERT INTO `turno_trabajo` (`id_turno_trabajo`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (10, 2, 1, '2025-03-10 09:00:04', '2025-03-10 20:00:04');

COMMIT;


-- -----------------------------------------------------
-- Data for table `horario_turno`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (1, 1, 1, '2025-03-01 09:00:00', '2025-03-01 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (2, 1, 1, '2025-03-02 09:00:00', '2025-03-02 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (3, 1, 1, '2025-03-03 09:00:00', '2025-03-03 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (4, 1, 1, '2025-03-04 09:00:00', '2025-03-04 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (5, 1, 1, '2025-03-05 09:00:00', '2025-03-05 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (6, 1, 1, '2025-03-06 09:00:00', '2025-03-06 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (7, 1, 1, '2025-03-07 09:00:00', '2025-03-07 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (8, 1, 1, '2025-03-08 09:00:00', '2025-03-08 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (9, 1, 1, '2025-03-09 09:00:00', '2025-03-09 19:00:00');
INSERT INTO `horario_turno` (`id_horario_turno`, `empleado_id_empleado`, `caja_id_caja`, `fecha_hora_inicio`, `fecha_hora_cierra`) VALUES (10, 1, 1, '2025-03-10 09:00:00', '2025-03-10 19:00:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `nomina_sueldo`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (1, 2, '2025-03-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (2, 1, '2024-09-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (3, 1, '2024-10-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (4, 1, '2024-11-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (5, 1, '2024-12-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (6, 1, '2025-01-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (7, 1, '2025-02-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (8, 1, '2025-03-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (9, 1, '2025-04-01', NULL);
INSERT INTO `nomina_sueldo` (`id_nomina_sueldos`, `empleado_id_empleado`, `periodo`, `pagado`) VALUES (10, 1, '2025-05-01', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tarifa_individual`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (1, 100, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (2, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (3, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (4, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (5, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (6, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (7, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (8, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (9, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (10, 200, 8);
INSERT INTO `tarifa_individual` (`id_tarifa_individual`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (11, 200, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `servicio_prod`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (1, 'copia', 100);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (2, 'foto', 20);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (3, 'retoque', 100);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (4, 'CD', 200);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (5, 'Tasa con foto', 500);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (6, 'imprenta BN', 20);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (7, 'imprenta Color', 50);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (8, 'anillado', 200);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (9, 'plastificar', 110);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (10, 'cuaderno', 22);
INSERT INTO `servicio_prod` (`id_servicio_o_prod`, `nombre`, `precio`) VALUES (11, 'lapis', 500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `porcentaje_servisio`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (1, 1, 10);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (2, 2, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (3, 3, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (4, 4, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (5, 5, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (6, 6, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (7, 7, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (8, 8, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (9, 9, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (10, 10, 5);
INSERT INTO `porcentaje_servisio` (`id_porcentaje_servisio`, `servicio_prod_id_servicio_o_prod`, `porcentaje`) VALUES (11, 11, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `multa_premio`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (1, 1, '2025-03-01', 100, 'premio por ojos');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (2, 1, '2025-03-02', -300, 'llego tarde');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (3, 1, '2025-03-03', -100, 'llego tarde');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (4, 1, '2025-03-04', -100, 'llego tarde');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (5, 1, '2025-03-05', -100, 'llego tarde');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (6, 2, '2025-03-01', 200, 'horas extra');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (7, 2, '2025-03-02', 200, 'horas extra');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (8, 2, '2025-03-03', 200, 'horas extra');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (9, 2, '2025-03-04', -500, 'llego tarde');
INSERT INTO `multa_premio` (`id_multa_premio`, `empleado_id_empleado`, `fecha`, `monto`, `coment`) VALUES (10, 2, '2025-03-05', -550, 'llego tarde');

COMMIT;


-- -----------------------------------------------------
-- Data for table `movimiento`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (1, 1, '2024-11-03 10:00:04');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (2, 1, '2024-11-03 10:10:00');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (3, 1, '2024-11-03 13:10:00');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (4, 1, '2025-03-03 17:10:00');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (5, 1, '2025-03-02 11:10:00');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (6, 1, '2025-03-02 13:10:00');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (7, 1, '2025-03-02 14:10:00');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (8, 1, '2025-03-02 15:10:00');
INSERT INTO `movimiento` (`id_movimiento`, `caja_id_caja`, `fecha_hora`) VALUES (9, 1, '2025-03-03 15:10:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tipo_gasto`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `tipo_gasto` (`id_tipo_gasto`, `nombre`) VALUES (1, 'provedores');
INSERT INTO `tipo_gasto` (`id_tipo_gasto`, `nombre`) VALUES (2, 'limpiesa');
INSERT INTO `tipo_gasto` (`id_tipo_gasto`, `nombre`) VALUES (3, 'otro');

COMMIT;


-- -----------------------------------------------------
-- Data for table `gasto`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `gasto` (`movimiento_id_movimiento`, `tipo_gasto_id_tipo_gasto`, `discript`) VALUES (3, 1, 'Compramos papel');
INSERT INTO `gasto` (`movimiento_id_movimiento`, `tipo_gasto_id_tipo_gasto`, `discript`) VALUES (4, 1, 'Compramos agua');

COMMIT;


-- -----------------------------------------------------
-- Data for table `detalle_de_pago`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (1, 2, '123456789', 'tinkoff', 'Grilla Pepe', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (2, 3, '8765432', 'naranja', 'Dunkan Maklaud', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (3, 1, '476938386', 'mercado pago', 'Magnum Pepe', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (4, 4, '224859579', 'mercado pago', 'Sergio Mano', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (5, 5, '1326505858', 'mercado pago', 'Sergio Mano', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (6, 6, '957867645', 'mercado pago', 'Sergio Mano', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (7, 7, '98675647356', 'mercado pago', 'Sergio Mano', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (8, 8, '864753642', 'mercado pago', 'Sergio Mano', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (9, 9, '798675647', 'mercado pago', 'Sergio Mano', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (10, 10, '5247579356', 'mercado pago', 'Sergio Mano', 1);
INSERT INTO `detalle_de_pago` (`id_detalle_de_pago`, `empleado_id_empleado`, `tarjeta`, `banco`, `nombre_destino`, `por_defecto`) VALUES (11, 11, '2463737357', 'mercado pago', 'Sergio Mano', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `metodo_de_pago`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `metodo_de_pago` (`id_metodo_de_pago`, `nombre`) VALUES (1, 'efectivo');
INSERT INTO `metodo_de_pago` (`id_metodo_de_pago`, `nombre`) VALUES (2, 'tarjeta');
INSERT INTO `metodo_de_pago` (`id_metodo_de_pago`, `nombre`) VALUES (3, 'transferencia');

COMMIT;


-- -----------------------------------------------------
-- Data for table `cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (1, 'Petuj', '1194388842');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (2, 'Mask', '1166923345');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (3, 'Putin', '1166927345');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (4, 'Milei', '1166923344');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (5, 'Goga', '1143535656');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (6, 'Anton', '1107543456');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (7, 'Denis', '7922454566');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (8, 'Maksim', '7923345356');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (9, 'Petrov', '1143565656');
INSERT INTO `cliente` (`id_cliente`, `nombre`, `telefono`) VALUES (10, 'Eugenio', '1145477777');

COMMIT;


-- -----------------------------------------------------
-- Data for table `venta`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `venta` (`movimiento_id_movimiento`, `cliente_id_cliente`, `empleado_id_empleado`) VALUES (1, 2, 1);
INSERT INTO `venta` (`movimiento_id_movimiento`, `cliente_id_cliente`, `empleado_id_empleado`) VALUES (2, 3, 1);
INSERT INTO `venta` (`movimiento_id_movimiento`, `cliente_id_cliente`, `empleado_id_empleado`) VALUES (6, 1, 1);
INSERT INTO `venta` (`movimiento_id_movimiento`, `cliente_id_cliente`, `empleado_id_empleado`) VALUES (7, 2, 2);
INSERT INTO `venta` (`movimiento_id_movimiento`, `cliente_id_cliente`, `empleado_id_empleado`) VALUES (8, 3, 2);
INSERT INTO `venta` (`movimiento_id_movimiento`, `cliente_id_cliente`, `empleado_id_empleado`) VALUES (9, 1, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sacar_dinero`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `sacar_dinero` (`movimiento_id_movimiento`, `empleado_id_empleado`) VALUES (5, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tarifa_por_experiencia`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `tarifa_por_experiencia` (`id_tarifa_por_experiencia`, `cantidad_horas`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (1, 0, 100, 5);
INSERT INTO `tarifa_por_experiencia` (`id_tarifa_por_experiencia`, `cantidad_horas`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (2, 30, 120, 7);
INSERT INTO `tarifa_por_experiencia` (`id_tarifa_por_experiencia`, `cantidad_horas`, `tarifa_por_hora`, `porcentaje_de_ventas`) VALUES (3, 60, 150, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `fecha_tarifa_por_experiencia`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `fecha_tarifa_por_experiencia` (`tarifa_por_experiencia_id_tarifa_por_experiencia`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 2, '2024-10-01');
INSERT INTO `fecha_tarifa_por_experiencia` (`tarifa_por_experiencia_id_tarifa_por_experiencia`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 3, '2024-10-01');
INSERT INTO `fecha_tarifa_por_experiencia` (`tarifa_por_experiencia_id_tarifa_por_experiencia`, `empleado_id_empleado`, `fecha_desde`) VALUES (2, 4, '2024-10-01');
INSERT INTO `fecha_tarifa_por_experiencia` (`tarifa_por_experiencia_id_tarifa_por_experiencia`, `empleado_id_empleado`, `fecha_desde`) VALUES (2, 1, '2024-10-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `fecha_porcentaje_servisio`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 1, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 2, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 3, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 4, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 5, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 6, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 7, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 8, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 9, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 10, '2024-05-01');
INSERT INTO `fecha_porcentaje_servisio` (`porcentaje_servisio_id_porcentaje_servisio`, `empleado_id_empleado`, `fecha_desde`) VALUES (1, 11, '2024-05-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `detalle_venta`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `detalle_venta` (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`, `cantidad`, `precio_unitario`) VALUES (1, 1, 2, 200);
INSERT INTO `detalle_venta` (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`, `cantidad`, `precio_unitario`) VALUES (1, 2, 1, 100);
INSERT INTO `detalle_venta` (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`, `cantidad`, `precio_unitario`) VALUES (2, 4, 1, 400);
INSERT INTO `detalle_venta` (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`, `cantidad`, `precio_unitario`) VALUES (6, 1, 1, 10);
INSERT INTO `detalle_venta` (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`, `cantidad`, `precio_unitario`) VALUES (7, 2, 1, 20);
INSERT INTO `detalle_venta` (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`, `cantidad`, `precio_unitario`) VALUES (8, 3, 1, 100);
INSERT INTO `detalle_venta` (`venta_movimiento_id_movimiento`, `servicio_prod_id_servicio_o_prod`, `cantidad`, `precio_unitario`) VALUES (9, 1, 2, 200);

COMMIT;


-- -----------------------------------------------------
-- Data for table `combo_metodos_pago`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (1, 1, 50);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (1, 3, 50);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (2, 2, 200);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (3, 1, 44);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (4, 1, 60);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (5, 1, 100);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (6, 1, 10);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (7, 1, 20);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (8, 1, 100);
INSERT INTO `combo_metodos_pago` (`movimiento_id_movimiento`, `metodo_de_pago_id_metodo_de_pago`, `monto`) VALUES (9, 1, 200);

COMMIT;


-- -----------------------------------------------------
-- Data for table `hora`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `hora` (`id_hora`, `hora`) VALUES (1, '9:00');
INSERT INTO `hora` (`id_hora`, `hora`) VALUES (2, '19:00');
INSERT INTO `hora` (`id_hora`, `hora`) VALUES (3, '10:00');
INSERT INTO `hora` (`id_hora`, `hora`) VALUES (4, '18:00');

COMMIT;


-- -----------------------------------------------------
-- Data for table `dia`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `dia` (`id_dia`, `dia`) VALUES (1, 'Lunes');
INSERT INTO `dia` (`id_dia`, `dia`) VALUES (2, 'Martes');
INSERT INTO `dia` (`id_dia`, `dia`) VALUES (3, 'Miercoles');
INSERT INTO `dia` (`id_dia`, `dia`) VALUES (4, 'Jueves');
INSERT INTO `dia` (`id_dia`, `dia`) VALUES (5, 'Viernes');
INSERT INTO `dia` (`id_dia`, `dia`) VALUES (6, 'Sabado');
INSERT INTO `dia` (`id_dia`, `dia`) VALUES (7, 'Domingo');

COMMIT;


-- -----------------------------------------------------
-- Data for table `orario`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (1, 1, 2);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (2, 1, 2);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (3, 1, 2);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (4, 1, 2);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (5, 1, 2);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (6, 1, 2);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (7, 1, 2);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (6, 3, 4);
INSERT INTO `orario` (`dia_id_dia`, `hora_desde`, `hora_hasta`) VALUES (7, 3, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sucursal_orario`
-- -----------------------------------------------------
START TRANSACTION;
USE `sueldo`;
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (1, 1, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (1, 2, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (1, 3, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (1, 4, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (1, 5, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (2, 1, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (2, 2, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (2, 3, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (2, 4, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (2, 5, 1, 2);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (2, 6, 3, 4);
INSERT INTO `sucursal_orario` (`sucursal_id_sucursal`, `orario_dia_id_dia`, `orario_hora_desde`, `orario_hora_hasta`) VALUES (2, 7, 3, 4);

COMMIT;

