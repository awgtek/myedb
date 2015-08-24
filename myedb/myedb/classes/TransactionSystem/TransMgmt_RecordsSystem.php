<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/RecordsSystem/RecordIniFacade.php');


class TransMgmt_RecordsSystem
{

	static function get_record_xml($eid)
	{
		return RecordIniFacade::get_record_xml($eid);
	}

	static function get_record_xml_filtered($eid, $filter_properties)
	{
		return RecordIniFacade::get_record_xml_filtered($eid, $filter_properties);
	}

	
}


?>