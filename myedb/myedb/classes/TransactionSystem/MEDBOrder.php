<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_EntityManagementSystems.php");


class MEDBOrder
{
	var $order_id;
	function __construct($order_id)
	{
		$this->order_id = $order_id;
	}
	
	function set_approval_status($status_value)
	{
		$doc = new DOMDocument('1.0', 'UTF-8');
		$doc->formatOutput = true;
		$medborder_sas = $doc->createElement('medborder_sas',TransMgmt_EntityManagementSystems::set_approved_value($this->order_id, $status_value));
		$medborder_sas = $doc->appendChild($medborder_sas);
		$xml_string = $doc->saveXML();
		return $xml_string;
	}
	
	function update_medb_order_res_field_name_value()
	{
		return TransMgmt_EntityManagementSystems::update_medb_order_res_field_name_value(
			$this->order_id, $_POST['editorId'], $_POST['res_field_value']);
	}
	
	
}


?>