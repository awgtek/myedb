<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/MixedQueries.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Entity.php');

class ScalarQueries
{

	static function get_eid_rec_count($search_term, $prop_id, $type_id)
	{
		$eids = MixedQueries::get_eids($search_term, $prop_id, $type_id);
		return count($eids);
	}
	
	static function get_type_id($eid)
	{
		return Entity::get_type_id($eid);
	}
}

?>