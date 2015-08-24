<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Glue.php');
//include_once (dirname(__FILE__) .'/../ClientServerDataOps/validation_spec.php');
//include_once (dirname(__FILE__) .'/../RecordsSystem/RecordsSys_EntityManagementSystems.php');
//include_once (dirname(__FILE__) .'/../ClientServerDataOps/PostFieldSetter.php'); 
require_once (dirname(__FILE__) .'/../thirdparty/HTTP_Upload/Upload.php');
//include_once (dirname(__FILE__) .'/../ClientServerDataOps/ClientServerDataOps.php'); 
//include_once (dirname(__FILE__) .'/../RecordsSystem/memcache_search_keys.php');
//include_once (dirname(__FILE__) .'/XML_Record.php');

ini_set('memcache.chunk_size', 32768);


class Record extends XML_Record
{
	var $eid;
	var $type_id;
	var $glu;
	var $ent_prop_3dhash;
	var $xml_string;
	var $xslt_file;
	
	function Record($_eid,$_type_id)
	{
		$this->glu = new Glue();
		$this->eid = $_eid;// echo "helllllo".$_eid; if (empty($_eid))debug_print_backtrace();
		$this->type_id = $_type_id;
	//	echo "<br>EID:".$this->eid.",type_id:".$this->type_id."<br>";
	}
	
	static function delete_record($eid)
	{ 
		RecordsSys_EntityManagementSystems::delete_eid($eid);
	}
	
