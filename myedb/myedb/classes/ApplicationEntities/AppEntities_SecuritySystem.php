<?php
//include_once (dirname(__FILE__) .'/../Security/SecurityOperationsFacade.php');


class AppEntities_SecuritySystem
{
	static function get_user_eid()
	{
		return SecurityOperationsFacade::get_user_eid();
	}

}

?>