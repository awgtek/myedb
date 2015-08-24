<?php
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Notification/EmailManagement.php');


class NotificationSys
{
	
	static function email_user_cc_admins($user_id, $subject, $message)
	{
		EmailManagement::email_user_cc_admins($user_id, $subject, $message);
	}
	
	static function email_user_by_eid($user_id, $subject, $message)
	{
		return EmailManagement::email_user_by_eid($user_id, $subject, $message);
	}
	
	static function email_developer($subject, $message)
	{
		EmailManagement::email_developer($subject, $message);
	}
	
	static function email_to_defined_email_address($myent_settings_email,$subject,$message)
	{
		return EmailManagement::email_to_defined_email_address($myent_settings_email,$subject, $message);
		
	}
	
}
?>