	function get_record_xml($eid)
	{
		$type_id = RecordsSys_EntityManagementSystems::get_type_id($eid);
		$rec = new Record($eid,$type_id);
		$rec->initialize();
		$xml_string = $rec->xml_string;
		return $xml_string;
	}
/*	
	function initialize()
	{
		//if eid = 0, it's necessary to create empty record for specified type, can't cache!
		//or if doing filter proprties, as the record xml returned will vary
		$do_memcache = (!empty($this->eid) && empty($this->filter_properties));
		// procedural API 
		$xml_string = "";
		if ($do_memcache)		{
			$memcache_obj = memcache_connect('localhost', 11211); //echo "eid: ".$this->eid."<br>";
			$xml_string = memcache_get($memcache_obj,$this->eid);
		}
		if ($xml_string && $this->eid)
		{// echo "got it!";
			$this->xml_string = $xml_string;
		}
		else
		{
			//echo microtime()." -Record: initialize;  entering  <br>";
			//get the number of Categories properties added to this entity
			$tempglu = new Glue;
			$tempglu->set_type_id($type_id);
			$tempglu->prop_ids = array(6); //category property id = 6
			$tempglu->set_prop_id_prop_obj_hash();
			$tempglu->set_ent_prop_3dhash($this->eid);
			//print_r( $tempglu->ent_prop_3dhash); echo "count".count($tempglu->ent_prop_3dhash[6])."<br>";
			//echo "category count:". count(ClientServerDataOps::get_table_DS("category"));
			//debug_print_backtrace();
			
			$this->glu->prop_ids_num_extra[6] = count(ClientServerDataOps::get_table_DS("category"))
												- count($tempglu->ent_prop_3dhash[6]); //total categories minus those assigned to this entity - 2009-04-03 Adam George
			
												
			//get the number of SubCategories properties added to this entity
			$tempglu = new Glue;
			$tempglu->set_type_id($type_id);
			$tempglu->prop_ids = array(50); //subcategory property id = 50
			$tempglu->set_prop_id_prop_obj_hash();
			$tempglu->set_ent_prop_3dhash($this->eid);
			
			$this->glu->prop_ids_num_extra[50] = count(ClientServerDataOps::get_table_DS("subcategory"))
												- count($tempglu->ent_prop_3dhash[50]); //total subcategories minus those assigned to this entity - 2009-04-05 Adam George
			//echo "count esubcats: ".count(ClientServerDataOps::get_table_DS("subcategory"))."<br>count from glu: ".
			//$this->glu->prop_ids_num_extra[50]."--".count($tempglu->ent_prop_3dhash[50]);
												
			$this->glu->prop_ids_num_extra[11] = 1;
		//	$this->glu->prop_ids_num_extra[50] = 1;
		//	$this->glu->prop_ids_num_extra[35] = 1;
			$this->glu->set_prop_ids_num_extra_by_group_id(1);
			$this->glu->set_prop_ids_num_extra_by_group_id(2);
			$this->glu->set_prop_ids_num_extra_by_group_id(3);
			//$this->glu->set_prop_ids_num_extra_by_group_id(2);
			$this->glu->set_type_frame($this->type_id);
			//$this->glu->set_type_id($this->type_id);
			//$this->glu->set_prop_ids();
			//$this->glu->set_prop_id_prop_obj_hash();
			//echo microtime()." -Record: initialize;  calling ".'$this->glu->set_ent_prop_3dhash($this->eid);'."<br>";
			$this->ent_prop_3dhash = $this->glu->set_ent_prop_3dhash($this->eid);
			//echo microtime()." -Record: initialize;  calling ".'this->create_xml_rec();'."<br>";
			$this->xml_string = $this->create_xml_rec();
			if ($do_memcache)//if eid = 0, it's necessary to create empty record for specified type, can't cache!
			{
				$result = memcache_set($memcache_obj,$this->eid,$this->xml_string,MEMCACHE_COMPRESSED,0);
			//echo "succeed?".$result.",memcachekey:".$this->eid;
			}
			
		}
		if ($do_memcache)//if eid = 0, it's necessary to create empty record for specified type, can't cache!
		{
			$memcache_obj->close();
		}
		//print_r( $this->glu->ent_prop_3dhash); echo "count".count($glu->ent_prop_3dhash[6])."<br>";
		
		//$this->xslt_file = $_SERVER['DOCUMENT_ROOT']."/XSLTemplates/testrec.xsl"; //get rid of this line
		//echo "eid: ".$this->eid."microtime:".microtime()." -Record: initialize;  end <br>";
		
	}
	*/
	function update_record()
	{ 	//echo "eid:".$this->eid.",type_id:".$this->type_id.",I'm in update!<br>";
		PostFieldSetter::set_prop_fields_from_standin();
		PostFieldSetter::set_post_password_field();
		$upload = new HTTP_Upload("en");
		foreach ($_FILES as $fldname => $fileobj)
		{  //echo "yo:".$fldname.":yo";
			if (ereg("^pi26epi|^pi27epi|^pi61epi",$fldname) and !empty($fileobj['tmp_name']))
			{ 
				$file = $upload->getFiles($fldname);
				$file->setName('uniq');
				if ($file->isValid()) {
					$moved = $file->moveTo(APP_ROOT. "/client_uploaded_images/");
					if (PEAR::isError($moved)) {
						die ("unable to upload the image(s). Error ref: @E@123543fwq<br>".$moved->getMessage());
					}
					$_REQUEST[$fldname] = $file->getProp('name');
				}else echo $file->getMessage();
			}		
		}
		
		$this->glu->eid = $this->eid;
		$this->glu->set_type_id($this->type_id);
		$this->glu->set_ent_prop_3dhash_from_post($this->eid);
		$this->glu->commit_updates_from_ent_prop_3dhash();
		
		if ($_REQUEST['groups_to_delete'])
		{
			foreach ($_REQUEST['groups_to_delete'] as $pgidNridN)
			{
				ereg("^pgid([0-9]+)rid([0-9]+)$",$pgidNridN,$subpatterns);
				$type_id = $_REQUEST['rec_type_id'];
				$eid = $_REQUEST['rec_eid'];
				$prop_group_id = $subpatterns[1];
				$ron = $subpatterns[2];
				RecordsSys_EntityManagementSystems::del_prop_group_by_ron($type_id, $prop_group_id, $ron, $eid);
			}
		}
		if ($_REQUEST['props_to_delete'])
		{
			foreach ($_REQUEST['props_to_delete'] as $pidNridN)
			{
				ereg("^pid([0-9]+)rid([0-9]+)$",$pidNridN,$subpatterns);
				$eid = $_REQUEST['rec_eid'];
				$prop_id = $subpatterns[1];
				$ron = $subpatterns[2];
				RecordsSys_EntityManagementSystems::del_prop_by_ron($prop_id, $ron, $eid);
			}
		}
		if ($_REQUEST['rep_prop_quals'])
		{
			foreach ($_REQUEST['rep_prop_quals'] as $pqiNpgiNronN)
			{
				if (ereg("^pqi([0-9]+)pgi([0-9]+)ron([0-9]+)$",$pqiNpgiNronN,$subpatterns) and $subpatterns[1] != 0)
				{ 
					$eid = $_REQUEST['rec_eid'];
					$prop_qual_id = $subpatterns[1];
					$prop_group_id = $subpatterns[2];
					$ron = $subpatterns[3];
					RecordsSys_EntityManagementSystems::update_repeat_prop_qualifier($eid, $prop_group_id, 0, $ron, $prop_qual_id);
				}
				else if (ereg("^pqi([0-9]+)pi([0-9]+)ron([0-9]+)$",$pqiNpgiNronN,$subpatterns) and $subpatterns[1] != 0)
				{ 
					$eid = $_REQUEST['rec_eid'];
					$prop_qual_id = $subpatterns[1];
					$prop_id = $subpatterns[2];
					$ron = $subpatterns[3];
					RecordsSys_EntityManagementSystems::update_repeat_prop_qualifier($eid, 0, $prop_id, $ron, $prop_qual_id);
				}
			}
		}
		//$memcache_obj = memcache_pconnect('localhost', 11211);
		//memcache_delete($memcache_obj, $this->eid,0);
		//memcache_search_key::delete_search_keys();
	}
	
