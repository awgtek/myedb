<?php


class prop_qualifier
{
	function get_prop_qualifiers($prop_group_ids, $prop_ids)
	{
		array_push($prop_group_ids,0);
		array_push($prop_ids,0);
		$sql = "SELECT * FROM prop_qualifier WHERE prop_group_id IN (".join(",",$prop_group_ids).") OR prop_id IN (".join(",",$prop_ids).")";
		$retar = array();
		$result = mysql_query($sql);
		while ($row = mysql_fetch_assoc($result))
		{
			$retar[] = $row;
		}
		return $retar;
	}

}


?>