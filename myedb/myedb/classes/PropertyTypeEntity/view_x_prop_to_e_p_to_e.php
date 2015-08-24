<?php
//include_once (dirname(__FILE__) .'/../ClientServerDataOps/ClientServerDataOps.php');
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/EntityMgmt_ClientServerDataOps.php');

abstract class view_x_prop_to_e_p_to_e
{

	function get_eids($search_val, $prop_id, $type_id)
	{
		
	}
	
	//set type_id null if want all types
	function get_all_eids_by_type_category($type_category, $type_id)
	{
/*		$sql = "select distinct eid from view_varchar_prop_to_e_p_to_e natural join type where  type_category = 'product'  ";
		$eids = array();
		$result = mysql_query($sql);
		while ($row = mysql_fetch_array($result))
		{
			$eids[] = $row['eid'];
		}
		return $eids;
*/

		$dbh = new PDO('mysql:dbname='.AppConfig::gacv("AC_db").';host='.AppConfig::gacv("AC_server")
				,AppConfig::gacv("AC_user"),AppConfig::gacv("AC_pass")); 
		$dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

				
		$all_types = 0;		
		if ($type_id > 0) //less than zero means search all categories
		{
			$sql_type_id = $type_id ; //echo "I'm here";
		} 
		else
		{
			$sql_type_id = "";
			$all_types = 1;
		} 
				$thisclass = get_class($this);
		$sql = sprintf("select distinct eid from $thisclass natural join type WHERE type_category = :the_type_category 
				and (type_id = :sql_type_id or 1 = :all_types)"); //echo $sql;
		$sth = $dbh->prepare($sql ,array(PDO::ATTR_CURSOR, PDO::CURSOR_FWDONLY));//
		//$sth->execute(array(':lookup_tbl_id_col' => ($_REQUEST[$this->lookup_tbl_id_col])? $_REQUEST[$this->lookup_tbl_id_col] : $this->lookup_tbl_id_col));
		$sth->bindParam(':the_type_category',$type_category);
		$sth->bindParam(':sql_type_id',$sql_type_id);
		$sth->bindParam(':all_types',$all_types,PDO::PARAM_INT );
		$sth->execute();
		$res = $sth->fetchAll(PDO::FETCH_BOTH);//echo $sql.$this->lookup_tbl_id_col;//
		$eids = array();// print_r($res); 
    	foreach ($res as $ar)
 		{ 
			$eids[] = $ar['eid'];
		}
		return $eids;
		
	}
	
	function get_eids_by_prop_contains_search($search_val, $prop_id, $type_id)
	{
		$prop_is_lookup_table = false;
		$search_int_val = EntityMgmt_ClientServerDataOps::get_id_for_LookupTable_record_contains($prop_id, $search_val);
		if ($search_int_val != 0) //if zero, means no lookup value matched, if >0, lookupvalue matched, if <0, not a property based on lookup table
		{
			if ($search_int_val > 0)
			{
				$search_val = $search_int_val;
				$prop_is_lookup_table = true;
			}
		}
				
		$thisclass = get_class($this);
		ereg("^view_([a-z]*)_",$thisclass,$regs) or die ("ERROR: view_x_prop_to_e_p_to_e:3887777DK");
		$propname = $regs[1];
		$sql = "select eid, type_category from $thisclass natural join type where ".$propname."_val ".
			(($prop_is_lookup_table)? " = '$search_val' " : " like '%".$search_val."%' ") 
			. " and prop_id = $prop_id ";
		if ($type_id > 0) //less than zero means search all categories
		{
			$sql .= " and type_id = $type_id ";
		} 
		else
		{
			$sql .= " and type_category = 'product' ";
		} 
		$eids = array();//echo $sql;
		$result = mysql_query($sql);
		while ($row = mysql_fetch_array($result))
		{
			$eids[] = $row['eid'];
		}
		return $eids;
	}

	function get_vals($eid, $prop_id, $type_id)
	{
		$eid = sanitize($eid);
		$prop_id = sanitize($prop_id);
		$type_id = sanitize($type_id);
		
		$vals = array();
		$thisclass = get_class($this);
		preg_match("/^view_([a-z]*)_/",$thisclass,$regs) or die ("ERROR: view_x_prop_to_e_p_to_e:2EFKADK");
		$propname = $regs[1];
		$sql = sprintf("SELECT %s_val FROM %s WHERE eid = '%s' AND prop_id = '%s' AND  type_id = '%s'",$propname,$thisclass,$eid,$prop_id,$type_id);
		$result = mysql_query($sql); 
		while ($row = mysql_fetch_array($result))
		{
			$vals[] = $row[0];
		}
		return $vals;
	}
	
	function get_eids_values_hash($eids, $prop_id, $type_id, $desc=0)
	{
		//$nomatch_eids = $eids; //any for which entity doesn't have set property, on which this function sorts
		$eidvalhash = array(); 
		$thisclass = get_class($this);
		preg_match("/^view_([a-z]*)_/",$thisclass,$regs) or die ("ERROR: view_x_prop_to_e_p_to_e:2EeidsfhashFKADK");
		$propname = $regs[1];
		$eids_sql_set = implode(",",$eids);
		$desc = ($desc)? "desc" : "";
		$type_id_clause = "";
		if ($type_id > 0)
		{
			$type_id_clause = sprintf("AND  type_id = '%s' ",$type_id);
		}
		$sql = sprintf("SELECT eid, %s_val FROM %s WHERE eid in (%s) AND prop_id = '%s' %s  ORDER BY  %s_val ".$desc,$propname,$thisclass,$eids_sql_set,$prop_id,$type_id_clause,$propname);// echo $sql;
		$result = mysql_query($sql); 
		while ($row = mysql_fetch_array($result))
		{
			$eidvalhash[$row[0]] = $row[1];
		}
		return $eidvalhash;
	
	}
	
	//used to determine which types have been assigned which categories in the records
	function get_type_to_prop_val_mapping($prop_id)
	{
		$retar = array();
		$thisclass = get_class($this);
		preg_match("/^view_([a-z]*)_/",$thisclass,$regs) or die ("ERROR: view_x_prop_to_e_p_to_e:2E5658FKADK");
		$propname = $regs[1];
		$sql = sprintf("select distinct %s_val, type_id from %s where prop_id = %s",$propname,$thisclass,$prop_id);
		$result = mysql_query($sql);
		while ($row = mysql_fetch_array($result))
		{
			if (!is_array($retar[$row[$propname.'_val']]))
			{
				$retar[$row[$propname.'_val']] = array();
			}
			array_push($retar[$row[$propname.'_val']],$row['type_id']);
		}
		return $retar;
	}
}

?>