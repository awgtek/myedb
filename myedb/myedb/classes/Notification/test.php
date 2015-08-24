<?php
//require_once("C:/Users/AdamG/Documents/jobs/GaryInsider/iis_site/"."/test.php");
//require_once('../classes/Notification_EntityManagementSystems.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/EntityMgmt_Facade.php');

//include_once ('C:/Users/AdamG/Documents/jobs/GaryInsider/site/classes/Notification/Notification_EntityManagementSystems.php');
//include_once ('C:/Users/AdamG/Documents/jobs/GaryInsider/site/classes/Notification/testclass.php');
//include_once ('C:/Users/AdamG/Documents/jobs/GaryInsider/site/classes/Notification/testclass.php');

require_once dirname(__FILE__) . '\testclass.php'; 
//echo "::".dirname(__FILE__) ."herlellerle";
class testclass1
 {
 	function testclass()
 	{
 		
 	}
 	
 	function te1stclassst()
	{
		return "How";
	}
 
 }


class test extends UnitTestCase {
 //function test_pass2(){
 //$boolean = false;
 //$this->assertFalse($boolean);
 //}
 function test_pass(){
 	$tc = new te1stclass();
 $boolean2 = $tc->te1stclassst() == "H1ow";
 $this->assertFalse($boolean2);
 }
}
?>