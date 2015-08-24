<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/ScalarQueries.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/MixedQueries.php');

class EntityManagementSystems
{

	static function get_eid_rec_count($search_term, $prop_id, $type_id)
	{
		return ScalarQueries::get_eid_rec_count($search_term, $prop_id, $type_id);
	}
	
	static function get_vals($eid, $prop_id, $type_id)
	{
		return MixedQueries::get_vals($eid, $prop_id, $type_id);
	
	}

	static function get_eids($search_term, $prop_id, $type_id)
	{
		return MixedQueries::get_eids($search_term, $prop_id, $type_id);
	
	}
}


?>