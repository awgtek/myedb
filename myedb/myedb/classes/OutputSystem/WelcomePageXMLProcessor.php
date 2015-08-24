<?php
//include_once (dirname(__FILE__) .'/XMLProcessor.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/RotatedXMLTable.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/AppSettings.php');

class WelcomePageXMLProcessor extends XMLProcessor
{
	var $item_count = 5; //not used
	
	function add_entity_grouping_featured_list()
	{
		$doc = new DOMDocument("1.0","UTF-8");
		$encap_elem = $doc->createElement("entity_grouping");
		$encap_elem = $doc->appendChild($encap_elem);
		
		
		$gdbs = new RotatedXMLTable(AppSettings::gv("NumGroupItemsType1Display"), "entity_grouping",array(), array());
		$gdbs->where_clause = "where eg_type = ".AppSettings::gv("eg_type__featured");
		$gdbs->get_xml_dataset("entity_grouping",$doc);
		//$this->append_child_from_xml($xmlstring);

		/* append all nodes from $nodeList to the new dom, as children of $root:
		foreach ($nodeList as $domElement){
		   $domNode = $newDom->importNode($domElement, true);
		   $root->appendChild($domNode);
		}*/
		
		$gdbs = new RotatedXMLTable(AppSettings::gv("NumGroupItemsType2Display"), "entity_grouping",array(), array());
		$gdbs->where_clause = "where eg_type = ".AppSettings::gv("eg_type__populartrades");
		$gdbs->get_xml_dataset("entity_grouping",$doc);
		
		$gdbs = new RotatedXMLTable(AppSettings::gv("NumGroupItemsType3Display"), "entity_grouping",array(), array());
		$gdbs->where_clause = "where eg_type = ".AppSettings::gv("eg_type__tradeoftheday");
		$gdbs->get_xml_dataset("entity_grouping",$doc);
		
		$xmlstring = $doc->saveXML();
		$this->append_child_from_xml($xmlstring);
	}

	
	
}

?>