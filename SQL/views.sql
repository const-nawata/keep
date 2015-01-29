DELIMITER //
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------


CREATE OR REPLACE VIEW `users_view` AS
SELECT `users`.`id` AS `id`
	, `users`.`level` AS `level`
	 , `users`.`firstname` AS `firstname`
	 , `users`.`surname` AS `surname`
	 , `users`.`city_id` AS `city_id`
	 ,`cities`.`name` AS `city`
	 ,`cities`.`country_id` AS `country_id`
	 ,`countries`.`name` AS `country`
	 , `users`.`info` AS `info`
	 , `users`.`password` AS `password`
	 , `users`.`login` AS `login`
	 , `users`.`email` AS `email`
	 , concat(`cities`.`name`, ', ', `countries`.`name`) AS `city_country`
FROM `users`
LEFT JOIN `cities` ON `cities`.`id` = `users`.`city_id`
LEFT JOIN `countries` ON `countries`.`id` = `cities`.`country_id`//
--	----------------------------------------------------------------------------

CREATE OR REPLACE VIEW `clients_view` AS
SELECT * FROM `users_view` WHERE `level`='client'//
--	----------------------------------------------------------------------------

CREATE OR REPLACE VIEW `managers_view` AS
SELECT * FROM `users_view` WHERE `level`='manager'//
--	----------------------------------------------------------------------------

CREATE OR REPLACE VIEW cities_view AS
SELECT `cities`.`id` AS `id`
	 , `cities`.`name` AS `name`
	, `countries`.`id` AS `country_id`
	 , `countries`.`name` AS `country`
FROM `cities`
LEFT JOIN `countries` ON `countries`.`id`=`cities`.`country_id`//
--	----------------------------------------------------------------------------

CREATE OR REPLACE VIEW `goods_view` AS
SELECT `goods`.`id` AS `id`
	, `goods`.`name` AS `name`
	, `goods`.`cku` AS `cku`
	, `getGoodCatsIds`(`goods`.`id`) AS `cat_names`
	, `getGoodCatsNames`(`goods`.`id`) AS `cat_ids`

FROM `goods`//
--	----------------------------------------------------------------------------


--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
DELIMITER ;