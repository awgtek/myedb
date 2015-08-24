<?php
//include_once (dirname(__FILE__) .'/../ClientServerDataOps/LookupTable.php');


class validation_spec
{
	var $validation_spec_id;
	var $v_regex;
	var $lookup_table_hash;
	
	function validation_spec($v_spec_id)
	{
		//echo microtime()."in validation spec<br>";
		$this->validation_spec_id = $v_spec_id;
		$sql = "select * from validation_spec where validation_spec_id = '{$this->validation_spec_id}'"; 
		$val_ar = mysql_fetch_array(mysql_query($sql));
		if ($val_ar['lookup_table'])
		{
		//echo microtime()."in validation spec before getting lookup table<br>";
			//include_once($val_ar['lookup_table'] . ".php");
		//	$lookuptable = new LookupTable($val_ar['lookup_table']); 
		//	$this->lookup_table_hash = $lookuptable->get_table(); //this is slow
		//echo microtime()."in validation spec after getting lookuptable<br>";
			
			/*//add "not empty" regex to lookup
			$sql = "select v_regex from validation_spec where validation_spec_id = 5";
			$result = mysql_query($sql);
			$regex = mysql_result($result,0);
			$this->v_regex = $regex;
			*/
			if (!empty($val_ar['v_regex']))
			{
				$this->v_regex = $val_ar['v_regex'];
			}
		}
		else
		{
			$this->v_regex = $val_ar['v_regex'];
		}
		
	}
}

?>