<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/dbops.php');

//start using persistable classes? http://www.onlamp.com/pub/a/php/2005/06/16/overloading.html
class GenericDBDS
{
	var $where_clause;
	var $order_by;
	var $limit_clause;
	var $select_clause;
	var $from_clause;
	var $select_fields = array();
	var $where_keys_vals = array(); //hash with keys as fields and values as values

	function __construct($table_name, $select_fields = array(), $where_keys_vals = array())
	{
		$this->from_clause = "from ".$table_name;
		$this->select_clause = "SELECT"; 
		if (!empty($where_keys_vals))
		{
			$this->where_keys_vals = $where_keys_vals;
		}
		if (empty($select_fields))
		{
			$this->set_table_fields();
		}
		else
		{
			$this->select_fields = $select_fields;
		}
	}
	
	function get_total_recs_count()
	{
		$select_count_clause = "SELECT COUNT(*)";
		if (stristr($this->select_clause,"DISTINCT"))
		{
			if (!isset($this->distinct_field)) die ("distinct field must be set! GenericDBDS get_total_recs_count.lkajsldfksj");
			$select_count_clause = "SELECT COUNT(DISTINCT ".$this->distinct_field.")"; //ASSUMES FIRST FIELD IS ID FIELD!!
		}
		$sql = join(" ",array($select_count_clause,
								$this->from_clause,
								$this->where_clause
									)
								); 
		$result = mysql_query($sql); // echo $sql;
		($cnt = mysql_result($result,0));// or die("ERROR:".mysql_error()); //DUH! Can't or a result that could be zero
		return $cnt;
	}
	
	function get_recs()
	{
		$dbh = dbops::getpdo();
		$field_list = join(",",$this->select_fields);
		$where_clause = $this->where_clause;
		if (empty($where_clause) and !empty($this->where_keys_vals))
		{
			$where_clause_ar = array();
			foreach ($this->where_keys_vals as $key => $val)
			{
				$where_clause_ar[] = $key."=:".$key;
			}
			$where_clause = " WHERE " . join(" AND ",$where_clause_ar);
		}
		$sql = join(" ", array($this->select_clause ,
									 $field_list,
									 $this->from_clause,
									 $where_clause,
									 $this->order_by,
									 $this->limit_clause)); 
		$stmt = $dbh->prepare($sql);
		foreach($this->where_keys_vals as $key => $val)
		{
			$stmt->bindParam(":".$key,$val);
		}
		$stmt->execute() or die("an error occurred: GenericDBDS,get_recs+846645410");
		return $stmt->fetchAll();
	}
	
	function get_xml_dataset($encap_element)
	{
		$field_list = join(",",$this->select_fields);
		$sql = join(" ",array($this->select_clause,
								$field_list,
								$this->from_clause,
								$this->where_clause,
								$this->order_by,
								$this->limit_clause)); 
		$result = mysql_query($sql);
		$doc = new DOMDocument("1.0","UTF-8");
		$encap_elem = $doc->createElement($encap_element);
		$encap_elem = $doc->appendChild($encap_elem);
		while ($row = mysql_fetch_assoc($result))
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
		}
		return $doc->saveXML();
	}

	function set_table_fields()
	{
		$this->select_fields = $this->get_table_fields();
	}
	
	function get_table_fields()
	{
		$sql = "show columns ".$this->from_clause; 
		$fields_ar = array();
		$result = mysql_query($sql);
		while ($ar = mysql_fetch_assoc($result))
		{
			array_push($fields_ar,$ar['Field']);
		}
		return $fields_ar;
	}
}


?>