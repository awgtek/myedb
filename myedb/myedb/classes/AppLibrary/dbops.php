<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/AppConfig.php');


class dbops
{

	static function getpdo()
	{
		$dbh = new PDO('mysql:dbname='.AppConfig::gacv("AC_db").';host='.AppConfig::gacv("AC_server"),AppConfig::gacv("AC_user"),AppConfig::gacv("AC_pass")); 
		return $dbh;
	}


}


?>