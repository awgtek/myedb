<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/view_x_prop_to_e_p_to_e.php');
//include_once(dirname(__FILE__) .'/../MainClient/AppConfig.php');

class view_varchar_prop_to_e_p_to_e extends view_x_prop_to_e_p_to_e
{

	function get_eids($search_val, $prop_id, $type_id)
	{
		if (empty($search_val))
		{
			$search_val = " ";
		}
		
		$search_val = sanitize($search_val);
		$prop_id = sanitize($prop_id);
		$type_id = sanitize($type_id);
		
		$sql = sprintf("select eid from view_varchar_prop_to_e_p_to_e where
varchar_val = '%s' and prop_id = %s and type_id = %s ",$search_val,$prop_id,$type_id);
		$eids = array();// echo $sql;//debug_print_backtrace();
		$result = mysql_query($sql);
		if (mysql_num_rows($result) > 0)
		{
			while ($row = mysql_fetch_array($result))
			{
				$eids[] = $row['eid'];
			}
		}
		return $eids;
	}
	


}

?>