	function create_xml_rec()
	{
		//echo microtime()." --Record: create_xml_rec;   ".'entering'."<br>";
		
		//else continue on to make the xml string and set it in memcache:
		
		// create a new XML document
//		$doc = new DomDocument('1.0');
$doc = new DOMDocument('1.0', 'UTF-8');
//$doc->appendChild($doc->createProcessingInstruction(
//    'xml-stylesheet', 'href="/XSLTemplates/testrec.xsl" type="text/xsl"'));
		//we want a nice output
		$doc->formatOutput = true;
		// create root node
		$rec = $doc->createElement('record');
		$rec = $doc->appendChild($rec);
		$rec->setAttribute("eid",$this->eid);
		$rec->setAttribute("type_id",$this->type_id);
		
		//add prop/prop group qualifier record data
		$rpqs = $doc->createElement('rpqs');
		$rpqs = $rec->appendChild($rpqs);
		$rpqs_ar = RecordsSys_EntityManagementSystems::get_rpqs($this->eid);
		foreach($rpqs_ar as $rpq_rec)
		{
			$rpq = $doc->createElement('repeat_prop_qualifier');
			$rpq = $rpqs->appendChild($rpq);
			foreach($rpq_rec as $fieldname => $val)
			{
				$rpq->setAttribute($fieldname,$val);
			}
		}
		
		//add prop/prop group qualifiers
		$prop_quals = $doc->createElement('prop_qualifiers');
		$prop_quals = $rec->appendChild($prop_quals);
		$prop_quals_ar = RecordsSys_EntityManagementSystems::get_prop_qualifiers($this->eid,$this->type_id);
		foreach($prop_quals_ar as $prop_qual_value)
		{
			$prop_qual = $doc->createElement('prop_qualifier');
			$prop_qual = $prop_quals->appendChild($prop_qual);
			foreach($prop_qual_value as $fieldname => $val)
			{
				$prop_qual->setAttribute($fieldname,$val);
			}
		}
		//print_r ($this->glu->ent_prop_3dhash);
		//echo microtime()." --Record: create_xml_rec;   ".'starting foreach($this->glu->ent_prop_3dhash as $prop_id => $ron)'."<br>";
		// process one row at a time
		foreach($this->glu->ent_prop_3dhash as $prop_id => $ron) {
			//skip if not in filter properties set or if filter set is empty
			if (!empty($this->filter_properties) && !in_array($prop_id, $this->filter_properties))
			{ //echo "skipping ".$prop_id." for ".$this->eid;
				continue; 
				
			}
		  // add node for each row
		  foreach ($ron as $theron => $theprop )
		  {
				//echo microtime()." ----Record: create_xml_rec;   ".'starting loop for $ron: '."$theron, prop_id: $prop_id<br>";
		  	//  $roni = 0; //ron index
			 // $theprop = $ron[$roni];
			  $thepropname = $this->glu->prop_id_prop_obj_hash[$prop_id]->get_property_name();
			  $thepropgroupid = $this->glu->prop_id_prop_obj_hash[$prop_id]->prop_group_id;
			  $validationspecid = $this->glu->prop_id_prop_obj_hash[$prop_id]->validation_spec_id;
			  $occ = $doc->createElement("property");
			  $occ = $rec->appendChild($occ);
			  $occ->setAttribute("prop_name",$thepropname);
			  //ffi=(html) form field identifier
			  $occ->setAttribute("ffi","pi".$prop_id."epi".$theprop->my_ent_prop_id."ron".$theron);
			  $occ->setAttribute("prop_group_id",$thepropgroupid);
			  $occ->setAttribute("prop_id",$prop_id);
			  $occ->setAttribute("epi",$theprop->my_ent_prop_id);
			  $occ->setAttribute("ron",$theron);
			  // add a child node for each field
			  $fieldvalue = $theprop->get_val();
			  $valnode = $doc->createElement("value");
			  $occ->appendChild($valnode);
			  $value = $doc->createTextNode($fieldvalue);
			  $value = $valnode->appendChild($value);
			  //echo microtime()." ----Record: create_xml_rec;   ".'halfway through loop for $ron: '."$ron<br>";
			  
			  //add validation elements
			  if ($validationspecid)
			  {
				$validator = $doc->createElement("validator");
				$validator = $occ->appendChild($validator);
				
			  //echo microtime()." ----Record: create_xml_rec;   ".' before validationspec = new val...: '."$ron<br>";
				$validationspecobj = new validation_spec($validationspecid);
			//	$lookuptablehash = $validationspecobj->lookup_table_hash; //echo "hello66".$validationspecid;
				$v_regex = $validationspecobj->v_regex;
			/*	if ($lookuptablehash) //print_r($lookuptablehash);
				{
					$selectnode = $doc->createElement("select");
					$selectnode = $validator->appendChild($selectnode);
					foreach ($lookuptablehash as $LUTR_id => $cat_name)
					{
						$catoptnode = $doc->createElement("option");
						$selectnode->appendChild($catoptnode);
						$catoptnode->setAttribute("LUTR_id",$LUTR_id);
						$cat_name_txt_node = $doc->createTextNode($cat_name);
						$cat_name_txt_node = $catoptnode->appendChild($cat_name_txt_node);
					}
				} */
				if ($v_regex)
				{
					$regexnode = $doc->createElement("v_regex");
					$regexnode = $validator->appendChild($regexnode);
					$value = $doc->createTextNode($v_regex);
					$value = $regexnode->appendChild($value);
				}
			  }
			  //echo microtime()." ----Record: create_xml_rec;   ".'ending loop for $ron: '."$ron<br>";
			  
		  }
		  
		} // foreach
		// get completed xml document
		//echo microtime()." --Record: create_xml_rec;   ".'ended foreach($this->glu->ent_prop_3dhash as $prop_id => $ron)'."<br>";
		$xml_string = $doc->saveXML();
	//	print_r($this->glu->prop_id_prop_obj_hash);
		//echo microtime()." --Record: create_xml_rec;   ".'returning'."<br>";
		return $xml_string;
		
	/*	$xsl = new DOMDocument;
		$xsl->load($_SERVER['DOCUMENT_ROOT'].'/XSLTemplates/testrec.xsl');
		$xsl_string = $xsl->saveXML();
		// Configure the transformer
		$proc = new XSLTProcessor;
		$proc->importStyleSheet($xsl); // attach the xsl rules
		$form_string = $proc->transformToXML($doc);
		
		return "<table border=1><tr><td>$form_string</td><td><xmp>$form_string</xmp></td></tr></table><xmp>$xml_string</xmp><p>XSL:<br><xmp>$xsl_string</xmp>";	
		*/
	}
	
	function get_date_added()
	{
		return RecordsSys_EntityManagementSystems::get_date_added($this->eid);
	}
	
	function get_date_last_modified()
	{
		return RecordsSys_EntityManagementSystems::get_date_last_modified($this->eid);
	}
}
?>