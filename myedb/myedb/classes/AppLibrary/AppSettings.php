<?php


class AppSettings
{

	static $pswd_prefix = "password_";
	static $pswd_chk_prefix = "password_chk_";
	static function gv($key)
	{
		$c = new Configuration(); //in myedb_locspfc
		return $c->$key;
	}

}




?>