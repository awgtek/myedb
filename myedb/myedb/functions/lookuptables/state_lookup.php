<?php
// include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/MainClient/Main.php'); 
	include_once (dirname(__FILE__).'/../commonfunc.php');
site_setup();

$main = new Main(); //db connection

// $_POST['search'] = "N";
  $sql = "SELECT state_abbrev FROM state WHERE state_abbrev LIKE '%" . $_POST['search'] . "%'";
  $resource = mysql_query($sql);
  
?>
 
<ul>
 
<? while($taken = mysql_fetch_assoc($resource)) { ?>
  <li><? echo stripslashes($taken['state_abbrev']);?></li>
<? } ?>
 
</ul> 
