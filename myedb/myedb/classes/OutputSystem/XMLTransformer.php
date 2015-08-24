<?php

class XMLTransformer
{
	public function __call($name, $arguments) {
        // Note: value of $name is case sensitive.
     //   echo "Calling object method '$name' "
     //        . implode(', ', $arguments). "\n";
		//$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template($name);
		//echo $xslt_file; die();
			$xmlprocessor = XMLProcessor::prepare_doc($arguments[0],"",true,$arguments[1]);
			$xml_string = $xmlprocessor->doc->saveXML(); //echo "hello$xslt_file<xmp>".$xml_string."</xmp>";
		$result_xml = MyEDB_XSLTProcessor::output_template($xml_string, $xslt_file, "",true);
		//echo "<xmp>456".$result_xml."</xmp>";
		return $result_xml;
			
             
    }
	
	
}
?>