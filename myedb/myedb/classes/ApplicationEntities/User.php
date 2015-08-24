<?php
//include_once (dirname(__FILE__) .'/../ApplicationEntities/AppEntities_SecuritySystem.php');
//include_once (dirname(__FILE__) .'/../ApplicationEntities/AppEntities_EntityManagementSystems.php');

class User
{
	var $full_name;
	var $user_id;
	var $results_per_page;
	
	function __construct($user_id=0)
	{
		if (!$user_id)
		{
			$this->user_id = AppEntities_SecuritySystem::get_user_eid();
		}
		list($first_name) = AppEntities_EntityManagementSystems::get_vals($this->user_id, AppEntities_EntityManagementSystems::get_prop_id("first_name"), AppEntities_EntityManagementSystems::get_type_id("user"));
		list($last_name) = AppEntities_EntityManagementSystems::get_vals($this->user_id, AppEntities_EntityManagementSystems::get_prop_id("last_name"), AppEntities_EntityManagementSystems::get_type_id("user"));
		$this->full_name = $first_name . " " . $last_name;
		list($results_per_page) = AppEntities_EntityManagementSystems::get_vals($this->user_id, AppEntities_EntityManagementSystems::get_prop_id("results_per_page"), AppEntities_EntityManagementSystems::get_type_id("user"));
		$this->results_per_page = $results_per_page;
	}
	
	//factory method
	public static function get_user_instance()
	{
		return new User();
	}


}


?>