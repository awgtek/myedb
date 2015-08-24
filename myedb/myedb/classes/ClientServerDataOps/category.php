<?php
//include_once (dirname(__FILE__) .'/../ClientServerDataOps/LookupTable.php');

class category extends LookupTable
{
	

	/*function get_table()
	{
		$sql = "select * from category";
		$result = mysql_query($sql);
		$table_hash = array();
		while ($ar = mysql_fetch_array($result))
		{
			$table_hash[$ar['cat_id']] = $ar['cat_name'];
		}
		return $table_hash;

	}*/
	
	function get_list()
	{
		$lookup_table = new LookupTable("category");
		return $lookup_table->get_table();
	}
}

?>