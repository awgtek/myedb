# --------------------------------------------------------
# Host:                         172.16.34.3
# Database:                     myedb
# Server version:               5.1.31-1ubuntu2-log
# Server OS:                    debian-linux-gnu
# HeidiSQL version:             5.0.0.3272
# Date/time:                    2010-05-14 19:28:31
# --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

# Dumping structure for table myedb.acctmgr
DROP TABLE IF EXISTS `acctmgr`;
CREATE TABLE IF NOT EXISTS `acctmgr` (
  `acctmgr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acctmgr_val` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`acctmgr_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.boolean_prop
DROP TABLE IF EXISTS `boolean_prop`;
CREATE TABLE IF NOT EXISTS `boolean_prop` (
  `boolean_val` tinyint(1) unsigned DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  KEY `FK_bool_property` (`prop_id`),
  KEY `FK_bool_entity_property` (`ent_prop_id`),
  CONSTRAINT `FK_bool_entity_property` FOREIGN KEY (`ent_prop_id`) REFERENCES `entity_property` (`ent_prop_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_bool_property` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

# Data exporting was unselected.


# Dumping structure for table myedb.cache_state
DROP TABLE IF EXISTS `cache_state`;
CREATE TABLE IF NOT EXISTS `cache_state` (
  `cache_table_name` varchar(100) NOT NULL,
  `is_outdated` tinyint(1) NOT NULL,
  PRIMARY KEY (`cache_table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(120) DEFAULT NULL,
  `disabled` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.city
DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `city_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `city_name` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for procedure myedb.create_standalone_order
DROP PROCEDURE IF EXISTS `create_standalone_order`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `create_standalone_order`(IN in_details_xml TEXT, IN in_eidsrc INT, IN in_eiddst INT, IN in_type_id INT)
BEGIN
        DECLARE var_order_id INT;
INSERT INTO medb_order SET details_xml = in_details_xml, eidsrc = in_eidsrc, submitted = 1, date_added = NOW();
SELECT LAST_INSERT_ID() INTO var_order_id;
INSERT INTO medb_order_eiddst SET eiddst = in_eiddst, type_id = in_type_id, order_id = var_order_id;


END//
DELIMITER ;


# Dumping structure for procedure myedb.create_transaction
DROP PROCEDURE IF EXISTS `create_transaction`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `create_transaction`(IN in_eidsrc INT, IN in_eiddst INT, IN in_prop_group_id INT, IN in_prop_id INT, IN in_ron INT, IN in_qty INT)
BEGIN
        DECLARE var_transid, var_order_id INT;
SELECT order_id INTO var_order_id FROM medb_order WHERE eidsrc = in_eidsrc AND submitted = 0 LIMIT 1;
IF var_order_id IS null THEN
	        INSERT INTO medb_order (eidsrc) VALUES(in_eidsrc);
SELECT LAST_INSERT_ID() INTO var_order_id;
END IF;
SELECT SQL_CALC_FOUND_ROWS transid INTO var_transid FROM medb_transaction WHERE eidsrc = in_eidsrc AND eiddst = in_eiddst AND
                prop_group_id = in_prop_group_id AND ron = in_ron;
SET @rows = FOUND_ROWS();
IF @rows = 0 THEN
                INSERT INTO medb_transaction (eidsrc, eiddst, prop_group_id, ron, qty, order_id)
                        VALUES (in_eidsrc, in_eiddst, in_prop_group_id, in_ron, in_qty, var_order_id);
ELSE
                UPDATE medb_transaction SET qty = in_qty WHERE transid = var_transid;
END IF;


END//
DELIMITER ;


# Dumping structure for table myedb.date_prop
DROP TABLE IF EXISTS `date_prop`;
CREATE TABLE IF NOT EXISTS `date_prop` (
  `date_val` date DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  KEY `date_val` (`date_val`),
  KEY `FK_date_property` (`prop_id`),
  KEY `FK_date_entity_property` (`ent_prop_id`),
  CONSTRAINT `FK_date_entity_property` FOREIGN KEY (`ent_prop_id`) REFERENCES `entity_property` (`ent_prop_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_date_property` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

# Data exporting was unselected.


# Dumping structure for procedure myedb.delete_eid
DROP PROCEDURE IF EXISTS `delete_eid`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `delete_eid`(IN in_eid INT)
BEGIN
        DELETE FROM entity WHERE eid = in_eid;

END//
DELIMITER ;


# Dumping structure for procedure myedb.delete_lookup_table_item
DROP PROCEDURE IF EXISTS `delete_lookup_table_item`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `delete_lookup_table_item`(IN in_lookup_table VARCHAR(50),IN in_lookup_table_prim_key_col VARCHAR(50), IN in_lookup_table_row_id INT)
BEGIN

        DELETE entity_property.* FROM entity_property inner join int_prop on
	entity_property.ent_prop_id = int_prop.ent_prop_id
	inner join property on int_prop.prop_id = property.prop_id
	where property.validation_spec_id = (SELECT validation_spec_id FROM validation_spec
	WHERE lookup_table = in_lookup_table) and int_val = in_lookup_table_row_id;
SET @s = CONCAT('DELETE FROM ',in_lookup_table,' WHERE ',in_lookup_table_prim_key_col,' = ',
        in_lookup_table_row_id);
PREPARE stmt FROM @s;
EXECUTE stmt;

END//
DELIMITER ;


# Dumping structure for procedure myedb.delete_transaction
DROP PROCEDURE IF EXISTS `delete_transaction`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `delete_transaction`(IN in_trans_id INT)
BEGIN
        DECLARE eidsrc_var, var_trans_id INT;
SELECT eidsrc INTO eidsrc_var FROM medb_transaction WHERE transid = in_trans_id;
DELETE FROM medb_transaction WHERE transid = in_trans_id;
SELECT SQL_CALC_FOUND_ROWS transid INTO var_trans_id FROM medb_transaction WHERE eidsrc = eidsrc_var LIMIT 1;
SET @rows = FOUND_ROWS();
IF @rows = 0 THEN
             DELETE FROM medb_order WHERE eidsrc = eidsrc_var AND submitted = 0;
END IF;


END//
DELIMITER ;


# Dumping structure for procedure myedb.del_prop_by_ron
DROP PROCEDURE IF EXISTS `del_prop_by_ron`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `del_prop_by_ron`(IN in_prop_id INT, IN in_ron INT, IN in_eid INT)
BEGIN
        DECLARE tbl VARCHAR(100);
DECLARE loc_cat_id int;
SELECT table_name INTO tbl from property where prop_id = in_prop_id;
IF in_prop_id = 6 THEN
                select int_prop.int_val   INTO loc_cat_id
                from entity_property natural join int_prop
                where entity_property.eid = in_eid and entity_property.ron = in_ron
                and prop_id = in_prop_id   LIMIT 1;
SELECT SQL_CALC_FOUND_ROWS  int_prop.int_val
                from entity_property natural join int_prop
                where entity_property.eid = in_eid  AND int_prop.int_val = loc_cat_id
                and prop_id = in_prop_id   LIMIT 1;
SET @rows = FOUND_ROWS();
IF @rows = 1 THEN
                        SET @s = 'delete entity_property.* from
                        ((int_prop natural join entity_property  )
                        natural join property  )
                        inner join subcategory on int_prop.int_val = subcategory.subcat_id
                        where int_prop.prop_id = ? and subcategory.cat_id = ? and entity_property.eid = ?;
';
set @var_prop_id = 50;
SET @var_cat_id = loc_cat_id;
SET @var_in_eid = in_eid;
PREPARE stmt FROM @s;
EXECUTE stmt USING @var_prop_id, @var_cat_id, @var_in_eid;
END IF;
END IF;
SET @s = CONCAT('DELETE entity_property.*
 from (`',tbl,'` inner join `entity_property`
 on `',tbl,'`.`ent_prop_id` = `entity_property`.`ent_prop_id`)
where entity_property.ron = ',in_ron,'
and entity_property.eid = ',in_eid,' AND `',tbl,'`.`prop_id` = ',in_prop_id);
PREPARE stmt FROM @s;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
DELETE FROM repeat_prop_qualifier WHERE eid = in_eid AND prop_id = in_prop_id AND ron = in_ron;


END//
DELIMITER ;


# Dumping structure for procedure myedb.del_prop_group_by_ron
DROP PROCEDURE IF EXISTS `del_prop_group_by_ron`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `del_prop_group_by_ron`(IN in_type_id INT,IN in_prop_group_id INT, IN in_ron INT,
        IN in_eid INT)
BEGIN
     DECLARE y,z INT;
DECLARE x VARCHAR (50);
DECLARE sp1_cursor CURSOR FOR select distinct property.table_name
from property inner join property_type on property.prop_id = property_type.prop_id
where property_type.type_id = in_type_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET z = 1;
OPEN sp1_cursor;
REPEAT
                FETCH sp1_cursor INTO x;
SET @s = CONCAT('DELETE entity_property.*
 from (`',x,'` inner join `entity_property`
 on `',x,'`.`ent_prop_id` = `entity_property`.`ent_prop_id`)
inner join property on ',x,'.prop_id = property.prop_id
inner join property_grouping
on property.prop_group_id = property_grouping.prop_group_id
where property.prop_group_id = ',in_prop_group_id,' and entity_property.ron = ',in_ron,'
and entity_property.eid = ',in_eid);
PREPARE stmt FROM @s;
EXECUTE stmt;
UNTIL (z=1)
        END REPEAT;
CLOSE sp1_cursor;
DELETE FROM medb_transaction WHERE eiddst = in_eid AND prop_group_id = in_prop_group_id AND ron = in_ron;
DELETE FROM repeat_prop_qualifier WHERE eid = in_eid AND prop_group_id = in_prop_group_id AND ron = in_ron;


END//
DELIMITER ;


# Dumping structure for procedure myedb.disable_lookup_table_item
DROP PROCEDURE IF EXISTS `disable_lookup_table_item`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `disable_lookup_table_item`(IN in_lookup_table VARCHAR(50),IN in_lookup_table_prim_key_col VARCHAR(50), IN in_lookup_table_row_id INT)
BEGIN

        SET @s = CONCAT('UPDATE ',in_lookup_table,' SET disabled =1 WHERE ',in_lookup_table_prim_key_col,' = ',
        in_lookup_table_row_id);
PREPARE stmt FROM @s;
EXECUTE stmt;

END//
DELIMITER ;


# Dumping structure for table myedb.double_prop
DROP TABLE IF EXISTS `double_prop`;
CREATE TABLE IF NOT EXISTS `double_prop` (
  `double_val` double unsigned DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  KEY `FK_double_property` (`prop_id`),
  KEY `FK_double_entity_property` (`ent_prop_id`),
  CONSTRAINT `FK_double_entity_property` FOREIGN KEY (`ent_prop_id`) REFERENCES `entity_property` (`ent_prop_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_double_property` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

# Data exporting was unselected.


# Dumping structure for table myedb.entity
DROP TABLE IF EXISTS `entity`;
CREATE TABLE IF NOT EXISTS `entity` (
  `eid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` int(10) unsigned DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `user_added` varchar(150) DEFAULT NULL,
  `user_last_modified` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`eid`),
  KEY `FK_entity_type` (`type_id`),
  CONSTRAINT `FK_entity_type` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

# Data exporting was unselected.


# Dumping structure for table myedb.entity_category
DROP TABLE IF EXISTS `entity_category`;
CREATE TABLE IF NOT EXISTS `entity_category` (
  `cat_id` int(10) unsigned DEFAULT NULL,
  `eid` int(10) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.entity_grouping
DROP TABLE IF EXISTS `entity_grouping`;
CREATE TABLE IF NOT EXISTS `entity_grouping` (
  `eg_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eg_type` int(10) unsigned DEFAULT NULL,
  `eid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`eg_id`),
  KEY `FK_entity_grouping__entity` (`eid`),
  CONSTRAINT `FK_entity_grouping__entity` FOREIGN KEY (`eid`) REFERENCES `entity` (`eid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

# Data exporting was unselected.


# Dumping structure for table myedb.entity_grouping_types
DROP TABLE IF EXISTS `entity_grouping_types`;
CREATE TABLE IF NOT EXISTS `entity_grouping_types` (
  `eg_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eg_type_name` varchar(245) NOT NULL,
  PRIMARY KEY (`eg_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.entity_property
DROP TABLE IF EXISTS `entity_property`;
CREATE TABLE IF NOT EXISTS `entity_property` (
  `ent_prop_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eid` int(10) unsigned DEFAULT NULL,
  `ron` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ent_prop_id`),
  KEY `FK_ep_to_entity` (`eid`),
  CONSTRAINT `FK_ep_to_entity` FOREIGN KEY (`eid`) REFERENCES `entity` (`eid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for procedure myedb.finalize_order
DROP PROCEDURE IF EXISTS `finalize_order`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `finalize_order`(IN in_eid INT, IN in_details_xml TEXT, OUT out_order_id INT)
BEGIN
       DECLARE loc_order_id, loc_type_id, loc_eiddst INT;
DECLARE done INT DEFAULT 0;
DECLARE sp1_cursor CURSOR FOR SELECT DISTINCT eiddst FROM medb_transaction WHERE eidsrc = in_eid;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
START TRANSACTION;
SELECT order_id INTO loc_order_id FROM medb_order WHERE eidsrc = in_eid AND submitted = 0;
SET out_order_id = loc_order_id;
OPEN sp1_cursor;
REPEAT
               FETCH sp1_cursor INTO loc_eiddst;
IF NOT done THEN
                       SELECT type_id INTO loc_type_id FROM entity WHERE eid = loc_eiddst;
INSERT INTO medb_order_eiddst SET eiddst = loc_eiddst, type_id = loc_type_id, order_id = loc_order_id;
END IF;
UNTIL done
       END REPEAT;
CLOSE sp1_cursor;
UPDATE medb_order SET details_xml = in_details_xml, submitted = 1, date_added = NOW() WHERE eidsrc = in_eid AND submitted = 0;
update property natural join int_prop natural join entity_property natural join entity
        inner join medb_transaction on entity.eid = medb_transaction.eiddst and entity_property.ron = medb_transaction.ron
        and property.prop_group_id = medb_transaction.prop_group_id
        set int_val = int_val - qty
        where medb_transaction.eidsrc = in_eid  and property.prop_id = 15;
DELETE FROM medb_transaction WHERE eidsrc = in_eid;
COMMIT;

END//
DELIMITER ;


# Dumping structure for procedure myedb.get_active_subcategories
DROP PROCEDURE IF EXISTS `get_active_subcategories`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `get_active_subcategories`(IN `in_cat_id` int)
BEGIN
        select * from subcategory where subcat_id in
(
select int_val from view_int_prop_to_e_p_to_e where prop_id = 50 and int_val in
(
select subcat_id from subcategory where (cat_id = in_cat_id) -- or in_cat_id = 13) -- member directory includes all subcats
)
and eid in
(
select eid from view_int_prop_to_e_p_to_e where prop_id = 35 and int_val =2
)
and eid in
(
select eid from view_int_prop_to_e_p_to_e where (prop_id = 15 and int_val > 0 and (type_id = 1 or type_id = 2))
		or type_id = 4 or type_id = 5
)
)
order by subcat_name;


END//
DELIMITER ;


# Dumping structure for procedure myedb.get_order_history_dataset
DROP PROCEDURE IF EXISTS `get_order_history_dataset`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `get_order_history_dataset`(in lim_start int, in lim_length int, in in_type_id int,
        in in_eiddst int, in in_order_by_field varchar(100), in in_order_by_direction varchar(20))
BEGIN

      DECLARE l_transcount,l_order_id,l_counter INT;
DECLARE done,l_rebuild INT DEFAULT 0;
--  DECLARE lim_length_clause VARCHAR(50) DEFAULT "";
DECLARE cur1 CURSOR FOR   -- SELECT * FROM test_prepare_vw

                 select count(medb_order_eiddst.order_id),medb_order_eiddst.order_id from
                 medb_order_eiddst natural join medb_order
                 WHERE submitted = 1 AND (medb_order_eiddst.type_id <> 4 or        -- not travel type
				medb_order_eiddst.type_id is null)
                 group by medb_order_eiddst.order_id
                 -- order by medb_order_eiddst.order_id
                 -- limit lim_start,lim_length;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
-- workaround for mysql bug not accepting params in limit clause
  IF lim_length = 0 THEN
     -- SET lim_length_clause = CONCAT(',',lim_length);
set lim_length = 1000000;
END IF;
select  is_outdated into l_rebuild from cache_state where cache_table_name = "order_history_cache";
IF l_rebuild = 1 THEN

 -- set @query = CONCAT('CREATE VIEW test_prepare_vw AS select ',
-- 'count(medb_order_eiddst.order_id) as ordcnt,medb_order_eiddst.order_id from ',
-- ' medb_order_eiddst       ',
-- ' where medb_order_eiddst.type_id <> 4 ',
-- ' group by medb_order_eiddst.order_id ',
-- '  limit ',lim_start,lim_length_clause,' ')
--;
DROP TABLE IF EXISTS order_history_cache;
CREATE TABLE order_history_cache (hc_date_added datetime, hc_user_name varchar(150),
  hc_no_items int,hc_pickup varchar(20),hc_status varchar(50),n_prod_name varchar(200),prodacctno varchar(200),
  prodrefno varchar(200), n_co_acctno varchar(200),n_co_name varchar(200), n_prod_id INT,n_order_id INT);
OPEN cur1;
hist_loop: LOOP
  FETCH cur1 INTO l_transcount,l_order_id;
IF done=1 THEN
     LEAVE hist_loop;
END IF;
SET l_counter = 1;
WHILE l_counter <= l_transcount DO
      INSERT INTO order_history_cache (hc_date_added , hc_user_name ,
  hc_no_items ,hc_pickup ,hc_status ,n_prod_name,prodacctno,prodrefno,n_co_acctno ,n_co_name,n_prod_id,n_order_id)
select
medb_order.date_added,
ExtractValue(details_xml,'/order_info/record[@type_id="3"]/property[@prop_id="7"]/value')
as user_id,
ExtractValue(medb_order.details_xml,'/order_info/transactions/transaction[$l_counter]/@qty')
as trans_qty,
ExtractValue(details_xml,'/order_info/order_ship_addr')
as ship_or_pickup,
CASE medb_order.approved
        WHEN 1 THEN 'Approved'
        WHEN -1 THEN 'Not Approved'
        ELSE 'Pending'
END AS hc_status,
ExtractValue(details_xml,'/order_info/transactions/transaction[$l_counter]/record/property[@prop_id="1"]/value')
as prodname,
ExtractValue(details_xml,'/order_info/transactions/transaction[$l_counter]/record/property[@prop_id="33"]/value')
as prodacctno,
ExtractValue(details_xml,'/order_info/transactions/transaction[$l_counter]/record/property[@prop_id="57"]/value')
as prodrefno,
ExtractValue(details_xml,'/order_info/co_account_number')
as co_acctno,
ExtractValue(details_xml,'/order_info/co_name')
as co_name,
medb_order_eiddst.eiddst,medb_order_eiddst.order_id from
medb_order_eiddst inner join medb_order on (medb_order_eiddst.eiddst =
ExtractValue(medb_order.details_xml,'/order_info/transactions/transaction[$l_counter]/@eiddst')   )

and medb_order_eiddst.order_id = medb_order.order_id WHERE medb_order_eiddst.order_id = l_order_id;
SET l_counter = l_counter + 1;
END WHILE;
END LOOP hist_loop;
CLOSE cur1;
UPDATE cache_state SET is_outdated = 0 WHERE cache_table_name = "order_history_cache";
END IF;
-- IF l_rebuild = 1

  SET @START = lim_start;
SET @LIMIT = lim_length;
SET @QUERY = CONCAT('select hc_date_added as date_added , hc_user_name ,
  hc_no_items ,REPLACE(REPLACE(hc_pickup,"_"," "),"will ship","ship") AS ship_or_pickup ,hc_status ,n_prod_name,prodacctno,prodrefno,n_co_acctno ,
  n_co_name,n_prod_id,n_order_id
   from order_history_cache order by ',in_order_by_field,' ', in_order_by_direction,
   ' limit ?,?   ');
PREPARE stmt FROM @QUERY;
EXECUTE STMT USING @START,@LIMIT;
DEALLOCATE PREPARE STMT;



END//
DELIMITER ;


# Dumping structure for procedure myedb.helloworld
DROP PROCEDURE IF EXISTS `helloworld`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `helloworld`()
BEGIN
  SELECT 'hello world';


END//
DELIMITER ;


# Dumping structure for procedure myedb.insert_prop_hist_rec
DROP PROCEDURE IF EXISTS `insert_prop_hist_rec`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `insert_prop_hist_rec`(IN last_val TEXT,
IN prop_id INT, IN ron INT, IN eid INT, IN action_in VARCHAR(250), IN user_id VARCHAR(250),
IN prim_prop VARCHAR(250), IN user_full_name VARCHAR(250))
BEGIN
        DECLARE new_eid, new_epi INT;
SET @qry_get_type = CONCAT('SELECT type_id INTO @loc_type_id FROM type WHERE type_name = \'',prim_prop,'_history\'');
PREPARE stmt FROM @qry_get_type;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
SET @qry_get_type_lastval_id = CONCAT('SELECT prop_id INTO @lastval_prop_id FROM property WHERE prop_name = \'',prim_prop,'_lastval\'');
PREPARE stmt FROM @qry_get_type_lastval_id;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
INSERT INTO entity SET type_id = @loc_type_id;
SELECT LAST_INSERT_ID() INTO new_eid;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
SET @qry_ins_last_val = CONCAT('INSERT INTO ',prim_prop,'_prop SET ',prim_prop,'_val = \'',last_val,
                '\', prop_id = ',@lastval_prop_id,', ent_prop_id = ',new_epi);
PREPARE stmt FROM @qry_ins_last_val;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
INSERT INTO varchar_prop SET varchar_val = user_id, prop_id = 7, ent_prop_id = new_epi;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
INSERT INTO varchar_prop SET varchar_val = user_full_name, prop_id = 41, ent_prop_id = new_epi;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
INSERT INTO int_prop SET int_val = prop_id, prop_id = 38, ent_prop_id = new_epi;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
INSERT INTO int_prop SET int_val = ron, prop_id = 39, ent_prop_id = new_epi;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
INSERT INTO int_prop SET int_val = eid, prop_id = 40, ent_prop_id = new_epi;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
INSERT INTO varchar_prop SET varchar_val = action_in, prop_id = 42, ent_prop_id = new_epi;
INSERT INTO entity_property SET eid = new_eid;
SELECT LAST_INSERT_ID() INTO new_epi;
INSERT INTO date_prop SET date_val = now(), prop_id = 43, ent_prop_id = new_epi;



END//
DELIMITER ;


# Dumping structure for table myedb.int_prop
DROP TABLE IF EXISTS `int_prop`;
CREATE TABLE IF NOT EXISTS `int_prop` (
  `int_val` int(10) DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  KEY `FK_int_property` (`prop_id`),
  KEY `FK_int_entity_property` (`ent_prop_id`),
  KEY `Index_int_val` (`int_val`),
  CONSTRAINT `FK_int_entity_property` FOREIGN KEY (`ent_prop_id`) REFERENCES `entity_property` (`ent_prop_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_int_property` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

# Data exporting was unselected.


# Dumping structure for table myedb.level
DROP TABLE IF EXISTS `level`;
CREATE TABLE IF NOT EXISTS `level` (
  `level_id` int(10) unsigned NOT NULL DEFAULT '0',
  `level_name` varchar(200) DEFAULT NULL,
  `cat_id` int(10) unsigned DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.level_value
DROP TABLE IF EXISTS `level_value`;
CREATE TABLE IF NOT EXISTS `level_value` (
  `lv_id` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned DEFAULT NULL,
  `level_id` int(10) unsigned NOT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`lv_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.location
DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `addr_id` int(10) unsigned NOT NULL DEFAULT '0',
  `addr_type` int(50) DEFAULT NULL,
  `addr_line1` varchar(250) DEFAULT NULL,
  `addr_line2` varchar(250) DEFAULT NULL,
  `city_id` int(10) unsigned DEFAULT NULL,
  `state_id` int(10) unsigned DEFAULT NULL,
  `zip_id` int(10) unsigned DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`addr_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.medb_order
DROP TABLE IF EXISTS `medb_order`;
CREATE TABLE IF NOT EXISTS `medb_order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `approved` tinyint(1) NOT NULL,
  `approved_dt` datetime NOT NULL,
  `details_xml` text NOT NULL,
  `eidsrc` int(10) unsigned DEFAULT NULL,
  `submitted` tinyint(3) unsigned DEFAULT '0',
  `date_added` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `Index_mo_eid` (`eidsrc`),
  CONSTRAINT `FK_order_entity` FOREIGN KEY (`eidsrc`) REFERENCES `entity` (`eid`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for trigger myedb.medb_order_delete
DROP TRIGGER IF EXISTS `medb_order_delete`;
SET SESSION SQL_MODE='';
DELIMITER //
CREATE TRIGGER `medb_order_delete` AFTER DELETE ON `medb_order` FOR EACH ROW BEGIN
update cache_state set is_outdated = 1 where cache_table_name = "order_history_cache";
END//
DELIMITER ;
SET SESSION SQL_MODE=@OLD_SQL_MODE;


# Dumping structure for table myedb.medb_order_eiddst
DROP TABLE IF EXISTS `medb_order_eiddst`;
CREATE TABLE IF NOT EXISTS `medb_order_eiddst` (
  `moe_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eiddst` int(10) unsigned NOT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`moe_id`),
  KEY `eiddst` (`eiddst`,`type_id`),
  KEY `FK_moe_to_medb_order` (`order_id`),
  CONSTRAINT `FK_moe_to_medb_order` FOREIGN KEY (`order_id`) REFERENCES `medb_order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='for looking up order history by ordered item (eiddst)';

# Data exporting was unselected.


# Dumping structure for trigger myedb.medb_order_insert
DROP TRIGGER IF EXISTS `medb_order_insert`;
SET SESSION SQL_MODE='';
DELIMITER //
CREATE TRIGGER `medb_order_insert` AFTER INSERT ON `medb_order` FOR EACH ROW BEGIN
update cache_state set is_outdated = 1 where cache_table_name = "order_history_cache";
END//
DELIMITER ;
SET SESSION SQL_MODE=@OLD_SQL_MODE;


# Dumping structure for trigger myedb.medb_order_update
DROP TRIGGER IF EXISTS `medb_order_update`;
SET SESSION SQL_MODE='';
DELIMITER //
CREATE TRIGGER `medb_order_update` AFTER UPDATE ON `medb_order` FOR EACH ROW BEGIN
update cache_state set is_outdated = 1 where cache_table_name = "order_history_cache";
END//
DELIMITER ;
SET SESSION SQL_MODE=@OLD_SQL_MODE;


# Dumping structure for table myedb.medb_transaction
DROP TABLE IF EXISTS `medb_transaction`;
CREATE TABLE IF NOT EXISTS `medb_transaction` (
  `transid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `realized` tinyint(1) DEFAULT '0',
  `eidsrc` int(10) unsigned DEFAULT NULL,
  `eiddst` int(10) unsigned DEFAULT NULL,
  `prop_group_id` int(10) unsigned DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  `ron` int(10) unsigned NOT NULL,
  `qty` int(10) unsigned NOT NULL DEFAULT '1',
  `order_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`transid`),
  UNIQUE KEY `Index_group_ron` (`eidsrc`,`eiddst`,`prop_group_id`,`ron`),
  KEY `FK_prop_group_id` (`prop_group_id`),
  KEY `FK_prop_id` (`prop_id`),
  KEY `FK_eiddst` (`eiddst`) USING BTREE,
  KEY `FK_mt_order` (`order_id`),
  CONSTRAINT `FK_eiddst` FOREIGN KEY (`eiddst`) REFERENCES `entity` (`eid`) ON DELETE CASCADE,
  CONSTRAINT `FK_eidsrc` FOREIGN KEY (`eidsrc`) REFERENCES `entity` (`eid`) ON DELETE CASCADE,
  CONSTRAINT `FK_mt_order` FOREIGN KEY (`order_id`) REFERENCES `medb_order` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_prop_group_id` FOREIGN KEY (`prop_group_id`) REFERENCES `property_grouping` (`prop_group_id`),
  CONSTRAINT `FK_prop_id` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

# Data exporting was unselected.


# Dumping structure for table myedb.memcache_search_keys
DROP TABLE IF EXISTS `memcache_search_keys`;
CREATE TABLE IF NOT EXISTS `memcache_search_keys` (
  `search_key` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`search_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.order_history_cache
DROP TABLE IF EXISTS `order_history_cache`;
CREATE TABLE IF NOT EXISTS `order_history_cache` (
  `hc_date_added` datetime DEFAULT NULL,
  `hc_user_name` varchar(150) DEFAULT NULL,
  `hc_no_items` int(11) DEFAULT NULL,
  `hc_pickup` varchar(20) DEFAULT NULL,
  `hc_status` varchar(50) DEFAULT NULL,
  `n_prod_name` varchar(200) DEFAULT NULL,
  `prodacctno` varchar(200) DEFAULT NULL,
  `prodrefno` varchar(200) DEFAULT NULL,
  `n_co_acctno` varchar(200) DEFAULT NULL,
  `n_co_name` varchar(200) DEFAULT NULL,
  `n_prod_id` int(11) DEFAULT NULL,
  `n_order_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.property
DROP TABLE IF EXISTS `property`;
CREATE TABLE IF NOT EXISTS `property` (
  `prop_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prop_name` varchar(200) DEFAULT NULL,
  `table_name` varchar(50) DEFAULT NULL,
  `validation_spec_id` int(10) unsigned DEFAULT NULL,
  `prop_group_id` int(10) unsigned DEFAULT NULL,
  `track_history` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`prop_id`),
  KEY `FK_validation_spec` (`validation_spec_id`),
  KEY `FK_property_grouping` (`prop_group_id`),
  CONSTRAINT `FK_property_grouping` FOREIGN KEY (`prop_group_id`) REFERENCES `property_grouping` (`prop_group_id`),
  CONSTRAINT `FK_validation_spec` FOREIGN KEY (`validation_spec_id`) REFERENCES `validation_spec` (`validation_spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

# Data exporting was unselected.


# Dumping structure for table myedb.property_grouping
DROP TABLE IF EXISTS `property_grouping`;
CREATE TABLE IF NOT EXISTS `property_grouping` (
  `prop_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prop_group_name` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`prop_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.property_type
DROP TABLE IF EXISTS `property_type`;
CREATE TABLE IF NOT EXISTS `property_type` (
  `type_id` int(10) unsigned NOT NULL DEFAULT '0',
  `prop_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`type_id`,`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

# Data exporting was unselected.


# Dumping structure for table myedb.prop_qualifier
DROP TABLE IF EXISTS `prop_qualifier`;
CREATE TABLE IF NOT EXISTS `prop_qualifier` (
  `prop_qual_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qualifier` varchar(245) NOT NULL,
  `prop_group_id` int(10) unsigned DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`prop_qual_id`),
  KEY `FK_pq_pg` (`prop_group_id`),
  KEY `FK_pq_prop` (`prop_id`),
  CONSTRAINT `FK_pq_pg` FOREIGN KEY (`prop_group_id`) REFERENCES `property_grouping` (`prop_group_id`),
  CONSTRAINT `FK_pq_prop` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.record_set
DROP TABLE IF EXISTS `record_set`;
CREATE TABLE IF NOT EXISTS `record_set` (
  `rsid` int(10) unsigned NOT NULL DEFAULT '0',
  `rsname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`rsid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.repeat_prop_qualifier
DROP TABLE IF EXISTS `repeat_prop_qualifier`;
CREATE TABLE IF NOT EXISTS `repeat_prop_qualifier` (
  `rpq_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `eid` int(10) unsigned NOT NULL,
  `prop_group_id` int(10) unsigned DEFAULT NULL,
  `ron` int(10) unsigned NOT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  `prop_qual_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`rpq_id`),
  UNIQUE KEY `prop_group_unq` (`eid`,`prop_group_id`,`ron`),
  UNIQUE KEY `prop_unq` (`eid`,`ron`,`prop_id`),
  KEY `FK_rpq_pg` (`prop_group_id`),
  KEY `FK_rpq_prop` (`prop_id`),
  KEY `FK_rpq_pq` (`prop_qual_id`),
  CONSTRAINT `FK_rpq_eid` FOREIGN KEY (`eid`) REFERENCES `entity` (`eid`) ON DELETE CASCADE,
  CONSTRAINT `FK_rpq_pg` FOREIGN KEY (`prop_group_id`) REFERENCES `property_grouping` (`prop_group_id`),
  CONSTRAINT `FK_rpq_pq` FOREIGN KEY (`prop_qual_id`) REFERENCES `prop_qualifier` (`prop_qual_id`),
  CONSTRAINT `FK_rpq_prop` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for procedure myedb.reset_lookup_table_items
DROP PROCEDURE IF EXISTS `reset_lookup_table_items`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `reset_lookup_table_items`(IN in_lookup_table VARCHAR(50), IN operation INT)
BEGIN
                                IF (operation & 1 = 1) THEN
                BEGIN
                        DECLARE unknown_column CONDITION FOR SQLSTATE '42S22';
DECLARE EXIT HANDLER FOR unknown_column
                                BEGIN
                                                                 END;
SET @query1 = CONCAT('UPDATE ',in_lookup_table,' SET disabled = 0 ');
PREPARE qry FROM @query1;
EXECUTE qry;
END;
END IF;

        
END//
DELIMITER ;


# Dumping structure for procedure myedb.restore_subcats
DROP PROCEDURE IF EXISTS `restore_subcats`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `restore_subcats`()
BEGIN
        DECLARE done BOOLEAN DEFAULT FALSE;
DECLARE var_eid int;
DECLARE var_int_val INT;
declare tgoCur cursor for select tempgary.view_int_prop_to_e_p_to_e.eid,
         tempgary.view_int_prop_to_e_p_to_e.int_val from tempgary0414.entity natural join
         tempgary.view_int_prop_to_e_p_to_e left join
tempgary0414.view_int_prop_to_e_p_to_e on
tempgary.view_int_prop_to_e_p_to_e.eid =
tempgary0414.view_int_prop_to_e_p_to_e.eid and
tempgary.view_int_prop_to_e_p_to_e.int_val =
tempgary0414.view_int_prop_to_e_p_to_e.int_val and
tempgary.view_int_prop_to_e_p_to_e.prop_id =
tempgary0414.view_int_prop_to_e_p_to_e.prop_id and
tempgary.view_int_prop_to_e_p_to_e.type_id =
tempgary0414.view_int_prop_to_e_p_to_e.type_id
where tempgary0414.view_int_prop_to_e_p_to_e.eid is null and
tempgary0414.view_int_prop_to_e_p_to_e.int_val is null and
tempgary0414.view_int_prop_to_e_p_to_e.prop_id is null and
tempgary0414.view_int_prop_to_e_p_to_e.type_id is null
and tempgary.view_int_prop_to_e_p_to_e.prop_id = 50
order by tempgary.view_int_prop_to_e_p_to_e.eid;
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;
OPEN tgoCur;
tgo_loop: LOOP
          FETCH tgoCur INTO var_eid,var_int_val;
IF `done` THEN
                  LEAVE tgo_loop;
END IF;
INSERT INTO tempgary0414.entity_property set eid = var_eid;
INSERT INTO tempgary0414.int_prop SET int_val = var_int_val, prop_id = 50,
                  ent_prop_id = last_insert_id();
commit;
END LOOP tgo_loop;
close tgoCur;
commit;


END//
DELIMITER ;


# Dumping structure for table myedb.state
DROP TABLE IF EXISTS `state`;
CREATE TABLE IF NOT EXISTS `state` (
  `state_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `state_abbrev` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`state_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.status
DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status_val` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.subcategory
DROP TABLE IF EXISTS `subcategory`;
CREATE TABLE IF NOT EXISTS `subcategory` (
  `subcat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subcat_name` varchar(200) DEFAULT NULL,
  `cat_id` int(10) unsigned DEFAULT NULL,
  `disabled` tinyint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`subcat_id`),
  KEY `FK_subcategory_category` (`cat_id`),
  CONSTRAINT `FK_subcategory_category` FOREIGN KEY (`cat_id`) REFERENCES `category` (`cat_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.text_prop
DROP TABLE IF EXISTS `text_prop`;
CREATE TABLE IF NOT EXISTS `text_prop` (
  `text_val` text,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  KEY `FK_text_property` (`prop_id`),
  KEY `FK_text_entity_property` (`ent_prop_id`),
  KEY `Index_text_val` (`text_val`(150)),
  CONSTRAINT `FK_text_entity_property` FOREIGN KEY (`ent_prop_id`) REFERENCES `entity_property` (`ent_prop_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_text_property` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

# Data exporting was unselected.


# Dumping structure for table myedb.time_prop
DROP TABLE IF EXISTS `time_prop`;
CREATE TABLE IF NOT EXISTS `time_prop` (
  `time_val` time DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  KEY `time_val` (`time_val`),
  KEY `FK_time_property` (`prop_id`),
  KEY `FK_time_entity_property` (`ent_prop_id`),
  CONSTRAINT `FK_time_entity_property` FOREIGN KEY (`ent_prop_id`) REFERENCES `entity_property` (`ent_prop_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_time_property` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=FIXED;

# Data exporting was unselected.


# Dumping structure for table myedb.type
DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) DEFAULT NULL,
  `type_category` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for procedure myedb.update_prim_prop
DROP PROCEDURE IF EXISTS `update_prim_prop`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `update_prim_prop`(IN newval TEXT, IN in_prop_id INT, IN in_ent_prop_id INT,
        IN user_id VARCHAR(250), IN user_full_name VARCHAR(250), IN prim_prop VARCHAR(250))
BEGIN
        DECLARE loc_ron, loc_eid INT;
SET @oldval = "";
SET @use_new_val = newval, @use_ent_prop_id = in_ent_prop_id, @use_prop_id = in_prop_id;
SET @qry_get_old = CONCAT('SELECT ',prim_prop,'_val INTO @oldval FROM ',prim_prop,
                '_prop WHERE ent_prop_id = ? AND prop_id = ?');
PREPARE stmt FROM @qry_get_old;
EXECUTE stmt USING @use_ent_prop_id, @use_prop_id;
DEALLOCATE PREPARE stmt;
IF @oldval != newval THEN
                SET @qry_update_prop = CONCAT('UPDATE ',prim_prop,'_prop SET ',prim_prop,
                        '_val = ? WHERE ent_prop_id = ? AND prop_id = ?');
PREPARE stmt FROM @qry_update_prop;
EXECUTE stmt USING @use_new_val, @use_ent_prop_id, @use_prop_id;
DEALLOCATE PREPARE stmt;
SET @qry_get_tracking = CONCAT('SELECT track_history INTO @track_hist FROM property WHERE prop_id = ?');
PREPARE stmt FROM @qry_get_tracking;
EXECUTE stmt USING @use_prop_id;
DEALLOCATE PREPARE stmt;
IF @track_hist THEN
			SELECT eid, ron INTO loc_eid, loc_ron FROM entity_property WHERE ent_prop_id = in_ent_prop_id;
CALL insert_prop_hist_rec(@oldval,in_prop_id,loc_ron,loc_eid,'update',user_id,prim_prop,user_full_name);
END IF;
END IF;



END//
DELIMITER ;


# Dumping structure for procedure myedb.update_repeat_prop_qualifier
DROP PROCEDURE IF EXISTS `update_repeat_prop_qualifier`;
DELIMITER //
CREATE DEFINER=`dbuser`@`%` PROCEDURE `update_repeat_prop_qualifier`(IN in_eid INT, IN in_prop_group_id INT,
        IN in_prop_id INT, IN in_ron INT, IN in_prop_qual_id INT)
BEGIN

       DECLARE group_has_data,prop_has_data BOOLEAN DEFAULT false;
DECLARE cnt, z INT;
DECLARE x VARCHAR (50);
DECLARE tbl VARCHAR(100);
DECLARE sp1_cursor CURSOR FOR select distinct property.table_name
                FROM property INNER JOIN property_type ON property.prop_id = property_type.prop_id
                WHERE property_type.type_id = (SELECT type_id FROM entity WHERE eid = in_eid);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET z = 1;
IF in_prop_group_id > 0 THEN
		OPEN sp1_cursor;
REPEAT
			FETCH sp1_cursor INTO x;
SET @s = CONCAT('SELECT SQL_CALC_FOUND_ROWS entity_property.ent_prop_id   INTO @gbg
			 from (`',x,'` inner join `entity_property`
			 on `',x,'`.`ent_prop_id` = `entity_property`.`ent_prop_id`)
			inner join property on ',x,'.prop_id = property.prop_id
			inner join property_grouping
			on property.prop_group_id = property_grouping.prop_group_id
			where property.prop_group_id = ',in_prop_group_id,' and entity_property.ron = ',in_ron,'
			and entity_property.eid = ',in_eid,' LIMIT 0,1');
PREPARE stmt FROM @s;
EXECUTE stmt;
SET @rows = FOUND_ROWS();
IF @rows > 0 THEN
			      SET group_has_data = true;
END IF;
DEALLOCATE PREPARE stmt;
UNTIL (z=1)
		END REPEAT;
CLOSE sp1_cursor;
IF group_has_data = true THEN

		      IF in_prop_qual_id = 0 THEN
			      DELETE FROM repeat_prop_qualifier WHERE eid = in_eid AND prop_group_id = in_prop_group_id AND ron = in_ron;
ELSE
			INSERT INTO repeat_prop_qualifier (eid,prop_group_id,ron,prop_qual_id) VALUES(in_eid,in_prop_group_id,in_ron,in_prop_qual_id)
				ON DUPLICATE KEY UPDATE prop_qual_id = in_prop_qual_id;
END IF;
END IF;
ELSE

                SELECT table_name INTO tbl from property where prop_id = in_prop_id;
SET @s = CONCAT('SELECT SQL_CALC_FOUND_ROWS entity_property.ent_prop_id   INTO @gbg
 from (`',tbl,'` inner join `entity_property`
 on `',tbl,'`.`ent_prop_id` = `entity_property`.`ent_prop_id`)
where entity_property.ron = ',in_ron,'
and entity_property.eid = ',in_eid,' AND `',tbl,'`.`prop_id` = ',in_prop_id);
PREPARE stmt FROM @s;
EXECUTE stmt;
SET @rows = FOUND_ROWS();
IF @rows > 0 THEN
                      SET prop_has_data = true;
END IF;
DEALLOCATE PREPARE stmt;
IF prop_has_data = true THEN
                      IF in_prop_qual_id = 0 THEN
		              DELETE FROM repeat_prop_qualifier WHERE eid = in_eid AND prop_id = in_prop_id AND ron = in_ron;
ELSE
		                INSERT INTO repeat_prop_qualifier (eid,prop_id,ron,prop_qual_id) VALUES(in_eid,in_prop_id,in_ron,in_prop_qual_id)
			        ON DUPLICATE KEY UPDATE prop_qual_id = in_prop_qual_id;
END IF;
END IF;
END IF;



END//
DELIMITER ;


# Dumping structure for table myedb.validation_spec
DROP TABLE IF EXISTS `validation_spec`;
CREATE TABLE IF NOT EXISTS `validation_spec` (
  `validation_spec_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `v_regex` varchar(250) DEFAULT NULL,
  `lookup_table` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`validation_spec_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for table myedb.varchar_prop
DROP TABLE IF EXISTS `varchar_prop`;
CREATE TABLE IF NOT EXISTS `varchar_prop` (
  `varchar_val` varchar(250) CHARACTER SET latin1 DEFAULT NULL,
  `prop_id` int(10) unsigned DEFAULT NULL,
  `ent_prop_id` int(10) unsigned DEFAULT NULL,
  KEY `FK_varchar_property` (`prop_id`),
  KEY `FK_varchar_entity_property` (`ent_prop_id`),
  KEY `Index_varchar_val` (`varchar_val`),
  CONSTRAINT `FK_varchar_entity_property` FOREIGN KEY (`ent_prop_id`) REFERENCES `entity_property` (`ent_prop_id`) ON DELETE CASCADE,
  CONSTRAINT `FK_varchar_property` FOREIGN KEY (`prop_id`) REFERENCES `property` (`prop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

# Data exporting was unselected.


# Dumping structure for table myedb.zip
DROP TABLE IF EXISTS `zip`;
CREATE TABLE IF NOT EXISTS `zip` (
  `zip_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zip_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`zip_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

# Data exporting was unselected.


# Dumping structure for view myedb.view_boolean_prop_to_e_p_to_e
DROP VIEW IF EXISTS `view_boolean_prop_to_e_p_to_e`;
CREATE ALGORITHM=UNDEFINED DEFINER=`dbuser`@`%` SQL SECURITY DEFINER VIEW `view_boolean_prop_to_e_p_to_e` AS select `entity`.`eid` AS `eid`,`boolean_prop`.`boolean_val` AS `boolean_val`,`boolean_prop`.`prop_id` AS `prop_id`,`entity`.`type_id` AS `type_id` from ((`boolean_prop` join `entity_property`) join `entity`) where ((`boolean_prop`.`ent_prop_id` = `entity_property`.`ent_prop_id`) and (`entity_property`.`eid` = `entity`.`eid`));


# Dumping structure for view myedb.view_int_prop_to_e_p_to_e
DROP VIEW IF EXISTS `view_int_prop_to_e_p_to_e`;
CREATE ALGORITHM=UNDEFINED DEFINER=`dbuser`@`%` SQL SECURITY DEFINER VIEW `view_int_prop_to_e_p_to_e` AS select `entity`.`eid` AS `eid`,`int_prop`.`int_val` AS `int_val`,`int_prop`.`prop_id` AS `prop_id`,`entity`.`type_id` AS `type_id` from ((`int_prop` join `entity_property`) join `entity`) where ((`int_prop`.`ent_prop_id` = `entity_property`.`ent_prop_id`) and (`entity_property`.`eid` = `entity`.`eid`));


# Dumping structure for view myedb.view_text_prop_to_e_p_to_e
DROP VIEW IF EXISTS `view_text_prop_to_e_p_to_e`;
CREATE ALGORITHM=UNDEFINED DEFINER=`dbuser`@`%` SQL SECURITY DEFINER VIEW `view_text_prop_to_e_p_to_e` AS select `entity`.`eid` AS `eid`,`text_prop`.`text_val` AS `text_val`,`text_prop`.`prop_id` AS `prop_id`,`entity`.`type_id` AS `type_id` from ((`text_prop` join `entity_property`) join `entity`) where ((`text_prop`.`ent_prop_id` = `entity_property`.`ent_prop_id`) and (`entity_property`.`eid` = `entity`.`eid`));


# Dumping structure for view myedb.view_varchar_prop_to_e_p_to_e
DROP VIEW IF EXISTS `view_varchar_prop_to_e_p_to_e`;
CREATE ALGORITHM=UNDEFINED DEFINER=`dbuser`@`%` SQL SECURITY DEFINER VIEW `view_varchar_prop_to_e_p_to_e` AS select `entity`.`eid` AS `eid`,`varchar_prop`.`varchar_val` AS `varchar_val`,`varchar_prop`.`prop_id` AS `prop_id`,`entity`.`type_id` AS `type_id` from ((`varchar_prop` join `entity_property`) join `entity`) where ((`varchar_prop`.`ent_prop_id` = `entity_property`.`ent_prop_id`) and (`entity_property`.`eid` = `entity`.`eid`));
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
