<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Security/SecurityOperationsFacade.php');


class Output_SecuritySystem
{
	static function get_user_auth_level()
	{
		return SecurityOperationsFacade::get_user_auth_level();
	}
	
	static function get_user_eid()
	{
		return SecurityOperationsFacade::get_user_eid();
	}
	
}


?>