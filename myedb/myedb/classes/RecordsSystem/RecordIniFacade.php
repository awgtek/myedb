<?php
//include_once (dirname(__FILE__) .'/../AppLibrary/MyEDB_Matrix.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/Record.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/One_Row_Record.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/RecordHistory.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/RecordSearcher.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/memcache_search_keys.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/RecordsSys_EntityManagementSystems.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Property.php');
ini_set('memcache.chunk_size', 65536);

class RecordIniFacade
{
	var $xml_string;
	var $xslt_file ;
	var $memcache_on = false;

	function initialize(&$xml_string, &$xslt_file)
	{//echo "in recinffac<br>";
		
		$eid = $_REQUEST['eid'];
		$type_id = $_REQUEST['type_id'];
		if (empty($type_id))
		{
			$type_id = RecordsSys_EntityManagementSystems::get_type_id($eid); //added this because type missing in link in edit_entity_groupings_pgct.xsl
			$_REQUEST['type_id'] = $type_id;
		}
	//	$type_id = RecordsSys_EntityManagementSystems::get_type_id($eid); //can't rely on request type_id, because search results have generic type_id
	//	$_REQUEST['type_id'] = $type_id;
		$rec = new Record($eid,$type_id); //echo "just inserted: ".$_REQUEST['eid']."<br>";
	//	$rec->glu->prop_ids_num_extra[6] = 1;
	//	$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		//$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		$rec->initialize();
		$xml_string = $rec->xml_string;
		$xslt_file = $rec->xslt_file;
	}
	
	function delete_record(&$xml_string, &$xslt_file)
	{ 
		Record::delete_record($_REQUEST['eid']);
	}
	
	//todo: refactor to internal classes
	function filtered_search_by_mixed_criteria(&$xml_string, &$xslt_file="")
	{
		$recordsearcher = new RecordSearcher();
		//echo microtime()."RecordIniFacade: filtered_search_by_mixed_criteria;  before executing ".'$recordsearcher->filtered_search_by_mixed_criteria();'." <br>";
		$paged = (isset($_REQUEST['nopaged']) && $_REQUEST['nopaged'] == 1) ? 0 : 1;
		$eids = $recordsearcher->filtered_search_by_mixed_criteria($paged);
		if ($eids)
		{
			$_REQUEST['eids'] = $eids; 
			if (!isset($_REQUEST['type_id'])) $_REQUEST['type_id'] = $_SESSION['type_id'];
			//echo microtime()."RecordIniFacade: filtered_search_by_mixed_criteria;  before executing initializeRecordSet <br>";
			$this->initializeRecordSet($xml_string, $xslt_file);
			//echo microtime()."RecordIniFacade: filtered_search_by_mixed_criteria;  after executing initializeRecordSet <br>";
		}
	}

	//for e.g. export of admin search results
	function filtered_search_by_mixed_criteria_csv(&$output_data, &$xslt_file="")
	{
		$recordsearcher = new RecordSearcher();
		//echo microtime()."RecordIniFacade: filtered_search_by_mixed_criteria;  before executing ".'$recordsearcher->filtered_search_by_mixed_criteria();'." <br>";
		$eids = $recordsearcher->filtered_search_by_mixed_criteria(false);
		$_REQUEST['eids'] = $eids; 
		if (!isset($_REQUEST['type_id'])) $_REQUEST['type_id'] = $_SESSION['type_id'];
		//$this->initializeRecordSet($xml_string, $xslt_file);
		
		//initialize MyEDB_Matrix with prop ids to be column names
			//get Property::get_property_list
		$property_list = Property::get_property_list(); //print_r($property_list); echo "helloo";
		$myedb_matrix = new MyEDB_Matrix($property_list);
		
		//do loop through eids creating associative array of resulting recs
		foreach($eids as $eid)
		{
			$type_id = RecordsSys_EntityManagementSystems::get_type_id($eid); //can't rely on request type_id, because search results may have generic type_id
			$one_row_rec = new One_Row_Record($eid,$type_id);
			$one_row_rec->exclude_properties = array(26,27);
			$one_row_rec->setup();
			//add $one_row_rec to MyEDB_Matrix
			$myedb_matrix->add_one_row_record($one_row_rec);
			//add $complete_prop_matrix to $eid_recs
		}
		$myedb_matrix->finalize_matrix();
		$output_data = $myedb_matrix->get_matrix();
		
	}
	
	//todo: refactor to internal classes
	function search_by_prop_val_contains(&$xml_string, &$xslt_file="")
	{ 
		$search_prop_id = $_REQUEST['spi'];
		$search_prop_val = $_REQUEST['spv'];
		$type_id = $_REQUEST['type_id'];
		$eids = RecordsSys_EntityManagementSystems::get_eids_by_prop_contains_search($search_prop_val, $search_prop_id, $type_id);
		$_REQUEST['eids'] = $eids;
		$this->initializeRecordSet($xml_string, $xslt_file);
	}
	
