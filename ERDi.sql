-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema modelDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema modelDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `modelDB` DEFAULT CHARACTER SET utf8 ;
USE `modelDB` ;

-- -----------------------------------------------------
-- Table `modelDB`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelDB`.`table1` (
  `num1` INT NOT NULL,
  PRIMARY KEY (`num1`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelDB`.`table2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelDB`.`table2` (
  `num2` INT NOT NULL,
  PRIMARY KEY (`num2`),
  CONSTRAINT `fk_table2_num2`
    FOREIGN KEY (`num2`)
    REFERENCES `modelDB`.`table1` (`num1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
