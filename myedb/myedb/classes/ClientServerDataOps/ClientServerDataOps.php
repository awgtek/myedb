<?php
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/SubLookupTableEditOps.php');
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/LookupTableEditOps.php');
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/LookupTable.php');
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/ClientServerDataOps_EntityManagementSystems.php');

class ClientServerDataOps
{



	function get_id_for_LookupTable_record_contains($prop_id, $contains_string)
	{
		$retval = -1;
		LookupTable::get_table_by_prop_id($prop_id, $table_name);
		if ($table_name)
		{
			$lookupTable = new LookupTable($table_name);
			$retval = $lookupTable->get_id_for_record_contains($contains_string);
		}
		return $retval;
	}
	
	function get_value_by_id($id, $prop_id)
	{
		return LookupTable::get_value_by_id($id, $prop_id);
	}
	
	function has_lookup_table($prop_id)
	{
		LookupTable::get_table_by_prop_id($prop_id, $table_name);
		if ($table_name)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	function initialize_sub_lookup_table(&$xml_string)
	{
		$leto = new SubLookupTableEditOps();
		$leto->set_lookuptable_xml(isset($_REQUEST['pgn']));
		$xml_string = $leto->lookuptable_xml;
	}
	
	function initialize_sub_lookup_table_json(&$xml_string)
	{
		$cat_id = $_REQUEST['cat_id'];
				$sql = sprintf("Call get_active_subcategories(%s)",$cat_id);
		$result = mysqli_query($_SESSION['mysqli_link'], $sql, MYSQLI_USE_RESULT );// echo "hellooo".$sql;
		if (!$result)
			 echo "<div style='z-index:1579300'>ERROR! (ClientServerDataOps:2k32l)".mysqli_error($_SESSION['mysqli_link'])."</div>";
		$table_hash = array(); //print_r($res); 
		while ($ar =  mysqli_fetch_array($result, MYSQLI_BOTH)) 
		{//echo $sql."-".$lookup_tbl_id_col." ".$lookup_not_set;
			//print_r($ar);
			$table_hash[$ar[0]] = array($ar[1],"lookup_table_id"=>$ar[$this->lookup_tbl_id_col],"disabled"=>$ar['disabled']); 
		}
		mysqli_free_result($result);
		
		$xml_string = json_encode($table_hash);
		 
	}
	
	function initialize_sub_lookup_table_jsonOld(&$xml_string)
	{
		$lookuptable = new SubLookupTable($_REQUEST["table_name"]);
		$table_hash = $lookuptable->get_table($paged);//true=paged
		//eliminate subcategories that don't have records assigned
		foreach (array_keys($table_hash) as $array_key)
		{
			if (ClientServerDataOps_EntityManagementSystems::get_count_of_val_by_prop(50,0,$array_key,"Int")==0)
			{
				unset($table_hash[$array_key]);
			}
		}


		$xml_string = json_encode($table_hash);
	}
	
	function initialize_lookup_table(&$xml_string)
	{
		$leto = new LookupTableEditOps();
		$leto->set_lookuptable_xml();
		$xml_string = $leto->lookuptable_xml;
	}
	
	function update_lookuptable()
	{
		$leto = new LookupTableEditOps();
		$leto->process_update_post();
	}

	function insert_lookuptable()
	{
		$leto = new LookupTableEditOps();
		$leto->process_insert_post();
	}
	
	function insert_sublookuptable()
	{
		$leto = new SubLookupTableEditOps();
		$leto->process_insert_post();
	}
	
	function get_LookupTableObj()
	{
		return new LookupTable();
	}
	
	function get_table_DS($table_name)
	{
		$lookup_table = new LookupTable($table_name);
		return $lookup_table->get_table();
	}
}



?>