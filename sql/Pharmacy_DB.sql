-- MySQL Script generated by MySQL Workbench
-- Thu Apr  5 12:08:31 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pharmacy
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pharmacy
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pharmacy` DEFAULT CHARACTER SET utf8 ;
USE `pharmacy` ;

-- -----------------------------------------------------
-- Table `pharmacy`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`User` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(100) NULL DEFAULT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('client', 'admin', 'doctor') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`Order` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) NOT NULL,
  `date` DATE NOT NULL,
  `status` ENUM('paid', 'canceled', 'in_process') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Order_User1_idx` (`user_id` ASC),
  CONSTRAINT `fk_Order_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `pharmacy`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`Medicine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`Medicine` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `count_in_store` BIGINT(20) NOT NULL,
  `count` INT NOT NULL,
  `dosage_mg` INT NOT NULL,
  `need_prescription` TINYINT NOT NULL,
  `price` DECIMAL(10, 4) NOT NULL,
  `deleted` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`Prescription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`Prescription` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `doctor_id` BIGINT(20) NOT NULL,
  `user_id` BIGINT(20) NOT NULL,
  `medicine_id` BIGINT(20) NOT NULL,
  `creation_date` DATE NOT NULL,
  `expiration_date` DATE NOT NULL,
  `comment` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Prescription_User1_idx` (`doctor_id` ASC),
  INDEX `fk_Prescription_User2_idx` (`user_id` ASC),
  INDEX `fk_Prescription_Medicine1_idx` (`medicine_id` ASC),
  CONSTRAINT `fk_Prescription_User1`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `pharmacy`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescription_User2`
    FOREIGN KEY (`user_id`)
    REFERENCES `pharmacy`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescription_Medicine1`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `pharmacy`.`Medicine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`Request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`Request` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `doctor_id` BIGINT(20) NOT NULL,
  `prescription_id` BIGINT(20) NOT NULL,
  `status` ENUM('pending', 'approved', 'rejected') NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Request_User_idx` (`doctor_id` ASC),
  INDEX `fk_Request_Prescription1_idx` (`prescription_id` ASC),
  CONSTRAINT `fk_Request_User`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `pharmacy`.`User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Request_Prescription1`
    FOREIGN KEY (`prescription_id`)
    REFERENCES `pharmacy`.`Prescription` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pharmacy`.`Order_Medicine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pharmacy`.`Order_Medicine` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `medicine_id` BIGINT(20) NOT NULL,
  `order_id` BIGINT(20) NOT NULL,
  `count` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`, `medicine_id`, `order_id`),
  INDEX `fk_Medicine_has_Order_Order1_idx` (`order_id` ASC),
  INDEX `fk_Medicine_has_Order_Medicine1_idx` (`medicine_id` ASC),
  CONSTRAINT `fk_Medicine_has_Order_Medicine1`
    FOREIGN KEY (`medicine_id`)
    REFERENCES `pharmacy`.`Medicine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medicine_has_Order_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pharmacy`.`Order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
