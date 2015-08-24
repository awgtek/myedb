<?php
//include_once (dirname(__FILE__) .'/../ApplicationEntities/User.php');
//include_once (dirname(__FILE__) .'/../ApplicationEntities/SiteVariables.php');


class AppEntities_Facade
{

	public static function get_user_instance()
	{
		return User::get_user_instance();
	}

	public function get_travel_order_confirmation_email_info()
	{
		return SiteVariables::get_travel_order_confirmation_email_info();
		
	}
	
	public function get_email_info($eid)
	{
		return SiteVariables::get_email_info($eid);
		
	}
	
	public function getAppEntitiesInstance()
	{
		return new AppEntities();
	}
	
}


?>