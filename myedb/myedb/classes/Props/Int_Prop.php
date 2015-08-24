<?
//include_once ("Prim_Prop.php");
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/ClientServerDataOps.php');

class Int_Prop extends Prim_Prop
{
	function Int_Prop($ent_prop_id, $prop_id)
	{
		parent::Prim_Prop($ent_prop_id, $prop_id);
	}

	function get_value_with_referenced()
	{
		$final_value = null;
		$this_type = get_class($this);
	$sql = "select ".str_replace("_prop","_val",strtolower($this_type))." from ".
strtolower($this_type)." where prop_id = ".$this->my_prop_id." and ent_prop_id = ".$this->my_ent_prop_id;
		$result = mysql_query($sql);
		if (mysql_num_rows($result)==0)
			return "";
		$value = mysql_result($result,0);
		
		if (ClientServerDataOps::has_lookup_table($this->my_prop_id) && !empty($value))
		{
			$final_value = ClientServerDataOps::get_value_by_id($value,$this->my_prop_id);
		}
		else
		{
			$final_value = $value;
		}
		
		return $final_value;
	}
	
	
}
?>