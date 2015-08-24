<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/ScalarQueries.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/MixedQueries.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/EntityMgmt_Facade.php');

class Notification_EntityManagementSystems
{

	static function get_vals($eid, $prop_id, $type_id)
	{
		return MixedQueries::get_vals($eid, $prop_id, $type_id);
	
	}
	
	static function get_eids($search_term, $prop_id, $type_id, $search_compare_op)
	{
		return MixedQueries::get_eids($search_term, $prop_id, $type_id, $search_compare_op);
	
	}
	
	static function get_prop_id($prop_alias)
	{
		return EntityMgmt_Facade::get_prop_id($prop_alias);
	}
	
	static function get_type_id($type_alias)
	{
		return EntityMgmt_Facade::get_type_id($type_alias);
	}
	
	function testst()
	{
		return "How";
	}


}


?>