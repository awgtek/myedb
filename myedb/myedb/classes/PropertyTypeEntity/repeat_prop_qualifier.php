<?php


class repeat_prop_qualifier
{

	function get_rpqs($eid)
	{
		$sql = "SELECT * FROM repeat_prop_qualifier WHERE eid = '$eid'";
		$result = mysql_query($sql);
		$retar = array();
		while ($row = mysql_fetch_assoc($result))
		{
			$retar[] = $row;
		}
		return $retar;
	}


}



?>