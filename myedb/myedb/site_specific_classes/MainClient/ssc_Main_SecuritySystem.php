<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Security/SecurityOperationsFacade.php');


class ssc_Main_SecuritySystem extends Main_SecuritySystem
{
	
}

class ssc_Main_SecuritySystemOld
{
	var $output_function;

	function passed_security_check(&$xml_string)
	{
		$passed = false;
		$passed = SecurityOperationsFacade::passed_security_check($xml_string);
		if (!$passed)
		{
			$this->output_function = "show_login";
		}
		return $passed;
	}

	function user_authorized_output_function_check($output_function_name)
	{
		return SecurityOperationsFacade::user_authorized_output_function_check($output_function_name);
	}
	
	function get_user_auth_level()
	{
		return SecurityOperationsFacade::get_user_auth_level();
	}
}


?>