<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/view_x_prop_to_e_p_to_e.php');

class view_boolean_prop_to_e_p_to_e extends view_x_prop_to_e_p_to_e
{

	function get_eids($search_val, $prop_id, $type_id)
	{
		$search_val = sanitize($search_val);
		$prop_id = sanitize($prop_id);
		$type_id = sanitize($type_id);
		
		$sql = sprintf("select eid from view_boolean_prop_to_e_p_to_e where
boolean_val = '%s' and prop_id = %s and type_id = %s ",$search_val,$prop_id,$type_id);
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