	//todo: refactor to internal classes
	function search_by_prop_val(&$xml_string, &$xslt_file="")
	{
		$search_prop_id = $_REQUEST['spi'];
		$search_prop_val = $_REQUEST['spv'];
		$type_id = $_REQUEST['type_id'];
		$eids = RecordsSys_EntityManagementSystems::get_eids($search_prop_val, $search_prop_id, $type_id);
		$_REQUEST['eids'] = $eids;
		$this->initializeRecordSet($xml_string, $xslt_file);
	}
	
	//todo: refactor to internal classes
	function initializeRecordSet(&$xml_string, &$xslt_file="")
	{
		$eids = $_REQUEST['eids'];
	//	$type_id = $_REQUEST['type_id'];
		if ($this->memcache_on)
		{
			$memcache_key = md5(implode(",",$eids));
			//$memcache_obj = memcache_pconnect('localhost', 11211); //using pconnect gives unknown errors on live server
			$memcache_obj = memcache_connect('localhost', 11211);
			$memcache_obj->setCompressThreshold(20000, 0.2);
				//	print_r($memcache_obj->getExtendedStats());
		
			memcache_search_key::add_search_key($memcache_key);
			$xml_string = memcache_get($memcache_obj,$memcache_key);
		}
		if ($xml_string == null)
		{
			//echo "getting eids...<br>:"; echo ini_get('memcache.chunk_size');
			//print_r($memcache_obj->getExtendedStats());
			
			$doc = new DOMDocument('1.0','UTF-8');
			$doc->formatOutput = true;
			$recs = $doc->createElement('records');
			$recs = $doc->appendChild($recs);
			
			$cnt = 0;
			foreach ($eids as $eid)
			{
				$cnt++;
				//echo microtime()."RecordIniFacade: initializeRecordSet;  in loop run $cnt, eid: $eid,  <br>";
				$type_id = RecordsSys_EntityManagementSystems::get_type_id($eid); //can't rely on request type_id, because search results may have generic type_id
				$rec = new Record($eid,$type_id);
				$rec->set_ids_num_extra_from_lookup_count = false;
				$rec->initialize();
				
				//echo microtime()." --------RecordIniFacade: initializeRecordSet;  in loop run $cnt, after rec initalize  <br>";
				
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
			if ($this->memcache_on)
			{
				$result = memcache_set($memcache_obj,$memcache_key,$xml_string,MEMCACHE_COMPRESSED,0);
			}
		//	echo "succeed?".$result.",memcachekey:".$memcache_key;
				
		}
//echo "<xmp>".$xml_string."</xmp>";
			////echo microtime()." --------RecordIniFacade: initializeRecordSet;  in loop run $cnt, after doc saveXML  <br>";
		if ($this->memcache_on)
		{
			$memcache_obj->close();
		}
		
	}
	

	function update_record(&$xml_string, &$xslt_file)
	{
		if (empty($_REQUEST['rec_eid']) && empty($_REQUEST['rec_type_id']))
		{
			$rec = new Record($_REQUEST['eid'], $_REQUEST['type_id']);
		}
		else //leaving the below because \include\templates\RecordEditor\record.xsl includes the below rec_x post variables for some reason
		{
			$rec = new Record($_REQUEST['rec_eid'], $_REQUEST['rec_type_id']);
		}
		$rec->update_record();
//		$_REQUEST['eid'] = $_REQUEST['rec_eid'];
//		$_REQUEST['type_id'] = $_REQUEST['rec_type_id'];//required by this classes initialize method
//		$this->initialize($xml_string, $xslt_file);
	}
	
	function get_record_xml($eid)
	{
		return Record::get_record_xml($eid);
	}
	
	function get_record_xml_filtered($eid,$filter_properties)
	{ 
		$type_id = RecordsSys_EntityManagementSystems::get_type_id($eid);
		$rec = new Record($eid,$type_id);
		$rec->filter_properties = $filter_properties;
		$rec->initialize();
		$xml_string = $rec->xml_string;
		return $xml_string;
	}
	
	function get_record_history_page_xml(&$xml_string, &$xslt_file="")
	{
		$eid = $_REQUEST['eid'];
		$type_id = $_REQUEST['type_id'];
		
		$rec_hist = new RecordHistory($eid, $type_id);
		$rec_hist->create_record_history_page_xml();
		$xml_string = $rec_hist->record_history_page_xml;
	}
	
	function donothing(&$xml_string, &$xslt_file="")
	{
	
	}
}

?>