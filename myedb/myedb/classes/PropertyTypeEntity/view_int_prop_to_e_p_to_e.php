<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/view_x_prop_to_e_p_to_e.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/EntityMgmt_ClientServerDataOps.php');

class view_int_prop_to_e_p_to_e extends view_x_prop_to_e_p_to_e
{

	function get_eids($search_val, $prop_id, $type_id, $search_compare_op)
	{  
		$search_val = sanitize($search_val);
		$prop_id = sanitize($prop_id);
		$type_id = sanitize($type_id);
		
		$compare_op = "=";
		if (is_numeric($search_compare_op))
		{
			if ($search_compare_op > 0)
			{
				$compare_op = ">";
			}
			else if ($search_compare_op < 0)
			{
				$compare_op = "<";
			}
		}
		$sql = sprintf("select eid from view_int_prop_to_e_p_to_e where
int_val %s %s and prop_id = %s and type_id = %s ",$compare_op, $search_val,$prop_id,$type_id); //echo $search_compare_op."--<br>".$sql;
		$eids = array();
		$result = mysql_query($sql);
		while ($row = mysql_fetch_array($result))
		{
			$eids[] = $row['eid'];
		}
		return $eids;
	}

}

?>