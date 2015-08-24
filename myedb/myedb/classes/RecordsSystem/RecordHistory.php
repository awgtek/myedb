<?php
//include_once (dirname(__FILE__) .'/../RecordsSystem/Record.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/RecordsSys_EntityManagementSystems.php');

class RecordHistory
{
	var $rec;
	var $eid;
	var $type_id;
	var $record_history_page_xml;
	
	function __construct($eid, $type_id)
	{ 
		$this->rec = new Record($eid, $type_id);
		$this->eid = $eid;
		$this->type_id = $type_id;
	}
	
	function create_record_history_page_xml()
	{
		$entity = RecordsSys_EntityManagementSystems::get_entity($this->eid);
	
		$doc = new DOMDocument('1.0','UTF-8');
		$doc->formatOutput = true;
		$rec_hist = $doc->createElement('RecordHistory');
		$rec_hist = $doc->appendChild($rec_hist);
		$date_created_elem = $doc->createElement("date_created");
		$date_created_text = $doc->createTextNode($this->rec->get_date_added());
		$date_created_elem->appendChild($date_created_text);
		$rec_hist->appendChild($date_created_elem);
		$date_last_modified_elem = $doc->createElement('date_last_modified');
		$date_last_modified_text = $doc->createTextNode($this->rec->get_date_last_modified());
		$date_last_modified_elem->appendChild($date_last_modified_text);
		$rec_hist->appendChild($date_last_modified_elem);
		
		$user_added_elem = $doc->createElement("user_added");
		$user_added_text = $doc->createTextNode($entity->user_added);
		$user_added_elem->appendChild($user_added_text);
		$rec_hist->appendChild($user_added_elem);
		
		$user_last_modified_elem = $doc->createElement("user_last_modified");
		$user_last_modified_text = $doc->createTextNode($entity->user_last_modified);
		$user_last_modified_elem->appendChild($user_last_modified_text);
		$rec_hist->appendChild($user_last_modified_elem);
		
		$prop_changes = $doc->createElement('prop_changes');
		$prop_changes = $rec_hist->appendChild($prop_changes);
		$changesdoc = new DOMDocument('1.0','UTF-8');
		$changesdoc->formatOutput = true;
		$changesdoc->loadXML($this->get_properties_change_history_records_xml());
		$chngrecords = $doc->importNode($changesdoc->firstChild,true);
		$prop_changes->appendChild($chngrecords);
		
		$this->record_history_page_xml = $doc->saveXML();
	}

	function get_properties_change_history_records_xml()
	{
		$eids = array();
		$xml_string = "";
		$sql = "select eid from view_int_prop_to_e_p_to_e
where type_id in (select type_id from type where type_name like '%_history') and prop_id = 40 and int_val = ".$this->eid;
		($result = mysql_query($sql)) or die("Error in RecordHistory...3lkd0skdjskfklk".mysql_error());
		while ($row = mysql_fetch_assoc($result))
		{
			$eids[] = $row['eid'];
		}

		$doc = new DOMDocument('1.0','UTF-8');
		$doc->formatOutput = true;
		$recs = $doc->createElement('records');
		$recs = $doc->appendChild($recs);
		
		
		foreach ($eids as $eid)
		{
			$type_id = RecordsSys_EntityManagementSystems::get_type_id($eid);
			$rec = new Record($eid,$type_id);
			$rec->initialize();
			
			$xml_string = $rec->xml_string;
		
			$doc2 = new DOMDocument('1.0','UTF-8');
			$doc2->loadXML($xml_string);
			$node = $doc->importNode($doc2->firstChild,true);
			$recs->appendChild($node);
		}
	//	$rec->glu->prop_ids_num_extra[6] = 1;
	//	$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		//$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		//	$xslt_file = 		$_SERVER['DOCUMENT_ROOT']."/XSLTemplates/testrecs.xsl";
		$xml_string = $doc->saveXML();

		return $xml_string;
	}
}


?>