<?php
//include_once (dirname(__FILE__) .'/Base_Record.php');

//represents a record for a type. 
//only adds the first ron of all properties to its data structure, and if properties belong to a group, then 
//ensures that the properties from that group are produced in a set defined as having the same ron number.
//data structure of this class: key => value pairs, with key being the properties of this type and value the 
//the corresponding values of this eid
class One_Row_Record extends Base_Record
{
	var $prop_id_value_hash;
	
	function __construct($_eid, $_type_id)
	{
		parent::__construct($_eid, $_type_id);
		$this->initialize();
	}
	
	/*in One_Row_Record, when creating record, iterate through ent_prop_3dhash as in Record:246. When going 
	 * through rons as in Record:254, if thepropgroupid is empty, then add the value to 
	 * $prop_id_value_hash[$prop_id]. If thepropgroupid is not empty, set 
	 * propgroupdata[$thepropgroupid] = array()//if not set; then set 
	 * propgroupdata[$thepropgroupid][$ron] = array();//if first; then 
	 * propgroupdata[$thepropgroupid][$ron][$propid] = value; after iteration, iterate through 
	 * propgroupdata, then pop first ron, and add all prop_ids to $prop_id_value_hash
	*/	
	function setup()
	{
		$propgroupdata = array();
		foreach($this->glu->ent_prop_3dhash as $prop_id => $ron) {
			//skip if not in filter properties set or if filter set is empty
			if (!empty($this->filter_properties) && !in_array($prop_id, $this->filter_properties))
			{ 
				continue; 
				
			}
			if (!empty($this->exclude_properties) && in_array($prop_id, $this->exclude_properties))
			{
				continue;
			}
			$thepropname = $this->glu->prop_id_prop_obj_hash[$prop_id]->get_property_name();
			$thepropgroupid = $this->glu->prop_id_prop_obj_hash[$prop_id]->prop_group_id;
			// add node for each row
			foreach ($ron as $theron => $theprop )
			{
				//echo microtime()." ----Record: create_xml_rec;   ".'starting loop for $ron: '."$theron, prop_id: $prop_id<br>";
				  //  $roni = 0; //ron index
				 // $theprop = $ron[$roni];
				if (method_exists($theprop,"get_value_with_referenced"))
				{
					$fieldvalue = $theprop->get_value_with_referenced(); //set lookuptable values
				}
				else
				{
					$fieldvalue = $theprop->get_val();
				}
				if (empty($thepropgroupid))
				{
					$this->prop_id_value_hash[$prop_id] = $fieldvalue;
				}
				else
				{
					if (!isset($propgroupdata[$thepropgroupid]))
					{
						$propgroupdata[$thepropgroupid] = array();
					}	
					if (!isset($propgroupdata[$thepropgroupid][$theron]))
					{
						$propgroupdata[$thepropgroupid][$theron] = array();
					}
					$propgroupdata[$thepropgroupid][$theron][$prop_id] = $fieldvalue;
				}
			}
		} // foreach
		foreach ($propgroupdata as $propgroupid => $propgroupdatum)
		{
			$first_row_of_prop_group = array_shift($propgroupdatum);
			foreach ($first_row_of_prop_group as $fr_prop_id => $fr_prop_val)
			{
				$this->prop_id_value_hash[$fr_prop_id] = $fr_prop_val;
			}
		}
		
		// get completed xml document
		//echo microtime()." --Record: create_xml_rec;   ".'ended foreach($this->glu->ent_prop_3dhash as $prop_id => $ron)'."<br>";
	//	$xml_string = $doc->saveXML();
		//echo microtime()." --Record: create_xml_rec;   ".'returning'."<br>";
	//	return $xml_string;
		
	}
}
?>