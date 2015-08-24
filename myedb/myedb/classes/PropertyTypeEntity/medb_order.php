<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/dbops.php');
//include_once(dirname(__FILE__) .'/../MainClient/AppConfig.php');

class medb_order
{
	var $order_id;
	var $approved;
	
	function __construct($order_id)
	{
		$this->order_id = $order_id; 
	}
	
	function set_approved_value($approved_value)
	{
		$dbh = dbops::getpdo();
		$stmt = $dbh->prepare("UPDATE medb_order set approved = :approved where order_id = :order_id");
		$stmt->bindParam(":approved",$approved_value);
		$stmt->bindParam(":order_id",$this->order_id);
		$stmt->execute() or die("an error occurred: medb_order,83kjf641sl8890");
		return 1;
	}

	function update_medb_order_res_field_name_value($res_field_name, $new_value)
	{	 
		if (1 == get_magic_quotes_runtime() || 1 == get_magic_quotes_gpc()){ 
        	$new_value = stripslashes($new_value); //PDO does the escaping 
    	} 
    	$new_value = trim($new_value);
    	//$new_value = htmlspecialchars($new_value,ENT_NOQUOTES);
    	//echo htmlentities($new_value)."-[-"; die();
		//$new_value = htmlentities($new_value, ENT_QUOTES);
		
		$dbh = new PDO('mysql:dbname='.AppConfig::gacv("AC_db").';host='.AppConfig::gacv("AC_server")
				,AppConfig::gacv("AC_user"),AppConfig::gacv("AC_pass")); 
		$sql = sprintf("select details_xml from medb_order WHERE order_id = :pdo_order_id "); 
		$sth = $dbh->prepare($sql ,array(PDO::ATTR_CURSOR, PDO::CURSOR_FWDONLY));//
		//$sth->execute(array(':lookup_tbl_id_col' => ($_REQUEST[$this->lookup_tbl_id_col])? $_REQUEST[$this->lookup_tbl_id_col] : $this->lookup_tbl_id_col));
		$sth->bindParam(':pdo_order_id',$this->order_id, PDO::PARAM_INT);
	//	$sth->bindParam(':lookup_not_set',$lookup_not_set);
	//	$lookup_tbl_id_col = $_REQUEST[$this->lookup_tbl_id_col] ;
	//	$lookup_not_set = ($_REQUEST[$this->lookup_tbl_id_col])? 0 : 1;
		$sth->execute();
		$details_xml = $sth->fetchColumn();
		
		$xml = simplexml_load_string($details_xml);

		$result = $xml->xpath("/travel_res_info/travel_res_submitted_fields/travel_res_submit_field [@res_field_name='" . $res_field_name . "']" );

		$result[0]->res_field_value=$new_value;
  		$new_details_xml = $xml->asXML();
		//echo "yoohoo".htmlentities($xml->asXML()); die;
		
		$sql = sprintf("update medb_order set details_xml = :new_details_xml WHERE order_id = :pdo_order_id "); 
		$sth = $dbh->prepare($sql ,array(PDO::ATTR_CURSOR, PDO::CURSOR_FWDONLY));//
		//$sth->execute(array(':lookup_tbl_id_col' => ($_REQUEST[$this->lookup_tbl_id_col])? $_REQUEST[$this->lookup_tbl_id_col] : $this->lookup_tbl_id_col));
		$sth->bindParam(':pdo_order_id',$this->order_id, PDO::PARAM_INT);
		$sth->bindParam(':new_details_xml',$new_details_xml);
	//	$lookup_tbl_id_col = $_REQUEST[$this->lookup_tbl_id_col] ;
	//	$lookup_not_set = ($_REQUEST[$this->lookup_tbl_id_col])? 0 : 1;
		$sth->execute();
		
		return $new_value;
				
	}
}


?>