<?

abstract class TransXMLElement
{
	var $encap_elem;

	abstract function insert_node(DOMDocument &$doc, DOMElement &$field_elem, SimpleXMLElement $details_xml);


}


?>