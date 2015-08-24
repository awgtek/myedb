<?php
//include_once (dirname(__FILE__) .'/../Security/EntityManagementSystems.php');
//include_once (dirname(__FILE__) .'/../Security/myentitydb_Access_user.php');
//include_once (dirname(__FILE__) .'/../Security/RestrictFunctionDict.php');
//include_once (dirname(__FILE__) .'/../Security/EntDict.php');

class SecurityOperationsMain
{

	var $xml_string;
	var $xslt_file;

	function SecurityOperationsMain()
	{
		$this->xslt_file = "";
		
	}

	function user_auth_output_function_check($output_function_name)
	{
		$funcauthlevel = RestrictFunctionDict::get_output_function_auth_level($output_function_name);
		if (false)
		{ 
			return true; //function not restricted
		}
		else
		{
			$usereidgetter = new myentitydb_Access_user();
			$user_id = $usereidgetter->get_user_eid();
			$authar = EntityManagementSystems::get_vals($user_id, EntDict::get_prop_id("userauthlevel"), EntDict::get_type_id("user"));
			$userauthlevel = $authar[0]; //only one result; assumes user has only one level
			
			return $userauthlevel >= $funcauthlevel;

		}

	}

	function passed_security_check(&$xml_string)
	{
		$passed = false; 
		if ($this->is_login_page_post())
		{// echo "<br>in login page post..";
			$passed = $this->process_login();//echo "yoooin Passed sec check";
			$this->unset_login_page_post();
		}
		elseif ($this->is_logout_page_post())
		{ 
			$passed = $this->process_logout();
			$this->unset_login_page_post();
		}
		else 
		{
			$passed = $this->check_user();//echo "checking user ".$passed;
		}
	//	$active_tester = new myentitydb_Access_user(true,true);
	//	$active_tester->debug = true;
	//	debug_print_backtrace() ;
	//		echo "<br>SOM passed_security_check,".$active_tester->cookie_name." is cookie name, cookie path: ".
	//		$active_tester->cookie_path." user: ".$active_tester->user.
	//			" pass: ".$active_tester->user_pw."<br>";
		
		//$xslt_file = $this->xslt_file;
		//return empty($this->xslt_file); //would be set to same form if failed
		if ($passed)
		{//echo "checking whether user is active...";
			$passed = $this->is_user_active();
		}
		$xml_string = $this->xml_string;
		return $passed;
	}

	function is_user_active()
	{
		$passed = true;
		$active_tester = new myentitydb_Access_user();
		
		if (!$active_tester->is_active())
		{
			$passed = false;
			$this->xml_string = $active_tester->xml_string;
		}
		return $passed;
	}

	function check_user()
	{
//	$_SESSION['user'] = "test_users";
//	$_SESSION['pw'] = "password";
		$test_access_level = new myentitydb_Access_user();
		if (!$test_access_level->access_page($_SERVER['PHP_SELF'], $_SERVER['QUERY_STRING'] ,1)) // change this value to test differnet access levels (default: 1 = low and 10 high)
		{
			//echo "in SOM check user, didn't pass access page<br>";
			$this->xml_string = $test_access_level->xml_string;
			$this->xslt_file = $test_access_level->xslt_file;
			return false;
		} //echo "passssed";
		if (!$test_access_level->is_logged_in() )
		{ //echo "hellcooo no no:".$test_access_level->is_logged_in();
			$this->xml_string = $test_access_level->xml_string;
			$this->xslt_file = $test_access_level->xslt_file;
			return false;
		}
		//	$rec_count = EntityManagementSystems::get_eid_rec_count($user_id, 7, 3); 
	//	return ($rec_count == 1);
		return true;
	}
	
	function process_login()
	{ //echo "in process_login<br>";
		$process_success = false; 
		$loginuser = new myentitydb_Access_user(); 
		if ($loginuser->is_logged_in())
		{
			$loginuser->log_out();
			//return true; //already logged in!
		}
		$process_success = $loginuser->process_login();//echo "right thereee";
		$this->xml_string = $loginuser->xml_string;
		//$this->xslt_file = $loginuser->xslt_file;
	//	$_SESSION['user'] = $_REQUEST['login'];
	//	$_SESSION['pw'] = $_REQUEST['pw'];
		
		return $process_success;
	}
	
	function process_logout()
	{ //echo "in process_logout<br>";
		$logout_processor = new myentitydb_Access_user();
		$logout_processor->process_logout();
		$this->xml_string = $logout_processor->xml_string;
		return false;
	}
	
	function is_login_page_post()
	{
		return $_REQUEST['target_component'] == "SecurityOperationsFacade" &&
			$_REQUEST['target_function'] == "process_login";
	}
	
	function is_logout_page_post()
	{
		return $_REQUEST['target_component'] == "SecurityOperationsFacade" &&
			$_REQUEST['target_function'] == "process_logout";
	}
	
	function unset_login_page_post()
	{
		unset($_REQUEST['target_component']);
		unset($_REQUEST['target_function']);
	}
	
	function get_user_type_id()
	{
		return  EntDict::get_type_id("user");
	}

}

?>