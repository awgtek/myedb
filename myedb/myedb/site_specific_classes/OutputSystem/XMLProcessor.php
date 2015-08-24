<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/OutputSys_EntityManagementSystems.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/OutputSys_ClientServerDataOps.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/ClientServerDataOps/SubLookupTable.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/GenericDBDS.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/AppSettings.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/ApplicationEntities/AppEntities_Facade.php');

class XMLProcessor
{
	var $doc;
	var $doc_root;
	var $root_elem;
	
	function XMLProcessor($empty_doc = false,$root_elem='myedbroot')
	{
		$this->root_elem = $root_elem;
		if ($empty_doc)
		{
			$this->create_empty_doc_root();
		}
		else
		{
			$this->create_doc_root();
		}
	}
	
	function create_empty_doc_root()
	{
		$this->doc = new DOMDocument('1.0','UTF-8');
		$this->doc->formatOutput = false;
		$this->doc_root = $this->doc->createElement($this->root_elem);
		$this->doc_root = $this->doc->appendChild($this->doc_root); 
	}
	
	function create_doc_root()
	{
		$this->doc = new DOMDocument('1.0','UTF-8');
		$this->doc->formatOutput = true;
		$this->doc_root = $this->doc->createElement('myedbroot');
		$this->doc_root = $this->doc->appendChild($this->doc_root); 
		$this->add_standard_additions();
	}
	
	function add_standard_additions()
	{
		$logged_in_user = AppEntities_Facade::get_user_instance();
		$logged_in_user_id = $logged_in_user->user_id;
		
		$rec = new Record($logged_in_user_id,3); 
		$rec->initialize();
		$xml_string = $rec->xml_string;
		$this->append_child_from_xml($xml_string, "logged_in_user_record"); //echo $xml_string;
		
	}

	function append_child_from_xml($xml_string, $encap_elem="")
	{
		$doc2 = new DOMDocument('1.0','UTF-8'); 
		$doc2->loadXML($xml_string);
		$node = $this->doc->importNode($doc2->firstChild,true);
		if (!empty($encap_elem))
		{
			$new_encap_elem = $this->doc->createElement($encap_elem);
			$new_encap_elem = $this->doc_root->appendChild($new_encap_elem);
			$new_encap_elem->appendChild($node);
		}
		else
		{
			$this->doc_root->appendChild($node);
		}
	}
	
	static function prepare_doc(&$xml_string,$lists_ar="",$empty_doc = false,$root_elem='myedbroot')
	{
		$xmlproc = new XMLProcessor($empty_doc,$root_elem);
		if (!empty($xml_string))
		{
			$xmlproc->append_child_from_xml($xml_string);
		}
		if (!empty($lists_ar))
		{
			foreach($lists_ar as $the_list)
			{
				$xmlproc->$this_list();
			}
		}
		$xml_string = $xmlproc->doc->saveXML();
		return $xmlproc;
		
	}

	static function encap_with_lists(&$xml_string)
	{
		$lookup_table_obj = OutputSys_ClientServerDataOps::get_LookupTableObj();
		$xmlproc = new XMLProcessor();
		if (!empty($xml_string))
		{
			$xmlproc->append_child_from_xml($xml_string);
		}
		$xmlproc->add_lookup_table_list($lookup_table_obj,"acctmgr",'lookup_table_acctmgrs');
		$xmlproc->add_category_list();
		$xmlproc->add_subcategory_list();
		$xmlproc->add_type_list();
		$xmlproc->add_status_list();
		
		$xmlproc->add_entity_grouping_featured_list();
		$xmlproc->add_entity_grouping_featured_type_list();
		
		$xml_string = $xmlproc->doc->saveXML();
		return $xmlproc;
	}
	
