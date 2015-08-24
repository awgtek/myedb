<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/MixedQueries.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/EntityMgmt_Facade.php');

class OutputSys_EntityManagementSystems
{
	static function get_type_list()
	{
		return MixedQueries::get_type_list();
	}

	static function get_category_list()
	{
		return MixedQueries::get_category_list();
	}

	static function get_category_type_mapping()
	{
		return MixedQueries::get_type_to_prop_val_mapping(6);
	}
	
	static function get_property_list()
	{
		return EntityMgmt_Facade::get_property_list();
	}

}


?>