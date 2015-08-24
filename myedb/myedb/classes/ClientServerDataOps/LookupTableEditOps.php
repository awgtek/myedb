<?php
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/LookupTable.php');
//include_once(dirname(__FILE__) .'/../../functions/commonfunc.php');

class LookupTableEditOps
{
	var $lookuptable_xml;
	
	function __construct()
	{
		if (isset($_REQUEST["table_name"]))
		{
			vtorc($_REQUEST["table_name"]);//validate input
		}
	}

	function set_lookuptable_xml()
	{
		$lookuptable = new LookupTable($_REQUEST["table_name"]);
		$table_hash = $lookuptable->get_table();
		$doc = new DOMDocument('1.0','UTF-8');
		$doc->formatOutput = true;
		$lookup_item_group = $doc->createElement('lookup_item_group');
		$lookup_item_group = $doc->appendChild($lookup_item_group);
		$lookup_item_group->setAttribute('lookup_table_name',$_REQUEST["table_name"]);
		foreach($table_hash as $cat_id => $catval_ar)
		{
			$lookup_item = $doc->createElement('lookup_item');
			$lookup_item = $lookup_item_group->appendChild($lookup_item);
			$lookup_item->setAttribute('prim_key_col',$cat_id);
			$lookup_item->setAttribute('lookup_value_col',$catval_ar[0]);
			$lookup_item->setAttribute('is_disabled',$catval_ar["disabled"]);
		}
		$this->lookuptable_xml = $doc->saveXML();
	}
	
	function process_insert_post()
	{
		$insert_value = $_POST['insert_value'];
		if (!get_magic_quotes_gpc()) {
			$insert_value = addslashes($insert_value);
		} 
		if (empty($insert_value))
		{
			echo "<script>alert('insert value cannot be empty!');</script>";
			return;
		}
	//	$insert_value = htmlspecialchars ( $insert_value, ENT_NOQUOTES , "UTF-8" ); 
		$lookuptable = new LookupTable($_REQUEST["table_name"]);
		$sql = sprintf("INSERT INTO %s SET %s = '%s'",$lookuptable->tbl_name,$lookuptable->lookup_value_col,$insert_value);
		mysql_query($sql) or die("could not insert [LookupTableEditOps::process_insert_post:lkensdkfdkE]");
	}
	
	function process_update_post()
	{
		$lookuptable = new LookupTable($_REQUEST["table_name"]);
		foreach ($_POST as $postkey => $postval)
		{
			if (ereg("^edit_([0-9]+)",$postkey, $regs))
			{
				if (empty($postval))
				{
					echo "<script>alert('edited value cannot be empty!');</script>";
					return;
				}
				//$postval = htmlspecialchars ( $postval, ENT_NOQUOTES , "UTF-8" ); //didn't have to do this if I just made sure to createTextNode rather than put value in second element of createElement in Record.php
				$sql = sprintf("UPDATE %s SET %s = '%s' WHERE %s = %s",$lookuptable->tbl_name
					,$lookuptable->lookup_value_col
					,$postval
					,$lookuptable->prim_key_col
					,$regs[1]);
				mysql_query($sql) or die("could not update [process_update_post:lkenkfdkE]");
			}
		}
		foreach ($_POST as $postkey => $postval)
		{
			if (ereg("^delete_([0-9]+)",$postkey, $regs))
			{
				$sql = sprintf("Call delete_lookup_table_item('%s','%s',%s)",$lookuptable->tbl_name,$lookuptable->prim_key_col,$regs[1]);
				if (!mysqli_query($_SESSION['mysqli_link'], $sql)) echo "<div style='z-index:1500'>ERROR! (LookupTableEditOps:process_update_post,sdf65ak)".mysqli_error($_SESSION['mysqli_link'])."</div>".$sql;
			}
		}
		//reset disabled items
		$operation = 1; //see stored procedure for definition of operations
		$sql = sprintf("Call reset_lookup_table_items('%s','%s')",$lookuptable->tbl_name,$operation);
		$result = mysqli_query($_SESSION['mysqli_link'], $sql);
		if (!$result) echo "<div style='z-index:1500'>ERROR! (LookupTableEditOps:process_update_post,sd20090315681f65ak)".mysqli_error($_SESSION['mysqli_link'])."</div>".$sql;
		//mysqli_free_result($result);//this didn't fix the error: ERROR! (LookupTableEditOps:process_update_post,sdf65ak)Commands out of sync; you can't run this command now
		//so must ensure that stored procedure does not produce a result set!
		foreach ($_POST as $postkey => $postval)
		{
			if (ereg("^disable_([0-9]+)",$postkey, $regs))
			{
				$sql = sprintf("Call disable_lookup_table_item('%s','%s',%s)",$lookuptable->tbl_name,$lookuptable->prim_key_col,$regs[1]);
				if (!mysqli_query($_SESSION['mysqli_link'], $sql)) echo "<div style='z-index:1500'>ERROR! (LookupTableEditOps:process_update_post,sdf65ak)".mysqli_error($_SESSION['mysqli_link'])."</div>".$sql;
			}
		}
	}
}


?>