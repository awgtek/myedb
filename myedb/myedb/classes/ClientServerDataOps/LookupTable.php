<?php
//include_once(dirname(__FILE__) .'/../../functions/commonfunc.php');

//Note all DB lookup tables must have field 0 as id, field 1 as value
class LookupTable
{
	var $tbl_name;
	var $prim_key_col;
	var $lookup_value_col;
	var $has_disabled_column;
	var $lookup_ids; //array
	
	function LookupTable($_tbl_name="")
	{
		vtorc($_tbl_name); //verify it's valid table name (commonfunc.php)
		if (!empty($_tbl_name))
		{
			$this->tbl_name = $_tbl_name;
			$this->set_key_val_cols();
		}
	}
	
	function set_table_name($_tbl_name)
	{
		vtorc($_tbl_name); //verify it's valid table name (commonfunc.php)
		if (!empty($_tbl_name))
		{
			$this->tbl_name = $_tbl_name;
		}
		else
		{
			die("table cannot be empty: msg:2lk3mn;alksd78");
		}
	}
	
	private function set_key_val_cols()
	{
		$sql = "SHOW COLUMNS FROM ".$this->tbl_name;
		$result = mysql_query($sql);
		$cnt = 0; //first column is primary key and second is lookup value
		while ($row = mysql_fetch_array($result))
		{	
			if ($cnt == 0)
			{
				$this->prim_key_col = $row['Field'];
			}
			else if ($cnt == 1)
			{
				$this->lookup_value_col = $row['Field'];
			}
			if ($row['Field'] == "disabled")
			{
				$this->has_disabled_column = true;
			}
			$cnt++;
		}
	}
	
	function get_value_by_id($id, $prop_id)
	{
		LookupTable::get_table_by_prop_id($prop_id, $table_name);
		if (!$table_name) die ("error: LookupTable 232kdklwk33k3k4");
		$lookuptable = new LookupTable($table_name);
		$sql = "SELECT ".$lookuptable->lookup_value_col." FROM ".$lookuptable->tbl_name." WHERE ".$lookuptable->prim_key_col." = '".$id."'"; 
		$result = mysql_query($sql);
		if (!mysql_num_rows($result)) die ("Error: LookupTable $table_name - no value for id: $id ");
		return mysql_result($result,0,$this->lookup_value_col);
	}
	
	function get_id_for_record_contains($contains_string)
	{
		$retval = 0;
		$sql = "SELECT ".$this->prim_key_col." FROM ".$this->tbl_name." WHERE ".$this->lookup_value_col." LIKE '%".$contains_string."%'";
		$result = mysql_query($sql);
		$rowcnt = mysql_num_rows($result);
		if ($rowcnt > 0)
		{
			$retval = mysql_result($result,0,$this->prim_key_col);
		}
		return $retval;
	}
	
	function insert()
	{
		
	}
	
	function update()
	{
	
	}
	
	function get_tableOld()
	{
		if (empty($this->lookup_value_col))
		{
			$this->set_key_val_cols();
		}
	/*	if ($this->has_disabled_column)
		{
			$wherenotdisabled = " where disabled <> 1";
		}*/
		$sql = sprintf("select * from %s %s order by %s",$this->tbl_name,$wherenotdisabled,$this->lookup_value_col); 
		$result = mysql_query($sql); 
		$table_hash = array();
		while ($ar = mysql_fetch_array($result))
		{
			//LookupTable tables always have id as first field and and name as second field
			$table_hash[$ar[0]] = array($ar[1],"disabled"=>$ar['disabled']); 
		} //echo $this->lookup_value_col." - ".count($table_hash)."<br>";
		return $table_hash;

	}

