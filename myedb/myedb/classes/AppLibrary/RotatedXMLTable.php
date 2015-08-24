<?php
//include_once (dirname(__FILE__) .'/GenericDBDS.php');


class RotatedXMLTable extends GenericDBDS
{
	var $current_index;
	var $item_count;
	var $next_used_iter;
	var $tot_num_rows;
	var $iter_counter;
	var $xmldoc;
    /* class constructor */ 
    function __construct($item_count, $table_name, $select_fields = array(), $where_keys_vals = array())
    { 
        parent::__construct($table_name, $select_fields = array(), $where_keys_vals = array()); // calling the super class constructor
        $this->item_count = $item_count; 
        $this->iter_counter = 0;
    } 
	
	function get_xml_dataset($encap_element="", &$domdoc="")
	{
		$field_list = join(",",$this->select_fields);
		$sql = join(" ",array($this->select_clause,
								$field_list,
								$this->from_clause,
								$this->where_clause,
								$this->order_by,
								$this->limit_clause)); 
		$result = mysql_query($sql); //echo $sql;
		$this->tot_num_rows = mysql_num_rows($result);
		
		if (empty($domdoc))
		{
			$doc = new DOMDocument("1.0","UTF-8");
			$this->xmldoc = $doc;
			$encap_elem = $doc->createElement($encap_element);
			$encap_elem = $doc->appendChild($encap_elem);
		}
		else
		{ 
			$encap_elem = $domdoc->firstChild;
			$doc = $domdoc; 
		}
		$res_pntr = 0;
		while ($row = mysql_fetch_assoc($result))
		{ 
			$res_pntr++;
			if ($this->use_current_iter($res_pntr))
			{
				$record_elem = $doc->createElement($encap_element."_record");
				$record_elem = $encap_elem->appendChild($record_elem);
				foreach($this->select_fields as $select_field)
				{
					$field_elem = $doc->createElement($encap_element."_field");
					$field_elem = $record_elem->appendChild($field_elem);
					$field_elem->setAttribute("field_name",$select_field);
					$text_node = $doc->createTextNode($row[$select_field]);
					$field_elem->appendChild($text_node);
				}
				if ($res_pntr == $this->tot_num_rows) //loop back around result set
				{
					$res_pntr = 0;
					mysql_data_seek($result,0);
				}
			}
		}
		mysql_free_result($result);
		
		//echo "<xmp>". $doc->saveXML()."</xmp>";
	}
	
	function use_current_iter($cntr)
	{
		if (empty($this->next_used_iter)) //starting/setup work
		{
			$this->next_used_iter = $this->get_current_index(); //$this->get_next_index();
			
		}
		if ($cntr == $this->next_used_iter)
		{
			$this->iter_counter++;
			if ($this->iter_counter <= $this->item_count)
			{
				$this->next_used_iter = $this->get_next_index();
				return true;
			}
			return false;
		}
		else
		{
			return false;
		}
		
	}

	function get_next_index()
	{
		$tot_num_rows = $this->tot_num_rows;
		$next_index = $_SESSION[$this->sess_key()] + 1;
		if ($next_index > $tot_num_rows)
		{
			$next_index = 1;
		}
		$_SESSION[$this->sess_key()] = $next_index;
		return $next_index;
	}
	
	function get_current_index()
	{
		if (!isset($_SESSION[$this->sess_key()]))
		{
			$_SESSION[$this->sess_key()] = 1;
		}
		return $_SESSION[$this->sess_key()];
	}
	
	function sess_key()
	{
		return md5($this->from_clause.$this->where_clause);
	}
}

?>