DELIMITER //
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------



DROP FUNCTION IF EXISTS `getGoodCatsNames`//
CREATE FUNCTION `getGoodCatsNames`(pGoodId INT(11))
  RETURNS text CHARSET utf8
  DETERMINISTIC
BEGIN
	DECLARE `cats_list` TEXT DEFAULT '';
	DECLARE `cat_name` VARCHAR(50);
	DECLARE `delim`	VARCHAR(2) DEFAULT ', ';
	DECLARE no_more_cats BOOLEAN;

	DECLARE cur1 CURSOR FOR
		SELECT `categories`.`name`
		FROM `good_catigories`
		LEFT JOIN `categories` ON `categories`.`id` = `good_catigories`.`category_id`
		WHERE `good_catigories`.`good_id`=pGoodId;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_cats = TRUE;

	OPEN cur1;

loop_cats:
	LOOP
		FETCH cur1 INTO `cat_name`;
   	
		IF( no_more_cats ) THEN
			SET `cats_list` = substr(`cats_list`,2);

       		CLOSE cur1;
            LEAVE loop_cats;
   	    END IF;


		SET `cats_list` = concat(`cats_list`,`delim`, `cat_name`);
	END LOOP loop_cats;

	IF `cats_list`='' THEN SET `cats_list`='NO CATS'; END IF;

-- 	SET `cats_list`='NO CATS';

	RETURN `cats_list`;
END//


--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
DELIMITER ;
