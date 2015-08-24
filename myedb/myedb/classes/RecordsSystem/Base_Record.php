<?php


class Base_Record
{
	var $filter_properties;
	var $exclude_properties;
	
	function __construct($_eid,$_type_id)
	{
		$this->glu = new Glue();
		$this->eid = $_eid;
		$this->type_id = $_type_id;
	//	echo "<br>EID:".$this->eid.",type_id:".$this->type_id."<br>";
	}
	
	function initialize()
	{
		//if eid = 0, it's necessary to create empty record for specified type, can't cache!
		//or if doing filter proprties, as the record xml returned will vary
		//$do_memcache = (!empty($this->eid) && empty($this->filter_properties));
		/* procedural API */
		$xml_string = "";
		//echo microtime()." -Record: initialize;  entering  <br>";
		//get the number of Categories properties added to this entity
											
		$this->glu->set_type_frame($this->type_id);
		//$this->glu->set_type_id($this->type_id);
		//$this->glu->set_prop_ids();
		//$this->glu->set_prop_id_prop_obj_hash();
		//echo microtime()." -Record: initialize;  calling ".'$this->glu->set_ent_prop_3dhash($this->eid);'."<br>";
		$this->ent_prop_3dhash = $this->glu->set_ent_prop_3dhash($this->eid);
			//echo microtime()." -Record: initialize;  calling ".'this->create_xml_rec();'."<br>";
		//print_r( $this->glu->ent_prop_3dhash); echo "count".count($glu->ent_prop_3dhash[6])."<br>";
		
		//$this->xslt_file = $_SERVER['DOCUMENT_ROOT']."/XSLTemplates/testrec.xsl"; //get rid of this line
		//echo "eid: ".$this->eid."microtime:".microtime()." -Record: initialize;  end <br>";
		
	}
	
}
?>