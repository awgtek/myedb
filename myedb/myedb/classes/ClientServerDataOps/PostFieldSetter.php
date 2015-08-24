<?php
 include_once (dirname(__FILE__) .'/../ClientServerDataOps/LookupTable.php'); 
 include_once (dirname(__FILE__) .'/../../functions/commonfunc.php');
//include_once (dirname(__FILE__) .'/../AppLibrary/AppSettings.php');

class PostFieldSetter
{

	function set_prop_fields_from_standin()
	{
		$roni = 0;
		foreach ($_POST as $postkey => $postval)
		{
			$final_post_val = clean_request_val($_POST[$postkey]);
			if (is_array($final_post_val))
				continue;
			$posted_lookup_field = trim($final_post_val);
			if (ereg("^standin_pi([0-9]+)epi([0-9]+)ron([0-9]+)$",$postkey,$regs) and (!empty($posted_lookup_field)
				or (empty($posted_lookup_field) and $regs[2] != 0) ) ) //update blank field only if field set previously
			{
				$prop_id = $regs[1];
				$ent_prop_id = $regs[2];
				$roni = $regs[3];
				
				  LookupTable::get_table_and_field_by_prop_id($prop_id, $lookuptable, $lookupfield);
				
				$sql = "SELECT ".$lookuptable."_id FROM $lookuptable WHERE $lookupfield = '$posted_lookup_field'";
				$result = mysql_query($sql);
				if ($row = mysql_fetch_array($result))
				{
					$_POST[str_replace("standin_","",$postkey)] = $row[$lookuptable."_id"];
					$_REQUEST[str_replace("standin_","",$postkey)] = $row[$lookuptable."_id"];
				}
				else
				{
					$sql = "INSERT INTO ".$lookuptable." SET $lookupfield = '$posted_lookup_field'";
					mysql_query($sql);
					$inserted_id = mysql_insert_id();
					$_POST[str_replace("standin_","",$postkey)] = $inserted_id;
					$_REQUEST[str_replace("standin_","",$postkey)] = $inserted_id;
				}
				
			}
		
		}
	}

	function set_post_password_field()
	{
		$roni = 0;
		foreach ($_POST as $postkey => $postval)
		{
			$final_post_val = clean_request_val($_POST[$postkey]);
			if (is_array($final_post_val))
				continue;
			$posted_lookup_field = trim($final_post_val);
			//$posted_lookup_field = trim(clean_request_val($_POST[$postkey])); //trim errors out if input is array
			if (ereg("^".AppSettings::$pswd_prefix."pi([0-9]+)epi([0-9]+)ron([0-9]+)$",$postkey,$regs) 
					and (!empty($posted_lookup_field) ) ) //update blank field only if field set previously
			{
				$prop_id = $regs[1];
				$ent_prop_id = $regs[2];
				$roni = $regs[3];
				
				$_POST[str_replace(AppSettings::$pswd_prefix,"",$postkey)] = md5($posted_lookup_field);
				
			}
		
		}
	}

}


?>