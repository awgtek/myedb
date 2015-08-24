<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_EntityManagementSystems.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_RecordsSystem.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransactionMgmt.php");

class CheckoutProcessor
{

	function finalize_order()
	{
		$eid = $_REQUEST['rec_eid']; //should be current user's eid.
		$logged_in_user = AppEntities_Facade::get_user_instance();
		$logged_in_user_id = $logged_in_user->user_id;
		if ($eid != $logged_in_user_id) die("Security error: 3390kflsi33");
		
		TransactionMgmt::get_transactions();
		$details_xml = "'<details_xml><order><blah></blah></order></details_xml>'"; //placeholder
		
		$doc = new DOMDocument('1.0', 'UTF-8');
		$doc->formatOutput = true;
		//create root node
		$order_info = $doc->createElement('order_info');
		$order_info = $doc->appendChild($order_info);

		//insert transactions
			$doc2 = new DOMDocument('1.0','UTF-8');
			$trans_xml = TransactionMgmt::get_transactions();
			$doc2->loadXML($trans_xml);
			$node = $doc->importNode($doc2->firstChild,true);
		$order_info->appendChild($node);
		
		//insert ship address
		$ship_info = $doc->createElement('ship_info');
		$ship_info = $order_info->appendChild($ship_info);
		$ship_dest = $doc->createElement('ship_dest');
		$ship_dest = $ship_info->appendChild($ship_dest);
		$ship_dest->setAttribute('pgiron',$_REQUEST['order_ship_addr']);	
		
			$doc3 = new DOMDocument('1.0','UTF-8');
			$eidsrc_rec_xml = TransMgmt_RecordsSystem::get_record_xml($eid);
			$doc3->loadXML($eidsrc_rec_xml);
			$node2 = $doc->importNode($doc3->firstChild,true);
		$order_info->appendChild($node2);
		
		//insert credit card info
		/*$cc_info = $doc->createElement('cc_info');
		$cc_info = $order_info->appendChild($cc_info);
		$cc_number = $doc->createTextNode($_REQUEST['CCinfo']);
		$cc_info->appendChild($cc_number);
		$order_info->appendChild($cc_info);
*/
		$check_out_elements = array(
		//"cc_info",
		//"CCexpdate",
		//"CChldrname",
		"co_account_number",
		"co_business_name",
		"co_name",
		"chkout_order_phone",
		"order_ship_addr","shipaddr_addr1","shipaddr_addr2",
		"shipaddr_city", "shipaddr_state","shipaddr_zip",
		"chkout_special_requests");
		
		foreach ($check_out_elements as $elem)
		{
			$ship_elem = $doc->createElement($elem);
			$ship_elem = $order_info->appendChild($ship_elem);
			$ship_elem_txt = $doc->createTextNode($_REQUEST[$elem]);
			$ship_elem->appendChild($ship_elem_txt);
			$order_info->appendChild($ship_elem);
		}
		
		$details_xml = $doc->saveXML();
		$details_xml = "'".addslashes($details_xml)."'";
		
		TransMgmt_EntityManagementSystems::finalize_order($eid, $details_xml);
		
		if (!isset($_SESSION['finalized_order_id'])) { die("Transaction failed. error: 2kdjs;aii3i3"); }
		$order_id = $_SESSION['finalized_order_id'];
		$doc = new DOMDocument('1.0', 'UTF-8');
		$order_id_elem = $doc->createElement('final_order_id',$order_id);
		$doc->appendChild($order_id_elem);
		return $doc->saveXML();
		
		
			
	}

}


?>