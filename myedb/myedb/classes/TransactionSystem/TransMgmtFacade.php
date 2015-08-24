<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransactionCreator.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransactionMgmt.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/CheckoutProcessor.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TravelProcessor.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/OrderHistoryOps.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/MEDBOrder.php");

class TransMgmtFacade
{
	function update_medb_order_res_field_name_value(&$xml_string)
	{
		$medb_order = new MEDBOrder($_REQUEST['order_id']);
		$xml_string = $medb_order->update_medb_order_res_field_name_value();
		
	}
	
	function set_approval_status(&$xml_string)
	{
		$medb_order = new MEDBOrder($_REQUEST['order_id']);
		$xml_string = $medb_order->set_approval_status($_REQUEST['status_value']);
		// wait for 4 seconds
		//usleep(2000000);

	}

	function finalize_order(&$xml_string)
	{
		$xml_string = CheckoutProcessor::finalize_order();
	}

	function create_transaction(&$xml_string, &$xslt_file)
	{
//	print_r($_REQUEST['groups_to_add_to_transactions']);
//		 echo "in create_transaction<br>";
		 $tc = new TransactionCreator();
		 $tc->create_transaction();
	}
	
	function get_pending_transactions(&$xml_string, &$xslt_file)
	{
		$xml_string = TransactionMgmt::get_transactions();
	}
	
	function delete_transaction()
	{
		TransactionMgmt::delete_transaction();
	}

	function get_checkout_form_xml(&$xml_string)
	{
		$transmgmt = new TransactionMgmt();
		$xml_string = $transmgmt->get_checkout_form_xml();
	}
	
	function initiate_travel_order(&$xml_string)
	{
		$travel_processor = new TravelProcessor();
		$xml_string = $travel_processor->initiate_travel_order();
	}
	
	function confirm_travel_order(&$xml_string)
	{
		$xml_string = TravelProcessor::confirm_travel_order();
	}
	
	function get_order_history_page_xml(&$xml_string)
	{
		$xml_string = OrderHistoryOps::create_order_history_page_xml();
	}
	
	function get_order_details_page_xml(&$xml_string)
	{
		$xml_string = OrderHistoryOps::create_order_details_page_xml();
	}
	
	function get_product_order_history_page_xml(&$xml_string)
	{
		$xml_string = OrderHistoryOps::create_product_order_history_page_xml();
	}
	
	function donothing(&$xml_string)
	{
		$xml_string = "<empty />";
	}
	
	function delete_medb_order(&$output_data)
	{
		$output_data = medb_order_DS::delete_medb_order($_REQUEST['oid']);
	}
}

?>