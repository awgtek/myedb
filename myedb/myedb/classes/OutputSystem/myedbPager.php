<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/MainClient/AppConfig.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/AppLibrary/MyEDB_Pager.php");

class myedbPager extends MyEDB_Pager
{
	//var $per_page = 4;
	
	function __construct()
	{
		parent::__construct();
	}
	
}

?>