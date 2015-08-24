<?php
//include_once (dirname(__FILE__) .'/../RecordsSystem/One_Row_Record.php');


class MyEDB_Matrix
{
	var $prop_ids;
	var $MM_hash;
	var $property_list;
	var $final_property_ids = array();

	function __construct($property_list)
	{
		$this->prop_ids = array_keys($property_list);// print_r($property_list); echo "herrro";
		$this->property_list = $property_list;
		$this->MM_hash = array();
		
	}
	
	//for each property from prop_ids, add matching property to complete_prop_matrix
	// from $one_row_rec,
	// and if none, add blank to $complete_prop_matrix for that property
	function add_one_row_record(One_Row_Record $one_row_record)
	{
		$add_rec = array();
		foreach ($this->prop_ids as $prop_id)
		{
			if (isset($one_row_record->prop_id_value_hash[$prop_id]))
			{
				$add_rec[$prop_id] = $one_row_record->prop_id_value_hash[$prop_id];
			}
			else
			{
				$add_rec[$prop_id] = null;
			}
		}
		$this->MM_hash[] = $add_rec;
		
	}
	
	/*delete columns that are empty: starting with first row, collect column numbers 
	that correspond to empty cells; on second row eliminate from set of column numbers any whose corresponding cells 
	aren't empty; do same for all subsequent rows; then for each row, foreach $empty_col_prop_ids,
	unset(row[$emptycolumnnumber]).	*/
	private function remove_empty_columns()
	{
		$empty_col_prop_ids = array();
		//find empty columns
		$cnt = 0;
		foreach ($this->MM_hash as $rec)
		{
			if ($cnt == 0) //first row, set up reference list of empty props
			{
				foreach($rec as $prop_id => $val)
				{
					if (is_null($val) || $val == "")
					{
						$empty_col_prop_ids[] = $prop_id;
					}
				}
			}
			else 
			{
				if(!(is_null($val) || $val == ""))//can't use empty() because val could be 0
				{
					if (in_array($prop_id,$empty_col_prop_ids))
					{
						$empty_col_prop_ids = array_diff($empty_col_prop_ids,array($prop_id)); //remove propid from set of empty propids
					}
				}
			}
			$cnt++;
		}
		
		//delete empty columns
		foreach($this->MM_hash as &$rec)
		{
			foreach ($empty_col_prop_ids as $prop_id)
			{
				unset($rec[$prop_id]);
			}
		}
		$this->final_property_ids = array_diff($this->prop_ids,$empty_col_prop_ids);
	}
	
	private function add_column_header()
	{
		$prop_header = array();
		foreach ($this->final_property_ids as $prop_id)
		{
			$prop_header[$prop_id] = $this->property_list[$prop_id];
		}
		array_unshift($this->MM_hash,$prop_header);
	}
	
	public function finalize_matrix()
	{
		$this->remove_empty_columns();
		$this->add_column_header();
	}
	
	function get_matrix()
	{
		return $this->MM_hash;
	}
}
?>