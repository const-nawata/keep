
-- 
--  Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;


DELIMITER //
--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS `users`//
CREATE TABLE `users`(
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `level` VARCHAR(10) DEFAULT 'client',
  `firstname` VARCHAR(50) DEFAULT 'Firstname',
  `surname` VARCHAR(50) DEFAULT 'Sirname',
  `city_id` INT(10) UNSIGNED DEFAULT NULL,
  `info` TEXT DEFAULT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `login` VARCHAR(20) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX id (id),
  UNIQUE INDEX login (login),
  INDEX user_city_FK (city_id),
  CONSTRAINT FK_users_cities_id FOREIGN KEY (city_id)
  REFERENCES cities (id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 1
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_unicode_ci//


INSERT INTO `users` (
	`id`,
	`level`,
	`firstname`,
	`surname`,
	`city_id`,
	`info`,
	`password`,
	`email`,
	`login`
)VALUES(
	1,
	'admin',
	'Administrator',
	'Roott',
	1,
	'Info for root',
	1,
	NULL,
	'root'
)//


DROP TABLE IF EXISTS `departments`//
CREATE TABLE departments(
	 id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	 `name` VARCHAR(50) DEFAULT NULL,
	 is_main TINYINT(1) NOT NULL DEFAULT 0,
	 info VARCHAR(1000) DEFAULT NULL,
	 PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_unicode_ci//


DROP VIEW IF EXISTS `login_info`//
DROP VIEW IF EXISTS `clients_2`//
DROP VIEW IF EXISTS `clients_6`//
DROP VIEW IF EXISTS `clients_7`//
DROP VIEW IF EXISTS `clients_8`//
DROP VIEW IF EXISTS `departments_2`//
DROP VIEW IF EXISTS `departments_6`//
DROP VIEW IF EXISTS `departments_7`//
DROP VIEW IF EXISTS `departments_8`//

DROP TABLE IF EXISTS `logins`//
DROP TABLE IF EXISTS `clients`//
DROP TABLE IF EXISTS `managers`//
DROP TABLE IF EXISTS `err_log`//


ALTER TABLE good_catigories DROP FOREIGN KEY good_catigoriy_good_FK//
ALTER TABLE good_catigories DROP INDEX good_catigoriy_good_FK//
ALTER TABLE good_catigories ADD CONSTRAINT good_catigoriy_good_FK
	FOREIGN KEY (good_id) REFERENCES goods(id) ON DELETE CASCADE ON UPDATE CASCADE//

ALTER TABLE goods CHANGE COLUMN img_name img_file VARCHAR(20) DEFAULT '' COMMENT 'Image dimensions is 200x110'//


--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------
DELIMITER ;


-- 
--  Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
