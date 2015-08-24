<?
//include_once ("Gen_Prop.php");
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/ApplicationEntities/AppEntities_Facade.php');

class Prim_Prop extends Gen_Prop
{
	function Prim_Prop($ent_prop_id, $prop_id)
	{
		verify_integers(array($ent_prop_id,$prop_id));		
		
		parent::Gen_Prop($ent_prop_id, $prop_id);
	}
	
	function get_val()
	{
		$this_type = get_class($this);
	$sql = "select ".str_replace("_prop","_val",strtolower($this_type))." from ".
strtolower($this_type)." where prop_id = ".$this->my_prop_id." and ent_prop_id = ".$this->my_ent_prop_id;
		$result = mysql_query($sql);
		if (mysql_num_rows($result)==0)
			return "";
		return mysql_result($result,0);
	}
	
	function create_new($newval,$prop_id, $ent_prop_id)
	{
		$this_prop = get_class($this);
		$this_prop = strtolower($this_prop);
		sanitize($newval);
		
		$sql = "insert into $this_prop set ".str_replace("_prop","_val",$this_prop)."='".$newval."', prop_id = $prop_id, ent_prop_id = $ent_prop_id";
		mysql_query($sql) or die("Error:aksjdvvp1".mysql_error());

	}
	
	function get_count_of_val_by_prop($val, $cmp=0)
	{
		$cmpstr = "=";
		if ($cmp)
		{
			$cmpstr = $cmp;
		}
		$this_type = get_class($this);
		$val_field = str_replace("_prop","_val",strtolower($this_type));

		$loc_my_prop_id = $this->my_prop_id;
	    sanitize(array($val_field,
	    				$cmpstr,$val) );
	    verify_integers(array($loc_my_prop_id));		
		
		$sql = "select count(".$val_field.") from ".
strtolower($this_type)." where prop_id = ".$loc_my_prop_id." and ".$val_field." $cmpstr '$val'";
		$result = mysql_query($sql);
		if (mysql_num_rows($result)==0)
			return "";
		return mysql_result($result,0);
	}

	function update($theval,$prop_id, $ent_prop_id)
	{ //echo "yoo". get_magic_quotes_gpc()."--".$theval."<br>";
		$this_prop = get_class($this);
		$prim_prop = str_replace("_prop","",strtolower($this_prop));
		$logged_in_user = AppEntities_Facade::get_user_instance();
		$logged_in_user_id = $logged_in_user->user_id;
		$logged_in_user_full_name = $logged_in_user->full_name;
		//$this_prop = strtolower($this_prop);
		
		//$sql = "UPDATE $this_prop set ".str_replace("_prop","_val",$this_prop)."='".$theval."' WHERE prop_id = $prop_id AND ent_prop_id = $ent_prop_id";
		//mysql_query($sql) or die("Error:aksjdvvp2".mysql_error());
		//echo  "UPDATE $this_prop set ".str_replace("_prop","_val",$this_prop)."='".$theval."' WHERE prop_id = $prop_id AND ent_prop_id = $ent_prop_id - primp_prop: ".$prim_prop."<br>";
		
	    sanitize_trim_mysqli_escape($_SESSION['mysqli_link'],array($theval,
	    				$logged_in_user_id,$logged_in_user_full_name) );
	    verify_integers(array($ent_prop_id,$prop_id));		
	    
		$sql = sprintf("Call update_prim_prop(%s,%s,%s,%s,%s,%s)","'".$theval."'", $prop_id, 
			$ent_prop_id, "'".$logged_in_user_id."'", 
				"'".$logged_in_user_full_name."'", "'".$prim_prop."'"); //echo $sql;
		if (!mysqli_multi_query($_SESSION['mysqli_link'], $sql )) echo "<div style='z-index:1500'>ERROR! (Prim_Prop:sadsa23d*arek)".mysqli_error($_SESSION['mysqli_link'])."</div>";
		
	}
	
	
}

?>