	function encap_with_lists_non_static(&$xml_string="")
	{
		$lookup_table_obj = OutputSys_ClientServerDataOps::get_LookupTableObj();
		//$xmlproc = new XMLProcessor();
		if (!empty($xml_string))
		{
			$this->append_child_from_xml($xml_string);
		}
		$this->add_lookup_table_list($lookup_table_obj,"acctmgr",'lookup_table_acctmgrs');
		$this->add_category_list();
		$this->add_subcategory_list();
		$this->add_type_list();
		$this->add_status_list();
		
		$this->add_entity_grouping_featured_list();
		$this->add_entity_grouping_featured_type_list();
		
		$xml_string = $this->doc->saveXML();
		//return $xmlproc;
	}
	
	function add_entity_grouping_featured_list()
	{
		$gdbs = new GenericDBDS("entity_grouping");
		//$gdbs->where_clause = "where eg_type = ".AppSettings::gv("eg_type__featured");
		$xmlstring = $gdbs->get_xml_dataset("entity_grouping");
		$this->append_child_from_xml($xmlstring);
	}

	function add_entity_grouping_featured_type_list()
	{
		$gdbs = new GenericDBDS("entity_grouping_types");
		//$gdbs->where_clause = "where eg_type = ".AppSettings::gv("eg_type__featured");
		$xmlstring = $gdbs->get_xml_dataset("entity_grouping_types");
		$this->append_child_from_xml($xmlstring);
	}

	function add_lookup_table_lists()
	{
		$lookup_table_obj = OutputSys_ClientServerDataOps::get_LookupTableObj();
		$this->add_lookup_table_list($lookup_table_obj,"acctmgr",'lookup_table_acctmgrs');
		$this->add_category_list();
		$this->add_subcategory_list();
		$this->add_type_list();
		$this->add_status_list();
		$this->add_city_state_zip_lists();
	
	}
	
	function add_category_list()
	{//return;
		//$category_hash = OutputSys_EntityManagementSystems::get_category_list();
		$lookuptable = new LookupTable("category");
		$category_hash = $lookuptable->get_table();
		$category_type_matrix = OutputSys_EntityManagementSystems::get_category_type_mapping();
		/*
		$doc = new DOMDocument('1.0','UTF-8');
		$doc->formatOutput = true;
		$root = $doc->createElement('myedbroot');
		$root = $doc->appendChild($root);
			*/	
		
		$cats = $this->doc->createElement('categories');
		$this->doc_root->appendChild($cats);
		
		foreach ($category_hash as $cat_id => $cat_name_ar)
		{
			$cat_name = $cat_name_ar[0];
			$cat = $this->doc->createElement('category');
			$cats->appendChild($cat);
			$cat->setAttribute("cat_id",$cat_id);
			$cat->setAttribute("is_disabled",$cat_name_ar['disabled']);
			//add elements showing which types are associated with this category
			$types = $this->doc->createElement('cattypes');
			$cat->appendChild($types);
			if (is_array($category_type_matrix[$cat_id]))//if not set, means no records associated with category
			{
				foreach($category_type_matrix[$cat_id] as $type_id)
				{
					$type = $this->doc->createElement('cattype');
					$types->appendChild($type);
					$type_id_txt = $this->doc->createTextNode($type_id);
					$type->appendChild($type_id_txt);
				}
			}
			//add category text node
			$catval = $this->doc->createElement('catval');
			$cat->appendChild($catval);
			$catnm_node = $this->doc->createTextNode($cat_name);
			$catval->appendChild($catnm_node);
		}
	//	$rec->glu->prop_ids_num_extra[6] = 1;
	//	$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		//$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		//	$xslt_file = 		$_SERVER['DOCUMENT_ROOT']."/XSLTemplates/testrecs.xsl";
		//$xml_string = $doc->saveXML();
		
	}

