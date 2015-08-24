<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Property.php');
//include_once (dirname(__FILE__) .'/../ClientServerDataOps/category.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/medb_transaction.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/prop_qualifier.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/repeat_prop_qualifier.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Entity.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Glue.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/Type.php');


class MixedQueries
{
	function get_rpqs($eid)
	{
		return repeat_prop_qualifier::get_rpqs($eid);
	}
	
	//data_type specified to return all eids which have at least one set property matching this data type. e.g. every product should have a name (varchar), hence a search for varchar and product should return all product eids
	function get_all_eids_by_type_category_and_datatype($data_type, $type_category, $type_id)
	{
		$vptepte_class_name = "view_" . $data_type . "_prop"."_to_e_p_to_e";
//		include_once (dirname(__FILE__) ."/../PropertyTypeEntity/{$vptepte_class_name}.php");
		$theclass = new $vptepte_class_name();
		$eids = $theclass->get_all_eids_by_type_category($type_category, $type_id);
		return $eids;
		
	}

	function get_prop_qualifiers($eid, $type_id)
	{
	
		//$type_id = Entity::get_type_id($eid);
		$glu = new Glue();
		$glu->set_type_frame($type_id);
		$prop_group_ids = array();
		$prop_ids = array();
		foreach($glu->prop_id_prop_obj_hash as $prop_obj)
		{
			if ($prop_obj->prop_group_id)
			{
				$prop_group_ids[] = $prop_obj->prop_group_id;
			}
			$prop_ids[] = $prop_obj->prop_id;
		}		
		return prop_qualifier::get_prop_qualifiers($prop_group_ids, $prop_ids);
	}

	function get_eids_by_prop_contains_search($search_val, $prop_id, $type_id)
	{
		$prop_name = Property::static_get_table_name($prop_id);
		$vptepte_class_name = "view_" . $prop_name . "_to_e_p_to_e";
//		include_once (dirname(__FILE__) ."/../PropertyTypeEntity/{$vptepte_class_name}.php");
		$theclass = new $vptepte_class_name();
		$eids = $theclass->get_eids_by_prop_contains_search($search_val, $prop_id, $type_id);
		return $eids;

	}

	function get_type_to_prop_val_mapping($prop_id)
	{
		$prop_name = Property::static_get_table_name($prop_id);
		$vptepte_class_name = "view_" . $prop_name . "_to_e_p_to_e";
//		include_once (dirname(__FILE__) .'/../PropertyTypeEntity/'.$vptepte_class_name.'.php');
		$theclass = new $vptepte_class_name();
		$prop_type_matrix = $theclass->get_type_to_prop_val_mapping($prop_id);
		return $prop_type_matrix;

	}

	static function get_eids($search_term, $prop_id, $type_id, $search_compare_op=0)
	{ 
		$prop_name = Property::static_get_table_name($prop_id);
		$vptepte_class_name = "view_" . $prop_name . "_to_e_p_to_e"; 
	//	include_once (dirname(__FILE__) .'/../PropertyTypeEntity/'.$vptepte_class_name.'.php');
		$theclass = new $vptepte_class_name();
		
		$reflObject = new ReflectionObject($theclass);
		$reflMethod = $reflObject->getMethod("get_eids");
		$reflParameters = $reflMethod->getParameters();
		
		$args = array();
		foreach ($reflParameters as $param) {
		  //$paramName = $param->getName();
		  //$args[$param->getPosition()] = $paramName;
		  $args[$param->getPosition()] = func_get_arg($param->getPosition()); //this way view_int_prop... will be passed the fourth argument. 
		  //Note: assumes get_eids signature matches order between here and the vptepte's
		}
		
		$eids = array();
		if (!$type_id)
		{
			$type_hash = MixedQueries::get_type_list();
			foreach ($type_hash as $_type_id => $type_name)
			{
				//$eids = array_merge($eids, $theclass->get_eids($search_term, $prop_id, $_type_id));
				$args[2] = $_type_id;
				$eids = array_merge($eids, $reflMethod->invokeArgs($theclass, $args));
			}
		}
		else
		{
			//$eids = $theclass->get_eids($search_term, $prop_id, $type_id);
			$eids = $reflMethod->invokeArgs($theclass, $args);
		}

		return $eids;
	}

	static function get_vals($eid, $prop_id, $type_id)
	{
		$prop_name = Property::static_get_table_name($prop_id);
		$vptepte_class_name = "view_" . $prop_name . "_to_e_p_to_e";
//		include_once (dirname(__FILE__) .'/../PropertyTypeEntity/'.$vptepte_class_name.'.php');
		$theclass = new $vptepte_class_name();
		$vals = $theclass->get_vals($eid, $prop_id, $type_id);
		return $vals;
	}
	
	static function get_eids_values_hash($eids, $prop_id, $type_id, $desc=0)
	{
		$prop_name = Property::static_get_table_name($prop_id);
		$vptepte_class_name = "view_" . $prop_name . "_to_e_p_to_e";
//		include_once (dirname(__FILE__) ."/../PropertyTypeEntity/{$vptepte_class_name}.php");
		$theclass = new $vptepte_class_name();
		return $theclass->get_eids_values_hash($eids, $prop_id, $type_id, $desc);
	}

	static function get_category_list()
	{
		return category::get_list();
	}
	
	static function get_type_list()
	{
		return Type::get_type_list();
	}
	
	static function get_unrealized_transactions_by_eidsrc($eidsrc)
	{
		return medb_transaction::get_unrealized_transactions_by_eidsrc($eidsrc);
	}
}

?>