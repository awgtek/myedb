<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/EntityGrouping.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/AppSettings.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/MetaDataOps_RecordSys.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/GenericDBDS.php');


class GroupedItems
{
	var $entity_grouping;
	var $grouping_type;

	function __construct()
	{
		$this->entity_grouping = new EntityGrouping($this->grouping_type);
	}

	function add_entity($eid)
	{
		$this->entity_grouping->add_entity($eid);
	}
	
	function remove_entity($eid)
	{
		$this->entity_grouping->remove_entity($eid);
	}
	
	static function remove_entity_by_id($eg_id)
	{
		EntityGrouping::remove_entity_by_id($eg_id);
	}
	
	function maximum_reached()
	{
		return $this->entity_grouping->max_reached();
	}
	
	function get_xml_list()
	{
		return MetaDataOps_RecordSys::get_xml_list($this->get_eids());
	}
	
	function get_eids()
	{
		$gdbs = (empty($this->grouping_type))? new GenericDBDS("entity_grouping",array("eid")) : new GenericDBDS("entity_grouping",array("eid"),array("eg_type"=>$this->grouping_type));
		$recs = $gdbs->get_recs();
		$eids = array();
		foreach($recs as $rec)
		{
			$eids[] = $rec["eid"];
		}
		//hack need to create new special functions for adding site messages
		$eids[] = 283; //id of public site welcome message
		return $eids;
	}

}


?>