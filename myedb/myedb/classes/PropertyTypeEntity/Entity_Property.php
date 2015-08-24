<?php

class Entity_Property
{
	var $my_eid;
	
	function create_new($eid, $ron)
	{
		$sql = "insert into entity_property set eid = ".$eid.", ron='".$ron."'";
		mysql_query($sql);
		return mysql_insert_id();
	}

}

?>