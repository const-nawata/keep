SELECT * FROM `clients_view`;

/*
delimiter //
--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------


DROP TRIGGER IF EXISTS `manager_bfr_ins`//
CREATE TRIGGER `manager_bfr_ins` BEFORE INSERT ON `managers` FOR EACH ROW
BEGIN
	INSERT INTO `logins` ( `logins`.`login` )VALUES( new.`login` );
END//
--	-------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS `manager_bfr_del`//
CREATE TRIGGER `manager_bfr_del` BEFORE DELETE ON `managers` FOR EACH ROW
BEGIN
	DELETE FROM `logins` WHERE `logins`.`login` = old.`login`;
  DELETE FROM `departments` WHERE `departments`.`manager_id` = old.`id`;
END//
--	-------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS `client_bfr_ins`//
CREATE TRIGGER `client_bfr_ins` BEFORE INSERT ON `clients` FOR EACH ROW
BEGIN
	INSERT INTO `logins` ( `logins`.`login` )VALUES( new.`login` );
END//
--	-------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS `client_bfr_del`//
CREATE TRIGGER `client_bfr_del` BEFORE DELETE ON `clients` FOR EACH ROW
BEGIN
	DELETE FROM `logins` WHERE `logins`.`login` = old.`login`;
END//
--	-------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW `managers_view` AS
	SELECT	`managers`.`id` AS `id`,
			`managers`.`firstname` AS `firstname`,
			`managers`.`surname` AS `surname`,
			`managers`.`email` AS `email`,
			`managers`.`info` AS `info`,
			CONCAT( `cities`.`name`, ', ', `countries`.`name` ) AS `city_country`
	FROM	`managers`
	LEFT JOIN `cities` ON `cities`.`id` = `managers`.`city_id`
	LEFT JOIN `countries` ON `countries`.id = `cities`.`country_id`
	WHERE `managers`.`level` = 'manager'//
--	-------------------------------------------------------------------------------------------------
*/





/*
CREATE OR REPLACE VIEW `departments_view` AS
	SELECT	`departments`.`id` AS `id`,
			`departments`.`info` AS `info`,
       TRIM( LEADING ', ' FROM CONCAT( TRIM( CONCAT( `managers`.`surname`, ' ', `managers`.`firstname` ) ), ', ', `cities`.`name` ) ) AS `manager`
	FROM	`departments`
	LEFT JOIN `managers` ON `managers`.`id` = `departments`.`manager_id`
  LEFT JOIN `cities` ON `cities`.`id` = `managers`.`city_id`//
--	-------------------------------------------------------------------------------------------------
*/

/*
CREATE OR REPLACE VIEW `depts_view` AS
	SELECT	`departments`.`id` AS `id`,
      `departments`.`name` AS `name`,
			`departments`.`info` AS `info`,
       TRIM( LEADING ', ' FROM CONCAT( TRIM( CONCAT( `managers`.`surname`, ' ', `managers`.`firstname` ) ), ', ', `cities`.`name` ) ) AS `manager`
	FROM	`departments`
	LEFT JOIN `managers` ON `managers`.`id` = `departments`.`manager_id`
  LEFT JOIN `cities` ON `cities`.`id` = `managers`.`city_id`//
--	-------------------------------------------------------------------------------------------------
*/

/*
CREATE OR REPLACE VIEW `admins_view` AS
	SELECT	`managers`.`id` AS `id`,
			`managers`.`firstname` AS `firstname`,
			`managers`.`surname` AS `surname`,
			`managers`.`email` AS `email`,
			`managers`.`info` AS `info`,
			CONCAT( `cities`.`name`, ', ', `countries`.`name` ) AS `city_country`
	FROM	`managers`
	LEFT JOIN `cities` ON `cities`.`id` = `managers`.`city_id`
	LEFT JOIN `countries` ON `countries`.id = `cities`.`country_id`
	WHERE `managers`.`level` = 'admin'//
--	-------------------------------------------------------------------------------------------------
*/


	/*
CREATE OR REPLACE VIEW `login_info` AS
	SELECT `logins`.`login` AS `login`,
			`managers`.`id` AS `id`,
			`managers`.`level` AS `level`,
			`managers`.`password` AS `password`
	FROM `managers`, `logins`
	WHERE `managers`.`login` = `logins`.`login`
-- 	LEFT JOIN `logins` ON `managers`.`login` = `logins`.`login`

	UNION ALL

	SELECT `logins`.`login` AS `login`,
			`clients`.`id` AS `id`,
			'client' AS `level`,
			`clients`.`password` AS `password`
	FROM `clients`, `logins`
	WHERE `clients`.`login` = `logins`.`login`//
-- 	LEFT JOIN `logins` ON `clients`.`login_id` = `logins`.`id`//
--	-------------------------------------------------------------------------------------------------
*/


