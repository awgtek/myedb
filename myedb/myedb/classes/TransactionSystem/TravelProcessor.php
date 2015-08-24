<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_RecordsSystem.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_SecuritySystem.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_EntityManagementSystems.php");
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/Notification/NotificationSys.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/Output_SecuritySystem.php');
//include_once dirname(__FILE__) . '/../ApplicationEntities/AppEntities_Facade.php'; 


class TravelProcessor
{
	var $details_encap_elem = 'travel_res_info';

	function initiate_travel_order()
	{
		$doc = new DOMDocument('1.0','UTF-8');
		$doc->formatOutput = true;
		
		$travel_res_info = $doc->createElement($this->details_encap_elem);
		$travel_res_info = $doc->appendChild($travel_res_info);
		
		$travel_res_submitted_fields = $doc->createElement('travel_res_submitted_fields');
		$travel_res_submitted_fields = $travel_res_info->appendChild($travel_res_submitted_fields);
		
		foreach ($_REQUEST as $post_key => $post_val)
		{
			$post_val = myedb_strip_slashes($post_val);
			if (ereg("^travel_res__(.*)$",$post_key,$regs))
			{
				$travel_res_submit_field = $doc->createElement('travel_res_submit_field');
				$travel_res_submit_field = $travel_res_submitted_fields->appendChild($travel_res_submit_field);
				$travel_res_submit_field->setAttribute("res_field_name",$post_key);
				$res_field_value = $doc->createElement('res_field_value');
				$res_field_value = $travel_res_submit_field->appendChild($res_field_value);
				$value = $doc->createTextNode($post_val);
				$res_field_value->appendChild($value);
				$res_field_label = $doc->createElement('res_field_label');
				$res_field_label = $travel_res_submit_field->appendChild($res_field_label);
				$label = $doc->createTextNode($_REQUEST['trav_res_lab__'.$regs[1]]);
				$res_field_label->appendChild($label);
				
				//save in case of "go back" button pressed
				$_SESSION[$post_key] = $post_val;
			}
		}
		//Get product info
		$docproduct = new DOMDocument('1.0','UTF-8');
		$filter_properties = array(1,4,5,10,12,13,14,15,16,17,33);// echo "in here: ".print_r($filter_properties,true);
		$eiddst_rec_xml = TransMgmt_RecordsSystem::get_record_xml_filtered($_REQUEST['eiddst'],$filter_properties);
		$docproduct->loadXML($eiddst_rec_xml);
		$simple_lookups_product = simplexml_load_string($eiddst_rec_xml);
		
		//get buyer user info
		$cur_user_eid = Output_SecuritySystem::get_user_eid();
		$docuser = new DOMDocument('1.0','UTF-8');
		$filter_properties = array(9,36,55);// echo "in here: ".print_r($filter_properties,true);
		$eiduser_rec_xml = TransMgmt_RecordsSystem::get_record_xml_filtered($cur_user_eid, $filter_properties);
		$docuser->loadXML($eiduser_rec_xml);
		$simple_lookups_user = simplexml_load_string($eiduser_rec_xml);
			
		//insert travel product into xml detail
		$travel_product_element = $doc->createElement('travel_product');
		$travel_product_element = $travel_res_info->appendChild($travel_product_element);
		$node = $doc->importNode($docproduct->firstChild,true);
		$travel_product_element->appendChild($node);

		//insert buyer user record into xml detail
		$buyer_info_element = $doc->createElement('buyer_info');
		$buyer_info_element = $travel_res_info->appendChild($buyer_info_element);
		$buyer_node = $doc->importNode($docuser->firstChild,true);
		$buyer_info_element->appendChild($buyer_node);
		//var_dump($buyer_info_element); die();
		
		//set up lookups info for product city, state, zip
		$travel_lookups_element = $doc->createElement('travel_lookups');
		$travel_lookups_element = $travel_res_info->appendChild($travel_lookups_element);
		
		$lookup_ids = array();
		foreach (array($simple_lookups_product, $simple_lookups_user) as $simple_lookups)
		{
			
			$lookup_xml = $simple_lookups->xpath('//property[@prop_id="12"]');
			foreach($lookup_xml as $lookup)
			{
				$lookup_ids[] = $lookup->value * 1;
			}
			
		}
		$this->add_lookup_table_list(OutputSys_ClientServerDataOps::get_LookupTableObj(),"city",
		'lookup_table_cities',$doc,$travel_lookups_element,$lookup_ids);
		
		
		$lookup_ids = array();
		foreach (array($simple_lookups_product, $simple_lookups_user) as $simple_lookups)
		{
			$lookup_xml = $simple_lookups->xpath('//property[@prop_id="13"]');
			foreach($lookup_xml as $lookup)
			{
				$lookup_ids[] = $lookup->value * 1;
			}
		}
		$this->add_lookup_table_list(OutputSys_ClientServerDataOps::get_LookupTableObj(),"state",
		'lookup_table_states',$doc,$travel_lookups_element,$lookup_ids);

		$lookup_ids = array();
		foreach (array($simple_lookups_product, $simple_lookups_user) as $simple_lookups)
		{
			$lookup_xml = $simple_lookups->xpath('//property[@prop_id="14"]');
			foreach($lookup_xml as $lookup)
			{
				$lookup_ids[] = $lookup->value * 1;
			}
		}
		$this->add_lookup_table_list(OutputSys_ClientServerDataOps::get_LookupTableObj(),"zip",
		'lookup_table_zips',$doc,$travel_lookups_element,$lookup_ids);
		
		$saved_res_info = $doc->saveXML();
		$_SESSION['saved_res_info'] = $saved_res_info; 
		return $saved_res_info;
	}

