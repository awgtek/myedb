<?php

class UpdaterSprocsContainer
{

	function create_standalone_order($details_xml, $eidsrc,$eiddst,$type_id)
	{//echo "<xmp>".$details_xml."</xmp>";die();

		$sql = sprintf("Call create_standalone_order(%s,%s,%s,%s)",$details_xml, $eidsrc,$eiddst,$type_id);
		if (!mysqli_multi_query($_SESSION['mysqli_link'], $sql )) echo "<div style='z-index:1500'>ERROR! (UpdaterSprocsContainer:create_standalone_order.jiihjssdskar56ek)".mysqli_error($_SESSION['mysqli_link'])."</div>";
	}

	function finalize_order($eid, $details_xml)
	{
	//	$sql = sprintf("Call finalize_order(%s,%s)",$eid, $details_xml);
	//	if (!mysqli_multi_query($_SESSION['mysqli_link'], $sql )) echo "<div style='z-index:1500'>ERROR! (UpdaterSprocsContainer:aassdskarek)".mysqli_error($_SESSION['mysqli_link'])."</div>";
		//<<<EOT
		$QUERY =
		//"			START TRANSACTION; ".
			sprintf("Call finalize_order(%s,%s,@out_order_id);",$eid, $details_xml).
			"SELECT @out_order_id as order_id;"
//SELECT @lng:=IF( STRCMP(`main_lang`,'de'), 'en', 'de' )
//FROM `main_data` WHERE  ( `main_activ` LIKE 1 ) ORDER BY `main_id` ASC;
//SELECT `main_id`, `main_type`, `main_title`, `main_body`, `main_modified`, `main_posted`
//FROM `main_data`
//WHERE ( `main_type` RLIKE "news|about" AND `main_lang` LIKE @lng AND `main_activ` LIKE 1 )
//ORDER BY `main_type` ASC;
			//"COMMIT;"
			;
//EOT;

		$mysqli = $_SESSION['mysqli_link'];
		$query = mysqli_multi_query( $mysqli, $QUERY ) or die("error 9832lkjaklh3". mysqli_error( $mysqli ) );

		if( $query )
		{
		  do {
		    if( $result = mysqli_store_result( $mysqli ) ) //must process result for each query to avoid blocking
		    {
		      $subresult = mysqli_fetch_assoc( $result );
		      if( ! isset( $subresult['order_id'] ) )
		        continue;

		      $_SESSION['finalized_order_id'] = $subresult['order_id']  ;
		     // foreach( $subresult AS $k => $v )
		    //  {
		     //   var_dump( $k , $v );
		    //  }
		    }
		  } while ( mysqli_next_result( $mysqli ) );
		}

	}

	static function update_repeat_prop_qualifier($eid, $prop_group_id, $prop_id, $ron, $prop_qual_id)
	{
		$sql = sprintf("Call update_repeat_prop_qualifier(%s,%s,%s,%s,%s)",$eid, $prop_group_id, $prop_id, $ron, $prop_qual_id);
		if (!mysqli_multi_query($_SESSION['mysqli_link'], $sql )) echo "<div style='z-index:1500'>ERROR! (UpdaterSprocsContainer:aasarek)".mysqli_error($_SESSION['mysqli_link'])."</div>";
		//$result = mysqli_store_result($_SESSION['mysqli_link']); echo "store result::" .mysqli_error($_SESSION['mysqli_link']);
		//mysqli_free_result($result); echo $sql;
	}

	static function delete_eid($eid)
	{
		$sql = sprintf("Call delete_eid(%s)",$eid);
		if (!mysqli_query($_SESSION['mysqli_link'], $sql)) echo "ERROR! (UpdaterSprocsContainer:sdfak)";

	}

	static function del_prop_group_by_ron($type_id, $prop_group_id, $ron, $eid)
	{
		//echo "<br>here: " . $type_id .", propgroupid: ". $prop_group_id .", ron: " . $ron .", eid: " . $eid;
		$sql = sprintf ("call del_prop_group_by_ron(%s,%s,%s,%s)",$type_id,$prop_group_id,$ron,$eid);
		//echo $sql;
		//mysql_query($sql) or die(mysql_error());
		/* Connect to a MySQL server */

	//	if (!$link) {
	//	printf("Can't connect to MySQL Server. Errorcode: %s\n", mysqli_connect_error());
	//	exit;
	//	}


		/* Send a query to the server */
		if ($result = mysqli_query($_SESSION['mysqli_link'], $sql)) {


		/* Fetch the results of the query */
		//while( $row = mysqli_fetch_array($result) ){

		//echo ($row[0]. "--------- SR. " . $row[1] . "<br>");

		//}

		/* Destroy the result set and free the memory used for it */
		//mysqli_free_result($result);
		}
		else echo "Error! (kwmeeckk)";

		/* Close the connection */
	//	mysqli_close($link);
//
	}
	static function del_prop_by_ron($prop_id, $ron, $eid)
	{
		free_mysqli_results(); //free up any previous results
		$sql = sprintf("Call del_prop_by_ron(%s,%s,%s)",$prop_id,$ron,$eid);
		if (!mysqli_query($_SESSION['mysqli_link'], $sql)) echo "ERROR! (UpdaterSprocsContainer:iwkd,mwk)".mysqli_error($_SESSION['mysqli_link']).$sql;

	}

	static function create_transaction($eidsrc,$eiddst,$prop_group_id,$prop_id,$ron,$qty)
	{
		$sql = sprintf("Call create_transaction(%s,%s,%s,%s,%s,%s)",$eidsrc,$eiddst,$prop_group_id,$prop_id,$ron,$qty);
		if (!mysqli_query($_SESSION['mysqli_link'], $sql)) echo "ERROR! (UpdaterSprocsContainer:create_transactionpopiwkd,mwk)";

	}

	static function delete_transaction($trans_id)
	{
		$sql = sprintf("Call delete_transaction(%s)",$trans_id);
		if (!mysqli_query($_SESSION['mysqli_link'], $sql)) echo "ERROR! (UpdaterSprocsContainer:delete_transactionpopiwkd,mwk)".mysqli_error($_SESSION['mysqli_link']);

	}


}

?>