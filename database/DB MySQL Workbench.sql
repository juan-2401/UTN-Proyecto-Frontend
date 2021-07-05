drop database adopcion;

create database adopcion;

use adopcion;


-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Adopcion
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Adopcion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Adopcion` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema adopcion
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema adopcion
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `adopcion` DEFAULT CHARACTER SET utf8 ;
USE `Adopcion` ;

-- -----------------------------------------------------
-- Table `Adopcion`.`Adoptantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Adopcion`.`Adoptantes` (
  `idAdoptante` INT NOT NULL AUTO_INCREMENT,
  `nombreAdoptante` VARCHAR(45) NOT NULL,
  `apellidoAdoptante` VARCHAR(45) NOT NULL,
  `mailAdoptante` VARCHAR(45) NOT NULL,
  `telefonoAdoptante` VARCHAR(45) NOT NULL,
  `direccionAdoptante` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdoptante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Adopcion`.`Mascotas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Adopcion`.`Mascotas` (
  `idMascota` INT NOT NULL AUTO_INCREMENT,
  `nombreMascota` VARCHAR(45) NOT NULL,
  `estadoMascota` VARCHAR(16) NOT NULL,
  `animalMascota` VARCHAR(5) NOT NULL,
  `nacimientoMascota` DATE NOT NULL,
  `sexoMascota` VARCHAR(1) NOT NULL,
  `Adoptantes_idAdpotantes` INT NOT NULL,
  PRIMARY KEY (`idMascota`, `Adoptantes_idAdpotantes`),
  INDEX `fk_Mascotas_Adoptantes_idx` (`Adoptantes_idAdpotantes` ASC) VISIBLE,
  CONSTRAINT `fk_Mascotas_Adoptantes`
    FOREIGN KEY (`Adoptantes_idAdpotantes`)
    REFERENCES `Adopcion`.`Adoptantes` (`idAdoptante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `adopcion` ;

-- -----------------------------------------------------
-- Table `adopcion`.`adoptantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adopcion`.`adoptantes` (
  `idAdpotantes` INT NOT NULL AUTO_INCREMENT,
  `nombreAdpotante` VARCHAR(45) NOT NULL,
  `apellidoAdpotantes` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdpotantes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `adopcion`.`mascotas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `adopcion`.`mascotas` (
  `idMascota` INT NOT NULL AUTO_INCREMENT,
  `nombreMascota` VARCHAR(45) NOT NULL,
  `estadoMascota` VARCHAR(16) NOT NULL,
  `animalMascota` VARCHAR(5) NOT NULL,
  `nacimientoMascota` DATE NOT NULL,
  `sexoMascota` VARCHAR(1) NOT NULL,
  `Adoptantes_idAdpotantes` INT NOT NULL,
  PRIMARY KEY (`idMascota`, `Adoptantes_idAdpotantes`),
  INDEX `fk_Mascotas_Adoptantes_idx` (`Adoptantes_idAdpotantes` ASC) VISIBLE,
  CONSTRAINT `fk_Mascotas_Adoptantes`
    FOREIGN KEY (`Adoptantes_idAdpotantes`)
    REFERENCES `adopcion`.`adoptantes` (`idAdpotantes`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;



--
-- Volcado de datos para la tabla `Adoptantes`
--

INSERT INTO `Adoptantes` (`idAdoptante`, `nombreAdoptante`, `apellidoAdoptante`, `mailAdoptante`, `telefonoAdoptante`, `direccionAdoptante`) VALUES
(001, 'Veterinaria', 'Patitas', 'patitas@veterinaria.com', '4551-3512', 'Calle Falsa 123'),
(002, 'Andrés', 'Acosta', 'a.acosta@gmail.com', '4553-0303', 'Av. Balsa 4123 B'),
(003, 'Gaston', 'Tesei', 'g.tesei@hotmail.com', '4552-5473', 'Calle Salsa 183 5B'),
(004, 'Carla', 'Paz', 'c.paz@gmail.com', '4788-7773', 'Av. Siempreviva 742 7H'),
(005, 'Mauro', 'Muñiz', 'm.muñiz@outlook.com', '4038-0838', 'Donato 9865 1A');


--
-- Volcado de datos para la tabla `Mascotas`
--

INSERT INTO `Mascotas` (`idMascota`, `nombreMascota`, `estadoMascota`, `animalMascota`, `nacimientoMascota`, `sexoMascota`, `mascotas`.`Adoptantes_idAdpotantes`) VALUES
(001, 'Pelusa', 'En Adopción', 'Gato', '2015-12-17', 'F', 001),
(002, 'Roxy', 'Adoptado', 'Perro', '2012-10-06', 'F', 002),
(003, 'Batata', 'Adoptado', 'Perro', '2014-02-20', 'M', 003),
(004, 'Nestor', 'Adoptado', 'Gato', '2013-10-03', 'M', 004),
(005, 'Buba', 'Adoptado', 'Gato', '2013-10-03', 'M', 004),
(006, 'Brisa', 'Adoptado', 'Perro', '2011-09-17', 'F', 005),
(007, 'Miel', 'En Adopción', 'Gato', '2017-05-25', 'F', 001),
(008, 'Albertina', 'Adoptado', 'Gato', '2018-01-16', 'F', 005),
(009, 'Denzel', 'En Adopción', 'Perro', '2019-03-09', 'M', 001);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
