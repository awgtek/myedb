<?php
//include_once (dirname(__FILE__) .'/../Security/EntDict.php');
//include_once (dirname(__FILE__) .'/../Security/EntityManagementSystems.php');
//include_once (dirname(__FILE__) .'/../Security/SecurityOperations_RecordSys.php');

class UserRegistration
{

	function is_registered($user_id)
	{
		$registered_ar = EntityManagementSystems::get_vals($user_id, EntDict::get_prop_id("registered"), EntDict::get_type_id("user")); //could get registered from xml above also
		if (count($registered_ar) == 1 )
		{
			$registered = $registered_ar[0]; //could be false or true, but shouldn't be false unless deliberately unchecked in admin
		}
		else
		{
			$registered = false;
		}
		return $registered;
	}

	function register_user()
	{
		//validation
		//user name
		$subject = trim($_REQUEST['pi7epi0ron0']); //user id
		$pattern = '/^[ \.A-Za-z0-9_!@\-#$^&*()?]*$/';
		$matched = preg_match($pattern, $subject);
		if (!$matched)
		{
			$_SESSION["process_result"] = "Invalid user name. Please try again.";
			return;
		}
		//password
		$subject = trim($_REQUEST['pi8epi0ron0']); //password
		$allowedchars = "[ A-Za-z0-9_!@\*\(\)\?]";
		//$allowedchars = "[ a-z]";
		$required1 = "[\d]";
		$required2 = "[A-Za-z]";
		$required = "(?:$allowedchars*$required1)(?:$allowedchars*$required2)|(?:$allowedchars*$required2)(?:$allowedchars*$required1)";
		$pattern = "/^$allowedchars*$required$allowedchars*$/";
		//$pattern = "/^$allowedchars*(?:$allowedchars{6,30})(?:$allowedchars*$required1)$allowedchars*$/";
		//$pattern = "/^[ a-z]*(?:[ a-z]*)(?:[ a-z]*[\d])[ a-z]*$/";
		//echo "subject=$subject<br>".$pattern."<br>";
		$matched = preg_match($pattern, $subject);
		if (!$matched or strlen($subject) < 6 or strlen($subject) > 30)//
		{
			$_SESSION["process_result"] = "Invalid password. Please try again. Use both letter(s) and number(s). Minimum 6 characters. The following special characters are also allowed: _!@*()?";
			return;
		}
		else
		{
			$_REQUEST['pi8epi0ron0'] = md5($subject);
		}
		//end password validation and md5
		
		$account_no = $_REQUEST['acctno'];
		$eids = EntityManagementSystems::get_eids($account_no, EntDict::get_prop_id("accountno"), EntDict::get_type_id("user"));
		if (count($eids) ==1)
		{
			$eid = $eids[0]; //assumes only 1 matching user in the database
			
			$_REQUEST['eid'] = $eid;
			$_REQUEST['type_id'] = 3;
			$rec_xml = SecurityOperations_RecordSys::get_record_xml();
			$xml = new SimpleXMLElement($rec_xml);

			$passelem = $xml->xpath('/record/property[@prop_id=8]');
			$passffi = $passelem[0]['ffi'];
			$useridelem = $xml->xpath('/record/property[@prop_id=7]');
			$useridffi = $useridelem[0]['ffi'];
			$regidelem = $xml->xpath('/record/property[@prop_id=34]');
			$regidffi = $regidelem[0]['ffi'];
			
			$registered = UserRegistration::is_registered($eid);
			if ($registered)
			{
				$_SESSION["process_result"] = "Error. Account already registered";
			}
			else
			{
				$_REQUEST['rec_eid'] = $eid;
				$_REQUEST['rec_type_id'] = 3;
				$_POST["$useridffi"] = $_REQUEST['pi7epi0ron0'];
				$_POST["$passffi"] = $_REQUEST['pi8epi0ron0'];
				$_POST["$regidffi"] = 1;
				SecurityOperations_RecordSys::update_user();
				//$_SESSION["process_result"] = "passed:".$eid." - pi7epi0ron0=" . $_REQUEST['pi7epi0ron0']." - pi8epi0ron0=" . $_REQUEST['pi8epi0ron0'];
				$_SESSION["process_result"] = "Thank you for registering. When you have received confirmation by email from New England Trade, you may then log in.";//." - passffi: ".$passffi." , useridffi: ".$useridffi." - pi7epi0ron0=" . $_POST["$useridffi"]." - pi8epi0ron0=" . $_POST["$passffi"];
			}

		}
		else
		{
			$eids = EntityManagementSystems::get_eids($_REQUEST['pi7epi0ron0'], EntDict::get_prop_id("userid"), EntDict::get_type_id("user"));
			if (count($eids) > 0)
			{
				$_SESSION["process_result"] = "User account already in use. Please choose another.";
				return;
			}
			
			$_REQUEST['eid'] = 0;
			$_REQUEST['type_id'] = 3;
			$_REQUEST['pi34epi0ron0'] = 1;
			$_REQUEST['pi25epi0ron0'] = -1; //user auth level
			$_REQUEST['pi33epi0ron0'] = $account_no;
				SecurityOperations_RecordSys::update_user();
			
			$new_user_eid = $_REQUEST['eid']; //this global variable gets set in Glue
			$app_entities = AppEntities_Facade::getAppEntitiesInstance();
			$email_info = AppEntities_Facade::get_email_info($app_entities->user_registration_email_to_approver); 
			$email_info["email_message"] = str_replace("[eid]",$new_user_eid,$email_info["email_message"]);
			NotificationSys::email_to_defined_email_address("registration_approver_email",
			$email_info["email_subject"],
				$email_info["email_message"]);
								//$_SESSION["process_result"] = "passed:".$eid." - pi7epi0ron0=" . $_REQUEST['pi7epi0ron0']." - pi8epi0ron0=" . $_REQUEST['pi8epi0ron0'];
				$_SESSION["process_result"] = "Thank you for registering. When you have received confirmation by email from New England Trade, you may then log in.";//." - passffi: ".$passffi." , useridffi: ".$useridffi." - pi7epi0ron0=" . $_POST["$useridffi"]." - pi8epi0ron0=" . $_POST["$passffi"];
			//$_SESSION["process_result"] = "Error. Account doesn't exist";
		}
	}

	function send_user_activation_email()
	{
		$app_entities = AppEntities_Facade::getAppEntitiesInstance();
		
		$email_info = AppEntities_Facade::get_email_info($app_entities->user_registration_approval_email); 
		NotificationSys::email_user_by_eid( $_REQUEST['eid'] ,
			$email_info["email_subject"],
				$email_info["email_message"]);
		
	}
}


?>