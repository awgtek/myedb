<?php
//include_once (dirname(__FILE__) .'/../RecordsSystem/RecordIniFacade.php');

class SecurityOperations_RecordSys
{

	function update_user()
	{
		$recinifacade = new RecordIniFacade();
		$recinifacade->update_record($xml_string_gbg, $xslt_file_gbg);
	}

	function get_record_xml()
	{
		RecordIniFacade::initialize($xml_string, $xslt_file_gbg);
		return $xml_string;
	}
}



?>