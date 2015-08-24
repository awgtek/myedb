<?php
//include_once (dirname(__FILE__) .'/../Security/SecurityOperationsMain.php');
//include_once (dirname(__FILE__) .'/../Security/myentitydb_Access_user.php');
//include_once (dirname(__FILE__) .'/../Security/UserRegistration.php');

class SecurityOperationsFacade
{
	function passed_security_check(&$xml_string)
	{
		$secops = new SecurityOperationsMain();
		return $secops->passed_security_check($xml_string);
	}
	
	static function get_user_eid()
	{
		$usereidgetter = new myentitydb_Access_user();
		return $usereidgetter->get_user_eid();
	}
	
	static function get_user_auth_level()
	{
		$userauthgetter = new myentitydb_Access_user();
		return $userauthgetter->get_user_auth_level();
	}
	
	static function user_authorized_output_function_check($output_function_name)
	{
		return SecurityOperationsMain::user_auth_output_function_check($output_function_name);
	}
	
	static function get_user_type_id()
	{
		return SecurityOperationsMain::get_user_type_id();
	}

	function register_user(&$xml_string)
	{
		UserRegistration::register_user();
	}
	
	function send_user_activation_email(&$xml_string, &$xslt_file)
	{
		UserRegistration::send_user_activation_email();
	}
	
	function forgot_password(&$xml_string, &$xslt_file)
	{
		$usercheck = new CheckingUser();
		$usercheck->forgot_password();
		$usercheck->set_xml_string_using_msg();
		$xml_string = $usercheck->xml_string;
	}
	
	function check_activation_password(&$xml_string, &$xslt_file)
	{
		$usercheck = new CheckingUser();
		$usercheck->check_activation_password($_REQUEST['activate'], $_REQUEST['id']);
		$usercheck->set_xml_string_using_msg();
		$xml_string = $usercheck->xml_string;
	}
	
	
	
}

?>