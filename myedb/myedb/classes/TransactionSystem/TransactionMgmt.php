<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_EntityManagementSystems.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_SecuritySystem.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_RecordsSystem.php");

class TransactionMgmt
{
	function get_transactions()
	{
		$eidsrc = TransMgmt_SecuritySystem::get_user_eid();
		$transar = TransMgmt_EntityManagementSystems::get_unrealized_transactions_by_eidsrc($eidsrc);
		$doc = new DOMDocument('1.0', 'UTF-8');
		$doc->formatOutput = true;
		$transactions = $doc->createElement('transactions');
		$transactions = $doc->appendChild($transactions);
		foreach ($transar as $trans)
		{
			$eiddst = "";
			$transaction = $doc->createElement('transaction');
			$transaction = $transactions->appendChild($transaction);
			foreach($trans as $colname => $val)
			{
				$transaction->setAttribute($colname,$val);
				if ($colname == "eiddst")
				{
					$eiddst = $val;
				}
			}
			$doc2 = new DOMDocument('1.0','UTF-8');
			$filter_properties = array(1,10,15,16,17,33,57); 
			$eiddst_rec_xml = TransMgmt_RecordsSystem::get_record_xml_filtered($eiddst,$filter_properties);
			$doc2->loadXML($eiddst_rec_xml);
			$node = $doc->importNode($doc2->firstChild,true);
			$transaction->appendChild($node);
		}
		$xml_string = $doc->saveXML();
		return $xml_string;
		
	}

	function delete_transaction()
	{
		$trans_id = $_REQUEST['transid'];
		TransMgmt_EntityManagementSystems::delete_transaction($trans_id);
	}

	function get_checkout_form_xml()
	{
		//put together a record and pending transaction in one xml doc
		$doc = new DOMDocument('1.0', 'UTF-8');
		$doc->formatOutput = true;
		$checkout_form = $doc->createElement('checkout_form');
		$checkout_form = $doc->appendChild($checkout_form);
		//add user record xml
		$user_rec_doc = new DOMDocument('1.0','UTF-8');
		$eidsrc_rec_xml = TransMgmt_RecordsSystem::get_record_xml(TransMgmt_SecuritySystem::get_user_eid());
		$user_rec_doc->loadXML($eidsrc_rec_xml);
		$user_node = $doc->importNode($user_rec_doc->firstChild,true);
		$checkout_form->appendChild($user_node);
		//add transactions
		$trans_recs_doc = new DOMDocument('1.0','UTF-8');
		$trans_xml = $this->get_transactions();
		$trans_recs_doc->loadXML($trans_xml);
		$transactions_node = $doc->importNode($trans_recs_doc->firstChild,true);
		$checkout_form->appendChild($transactions_node);
		$xml_string = $doc->saveXML();
		return $xml_string;
	}
}


?>