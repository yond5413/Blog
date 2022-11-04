-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema blogdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blogdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blogdb` DEFAULT CHARACTER SET utf8 ;
USE `blogdb` ;

-- -----------------------------------------------------
-- Table `blogdb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blogdb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blogdb`.`post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blogdb`.`post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `content` LONGTEXT NOT NULL,
  `time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT NOT NULL,
  `approved` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `blogdb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blogdb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blogdb`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blogdb`.`post_has_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blogdb`.`post_has_category` (
  `post_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`post_id`, `category_id`),
  INDEX `fk_post_has_category_category1_idx` (`category_id` ASC),
  INDEX `fk_post_has_category_post_idx` (`post_id` ASC),
  CONSTRAINT `fk_post_has_category_post`
    FOREIGN KEY (`post_id`)
    REFERENCES `blogdb`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_has_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `blogdb`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `blogdb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `blogdb`;
INSERT INTO `blogdb`.`user` (`id`, `first_name`, `last_name`, `email`, `password`, `role`) VALUES (1, 'John', 'Doe', 'johndoe@gmail.com', 'admin', 'admin');
INSERT INTO `blogdb`.`user` (`id`, `first_name`, `last_name`, `email`, `password`, `role`) VALUES (2, 'Joe', 'Dirt', 'jdirt@hotmail.com', 'dirt2344', 'moderator');
INSERT INTO `blogdb`.`user` (`id`, `first_name`, `last_name`, `email`, `password`, `role`) VALUES (3, 'Bruce', 'Wayne', 'batman@batmail.com', 'gotham4ever', 'guest');
INSERT INTO `blogdb`.`user` (`id`, `first_name`, `last_name`, `email`, `password`, `role`) VALUES (4, 'Peter', 'Parker', 'auntmay@spiderguy.com', 'spiderpig', 'guest');

COMMIT;


-- -----------------------------------------------------
-- Data for table `blogdb`.`post`
-- -----------------------------------------------------
START TRANSACTION;
USE `blogdb`;
INSERT INTO `blogdb`.`post` (`id`, `title`, `content`, `time`, `user_id`, `approved`) VALUES (1, 'Test Post', 'New to the blog environment, but happy to release our first test blog post', '2021-12-08 02:25:28', 1, 1);
INSERT INTO `blogdb`.`post` (`id`, `title`, `content`, `time`, `user_id`, `approved`) VALUES (2, 'Will the PS5 be in stock for Christmas', 'Will the PS5 be up for grabs for Christmas 2021?', '2021-12-08 02:35:12', 2, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `blogdb`.`category`
-- -----------------------------------------------------
START TRANSACTION;
USE `blogdb`;
INSERT INTO `blogdb`.`category` (`id`, `category`) VALUES (1, 'Pop Culture');
INSERT INTO `blogdb`.`category` (`id`, `category`) VALUES (2, 'Politics');
INSERT INTO `blogdb`.`category` (`id`, `category`) VALUES (3, 'Gossip');
INSERT INTO `blogdb`.`category` (`id`, `category`) VALUES (4, 'Tech');

COMMIT;


-- -----------------------------------------------------
-- Data for table `blogdb`.`post_has_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `blogdb`;
INSERT INTO `blogdb`.`post_has_category` (`post_id`, `category_id`) VALUES (2, 4);

COMMIT;

