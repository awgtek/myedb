<?php
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Notification/EmailProducer.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Notification/EmailMiscTasks.php');

class EmailManagement
{
	
	function email_user_cc_admins($user_eid, $subject, $message)
	{
		$email_producer = new EmailProducer();
		$email_misc_tasks = new EmailMiscTasks();
		$admin_emails = array();
		$admin_eids = $email_misc_tasks->get_admin_eids();
		$user_email = $email_misc_tasks->get_email_address($user_eid);
		foreach($admin_eids as $admin_eid)
		{
			$admin_emails[] = $email_misc_tasks->get_email_address($admin_eid);
		}
		
		
		return $email_producer->send_basic_text_email(array($user_email),$admin_emails,$subject,$message);
	}

	function email_user_by_eid($user_eid, $subject, $message)
	{
		$email_producer = new EmailProducer();
		$email_misc_tasks = new EmailMiscTasks();
		$user_email = $email_misc_tasks->get_email_address($user_eid);
		//echo "sending to ".$user_email;
		return $email_producer->send_basic_text_email(array($user_email),array(),$subject,$message);
	}

	static function email_developer($subject, $message)
	{
		$developer_email = AppSettings::gv("developer_email");
		$email_producer = new EmailProducer();
		return $email_producer->send_basic_text_email(array($developer_email),array(),$subject,$message);
		
	}	
	
	static function email_to_defined_email_address($myent_settings_email, $subject, $message)
	{
		$the_email = AppSettings::gv($myent_settings_email);
		$email_producer = new EmailProducer();
		return $email_producer->send_basic_text_email(array($the_email),array(),$subject,$message);
		
	}	
	
}
?>