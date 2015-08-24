<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/VoidQueries.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Security/SecurityOperationsFacade.php');


class TransMgmt_SecuritySystem
{
	static function get_user_eid()
	{
		return SecurityOperationsFacade::get_user_eid();
	}

	static function get_user_type_id()
	{
		return SecurityOperationsFacade::get_user_type_id();
	}
}

?>