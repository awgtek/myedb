<?php
	include_once (dirname(__FILE__).'/../commonfunc.php');
site_setup();

// include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/Main.php'); 
// include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/ClientServerDataOps/LookupTable.php'); 
// include_once ($_SERVER['DOCUMENT_ROOT'].'/functions/commonfunc.php');
$main = new Main(); //db connection

  
  LookupTable::get_table_and_field_by_prop_id(clean_request_val($_GET['prop_id']), $lookuptable, $lookupfield);
  $sql = "SELECT ".$lookupfield." FROM ".$lookuptable." WHERE ".$lookupfield." LIKE '%" . clean_request_val($_POST[$_GET['postedfield']]) . "%'";;
  $resource = mysql_query($sql);
?>
 
<ul>
 
<? while($taken = mysql_fetch_assoc($resource)) { ?>
  <li><? echo stripslashes($taken[$lookupfield]);?></li>
<? } ?>
 
</ul> 
