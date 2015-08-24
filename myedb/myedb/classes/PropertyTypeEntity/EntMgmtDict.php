<?php

//todo replace calls with calls to EntityMgmt_Facade
class EntMgmtDict
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
		$idhash['first_name'] = 9;
		$idhash['last_name'] = 36;
		$idhash['email_address'] = 55;
		$idhash['results_per_page'] = 62;
		$idhash['confirm_travel_order_email_subject'] = 63;
		$idhash['confirm_travel_order_email_message'] = 64;
		$idhash['email_subject'] = 66;
		$idhash['email_message'] = 67;
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