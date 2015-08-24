<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransXMLElement.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TravelProcessor.php");


class TravelRequestInfoNode extends TransXMLElement
{
	function __construct()
	{
		$travel_processor = new TravelProcessor();
		$this->encap_elem = $travel_processor->details_encap_elem;
	
	}

	function insert_node(DOMDocument &$doc, DOMElement &$field_elem, SimpleXMLElement $details_xml)
	{
		$travel_res_submitted_fields = dom_import_simplexml($details_xml->travel_res_submitted_fields[0]);
		//$travel_res_submitted_fields = $doc->createElement("travel_res_submitted_fields");
		$dom_sxe = $doc->importNode($travel_res_submitted_fields, true);
		$field_elem->appendChild($dom_sxe);

		if ($details_xml->travel_product[0])
		{
			$travel_res_product = dom_import_simplexml($details_xml->travel_product[0]);
			//$travel_res_submitted_fields = $doc->createElement("travel_res_submitted_fields");
			$dom_sxe = $doc->importNode($travel_res_product, true);
			$field_elem->appendChild($dom_sxe);
		}
		
		if ($details_xml->travel_lookups[0])
		{
			$travel_res_product_lookups = dom_import_simplexml($details_xml->travel_lookups[0]);
			//$travel_res_submitted_fields = $doc->createElement("travel_res_submitted_fields");
			$dom_sxe_lkp = $doc->importNode($travel_res_product_lookups, true);
			$field_elem->appendChild($dom_sxe_lkp);
		}
		
		
	}


}



?>