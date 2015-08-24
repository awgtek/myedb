<?
/*
 * MyEDB CMS - My Entity Database CMS
 * Copyright (C) 2009 Adam George (adamwg@hotmail.com)
 *
 * == BEGIN LICENSE ==
 *
 * Licensed under the terms of any of the following licenses at your
 * choice:
 *
 *  - GNU General Public License Version 2 or later (the "GPL")
 *    http://www.gnu.org/licenses/gpl.html
 *
 *  - GNU Lesser General Public License Version 2.1 or later (the "LGPL")
 *    http://www.gnu.org/licenses/lgpl.html
 *
 *  - Mozilla Public License Version 1.1 or later (the "MPL")
 *    http://www.mozilla.org/MPL/MPL-1.1.html
 *
 * == END LICENSE ==
 *
 * MyEDB_XSLTProcessor Class: produces output.
 */

class MyEDB_XSLTProcessor
{
	

	function output_template($xml_string, $xslt_file, $params_assoc_arr="",$return_string=false)
	{
		//echo microtime()." starting MyEDB_XSLTProcessor::output_template<br>";
		$doheader = false;
		$doc = new DOMDocument;
		$doc->loadXML($xml_string);
		if ($xslt_file)
		{ 
		//	$memcache_key = md5($xml_string . $xslt_file);
		//	$memcache_obj = memcache_connect('localhost', 11211);
		//	$memcache_obj->setCompressThreshold(2000, 0.2);
		
		//	$form_string = memcache_get($memcache_obj,$memcache_key);
		//	if ($form_string == null)
		//	{
				$xsl = new DOMDocument; 
				$xsl->load($xslt_file);
				$xsl_string = $xsl->saveXML();
				// Configure the transformer
				$proc = new XSLTProcessor;
				$proc->importStyleSheet($xsl); // attach the xsl rules
				if (is_array($params_assoc_arr))
				{
					foreach ($params_assoc_arr as $param => $val)
					{
						$proc->setParameter('',$param,$val);
					}
				}
				//echo microtime()." MyEDB_XSLTProcessor::output_template, before ".' $proc->transformToXML'."<br>";
				$form_string = $proc->transformToXML($doc);
				//echo microtime()." MyEDB_XSLTProcessor::output_template, after ".' $proc->transformToXML'."<br>";
		//		$result = memcache_set($memcache_obj,$memcache_key,$form_string,MEMCACHE_COMPRESSED,0);
				
		//	}
		//	$memcache_obj->close();
			
		}
		else
		{
			$form_string = $doc->saveXML(); 
			$doheader = true;
		}
 //   define("CABECERA_XHTML", '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">');
//		$form_string = CABECERA_XHTML."\n".$form_string;
		
		//echo microtime()." just echoed form_string MyEDB_XSLTProcessor::output_template<br>";
		//return;
		//logging debugging below
		$htmlxml =  "<div style='position: absolute;z-index: 1;top:1050px;'><table border=1><tr><td valign='top'></td><td><xmp>$form_string</xmp></td></tr></table><xmp>$xml_string</xmp><p>XSL:<br><xmp>$xsl_string</xmp></div>";	
		
		$logout_index_file = dirname(__FILE__)."/../../logs/logout_index.txt";
		if (!file_exists($logout_index_file))
		{
			touch($logout_index_file);
		}
		$logout_index = file_get_contents($logout_index_file);
		if (!$logout_index)
		{
			$logout_index = 1;
		}
		$logoutfile = dirname(__FILE__)."/../../logs/logout".$logout_index.".txt";
		$fp1 = fopen($logoutfile,'w');
		fwrite($fp1,$htmlxml);
		$new_logout_index = ($logout_index % 4) + 1;
		
		file_put_contents($logout_index_file,$new_logout_index);
		
		
		if ($return_string)
		{
			return $form_string;
		}
		else
		{
			if ($doheader)
			{
				header('Content-type: text/xml; charset=utf-8');
			}
			
			echo $form_string;
		} 
		
		//echo microtime()." ended MyEDB_XSLTProcessor::output_template<br>";
	}

}

?>