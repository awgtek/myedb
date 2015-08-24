<?php
require_once dirname(__FILE__) . '\SiteVariables.php'; 
//include_once(dirname(__FILE__) . '\..\MainClient/AppConfig.php');
//include_once (dirname(__FILE__) .'\..\..\serverspfc/dbstup.php');


class test extends UnitTestCase {

 function test_emailproducer2(){
 	echo "starting...";
 //	echo AppConfig::gacv("AC_server")."yohoo";flush();
 	mysql_connect(GI_SERVER,GI_USER,GI_PASS);
 	mysql_select_db(GI_DB);
 	$tc = new SiteVariables();
 	echo "helllll7ff";
 	$ar = $tc->get_travel_order_confirmation_email_info();
 	//$res = $tc->send_basic_text_email(array("adamwg@hotmail.com"), array("jolifam77@yahoo.com"), 
 	//		"email subject", "hello ths is my email body");
 	print_r($ar);
 	$this->assertTrue($ar["confirm_travel_order_email_subject"] == "my subject");
	//$this->assertFalse($boolean2);
 }
}
?>