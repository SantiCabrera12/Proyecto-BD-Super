-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema proyecto_bd_super
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema proyecto_bd_super
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `proyecto_bd_super` DEFAULT CHARACTER SET utf8 ;
USE `proyecto_bd_super` ;

-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`factura` (
  `id_factura` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_factura`));


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`cargo_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`cargo_laboral` (
  `id_cargo_laboral` INT NOT NULL AUTO_INCREMENT,
  `sueldo_mensual` DECIMAL NOT NULL,
  `cargo_laboral` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_cargo_laboral`));


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`empleados` (
  `legajo` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(60) NOT NULL,
  `apellidos` VARCHAR(60) NOT NULL,
  `nro_identificacion` VARCHAR(8) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `dirreccion` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `fecha_ingreso` DATE NOT NULL,
  `factura_id` INT NOT NULL,
  `cargo_laboral_id` INT NOT NULL,
  PRIMARY KEY (`legajo`),
  INDEX `fk_empleados_factura_idx` (`factura_id` ASC) VISIBLE,
  INDEX `fk_empleados_cargo_laboral_idx` (`cargo_laboral_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_factura`
    FOREIGN KEY (`factura_id`)
    REFERENCES `proyecto_bd_super`.`factura` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_cargo_laboral`
    FOREIGN KEY (`cargo_laboral_id`)
    REFERENCES `proyecto_bd_super`.`cargo_laboral` (`id_cargo_laboral`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`jornada_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`jornada_laboral` (
  `id_jornada` INT NOT NULL AUTO_INCREMENT,
  `hora_ingreso` DATETIME NOT NULL,
  `hora_salida` DATETIME NOT NULL,
  `empleados_id` INT NOT NULL,
  PRIMARY KEY (`id_jornada`),
  INDEX `fk_jordanda_laboral_empleados_idx` (`empleados_id` ASC) VISIBLE,
  CONSTRAINT `fk_jordanda_laboral_empleados`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `proyecto_bd_super`.`empleados` (`legajo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`tipo_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`tipo_producto` (
  `id_tipo_producto` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_tipo_producto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`pedidos` (
  `id_pedidos` INT NOT NULL AUTO_INCREMENT,
  `total` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_pedidos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`factura_compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`factura_compra` (
  `id_factura_compra` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(60) NOT NULL,
  `codigo` VARCHAR(10) NOT NULL,
  `total_compra` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `total` INT NOT NULL,
  PRIMARY KEY (`id_factura_compra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `factura_compra_id` INT NOT NULL,
  PRIMARY KEY (`id_proveedor`),
  INDEX `fk_proveedor_factura_compra_idx` (`factura_compra_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveedor_factura_compra`
    FOREIGN KEY (`factura_compra_id`)
    REFERENCES `proyecto_bd_super`.`factura_compra` (`id_factura_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`productos` (
  `id_productos` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL NOT NULL,
  `fecha_elaboracion` DATETIME NOT NULL,
  `fecha_vencimiento` DATETIME NOT NULL,
  `codigo` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `stock` INT NOT NULL,
  `pedidos_id` INT NOT NULL,
  `proveedor_id` INT NOT NULL,
  `tipo_producto_id` INT NOT NULL,
  PRIMARY KEY (`id_productos`),
  INDEX `fk_productos_pedidos_idx` (`pedidos_id` ASC) VISIBLE,
  INDEX `fk_productos_proveedor_idx` (`proveedor_id` ASC) VISIBLE,
  INDEX `fk_productos_tipo_producto_idx` (`tipo_producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_pedidos`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `proyecto_bd_super`.`pedidos` (`id_pedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_proveedor`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `proyecto_bd_super`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_tipo_producto`
    FOREIGN KEY (`tipo_producto_id`)
    REFERENCES `proyecto_bd_super`.`tipo_producto` (`id_tipo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`marca_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`marca_producto` (
  `id_marca_producto` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(60) NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`id_marca_producto`),
  INDEX `fk_marca_producto_productos_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_marca_producto_productos`
    FOREIGN KEY (`productos_id`)
    REFERENCES `proyecto_bd_super`.`productos` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`forma_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`forma_pago` (
  `id_forma_pago` INT NOT NULL AUTO_INCREMENT,
  `efectivo` INT NOT NULL,
  `tarjeta` INT NOT NULL,
  `factura_id` INT NOT NULL,
  PRIMARY KEY (`id_forma_pago`),
  INDEX `fk_forma_pago_factura_idx` (`factura_id` ASC) VISIBLE,
  CONSTRAINT `fk_forma_pago_factura`
    FOREIGN KEY (`factura_id`)
    REFERENCES `proyecto_bd_super`.`factura` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nro_identificacion` VARCHAR(45) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `telefono` VARCHAR(12) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `pedidos_id` INT NOT NULL,
  `factura_id` INT NOT NULL,
  `forma_pago_id` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_clientes_pedidos_idx` (`pedidos_id` ASC) VISIBLE,
  INDEX `fk_clientes_factura_idx` (`factura_id` ASC) VISIBLE,
  INDEX `fk_clientes_forma_pago_idx` (`forma_pago_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_pedidos`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `proyecto_bd_super`.`pedidos` (`id_pedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_factura`
    FOREIGN KEY (`factura_id`)
    REFERENCES `proyecto_bd_super`.`factura` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_forma_pago`
    FOREIGN KEY (`forma_pago_id`)
    REFERENCES `proyecto_bd_super`.`forma_pago` (`id_forma_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_bd_super`.`detalle_factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `proyecto_bd_super`.`detalle_factura` (
  `factura_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  INDEX `fk_detalle_factura_factura_idx` (`factura_id` ASC) VISIBLE,
  INDEX `fk_datelle_factura_productos_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_detalle_factura_factura`
    FOREIGN KEY (`factura_id`)
    REFERENCES `proyecto_bd_super`.`factura` (`id_factura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_datelle_factura_productos`
    FOREIGN KEY (`productos_id`)
    REFERENCES `proyecto_bd_super`.`productos` (`id_productos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
