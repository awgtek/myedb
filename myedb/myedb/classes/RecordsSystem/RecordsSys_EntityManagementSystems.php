<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/MixedQueries.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/VoidQueries.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/ScalarQueries.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/EntityMgmt_Facade.php');

class RecordsSys_EntityManagementSystems
{
	static function update_repeat_prop_qualifier($eid, $prop_group_id, $prop_id, $ron, $prop_qual_id)
	{
		VoidQueries::update_repeat_prop_qualifier($eid, $prop_group_id, $prop_id, $ron, $prop_qual_id);
	}

	function get_rpqs($eid)
	{
		return MixedQueries::get_rpqs($eid);
	}

	function get_prop_qualifiers($eid, $type_id)
	{
		return MixedQueries::get_prop_qualifiers($eid, $type_id);
	}

	static function delete_eid($eid)
	{
		VoidQueries::delete_eid($eid);
	}

	static function get_eids_by_prop_contains_search($search_term, $prop_id, $type_id)
	{
		return MixedQueries::get_eids_by_prop_contains_search($search_term, $prop_id, $type_id);
	
	}
	
	static function get_all_eids_by_type_category_and_datatype($data_type, $type_category, $type_id)
	{
		return MixedQueries::get_all_eids_by_type_category_and_datatype($data_type, $type_category, $type_id);
	
	}
	
	static function get_eids($search_term, $prop_id, $type_id, $search_compare_op)
	{
		return MixedQueries::get_eids($search_term, $prop_id, $type_id, $search_compare_op);
	
	}
	
	static function get_eids_values_hash($eids, $prop_id, $type_id, $desc=0)
	{
		return MixedQueries::get_eids_values_hash($eids, $prop_id, $type_id, $desc);
	}
	
	static function del_prop_group_by_ron($type_id, $prop_group_id, $ron, $eid)
	{
		VoidQueries::del_prop_group_by_ron($type_id, $prop_group_id, $ron, $eid);
	}
	
	static function del_prop_by_ron($prop_id, $ron, $eid)
	{
		VoidQueries::del_prop_by_ron($prop_id, $ron, $eid);
	}
	
	static function get_type_id($eid)
	{
		return ScalarQueries::get_type_id($eid);
	}
	
	static function get_date_added($eid)
	{
		return EntityMgmt_Facade::get_date_added($eid);
	}
	
	static function get_date_last_modified($eid)
	{
		return EntityMgmt_Facade::get_date_last_modified($eid);
	}
	
	static function get_entity($eid)
	{
		return EntityMgmt_Facade::get_entity($eid);
	}

}


?>