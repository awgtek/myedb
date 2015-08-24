<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransXMLElement.php");


class OrderInfoNode extends TransXMLElement
{
	function __construct()
	{
		$this->encap_elem = "order_info";
	}

	function insert_node(DOMDocument &$doc, DOMElement &$field_elem, SimpleXMLElement $details_xml)
	{  
		$check_out_elements = array("cc_info",
		"CCexpdate","CChldrname","chkout_order_phone","co_account_number","co_business_name",
		"co_name","chkout_special_requests");
		
		foreach ($check_out_elements as $elem)
		{
			$out_elem_val = $details_xml->{$elem}[0];
			$out_elem = $doc->createElement($elem,$out_elem_val);
			$field_elem->appendChild($out_elem);
		}
		
		
		$ccnum = $details_xml->cc_info[0];
		$ccinfo = $doc->createElement("ccinfo");
		$field_elem->appendChild($ccinfo);
		$ccnum = $doc->createElement("ccnum",$ccnum);
		$ccinfo->appendChild($ccnum);
		
		$pgiron = $details_xml->ship_info[0]->ship_dest[0]['pgiron'];
/*WAS FOR INSERTING SHIPPING ADDRESS FROM USER RECORD, MAY BE USED AGAIN LATER
 * 		if (ereg("pgi([0-9]*)ron([0-9]*)",$pgiron,$regs))
		{
		//	echo $regs[1]."---".$regs[2]."<br>";
			$prop_group_id = $regs[1];
			$ron = $regs[2];
			$shipping_element = $doc->createElement("shipping_address");
			$shipping_element = $field_elem->appendChild($shipping_element);
			foreach ($details_xml->xpath('//record[@type_id=3]/property[@prop_group_id='.$prop_group_id.' and @ron='.$ron.']') as $address_property) {
			//	echo $address_property->value, '...<br />';// echo "<xmp>".$address_property->asXML()."</xmp>";
				$address_prop_doc = new DOMDocument("1.0","UTF-8");
				$address_prop_doc->formatOutput = true;
				$address_prop_doc->loadXML($address_property->asXML());
				$node = $doc->importNode($address_prop_doc->firstChild,true);
				$shipping_element->appendChild($node);
			}
		}*/
		if($pgiron == "will_pick_up")
		{
			$node = $doc->createElement("will_pick_up","Yes");
			$field_elem->appendChild($node);
		}
	//	else
	//	{
			$check_out_elements = array("shipaddr_addr1","shipaddr_addr2",
		"shipaddr_city", "shipaddr_state","shipaddr_zip");
			
			foreach ($check_out_elements as $elem)
			{
				$out_elem_val = $details_xml->{$elem}[0];
				$out_elem = $doc->createElement($elem,$out_elem_val);
				$field_elem->appendChild($out_elem);
			}
			
					
	//	}
		$ar = $details_xml->xpath('//record[@type_id=3]/property[@prop_id=7]');
		if (is_array($ar))
		{
			list(,$userid_xml) = each($ar); //get first value
			$userid = $userid_xml->value;
		}
		$ar = $details_xml->xpath('//record[@type_id=3]/property[@prop_id=9]');
		if (is_array($ar))
		{
			list(,$first_name_xml) = each($ar); //get first value
			$first_name = $first_name_xml->value;
		}
		$ar = $details_xml->xpath('//record[@type_id=3]/property[@prop_id=36]');
		if (is_array($ar))
		{
			list(,$last_name_xml) = each($ar); //get first value
			$last_name = $last_name_xml->value;
		}
		$full_user_name = $first_name . " " . $last_name;
		
		$user_id_elem = $doc->createElement("user_id_elem");
		$user_id_elem = $field_elem->appendChild($user_id_elem);
		$text_node = $doc->createTextNode($userid);
		$user_id_elem->appendChild($text_node);

		$user_full_name_elem = $doc->createElement("user_full_name_elem");
		$user_full_name_elem = $field_elem->appendChild($user_full_name_elem);
		$text_node = $doc->createTextNode($full_user_name);
		$user_full_name_elem->appendChild($text_node);
		
		$transactions = $doc->createElement("transactions");
		$field_elem->appendChild($transactions);
		
		$item_count = 0;
		$quantity = 0;
		$product_name = "";
		$price = 0;
		foreach ($details_xml->xpath('//transactions/transaction') as $transaction)
		{

			$item_count += (int)$transaction['qty'];
			$quantity = (int)$transaction['qty'];
			$prop_group_id = (int)$transaction['prop_group_id'];
			$ron = (int)$transaction['ron'];
			$eiddst = (int)$transaction['eiddst'];
			
		//	$ar = $transactionSimpleXML->xpath('property[@prop_group_id='.$prop_group_id.' and @prop_id = 16 and @ron = '.$ron.']');
			$ar = $transaction->xpath('record[@eid='.$eiddst.']/property[@prop_group_id='.$prop_group_id.' and @prop_id = 16 and @ron = '.$ron.']');
			if (is_array($ar))
			{
				list(,$property) = each($ar); //get first value
				$price = $property->value;
			}
			
			$ar = $transaction->xpath('record[@eid='.$eiddst.']/property[@prop_id = 1]');
			if (is_array($ar))
			{
				list(,$property) = each($ar); //get first value
				$product_name = $property->value;
			}
			
			$ar = $transaction->xpath('record[@eid='.$eiddst.']/property[@prop_id = 33]');
			if (is_array($ar))
			{
				list(,$property) = each($ar); //get first value
				$account_number = $property->value;
			}
			
			$ar = $transaction->xpath('record[@eid='.$eiddst.']/property[@prop_id = 57]');
			if (is_array($ar))
			{
				list(,$property) = each($ar); //get first value
				$refno = $property->value;
			}
			
			//		echo "<xmp>".$transaction->asXML()."</xmp>";
			$transaction = $doc->createElement("transaction");
			$transactions->appendChild($transaction);
			$transaction->setAttribute("qty",$quantity);
			$transaction->setAttribute("product_name",$product_name);
			$transaction->setAttribute("price",$price);
			$transaction->setAttribute("account_number",$account_number);
			$transaction->setAttribute("refno",$refno);
		}
		$node = $doc->createElement("item_count",$item_count);
		$field_elem->appendChild($node);
	}


}



?>