-- DROP TRIGGER IF EXISTS `put_deleted_manager_after`//
/*CREATE TRIGGER `put_deleted_manager_after` AFTER DELETE ON `users` FOR EACH ROW
BEGIN
	IF old.`level` = 'manager' THEN
		INSERT INTO `deleted_managers` ( `deleted_managers`.`user_id` )VALUES( old.`id` );
	END IF;
END//
--	-------------------------------------------------------------------------------------------------
*/
-- DROP EVENT IF EXISTS `event_delete_clients`// -- DROP
-- DROP EVENT IF EXISTS `manager_deletion_cleaner_event`// -- DROP
/*CREATE EVENT `manager_deletion_cleaner_event` ON SCHEDULE 
-- 	EVERY 1 MINUTE COMMENT 'deletes clients and thares views for deleted managers' DO
	EVERY 10 SECOND COMMENT 'deletes clients and theirs views for deleted managers' DO
BEGIN
	DECLARE `manager_id` INT DEFAULT 0;
	DECLARE done INT DEFAULT 0;

	DECLARE cur1 CURSOR FOR
		SELECT `deleted_managers`.`user_id` FROM `deleted_managers`;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;


	OPEN cur1;
	FETCH cur1 INTO `manager_id`;
	WHILE NOT done DO
		DELETE FROM `users` WHERE `users`.`owner_id` = `manager_id`;




		FETCH cur1 INTO `manager_id`;
	END WHILE;

	DELETE FROM `deleted_managers`;

END//
-- -------------------------------------------------------------------------------------------------
*/



--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------
--	-------------------------------------------------------------------------------------------------



/*

SELECT `clients`.`id` AS `id`
       , `firstname`
     , `surname`
     , `city_id`
     , `cities`.`name` AS `city`
     , `cities`.`country_id` AS `country_id`
     , `countries`.`name` AS `country`
     , `info`
     , `password`
     , `login`
     , `email`
FROM  `clients`
LEFT JOIN `cities` ON `city_id` = `cities`.`id`
LEFT JOIN `countries` ON `countries`.`id` = `cities`.`country_id`

WHERE   `clients`.`id` = 0;
*/



-- 
--  Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */;



delimiter ;



DROP TABLE IF EXISTS goods;
CREATE TABLE goods(
	id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(50) DEFAULT NULL,
	cku VARCHAR(20) DEFAULT NULL COMMENT 'Article',
	in_pack INT(10) UNSIGNED NOT NULL DEFAULT 0,
	unit_id INT(10) UNSIGNED DEFAULT NULL,
	ex_price DOUBLE(15, 3) UNSIGNED NOT NULL DEFAULT 0.000 COMMENT 'Ex-Factory Price (опт)',
	rt_price DOUBLE(15, 3) UNSIGNED NOT NULL DEFAULT 0.000 COMMENT 'Retail Price (розница)',
	img_name VARCHAR(20) DEFAULT NULL,
	img_height INT(3) DEFAULT NULL,
	img_width INT(3) DEFAULT NULL,
	PRIMARY KEY (id),
	UNIQUE INDEX id (id),
	CONSTRAINT goods_unit_FK FOREIGN KEY (unit_id)
	REFERENCES keep.units (id) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8
COLLATE utf8_unicode_ci;


-- 
--  Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
