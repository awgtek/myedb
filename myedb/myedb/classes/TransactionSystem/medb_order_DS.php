<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/AppLibrary/GenericDBDS.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransXMLElement.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/OrderInfoNode.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TravelRequestInfoNode.php");

class medb_order_DS extends GenericDBDS
{
	var $limit_offset;
	var $limit_rows;
	var $order_by_field;
	var $order_by_direction;
	
	function __construct($table_name, $select_fields="")
	{
		parent::__construct($table_name, $select_fields);
	}
	function get_order_history_xml_dataset($encap_element)
	{
		$format = 'call get_order_history_dataset(%1$d,%2$d,%3$d,%4$d,\'%5$s\',\'%6$s\')';
		
		$sql = sprintf($format,$this->limit_offset,$this->limit_rows,0,0,$this->order_by_field,
			$this->order_by_direction);
		$mysqli ="";
		$ordhistrows = myedb_mysqli_query($sql,$mysqli) or die (mysqli_error($mysqli));
	//	print_r($ordhistrows);
		
	//	$field_list = (is_array($this->select_fields))? join(",",$this->select_fields) : $this->select_fields;

	/*	$sql = join(" ",array($this->select_clause,
								$field_list,
								$this->from_clause,
								$this->where_clause,
								$this->order_by,
								$this->limit_clause)); 
		$result = mysql_query($sql); */ //echo $sql;
		$doc = new DOMDocument("1.0","UTF-8");
		$doc->formatOutput = true;
		$encap_elem = $doc->createElement($encap_element);
		$encap_elem = $doc->appendChild($encap_elem);
		foreach ($ordhistrows as $histrow)
		{
			$record_elem = $doc->createElement($encap_element."_record");
			$record_elem = $encap_elem->appendChild($record_elem);
			//foreach($this->select_fields as $select_field)
			foreach ($histrow as $select_field => $field_value)
			{
				$field_elem = $doc->createElement($encap_element."_field");
				$field_elem = $record_elem->appendChild($field_elem);
				$field_elem->setAttribute("field_name",$select_field);
				
				$text_node = $doc->createTextNode($field_value);
				$field_elem->appendChild($text_node);
			}
			/*
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
						$details_xml = new SimpleXMLElement($row[$select_field]);
						$pgiron = $details_xml->ship_info[0]->ship_dest[0]['pgiron'];
					/ *not using this for now	if (ereg("pgi([0-9]*)ron([0-9]*)",$pgiron,$regs))
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
						}* /
						if($pgiron == "will_pick_up")
						{
							$node = $doc->createElement("will_pick_up","Yes");
							$field_elem->appendChild($node);
						}
						else
						{
							$check_out_elements = array(
							//"shipaddr_addr1","shipaddr_addr2","shipaddr_city", "shipaddr_state","shipaddr_zip",
							);
							
							foreach ($check_out_elements as $elem)
							{
								$out_elem_val = $details_xml->{$elem}[0];
								$out_elem = $doc->createElement($elem,$out_elem_val);
								$field_elem->appendChild($out_elem);
							}
							
									
						}	
						$elem = "co_account_number";
						$out_elem_val = $details_xml->{$elem}[0];
						$out_elem = $doc->createElement($elem,$out_elem_val);
						$field_elem->appendChild($out_elem);
						
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

					/ *	$details_doc = new DOMDocument("1.0","UTF-8");
						$details_doc->loadXML($row[$select_field]);
						$node = $doc->importNode($details_doc->firstChild,true);
						$field_elem->appendChild($node); * /
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
			}*/
		}
		return $doc->saveXML();
	}

	
	function get_order_history_xml_datasetOld($encap_element)
	{
		$field_list = (is_array($this->select_fields))? join(",",$this->select_fields) : $this->select_fields;

		$sql = join(" ",array($this->select_clause,
								$field_list,
								$this->from_clause,
								$this->where_clause,
								$this->order_by,
								$this->limit_clause)); 
		$result = mysql_query($sql); echo $sql;
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
						$details_xml = new SimpleXMLElement($row[$select_field]);
						$pgiron = $details_xml->ship_info[0]->ship_dest[0]['pgiron'];
					/* not using this for now	if (ereg("pgi([0-9]*)ron([0-9]*)",$pgiron,$regs))
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
						else
						{
							$check_out_elements = array(
							//"shipaddr_addr1","shipaddr_addr2","shipaddr_city", "shipaddr_state","shipaddr_zip",
							);
							
							foreach ($check_out_elements as $elem)
							{
								$out_elem_val = $details_xml->{$elem}[0];
								$out_elem = $doc->createElement($elem,$out_elem_val);
								$field_elem->appendChild($out_elem);
							}
							
									
						}	
						$elem = "co_account_number";
						$out_elem_val = $details_xml->{$elem}[0];
						$out_elem = $doc->createElement($elem,$out_elem_val);
						$field_elem->appendChild($out_elem);
						
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

	function get_order_details_xml($encap_element, $trans_xml_element_hash)
	{
		$field_list = join(",",$this->select_fields);
		$sql = join(" ",array($this->select_clause,
								$field_list,
								$this->from_clause,
								$this->where_clause,
								$this->order_by,
								$this->limit_clause)); 
		$result = mysql_query($sql);
		$doc = new DOMDocument("1.0","UTF-8");
		$doc->formatOutput = true;
		$encap_elem = $doc->createElement($encap_element);
		$encap_elem = $doc->appendChild($encap_elem);
		while ($row = mysql_fetch_assoc($result))
		{
			$record_elem = $doc->createElement($encap_element."_record");
			$record_elem = $encap_elem->appendChild($record_elem);
			foreach($this->select_fields as $select_field)
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
						$details_xml = new SimpleXMLElement($row[$select_field]);
						$trans_xml_element_hash[$details_xml->getName()]->insert_node($doc,$field_elem,$details_xml);//getName() should be either order_info or travel info
						
						//$rows = count($details_xml->xpath('/records/record'));

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

	function delete_medb_order($order_id)
	{
		$db = $_SESSION['mysqli_obj'];
		$stmt = $db->prepare("DELETE FROM medb_order WHERE order_id = ?");
		$stmt->bind_param('d', $oid_to_delete);
		$oid_to_delete = $order_id*1;
		/* execute prepared statement */
		$stmt->execute();

		$retval = sprintf("%d Row ($oid_to_delete) deleted.\n", $stmt->affected_rows);

	    /* close statement */ 
	    $stmt->close(); 
		return $retval;
	}

}

?>