	function get_table()
	{
		if (empty($this->lookup_value_col))
		{
			$this->set_key_val_cols();
		}
	/*	if ($this->has_disabled_column)
		{
			$wherenotdisabled = " where disabled <> 1";
		}*/
	//	$sql = sprintf("select * from %s %s order by %s",$this->tbl_name,$wherenotdisabled,$this->lookup_value_col); 
	//	$result = mysql_query($sql); 
		$table_hash = array();
	//	while ($ar = mysql_fetch_array($result))
	//	{
			//LookupTable tables always have id as first field and and name as second field
	//		$table_hash[$ar[0]] = array($ar[1],"disabled"=>$ar['disabled']); 
	//	} //echo $this->lookup_value_col." - ".count($table_hash)."<br>";

		$db = $_SESSION['mysqli_obj'];
		if (empty($this->lookup_ids))
		{
			$sql = sprintf("select * from %s order by %s",$this->tbl_name,
				$this->lookup_value_col); 
		    $stmt = $db->prepare($sql); 
		}
		else
		{
			$values = $this->lookup_ids;
			$sql = sprintf("SELECT * FROM %s WHERE {$this->prim_key_col} IN (%s) order by %s", 
					$this->tbl_name,
        		implode(', ', array_fill(0, count($values), '?')) ,
        		$this->lookup_value_col
   			 ); 
   			// echo $sql;
		    $stmt = $db->prepare($sql); 
		    array_unshift($values, implode('', array_fill(0, count($values), 'i'))); 
		    @call_user_func_array(array($stmt, 'bind_param'), $values); //need @ cuz bind_param gives warnings if $values are references
		}
		
	    $stmt->execute(); 
	
		$row = array();
		stmt_bind_assoc($stmt, $row); //commonfunc.php
		
		// loop through all result rows
		while ($stmt->fetch()) {
			$table_hash[$row[$this->prim_key_col]] = array($row[$this->lookup_value_col],"disabled"=>$row['disabled']); 
			//print_r($row);
		}
	    
	
	    /* close statement */ 
	    $stmt->close(); 
		
		
		return $table_hash;

	}

	function get_table_and_field_by_prop_id($prop_id, &$table_name, &$field_name)
	{
			$sql = "select validation_spec.lookup_table from property inner join validation_spec on property.validation_spec_id = 
		validation_spec.validation_spec_id where property.prop_id = ".$prop_id;
			
		  $lookuptableres = mysql_query($sql);
		  $ar = mysql_fetch_array($lookuptableres);
		  $lookuptable = $ar['lookup_table'];
		  
		  $sql = "SHOW COLUMNS FROM ".$lookuptable;
		  $columnsres = mysql_query($sql); 
		  for ($i = 0; $i < 2; $i++)
		  {
			$ar = mysql_fetch_array($columnsres);
		  }
		  $lookupfield = $ar['Field'];
		  
		  $table_name = $lookuptable;
		  $field_name = $lookupfield;
		
	}	

	function get_table_by_prop_id($prop_id, &$table_name) //, &$field_name, &$table_name_id)
	{
			$sql = "select validation_spec.lookup_table from property inner join validation_spec on property.validation_spec_id = 
		validation_spec.validation_spec_id where property.prop_id = ".$prop_id." and
		character_length(trim(validation_spec.lookup_table)) > 0"; //echo $sql;
			
		  $lookuptableres = mysql_query($sql);
		  if (!mysql_num_rows($lookuptableres))
		  {
		  	return;
		  }
		  $ar = mysql_fetch_array($lookuptableres);
		  $table_name = $ar['lookup_table'];
		  
	/*	  $sql = "SHOW COLUMNS FROM ".$lookuptable;
		  $columnsres = mysql_query($sql); 
		  $ar = mysql_fetch_array($columnsres);
		  $table_name_id = $ar['Field'];
		  $ar = mysql_fetch_array($columnsres);
		  $field_name = $ar['Field'];
		*/  		
	}	

	function append_xml_values(DOMElement &$lookup_table_elem, DOMDocument &$doc)
	{
		$lookup_table_hash = $this->get_table();
		foreach($lookup_table_hash as $lookup_table_id => $lookup_table_rec_ar)
		{
			$lookup_table_field_name = $lookup_table_rec_ar[0];
			$lookup_table_item_is_disabled = $lookup_table_rec_ar['disabled']; 
			$lookup_table_rec = $doc->createElement($this->tbl_name,$lookup_table_field_name);
			$lookup_table_elem->appendChild($lookup_table_rec);
			$lookup_table_rec->setAttribute($this->tbl_name."_id",$lookup_table_id);
			$lookup_table_rec->setAttribute("is_disabled",$lookup_table_item_is_disabled);
		}
		
	}
}

?>