<?php

class Property_Type
{
	var $my_type_id;
	
	function get_prop_ids($type_id)
	{
		$ret_ar = array();
		$sql = "select prop_id from property_type where type_id = $type_id";//echo $sql; debug_print_backtrace ();var_dump(debug_backtrace());
		$result = mysql_query($sql) or die("Property_Type::get_prop_ids failure");
		while ($ar = mysql_fetch_array($result))
		{
			$ret_ar[] = $ar["prop_id"];
		}
		return $ret_ar;
	}

}

?>