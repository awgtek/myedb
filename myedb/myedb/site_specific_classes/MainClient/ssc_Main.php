<?
session_start();
	include_once (dirname(__FILE__).'/../../functions/commonfunc.php');
site_setup();
     //  echo "<br>78 yo".microtime(true); flush();



//include_once (dirname(__FILE__) .'/../OutputSystem/ssc_OutputOperationsFacade.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/RequestProcessor.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/Main_SecuritySystem.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/ScalarQueries.php');
//include_once (dirname(__FILE__).'/../../serverspfc/dbstup.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/AppConfig.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/ScalarQueries.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Security/SecurityOperationsFacade.php');
   //    echo "<br>79 yo".microtime(true); flush();

//echo "YOO".$server;
class ssc_Main extends Main
{
	function ssc_Main()
	{
		parent::Main();
	}
	
}

class ssc_MainOld
{

	var $xml_string;
	var $xslt_file;

	function ssc_Main()
	{
		mysql_connect(GI_SERVER,GI_USER,GI_PASS);
		mysql_select_db(GI_DB);
		$link = mysqli_connect(GI_SERVER,GI_USER,GI_PASS, GI_DB);
		$_SESSION['mysqli_link'] = $link;
	}

	function run()
	{
	//	echo date('h:i:s A')." - just entered run<br>";
		//echo microtime()."Main:run just entered run() <br>";
		//$output_function = "output_template";
		//$mss = new Main_SecuritySystem();
		//if (!$mss->passed_security_check($this->xml_string) && $_REQUEST['target_function'][0] != "register_user") //handles login page post
		if (false) //won't be using this for now
		{
			$output_function = $mss->output_function;
		}
		//if (SecurityOperationsFacade::passed_security_check($this->xml_string, $this->xslt_file))
		else
		{
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
		
			//echo microtime()."Main:run before new RequestProcessor() <br>";
			$rp = new RequestProcessor();
			//echo microtime()."Main:run after new RequestProcessor() <br>";
			$output_function = $rp->process_request($this->xml_string, $this->xslt_file);
			//echo microtime()."Main:run after RequestProcessor::process_request <br>";
		}
		//echo microtime()."Main:run before user_authorized_output_function_check <br>";
		//	echo date('h:i:s A')." - just got output function<br>";
		/*if (!$mss->user_authorized_output_function_check($output_function))
		{
			die ("Unauthorized Access Attempt!");
		}*/
		$oof = new ssc_OutputOperationsFacade;
		//echo microtime()."Main:run before output_function <br>";
		if ($_REQUEST['OF_passthru'])
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
		{//echo "yoooo1"; die();
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

	
/*	function homepage()
	{
	//	http://172.16.34.3/index.php?target_component%5B%5D=RecordIniFacade&
	//	target_function%5B%5D=initialize&eid=188&OF_passthru=edit_trade_of_the_day_properties
			$_REQUEST['target_component'] = array('RecordIniFacade');
			$_REQUEST['target_function'] = array('initialize');
			$_REQUEST['eid'] = 1;
	//		$_REQUEST['target_function'] = array('search_by_prop_val');
	//		$_REQUEST['spi'] = 6;
	//		$_REQUEST['spv'] = 3;
	//		$_REQUEST['type_id'] = 1;
		//	$_REQUEST['output_function'] = "output_paged_templated_content"; 
			$_REQUEST['OF_passthru'] = "edit_trade_of_the_day_properties"; 
		
	}
	*/
	
	function homepageWithSecurity()
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