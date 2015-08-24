<?
//echo "yo1";
//session_start();
//echo "yoo1";
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Security/SecurityOperationsFacade.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/OutputOperationsFacade.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/RequestProcessor.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/Main_SecuritySystem.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/ScalarQueries.php');
//		include_once ($_SERVER['DOCUMENT_ROOT'].'/serverspfc/dbstup.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/AppConfig.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/ScalarQueries.php');

//echo "YOO".$server;
class Main
{

	var $xml_string;
	var $xslt_file;
	var $non_auth_target_functions;
	var $non_auth_output_functions;

	function Main()
	{
		mysql_connect(GI_SERVER,GI_USER,GI_PASS);
		mysql_select_db(GI_DB);
		$link = mysqli_connect(GI_SERVER,GI_USER,GI_PASS, GI_DB);
		$_SESSION['mysqli_link'] = $link;
		
		$mysqli = new mysqli(GI_SERVER,GI_USER,GI_PASS, GI_DB); 

		/* check connection */ 
		if (mysqli_connect_errno()) { 
		    printf("Connect failed: %s\n", mysqli_connect_error()); 
		    exit(); 
		} 
		
		$_SESSION['mysqli_obj'] = $mysqli;
		
		$this->non_auth_target_functions = array();
		$this->non_auth_target_functions[] = "register_user";//handles login page post
		$this->non_auth_target_functions[] = "forgot_password";//handles login page post
		$this->non_auth_target_functions[] = "check_activation_password";//handles login page post
		
		$this->non_auth_output_functions = array();
		$this->non_auth_output_functions[] = "request_new_password";
		//$this->non_auth_output_functions[] = "reset_password";
		
		
	}

	function run()
	{
	//	echo date('h:i:s A')." - just entered run<br>";
		//echo microtime()."Main:run just entered run() <br>";
		//$output_function = "output_template";
		//echo "<br>Main,  searcresrowcount".$_SESSION['search_res_row_cnt'];
		if ($_REQUEST['er'])
		{
			$un_encrypted_request = myedb_decrypt($_REQUEST['er']);
			if (!strstr($un_encrypted_request,"check_activation_password")) die ("error: bad link");
			eval($un_encrypted_request); //echo $_REQUEST['id']." -yooo- ".$_REQUEST['activate'];
		}
		
		$mss = new Main_SecuritySystem();

		$bypass_auth = in_array($_REQUEST['target_function'][0],$this->non_auth_target_functions)
			|| in_array($_REQUEST['OF_passthru'],$this->non_auth_output_functions);
		
		if (!$mss->passed_security_check($this->xml_string) 
			&& !$bypass_auth) 
		{//echo "didn't pass";
			$output_function = $mss->output_function;
		}
		//if (SecurityOperationsFacade::passed_security_check($this->xml_string, $this->xslt_file))
		else
		{// echo "did pass";
			if (!isset($_REQUEST['target_component']))
			{ 
				if (isset($_REQUEST['ntctf']))
				{
					$this->setup_for_no_server_side_content();
				}
				else if (isset($_REQUEST['pl']))
				{
					$this->set_product_lookup_page();
				}
				else
				{
					$this->set_default_site_page();
				}
			}
		
			//echo microtime()."Main:run before new RequestProcessor() <br>"; flush();
			$rp = new RequestProcessor();
			//echo microtime()."Main:run after new RequestProcessor() <br>"; flush();
			$output_function = $rp->process_request($this->xml_string, $this->xslt_file);
			//echo microtime()."Main:run after RequestProcessor::process_request <br>"; flush();
		}

		//echo microtime()."Main:run before user_authorized_output_function_check <br>";
		//	echo date('h:i:s A')." - just got output function<br>";
		if (!$mss->user_authorized_output_function_check($output_function))
		{
			
			$cur_user_eid = Main_SecuritySystem::get_user_eid();
			$subject = "unauthorized access attempt";
			$message = "user with eid ".$cur_user_eid." attempted to access ".$output_function; 
			NotificationSys::email_developer($subject,$message);
			die ("Unauthorized Access Attempt!");
		}
		$oof = new OutputOperationsFacade;
		//echo microtime()."Main:run before output_function <br>";
		if ($_REQUEST['OF_passthru'] && 
			($mss->authenticated || $bypass_auth))
		{
			$oof->output_function_passthru($this->xml_string, $_REQUEST['OF_passthru']); 
			//echo "<br>output function:".$_REQUEST['OF_passthru'];
		}
		else
		{
			$oof->$output_function($this->xml_string, $this->xslt_file);
		}
		//echo microtime()."Main:run after output_function <br>";
		//echo date('h:i:s A')." - just exec'd output function<br>";
	}

