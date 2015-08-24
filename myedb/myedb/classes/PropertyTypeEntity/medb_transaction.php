<?php


class medb_transaction
{

	static function get_unrealized_transactions_by_eidsrc($eidsrc)
	{
		$retar = array();
		$sql = sprintf("SELECT * FROM medb_transaction WHERE eidsrc = %s AND realized = 0",$eidsrc);
		$result = mysql_query($sql);
		while ($row = mysql_fetch_assoc($result))
		{
			$retar[] = $row;
		}
		return $retar;
	}

}


?>