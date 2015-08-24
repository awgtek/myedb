<?php

class Type
{
	var $my_type_name;

	function get_type_id($type_name)
	{
		$sql = "get type_id from type where type_name = $type_name";
		echo $sql;
		$res = mysql_query($sql);
		return mysql_result($res,0);
	}

	function get_type_list()
	{
		$sql = "select * from type";
		$result = mysql_query($sql);
		$table_hash = array();
		while ($ar = mysql_fetch_array($result))
		{
			$table_hash[$ar['type_id']] = $ar['type_name'];
		}
		return $table_hash;

	}


}
?>