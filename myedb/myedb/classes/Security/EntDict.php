<?php

class EntDict
{

	
	static function get_prop_id($prop_alias)
	{
		$idhash = array();
		$idhash["userid"] = 7;
		$idhash["userpass"] = 8;
		$idhash["userauthlevel"] = 25;
		$idhash['accountno'] = 33;
		$idhash['registered'] = 34;
		$idhash['active'] = 31;
		return $idhash[$prop_alias];
	}

	static function get_type_id($type_alias)
	{
		$idhash = array();
		$idhash["user"] = 3;
		return $idhash[$type_alias];
	}

}

?>