	function setup_for_no_server_side_content()
	{
		$target_component = array();
		$target_component[] = "RecordIniFacade";
		$target_function = array();
		$target_function[] = "donothing";
		$_REQUEST['target_component'] = $target_component;
		$_REQUEST['target_function'] = $target_function;
		
	}

	function set_product_lookup_page()
	{
//http://172.16.2.74/index.php?target_component%5B%5D=RecordIniFacade&target_function%5B%5D=initialize&eid=18&type_id=1&OF_passthru=show_purchasable_product		$_REQUEST['eids'] = array(4,5,6);

		$_REQUEST['type_id'] = ScalarQueries::get_type_id($_REQUEST['pl']);
		$_REQUEST['eid'] = $_REQUEST['pl'];
		$target_component = array();
		$target_component[] = "RecordIniFacade";
		$target_function = array();
		$target_function[] = "initialize";
		$_REQUEST['target_component'] = $target_component;
		$_REQUEST['target_function'] = $target_function;
		if (ScalarQueries::get_type_id($_REQUEST['eid']) == 4)
		{
			$_REQUEST['OF_passthru'] = "show_travel_item";
		}
		else
		{
			$_REQUEST['OF_passthru'] = "show_purchasable_product";
		}
		
	}

	function set_default_site_page()
	{
		$this->homepage();
	}

	function test2()
	{
		$_REQUEST['eids'] = array(4,5,6);
		$_REQUEST['type_id'] = 1;
		$target_component = array();
		$target_component[] = "RecordIniFacade";
		$target_function = array();
		$target_function[] = "initializeRecordSet";
		$_REQUEST['target_component'] = $target_component;
		$_REQUEST['target_function'] = $target_function;
		$_REQUEST['output_function'] = "output_paged_templated_content";
		//$_REQUEST['output_function'] = "admin_paged_content";
		//RecordIniFacade::initializeRecordSet($this->xml_string);
	//	$this->output_function = "output_paged_templated_content";
	//	OutputOperationsFacade::paginateXML($this->xml_string, $this->xslt_file);

	}

	function homepage()
	{
		$mss = new Main_SecuritySystem();
		$authlevel = $mss->get_user_auth_level();
		if ($authlevel >= 1)
		{
//http://172.16.2.74/index.php?target_component%5B%5D=RecordIniFacade&target_function%5B%5D=search_by_prop_val_contains&spi=1&spv=&type_id=1&output_function=admin_paged_content
			$_REQUEST['target_component'] = array('RecordIniFacade');
			$_REQUEST['target_function'] = array('donothing');
	/*		$_REQUEST['spi'] = 6;
			$_REQUEST['spv'] = 3;
			$_REQUEST['type_id'] = 1; */
			$_REQUEST['OF_passthru'] = "welcome_page"; 
		}
		else
		{
			$_REQUEST['target_component'] = array('MetaDataOps');
			$_REQUEST['target_function'] = array('FI_get_xml_list');
	//		$_REQUEST['target_function'] = array('search_by_prop_val');
	//		$_REQUEST['spi'] = 6;
	//		$_REQUEST['spv'] = 3;
	//		$_REQUEST['type_id'] = 1;
		//	$_REQUEST['output_function'] = "output_paged_templated_content"; 
			$_REQUEST['OF_passthru'] = "public_welcome_page"; 
		}
	}






	function runOld()
	{
		$check_user_passed = false;
		$this->xslt_file = "";
		if ($this->is_login_page_post())
		{
			$this->process_request();
			$check_user_passed = empty($this->xslt_file); //would be set to same form if failed
			
		}
		else if ($this->check_user_passed())
		{
			//if (empty($this->xslt_file)) //previous process hasn't "claimed the page"
			//{
			$check_user_passed = true;
			if ($this->request_exists())
			{
				$this->process_request();
			}
			//}
		}
		
		//now that all postbacks are processed
		if ($check_user_passed)
		{
			if (empty($this->xslt_file)) //previous process hasn't "claimed the page"
			{
				$this->test2();
			}
		}
	}

	function check_user_passedOld()
	{
		//check to see if posting from login page before authenticating and denying access to 'process_request' if not logged in
	//	if ()
	//	{
	//		$this->process_request(); //SecurityOperationsFacade::process_login
			//unset $_REQUEST['target_component'] and $_REQUEST['target_function'] so that not processed again
			//unset($_REQUEST['target_component']);
			//unset($_REQUEST['target_function']);
	//		return empty($this->xslt_file); //if xslt_file was set then user hasn't validated
	//	}
	//	else
	//	{
			$passed = SecurityOperationsFacade::test_check_user($this->xml_string, $this->xslt_file);
			//if (!$passed)
			//{
			//	OutputOperationsFacade::output_template($xml_string, $xslt_file);
			//}
			return $passed;
	//	}
	//	echo "checking user (".$user.")...".SecurityOperationsFacade::test_check_user($user);
	}

}
?>