	private function add_lookup_table_list($lookup_table_obj, $lookup_table,$encap_elem,
			DOMDocument &$doc, DOMElement &$lookups_elem, $lookup_ids="")
	{
		//$lookup_table_obj->tbl_name = $lookup_table;
		$lookup_table_obj->set_table_name($lookup_table);
		if (!empty($lookup_ids))
		{
			$lookup_table_obj->lookup_ids = $lookup_ids;	
		}
	//	$lookup_table_hash = $lookup_table_obj->get_table();
		
		$lookup_table_elem = $doc->createElement($encap_elem);
		$lookups_elem->appendChild($lookup_table_elem);
		
		$lookup_table_obj->append_xml_values($lookup_table_elem, $doc);
		/*
		foreach($lookup_table_hash as $lookup_table_id => $lookup_table_rec_ar)
		{
			$lookup_table_field_name = $lookup_table_rec_ar[0];
			$lookup_table_item_is_disabled = $lookup_table_rec_ar['disabled']; 
			$lookup_table_rec = $this->doc->createElement($lookup_table,$lookup_table_field_name);
			$lookup_table_elem->appendChild($lookup_table_rec);
			$lookup_table_rec->setAttribute($lookup_table."_id",$lookup_table_id);
			$lookup_table_rec->setAttribute("is_disabled",$lookup_table_item_is_disabled);
		}
		*/
	}
	
	
	function confirm_travel_order()
	{
		//echo "<xmp>".$_SESSION['saved_res_info']."</xmp>"; die();
		$eidsrc = TransMgmt_SecuritySystem::get_user_eid();
		$details_xml = "'".sanitize_trim_mysqli_escape($_SESSION['mysqli_link'],$_SESSION['saved_res_info'])."'"; 
		//standalone: doesn't sit in cart
		TransMgmt_EntityManagementSystems::create_standalone_order($details_xml,$eidsrc,$_POST['eiddst'],$_POST['type_id']);
		$doc = new DOMDocument('1.0','UTF-8');
		$travel_order_confirmation = $doc->createElement('travel_order_confirmation');
		$travel_order_confirmation = $doc->appendChild($travel_order_confirmation);

		$cur_user_eid = Output_SecuritySystem::get_user_eid();
		$email_info = AppEntities_Facade::get_travel_order_confirmation_email_info(); 
		NotificationSys::email_user_cc_admins($cur_user_eid,
			$email_info["confirm_travel_order_email_subject"],
				$email_info["confirm_travel_order_email_message"]);
		
	//	NotificationSys::email_developer(
	//		$email_info["confirm_travel_order_email_subject"],
	//			$email_info["confirm_travel_order_email_message"]);
				
		return $doc->saveXML();
		
	}


}



?>