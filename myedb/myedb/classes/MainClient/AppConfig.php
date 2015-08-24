<?php
//include_once (dirname(__FILE__) .'/../../serverspfc/dbstup.php');
//include_once (dirname(__FILE__) .'/../ApplicationEntities/User.php');
//include_once (dirname(__FILE__) .'/../ApplicationEntities/AppEntities_Facade.php');

class AppConfig
{
	var $default_rows_per_page = 25;
	//"remove when absent" is for removing checkbox fields from session 
	var $persisted_paged_search_keys = array("cspi","cspv","cspt"=>"remove_when_absent","cspve"=>"remove_when_absent","cspvi"=>"remove_when_absent","spi","spv","type_id","srtpi","output_function","search_res_row_cnt","spc","spt","spg");
	var $AC_server;
	var $AC_user;
	var $AC_pass;
	var $AC_db;
	
	function __construct()
	{
//include_once ($_SERVER['DOCUMENT_ROOT'].'/serverspfc/dbstup.php');
		$this->AC_server = GI_SERVER;
		$this->AC_user = GI_USER;
		$this->AC_pass = GI_PASS;
		$this->AC_db = GI_DB;
		$logged_in_user = AppEntities_Facade::get_user_instance();
		$results_per_page = $logged_in_user->results_per_page;
		if ($results_per_page)
		{
			$this->default_rows_per_page = $results_per_page;
		}
		
	}
	
	static function get_app_config()
	{
		$appconfig = new AppConfig();
		return $appconfig;
	}
	
	static function get_app_config_var($thevar)
	{
		$appconfig = new AppConfig();
		return $appconfig->$thevar;
	}

	//alias
	static function gacv($thevar)
	{ 
		return AppConfig::get_app_config_var($thevar);
	}
}


?>