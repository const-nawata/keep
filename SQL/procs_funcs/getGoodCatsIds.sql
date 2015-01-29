DELIMITER //
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------



DROP FUNCTION IF EXISTS `getGoodCatsIds`//
CREATE FUNCTION `getGoodCatsIds`(pGoodId INT(11))
  RETURNS text CHARSET utf8
  DETERMINISTIC
BEGIN
	DECLARE `ids_list` TEXT DEFAULT '';
	DECLARE `cat_id` INTEGER(11);
	DECLARE `delim`	VARCHAR(2) DEFAULT ', ';
	DECLARE no_more_cats BOOLEAN;

	DECLARE cur1 CURSOR FOR SELECT `category_id` FROM `good_catigories` WHERE `good_id`=pGoodId;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_cats = TRUE;

	OPEN cur1;

loop_cats:
	LOOP
		FETCH cur1 INTO `cat_id`;
   	
		IF( no_more_cats ) THEN
			SET `ids_list` = substr(`ids_list`,2);

       		CLOSE cur1;
            LEAVE loop_cats;
   	    END IF;


		SET `ids_list` = concat(`ids_list`,`delim`, `cat_id`);
	END LOOP loop_cats;

-- 	IF `ids_list`='' THEN SET `ids_list`='NO CATS'; END IF;

	RETURN `ids_list`;
END//


--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
--	----------------------------------------------------------------------------
DELIMITER ;
