<?php
//include_once (dirname(__FILE__) .'/EntMgmtDict.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Entity.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Property.php');


class EntityMgmt_Facade
{

	static function get_prop_id($prop_alias)
	{
		return EntMgmtDict::get_prop_id($prop_alias);
	}
	
	static function get_type_id($type_alias)
	{
		return EntMgmtDict::get_type_id($type_alias);
	}

	static function get_date_added($eid)
	{
		return Entity::get_date_added($eid);
	}
	
	static function get_date_last_modified($eid)
	{
		return Entity::get_date_last_modified($eid);
	}
	
	static function get_property_list()
	{
		return Property::get_property_list();
	}
	
	static function get_entity($eid)
	{
		$entity = new Entity($eid);
		return $entity;
	}

}


?>