<?php
//include_once (dirname(__FILE__) .'/../ApplicationEntities/AppEntities_Facade.php');

class Entity
{
	var $my_type_id;
	var $date_last_modified;
	var $date_added;
	var $user_last_modified;
	var $user_added;

	function __construct($eid)
	{ 
		$sql = sprintf("select * from entity where eid = %s",$eid);
		($result = mysql_query($sql)) or die("Error: Entity::get_date_last_modified laasdsawq43dfwle;".mysql_error()); 
		if (mysql_num_rows($result)==1)
		{
			$this->date_last_modified = mysql_result($result,0,'last_modified');
			$this->date_added = mysql_result($result,0,'date_added');
			$this->user_last_modified = mysql_result($result,0,'user_last_modified');
			$this->user_added = mysql_result($result,0,'user_added');
		}
	}
	
	function create_new($type_id)
	{
		$logged_in_user = AppEntities_Facade::get_user_instance();
		$logged_in_user_id = $logged_in_user->user_id;
		$logged_in_user_full_name = $logged_in_user->full_name;
		$user_added = $logged_in_user_full_name." (".$logged_in_user_id.")";

		$sql = sprintf("insert into entity set type_id = '%s', date_added=NOW(), user_added = '%s'",$type_id,$user_added) ;
		mysql_query($sql);


		return mysql_insert_id();	
	}
	
	function get_type_id($eid)
	{
		$sql = sprintf("select type_id from entity where eid = %s",$eid);//echo $sql; var_dump(debug_backtrace()); 
		$result = mysql_query($sql);
		$type_id = mysql_result($result,0);
		return $type_id;
	}
	
	function set_last_modified_date($eid)
	{
		$logged_in_user = AppEntities_Facade::get_user_instance();
		$logged_in_user_id = $logged_in_user->user_id;
		$logged_in_user_full_name = $logged_in_user->full_name;
		$user_mod = $logged_in_user_full_name." (".$logged_in_user_id.")";
		
		$sql = sprintf("update entity set last_modified = NOW(), user_last_modified = '%s' where eid = %s",$user_mod, $eid);
		mysql_query($sql) or die("Error: Entity::set_last_modified_date lake39dkwle;");
	}
	
	function get_date_added($eid)
	{
		$date_added = "";
		$sql = sprintf("select date_added from entity where eid = %s",$eid);
		($result = mysql_query($sql)) or die("Error: Entity::get_date_added laasdsake39dkffswle;".mysql_error());
		if (mysql_num_rows($result)==1)
		{
			$date_added = mysql_result($result,0);
		}
		return $date_added;
	}
	
	function get_date_last_modified($eid)
	{
		$date_last_modified = "";
		$sql = sprintf("select last_modified from entity where eid = %s",$eid);
		($result = mysql_query($sql)) or die("Error: Entity::get_date_last_modified laasdsawq43dfwle;".mysql_error()); 
		if (mysql_num_rows($result)==1)
		{
			$date_last_modified = mysql_result($result,0);
		}
		return $date_last_modified;
	}

}

?>