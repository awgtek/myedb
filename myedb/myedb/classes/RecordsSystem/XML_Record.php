<?php
//include_once (dirname(__FILE__) .'/Base_Record.php');


class XML_Record extends Base_Record
{
	var $set_ids_num_extra_from_lookup_count = true;
	
	function initialize()
	{
		//if eid = 0, it's necessary to create empty record for specified type, can't cache!
		//or if doing filter proprties, as the record xml returned will vary
		//$do_memcache = (!empty($this->eid) && empty($this->filter_properties));
		$do_memcache = false; //don't need this
		/* procedural API */
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
			if ($this->set_ids_num_extra_from_lookup_count)
			{
				$tempglu = new Glue;
				$tempglu->set_type_id($this->type_id);
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
				$tempglu->set_type_id($this->type_id);
				$tempglu->prop_ids = array(50); //subcategory property id = 50
				$tempglu->set_prop_id_prop_obj_hash();
				$tempglu->set_ent_prop_3dhash($this->eid);
				
				$this->glu->prop_ids_num_extra[50] = count(ClientServerDataOps::get_table_DS("subcategory"))
													- count($tempglu->ent_prop_3dhash[50]); //total subcategories minus those assigned to this entity - 2009-04-05 Adam George
				//echo "count esubcats: ".count(ClientServerDataOps::get_table_DS("subcategory"))."<br>count from glu: ".
				//$this->glu->prop_ids_num_extra[50]."--".count($tempglu->ent_prop_3dhash[50]);
			}			
			if ($this->type_id != 3) 
			{						
				$this->glu->prop_ids_num_extra[11] = 1;
			}
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
}
?>