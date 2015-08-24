<?
//include_once(dirname(__FILE__) .'/../Props/Int_Prop.php');

class ClientServerDataOps_EntityManagementSystems
{
	
	//prim_type e.g. "Int" note upper case
	static function get_count_of_val_by_prop($prop_id,$cmp,$val, $prim_type)
	{
		$prim_type_class = $prim_type."_Prop";
		$prim_type_obj = new $prim_type_class(0,$prop_id);
		return $prim_type_obj->get_count_of_val_by_prop($val,$cmp);
		
	}

}


?>