	function add_subcategory_list()
	{//return;
		$lookuptable = new SubLookupTable("subcategory");
		$subcategory_hash = $lookuptable->get_table();
		
		$subcategories = $this->doc->createElement('subcategories');
		$this->doc_root->appendChild($subcategories);
		
		foreach($subcategory_hash as $lkup_id => $val_ext_ar)
		{
			$subcategory = $this->doc->createElement('subcategory');
			$subcategory = $subcategories->appendChild($subcategory);
			$subcategory->setAttribute('subcat_id',$lkup_id);
			$subcategory->setAttribute('subcat_name',$val_ext_ar[0]);
			$subcategory->setAttribute('cat_id',$val_ext_ar['lookup_table_id']);
			$subcategory->setAttribute('is_disabled',$val_ext_ar['disabled']);
		}
	}

	function add_type_list()
	{
		$type_hash = OutputSys_EntityManagementSystems::get_type_list();
		
		$types = $this->doc->createElement('types');
		$this->doc_root->appendChild($types);
		
		foreach ($type_hash as $type_id => $type_name)
		{
			$type = $this->doc->createElement('type');
			$types->appendChild($type);
			$type->setAttribute("type_id",$type_id);
			$typenm_node = $this->doc->createTextNode($type_name);
			$type->appendChild($typenm_node);
		}
	}

	function add_property_list()
	{
		$property_hash = OutputSys_EntityManagementSystems::get_property_list();
		
		$namespace = 'urn:myedb:propertylist';
		//$properties = $this->doc->createElementNS($namespace,'pl:properties'); //this works, but must use createElementNs(..) for subelements
		$properties = $this->doc->createElementNS($namespace,'properties'); //using default namespace (don't have to use prefixes for subelements)
		//$properties = $this->doc->createElement('properties');
		$this->doc_root->appendChild($properties);
		
		foreach ($property_hash as $property_id => $property_name)
		{
			//$property = $this->doc->createElementNS($namespace,'property'); //works, see above (adds prefix)
			$property = $this->doc->createElement('property');
			$properties->appendChild($property);
			$property->setAttribute("property_id",$property_id);
			$propertynm_node = $this->doc->createTextNode($property_name);
			$property->appendChild($propertynm_node);
		}
	}

	function add_city_state_zip_lists()
	{
		//$lookup_table_obj = OutputSys_ClientServerDataOps::get_LookupTableObj();
		$this->add_lookup_table_list(OutputSys_ClientServerDataOps::get_LookupTableObj(),"city",'lookup_table_cities');
		$this->add_lookup_table_list(OutputSys_ClientServerDataOps::get_LookupTableObj(),"state",'lookup_table_states');
		$this->add_lookup_table_list(OutputSys_ClientServerDataOps::get_LookupTableObj(),"zip",'lookup_table_zips');

	}
	
	function add_status_list()
	{
		$lookup_table_obj = OutputSys_ClientServerDataOps::get_LookupTableObj();
		$this->add_lookup_table_list($lookup_table_obj,"status",'lookup_table_statuses');
	}
	
	function add_lookup_table_list($lookup_table_obj, $lookup_table,$encap_elem)
	{
		//$lookup_table_obj->tbl_name = $lookup_table;
		$lookup_table_obj->set_table_name($lookup_table);
		
	//	$lookup_table_hash = $lookup_table_obj->get_table();
		
		$lookup_table_elem = $this->doc->createElement($encap_elem);
		$this->doc_root->appendChild($lookup_table_elem);
		
		$lookup_table_obj->append_xml_values($lookup_table_elem, $this->doc);
		/*
		foreach($lookup_table_hash as $lookup_table_id => $lookup_table_rec_ar)
		{
			$lookup_table_field_name = $lookup_table_rec_ar[0];
			$lookup_table_item_is_disabled = $lookup_table_rec_ar['disabled']; 
			$lookup_table_rec = $this->doc->createElement($lookup_table,$lookup_table_field_name);
			$lookup_table_elem->appendChild($lookup_table_rec);
			$lookup_table_rec->setAttribute($lookup_table."_id",$lookup_table_id);
			$lookup_table_rec->setAttribute("is_disabled",$lookup_table_item_is_disabled);
		}
		*/
	}
}



?>