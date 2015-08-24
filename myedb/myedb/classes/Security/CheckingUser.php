<?php

//class for cases where this->user is set before the user is logged in, i.e. before session user variable is set 
class CheckingUser extends myentitydb_Access_user
{
	
	function __construct()
	{
		$this->xml_string = "<login_form><temp></temp></login_form>";
		$this->user = $_REQUEST['pi7epi0ron0'].$_REQUEST['id']; //one or the other
		
	}
	
	function send_mail($user_eid,$message_no,$subject_no)
	{
		return NotificationSys::email_user_by_eid( $user_eid ,
			$this->messages($subject_no),
				$this->messages($message_no));
		
	}
}
?>