<?php
/*This is at present a helper class for the RecordSys component. If it comes to be used by other components, it should be moved to a common utility component */
//include_once(dirname(__FILE__) .'/../MainClient/AppConfig.php');

class memcache_search_key
{

	function add_search_key($search_key)
	{
		$dbh = new PDO('mysql:dbname='.AppConfig::gacv("AC_db").';host='.AppConfig::gacv("AC_server")
				,AppConfig::gacv("AC_user"),AppConfig::gacv("AC_pass")); 
		$sql = "INSERT INTO memcache_search_keys (search_key) VALUES (:search_key)
  ON DUPLICATE KEY update search_key = search_key;"; //on duplicate key syntax suggestion from http://bogdan.org.ua/2007/10/18/mysql-insert-if-not-exists-syntax.html#comment-80275
		$q = $dbh->prepare($sql);   
		$q->execute(array(':search_key'=>$search_key));   
		
	}
	
	function delete_search_keys()
	{
		$dbh = new PDO('mysql:dbname='.AppConfig::gacv("AC_db").';host='.AppConfig::gacv("AC_server")
				,AppConfig::gacv("AC_user"),AppConfig::gacv("AC_pass")); 

		$memcache_obj = memcache_pconnect('localhost', 11211);

		$sql = sprintf("select search_key from %s ","memcache_search_keys"); 
		$sth = $dbh->prepare($sql ,array(PDO::ATTR_CURSOR, PDO::CURSOR_FWDONLY));//
		$sth->execute();
		$res = $sth->fetchAll(PDO::FETCH_BOTH);//echo $sql.$this->lookup_tbl_id_col;//
    	foreach ($res as $ar)
		{
			memcache_delete($memcache_obj, $ar["search_key"],0);
		}
				
		/* Delete all rows from the FRUIT table */
		$count = $dbh->exec("DELETE FROM memcache_search_keys");

		
	}

}
?>