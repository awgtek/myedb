<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/RecordsSystem/RecordIniFacade.php');


class MetaDataOps_RecordSys
{

	function get_xml_list($eids)
	{
		$xmlstring = "";
		$_REQUEST['eids'] = $eids;
		RecordIniFacade::initializeRecordSet($xmlstring);
		return $xmlstring;
	}



}



?>