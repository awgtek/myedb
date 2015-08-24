<?php

class travel_order_DS extends medb_order_DS
{
	function get_order_history_xml_dataset($encap_element)
	{
		$field_list = (is_array($this->select_fields))? join(",",$this->select_fields) : $this->select_fields;

		$sql = join(" ",array($this->select_clause,
								$field_list,
								$this->from_clause,
								$this->where_clause,
								$this->order_by,
								$this->limit_clause)); 
		$result = mysql_query($sql);// echo $sql;
		$doc = new DOMDocument("1.0","UTF-8");
		$doc->formatOutput = true;
		$encap_elem = $doc->createElement($encap_element);
		$encap_elem = $doc->appendChild($encap_elem);
		while ($row = mysql_fetch_assoc($result))
		{
			$record_elem = $doc->createElement($encap_element."_record");
			$record_elem = $encap_elem->appendChild($record_elem);
			//foreach($this->select_fields as $select_field)
			foreach($row as $select_field => $field_value)
			{
				$field_elem = $doc->createElement($encap_element."_field");
				$field_elem = $record_elem->appendChild($field_elem);
				$field_elem->setAttribute("field_name",$select_field);
				if ($select_field == "details_xml")
				{
					try 
					{
						if (empty($row[$select_field]))
							throw new Exception("empty details_xml");
						$xml_transformer = new XMLTransformer();
						$transformed_xml = $xml_transformer->travel_order_rec_for_DS($row[$select_field],"the_travel_rec_stub");
						$transformed_doc = new DOMDocument('1.0','UTF-8'); 
						$transformed_doc->loadXML($transformed_xml);
						$transformed_node = $doc->importNode($transformed_doc->firstChild,true);
						$field_elem->appendChild($transformed_node);
						/*				
						$details_xml = new SimpleXMLElement($row[$select_field]);
						$pgiron = $details_xml->ship_info[0]->ship_dest[0]['pgiron'];

						if($pgiron == "will_pick_up")
						{
							$node = $doc->createElement("will_pick_up","Yes");
							$field_elem->appendChild($node);
						}
						else
						{
							$check_out_elements = array("shipaddr_addr1","shipaddr_addr2",
						"shipaddr_city", "shipaddr_state","shipaddr_zip");
							
							foreach ($check_out_elements as $elem)
							{
								$out_elem_val = $details_xml->{$elem}[0];
								$out_elem = $doc->createElement($elem,$out_elem_val);
								$field_elem->appendChild($out_elem);
							}
							
									
						}						
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
						
						$item_count = 0;
						foreach ($details_xml->xpath('//transactions/transaction') as $transaction)
						{
							$item_count += (int)$transaction['qty'];
						}
						$node = $doc->createElement("item_count",$item_count);
						$field_elem->appendChild($node);
											
						list($product_name) = $details_xml->xpath('//transactions/transaction[@eiddst="'.$row['eiddst'].'"]/record/property[@prop_id="1"]/value');
						$product_name_node = $doc->createElement("product_name",$product_name);
						$field_elem->appendChild($product_name_node);
						
						//$rows = count($details_xml->xpath('/records/record'));
					*/
					/*	$details_doc = new DOMDocument("1.0","UTF-8");
						$details_doc->loadXML($row[$select_field]);
						$node = $doc->importNode($details_doc->firstChild,true);
						$field_elem->appendChild($node); */
					}
					catch (Exception $e) //do nothing if empty
					{
					
					}
				}
				else
				{
					$text_node = $doc->createTextNode($row[$select_field]);
					$field_elem->appendChild($text_node);
				}
			}
		}
		return $doc->saveXML();
	}

	
}
?>