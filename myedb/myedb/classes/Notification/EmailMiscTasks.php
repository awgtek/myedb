<?php
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Notification/Notification_EntityManagementSystems.php');

class EmailMiscTasks
{
	
	function get_email_address($user_eid)
	{
		list($email_address) = Notification_EntityManagementSystems::get_vals($user_eid, 
		Notification_EntityManagementSystems::get_prop_id("email_address"),
		 Notification_EntityManagementSystems::get_type_id("user"));
		return $email_address;
	}
	
	function get_admin_eids()
	{
		$eids = Notification_EntityManagementSystems::get_eids(3, 25, 3, 1);
		return $eids;
	}
}
?>