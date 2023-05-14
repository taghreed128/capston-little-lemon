-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Little_Lemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Little_Lemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Little_Lemon` DEFAULT CHARACTER SET utf8 ;
USE `Little_Lemon` ;

-- -----------------------------------------------------
-- Table `Little_Lemon`.`weight_unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`weight_unit` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`weight_unit` (
  `weight_unit_id` TINYINT NOT NULL AUTO_INCREMENT,
  `weight_unit_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`weight_unit_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`item_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`item_type` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`item_type` (
  `item_type_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `item_type_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`item_subtype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`item_subtype` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`item_subtype` (
  `item_subtype_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `item_subtype_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `item_type_item_type_id` SMALLINT NOT NULL,
  PRIMARY KEY (`item_subtype_id`),
  INDEX `fk_item_subtype_item_type1_idx` (`item_type_item_type_id` ASC),
  CONSTRAINT `fk_item_subtype_item_type1`
    FOREIGN KEY (`item_type_item_type_id`)
    REFERENCES `Little_Lemon`.`item_type` (`item_type_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`supplier` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`supplier` (
  `supplier_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `supplier_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`brand` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`brand` (
  `brand_id` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(200) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `supplier_supplier_id` SMALLINT NOT NULL,
  PRIMARY KEY (`brand_id`),
  INDEX `fk_brand_supplier1_idx` (`supplier_supplier_id` ASC),
  CONSTRAINT `fk_brand_supplier1`
    FOREIGN KEY (`supplier_supplier_id`)
    REFERENCES `Little_Lemon`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`item` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `weight_unit_weight_unit_id` TINYINT NOT NULL,
  `item_subtype_item_subtype_id` SMALLINT NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `brand_brand_id` MEDIUMINT NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_item_weight_unit1_idx` (`weight_unit_weight_unit_id` ASC),
  INDEX `fk_item_item_subtype1_idx` (`item_subtype_item_subtype_id` ASC),
  INDEX `fk_item_brand1_idx` (`brand_brand_id` ASC),
  CONSTRAINT `fk_item_weight_unit1`
    FOREIGN KEY (`weight_unit_weight_unit_id`)
    REFERENCES `Little_Lemon`.`weight_unit` (`weight_unit_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_item_subtype1`
    FOREIGN KEY (`item_subtype_item_subtype_id`)
    REFERENCES `Little_Lemon`.`item_subtype` (`item_subtype_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_item_brand1`
    FOREIGN KEY (`brand_brand_id`)
    REFERENCES `Little_Lemon`.`brand` (`brand_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`inventory` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`inventory` (
  `inventory_id` INT NOT NULL AUTO_INCREMENT,
  `inventory_quantity` SMALLINT NOT NULL,
  `inventory_min` SMALLINT NOT NULL,
  `inventory_max` SMALLINT NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `item_item_id` INT NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_inventory_item1_idx` (`item_item_id` ASC),
  CONSTRAINT `fk_inventory_item1`
    FOREIGN KEY (`item_item_id`)
    REFERENCES `Little_Lemon`.`item` (`item_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`provance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`provance` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`provance` (
  `provance_id` TINYINT NOT NULL AUTO_INCREMENT,
  `provance_name` VARCHAR(45) NOT NULL,
  `provance_abbreviation` VARCHAR(2) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`provance_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`city` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `provance_provance_id` TINYINT NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_provance1_idx` (`provance_provance_id` ASC),
  CONSTRAINT `fk_city_provance1`
    FOREIGN KEY (`provance_provance_id`)
    REFERENCES `Little_Lemon`.`provance` (`provance_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`street`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`street` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`street` (
  `street_id` INT NOT NULL AUTO_INCREMENT,
  `street_name` VARCHAR(45) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`street_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`zip_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`zip_code` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`zip_code` (
  `zip_code_id` BIGINT NOT NULL AUTO_INCREMENT,
  `zip_code` VARCHAR(45) NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `city_city_id` INT NOT NULL,
  `street_street_id` INT NOT NULL,
  PRIMARY KEY (`zip_code_id`),
  INDEX `fk_zip_code_city1_idx` (`city_city_id` ASC),
  INDEX `fk_zip_code_street1_idx` (`street_street_id` ASC),
  CONSTRAINT `fk_zip_code_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `Little_Lemon`.`city` (`city_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_zip_code_street1`
    FOREIGN KEY (`street_street_id`)
    REFERENCES `Little_Lemon`.`street` (`street_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`address` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `isActive` TINYINT(1) NULL,
  `street_number` VARCHAR(5) NOT NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `supplier_supplier_id` SMALLINT NOT NULL,
  `zip_code_zip_code_id` BIGINT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_supplier1_idx` (`supplier_supplier_id` ASC),
  INDEX `fk_address_zip_code1_idx` (`zip_code_zip_code_id` ASC),
  CONSTRAINT `fk_address_supplier1`
    FOREIGN KEY (`supplier_supplier_id`)
    REFERENCES `Little_Lemon`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_address_zip_code1`
    FOREIGN KEY (`zip_code_zip_code_id`)
    REFERENCES `Little_Lemon`.`zip_code` (`zip_code_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`area_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`area_code` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`area_code` (
  `area_code_id` TINYINT NOT NULL AUTO_INCREMENT,
  `area_code` SMALLINT(3) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `provance_provance_id` TINYINT NOT NULL,
  PRIMARY KEY (`area_code_id`),
  INDEX `fk_area_code_provance1_idx` (`provance_provance_id` ASC),
  CONSTRAINT `fk_area_code_provance1`
    FOREIGN KEY (`provance_provance_id`)
    REFERENCES `Little_Lemon`.`provance` (`provance_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`phone_number`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`phone_number` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`phone_number` (
  `phone_number_id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` VARCHAR(22) NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `supplier_supplier_id` SMALLINT NOT NULL,
  `area_code_area_code_id` TINYINT NOT NULL,
  PRIMARY KEY (`phone_number_id`),
  INDEX `fk_phone_number_supplier1_idx` (`supplier_supplier_id` ASC),
  INDEX `fk_phone_number_area_code1_idx` (`area_code_area_code_id` ASC),
  CONSTRAINT `fk_phone_number_supplier1`
    FOREIGN KEY (`supplier_supplier_id`)
    REFERENCES `Little_Lemon`.`supplier` (`supplier_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_phone_number_area_code1`
    FOREIGN KEY (`area_code_area_code_id`)
    REFERENCES `Little_Lemon`.`area_code` (`area_code_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`price` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`price` (
  `price_id` INT NOT NULL AUTO_INCREMENT,
  `item_item_id` INT NOT NULL,
  `price_tag` DECIMAL NOT NULL,
  `isActive` TINYINT(1) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`price_id`),
  INDEX `fk_price_item1_idx` (`item_item_id` ASC),
  CONSTRAINT `fk_price_item1`
    FOREIGN KEY (`item_item_id`)
    REFERENCES `Little_Lemon`.`item` (`item_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`order` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`feedback` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`feedback` (
  `feedback_id` INT NOT NULL AUTO_INCREMENT,
  `feedback_text` VARCHAR(900) NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `order_order_id` INT NOT NULL,
  PRIMARY KEY (`feedback_id`),
  INDEX `fk_feedback_order1_idx` (`order_order_id` ASC),
  CONSTRAINT `fk_feedback_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `Little_Lemon`.`order` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`order_has_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Little_Lemon`.`order_has_item` ;

CREATE TABLE IF NOT EXISTS `Little_Lemon`.`order_has_item` (
  `quantity` SMALLINT NOT NULL,
  `date_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `price_price_id` INT NOT NULL,
  `order_order_id` INT NOT NULL,
  PRIMARY KEY (`price_price_id`, `order_order_id`),
  INDEX `fk_order_has_item_order1_idx` (`order_order_id` ASC),
  CONSTRAINT `fk_order_has_item_price1`
    FOREIGN KEY (`price_price_id`)
    REFERENCES `Little_Lemon`.`price` (`price_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_has_item_order1`
    FOREIGN KEY (`order_order_id`)
    REFERENCES `Little_Lemon`.`order` (`order_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
