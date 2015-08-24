<?php

class Property
{
	var $prop_id;
	var $prop_name;
	var $table_name;
	var $validation_spec_id;
	var $prop_group_id;
	
	function Property($_prop_id)
	{
		$this->prop_id = $_prop_id;
		$sql = "select * from property where prop_id = '{$this->prop_id}'";
		$sqlresult = mysql_query($sql);
		$this->prop_name = mysql_result($sqlresult,0,"prop_name");
		$this->table_name = mysql_result($sqlresult,0,"table_name");
		$this->validation_spec_id = mysql_result($sqlresult,0,"validation_spec_id");
		$this->prop_group_id = mysql_result($sqlresult,0,"prop_group_id");
		
	}

	static function static_get_table_name($prop_id)
	{
		$sql = "select table_name from property where prop_id = '$prop_id'";// echo $sql;
		return mysql_result(mysql_query($sql),0);
	}
	
	function get_table_name($prop_id="")
	{
		if ($this->table_name && empty($prop_id))
			return $this->table_name;
		if (empty($prop_id))
			$prop_id = $this->prop_id;
		$sql = "select table_name from property where prop_id = '$prop_id'";
		return mysql_result(mysql_query($sql),0);
	}
	function get_property_name($prop_id="")
	{
		if ($this->prop_name && empty($prop_id))
			return $this->prop_name;
		if (empty($prop_id))
			$prop_id = $this->prop_id;
		$sql = "select prop_name from property where prop_id = '$prop_id'";
		return mysql_result(mysql_query($sql),0);
	}
	
	function get_property_group_id($prop_id="")
	{
		if ($this->prop_group_id && empty($prop_id))
			return $this->prop_group_id;
		if (empty($prop_id))
			$prop_id = $this->prop_id;
		$sql = "select prop_group_id from property where prop_id = '$prop_id'";
		return mysql_result(mysql_query($sql),0);
	}	
	function get_prop_ids_by_group_id($group_id)
	{
		$sql = "select prop_id from property where prop_group_id = '$group_id'";
		$result = mysql_query($sql);
		$prop_ids = array();
		while ($ar = mysql_fetch_array($result))
		{
			$prop_ids[] = $ar['prop_id'];
		}
		return $prop_ids;
	}
	
	function get_property_list()
	{
		$sql = "select * from property";
		$result = mysql_query($sql);
		$table_hash = array();
		while ($ar = mysql_fetch_array($result))
		{
			$table_hash[$ar['prop_id']] = $ar['prop_name'];
		}
		return $table_hash;

	}

	function get_property_ids()
	{
		$sql = "select * from property";
		$result = mysql_query($sql);
		$property_ids = array();
		while ($ar = mysql_fetch_array($result))
		{
			$property_ids[] = $ar['prop_id'];
		}
		return $property_ids;

	}
	

}

?>