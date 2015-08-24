<?
abstract class Gen_Prop
{
	var $my_prop_id;
	var $my_ent_prop_id;
	
	function Gen_Prop($ent_prop_id, $prop_id)
	{
		$this->my_ent_prop_id = $ent_prop_id;
		$this->my_prop_id = $prop_id;
	}


}

?>