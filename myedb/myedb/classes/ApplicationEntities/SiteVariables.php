<?php 
//include_once (dirname(__FILE__) . '/AppEntities_EntityManagementSystems.php');

class SiteVariables
{
	var $_type_id = 15; //site_variable
	var $_eid = 11; //reserved eid for site_variable records

	function get_travel_order_confirmation_email_info()
	{
		$email_info = array();
		list($email_info['confirm_travel_order_email_subject']) = AppEntities_EntityManagementSystems::get_vals(
			11, AppEntities_EntityManagementSystems::get_prop_id("confirm_travel_order_email_subject"), 15);
		list($email_info['confirm_travel_order_email_message']) = AppEntities_EntityManagementSystems::get_vals(
			11, AppEntities_EntityManagementSystems::get_prop_id("confirm_travel_order_email_message"), 15);
		
		return $email_info;
	}

	function get_email_info($eid)
	{
		$email_info = array();
		list($email_info['email_subject']) = AppEntities_EntityManagementSystems::get_vals(
			$eid, AppEntities_EntityManagementSystems::get_prop_id("email_subject"), 15);
		list($email_info['email_message']) = AppEntities_EntityManagementSystems::get_vals(
			$eid, AppEntities_EntityManagementSystems::get_prop_id("email_message"), 15);
		
		return $email_info;
	}

	
}
?>