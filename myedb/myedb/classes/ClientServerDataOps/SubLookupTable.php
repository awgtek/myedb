<?php
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/LookupTable.php');
//include_once(dirname(__FILE__) .'/../../functions/commonfunc.php');
//include_once(dirname(__FILE__) .'/../MainClient/AppConfig.php');
//include_once (dirname(__FILE__) .'/../AppLibrary/MyEDB_Pager.php');

//Note all DB lookup tables must have field 0 as id, field 1 as value
class SubLookupTable extends LookupTable
{
	var $tbl_name;
	var $prim_key_col;
	var $lookup_value_col;
	var $lookup_tbl_id_col;
	
	function SubLookupTable($_tbl_name="")
	{
		vtorc($_tbl_name); //verify it's valid table name (commonfunc.php)
		if (!empty($_tbl_name))
		{
			$this->tbl_name = $_tbl_name;
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
				else if ($cnt == 2)
				{
					$this->lookup_tbl_id_col = $row['Field'];
				}
				$cnt++;
			}
		}
	}
	
	function insert()
	{
		
	}
	
	function update()
	{
	
	}
	
	function get_total_results()
	{
		$dbh = new PDO('mysql:dbname='.AppConfig::gacv("AC_db").';host='.AppConfig::gacv("AC_server")
				,AppConfig::gacv("AC_user"),AppConfig::gacv("AC_pass")); 
		$sql = sprintf("select count(*) from %s WHERE ".$this->lookup_tbl_id_col." = :lookup_tbl_id_col OR 1 = :lookup_not_set",$this->tbl_name); 
		$sth = $dbh->prepare($sql ,array(PDO::ATTR_CURSOR, PDO::CURSOR_FWDONLY));//
		//$sth->execute(array(':lookup_tbl_id_col' => ($_REQUEST[$this->lookup_tbl_id_col])? $_REQUEST[$this->lookup_tbl_id_col] : $this->lookup_tbl_id_col));
		$sth->bindParam(':lookup_tbl_id_col',$lookup_tbl_id_col);
		$sth->bindParam(':lookup_not_set',$lookup_not_set);
		$lookup_tbl_id_col = $_REQUEST[$this->lookup_tbl_id_col] ;
		$lookup_not_set = ($_REQUEST[$this->lookup_tbl_id_col])? 0 : 1;
		$sth->execute();
		$result = $sth->fetchColumn();
		return $result;
	}
	
	function get_table($paged = 0)
	{
		/* Execute a prepared statement by passing an array of values */
		$dbh = new PDO('mysql:dbname='.AppConfig::gacv("AC_db").';host='.AppConfig::gacv("AC_server")
				,AppConfig::gacv("AC_user"),AppConfig::gacv("AC_pass")); 
		
		$sql = sprintf("select * from %s WHERE ".$this->lookup_tbl_id_col.
			" = :lookup_tbl_id_col OR 1 = :lookup_not_set order by %s",$this->tbl_name,$this->lookup_value_col); 
		if ($paged)
		{
			$sql .= MyEDB_Pager::get_sql_limit_clause();
		} 
		$sth = $dbh->prepare($sql ,array(PDO::ATTR_CURSOR, PDO::CURSOR_FWDONLY));//
		//$sth->execute(array(':lookup_tbl_id_col' => ($_REQUEST[$this->lookup_tbl_id_col])? $_REQUEST[$this->lookup_tbl_id_col] : $this->lookup_tbl_id_col));
		$sth->bindParam(':lookup_tbl_id_col',$lookup_tbl_id_col);
		$sth->bindParam(':lookup_not_set',$lookup_not_set);
		$lookup_tbl_id_col = $_REQUEST[$this->lookup_tbl_id_col] ;
		$lookup_not_set = ($_REQUEST[$this->lookup_tbl_id_col])? 0 : 1;
		$sth->execute();
		$res = $sth->fetchAll(PDO::FETCH_BOTH);//echo $sql.$this->lookup_tbl_id_col;//
		$table_hash = array(); //print_r($res); 
    	foreach ($res as $ar)
    //	foreach ($dbh->query("select * from subcategory") as $ar)
		{//echo $sql."-".$lookup_tbl_id_col." ".$lookup_not_set;
			$table_hash[$ar[0]] = array($ar[1],"lookup_table_id"=>$ar[$this->lookup_tbl_id_col],"disabled"=>$ar['disabled']); 
		}
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
}

?>