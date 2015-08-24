<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Security/SecurityOperationsFacade.php');


class Main_SecuritySystem
{
	var $output_function;
	var $authenticated = false;

	function passed_security_check(&$xml_string)
	{ 
		$passed = false;
		$passed = SecurityOperationsFacade::passed_security_check($xml_string);
		if (!$passed)
		{
			$this->output_function = "show_login";
		}
		$this->authenticated = $passed;
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
	
	static function get_user_eid()
	{
		return SecurityOperationsFacade::get_user_eid();
	}
	
}


?>