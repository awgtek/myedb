<?php
function add_include_path ($paths)
{
//echo "num args:".func_num_args(); //die();
//flush();
   foreach ($paths AS $path)
    {// echo "before yo".microtime(true); flush();
    	if (!file_exists($path) OR (file_exists($path) && filetype

($path) !== 'dir'))
        {
 	//echo "yo!"; flush(); //die();
            trigger_error("Include path '{$path}' not exists", 

E_USER_WARNING);
              continue;
        }
    //    echo "<br>after yo".microtime(true); flush();
    //    echo "woop"; flush(); //die();
        $paths = explode(PATH_SEPARATOR, get_include_path());
        
        if (array_search($path, $paths) === false)
            array_push($paths, $path);
        
        set_include_path(implode(PATH_SEPARATOR, $paths));
    }
}
/**
 * Does the same as spl_autoload, but without lowercasing
 */
function SPL_autoload_suxx($name)
{
	$rc = FALSE;
	
	$exts = explode(',', spl_autoload_extensions());
	$sep = (substr(PHP_OS, 0, 3) == 'Win') ? ';' : ':';
	$paths = explode($sep, ini_get('include_path'));
	foreach($paths as $path) {
		foreach($exts as $ext) {
			$file = $path . DIRECTORY_SEPARATOR . $name . $ext;
			if(is_readable($file)) {
				require_once $file;
				$rc = $file;
				break;
			}
		}
	}
	
	return $rc;
}

//first create a connection to your database...
function myedb_mysqli_connection()
{		
	$mysqli = new mysqli(GI_SERVER,GI_USER,GI_PASS, GI_DB);		
	if (mysqli_connect_errno()) 
	{			
		printf("Connect failed: %s\n", mysqli_connect_error());			
		exit();		
	} 		
	return $mysqli; 	
} 
//second create the function to call the stored procedure  
function myedb_mysqli_query($query,&$mysqli=""){
	//call the connection function  
	$mysqli = myedb_mysqli_connection();
	
	if($result = $mysqli->query($query))
	{			
		while($row = $result->fetch_assoc())
		{					
			$data[] = $row;			
		}	
		//free the resultset
		$result->free();
		//clear the other result(s) from buffer
		//loop through each result using the next_result() method
		while ($mysqli->next_result()) 
		{
			//free each result.
			$result = $mysqli->use_result();
			if ($result instanceof mysqli_result) 
			{
				$result->free();
			}
		}
				
		return $data;			
	}
	else 
	{			
		print('error on:'.$query.mysqli_error($this));                      
	} 
}

function free_mysqli_results()
{
		while (mysqli_next_result($_SESSION['mysqli_link'])) 
		{
			//free each result.
			$result = mysqli_use_result($_SESSION['mysqli_link']);
			if ($result instanceof mysqli_result) 
			{
				$result->free();
			}
		}
	
}

function site_setup()
{
	error_reporting(E_ALL ^ E_NOTICE ^ E_DEPRECATED);  
	//error_reporting(E_ALL );  
	
	//error_reporting (E_ALL & ~E_NOTICE & ~E_DEPRECATED); // I use this only for testing
	
	include_once (dirname(__FILE__).'/../serverspfc/dbstup.php');
	
    // Your custom class dir
    //define('CLASS_DIR', 'class/')

    // Add your class dir to include path
    //set_include_path(get_include_path().PATH_SEPARATOR.CLASS_DIR);

    // You can use this trick to make autoloader look for commonly used "My.class.php" type filenames
    //spl_autoload_extensions('.class.php');
//print_r( $_SERVER);
//echo dirname($_SERVER['PHP_SELF']);
	//echo dirname(dirname(__FILE__)); die();
	$app_root = dirname(dirname(__FILE__));
	define("APP_ROOT",$app_root); 
	define("URL_APP_ROOT", str_replace($_SERVER['DOCUMENT_ROOT'],"",$app_root));
//	add_include_path($app_root);
	$incl_dirs = array();
	$incl_dirs[] = $app_root."/classes/AppLibrary/";
	$incl_dirs[] = $app_root."/classes/ApplicationEntities/";
	$incl_dirs[] = $app_root."/classes/ClientServerDataOps/";
	$incl_dirs[] = $app_root."/classes/MainClient/";
	$incl_dirs[] = $app_root."/classes/MetaDataOps/";
	$incl_dirs[] = $app_root."/classes/Notification/";
	$incl_dirs[] = $app_root."/classes/OutputSystem/";
	$incl_dirs[] = $app_root."/classes/PropertyTypeEntity/";
	$incl_dirs[] = $app_root."/classes/Props/";
	$incl_dirs[] = $app_root."/classes/RecordsSystem/";
	$incl_dirs[] = $app_root."/classes/Security/";
	$incl_dirs[] = $app_root."/classes/thirdparty/";
	$incl_dirs[] = $app_root."/classes/thirdparty/HTTP_Upload/";
	$incl_dirs[] = $app_root."/classes/thirdparty/phpMailer/";
	$incl_dirs[] = $app_root."/classes/TransactionSystem/";
	$incl_dirs[] = $app_root."/site_specific_classes/MainClient/";
	$incl_dirs[] = $app_root."/site_specific_classes/OutputSystem/";
	$incl_dirs[] = $app_root."_locspfc/";
	add_include_path($incl_dirs);
   //     test_cookie_headers();echo "done";die();
	//echo $app_root."hereeeee"; //die();
    // Use default autoload implementation
	spl_autoload_register('SPL_autoload_suxx');// echo "done"; flush(); //die();
}



function clean_request_val($mixed, $quote_style = ENT_QUOTES )
{ 
//  	$trans_table = get_html_translation_table( HTML_SPECIALCHARS, ENT_QUOTES );
//echo "im in here! $str --".strtr($str, $trans_table)."--".htmlspecialchars($str, ENT_QUOTES)."<br>";
   if(is_array($mixed)){
     return array_map('clean_request_val',$mixed, array_fill(0,count($mixed),$quote_style));
  }

	return htmlspecialchars($mixed, ENT_QUOTES);
}

function myedb_strip_slashes( $input)
{
    if(is_array($input)){
        foreach($input as $k=>$i){
            $output[$k]=myedb_strip_slashes( $i);
        }
    }
    else{
        if(1 == get_magic_quotes_runtime() || get_magic_quotes_gpc()){
            $input=stripslashes($input);
        }     
        $output = $input;   
     }    
    
    return $output;
	
}


//and trim
function sanitize($input){
    if(is_array($input)){
        foreach($input as $k=>$i){
            $output[$k]=sanitize($i);
        }
    }
    else{
        if(get_magic_quotes_gpc()){
            $input=stripslashes($input);
        }        
        $output=trim(mysql_real_escape_string($input));
    }    
    
    return $output;
}

function sanitize_trim_mysqli_escape(&$mysqli_link, $input)
{
    if(is_array($input)){
        foreach($input as $k=>$i){
            $output[$k]=sanitize_trim_mysqli_escape($mysqli_link, $i);
        }
    }
    else{
        if(1 == get_magic_quotes_runtime()){
            $input=stripslashes($input);
        }        
        $output=trim(mysqli_real_escape_string($mysqli_link, $input));
    }    
    
    return $output;
	
}

function verify_integers($array)
{
	foreach ($array as $val)
	{
		$val = $val*1;
	    if (!	is_numeric($val)	)
	    {
	    	die ("error: props not int. 8l2kjere44444gggkjsah");
	    }
	}	
	
}

//validate_db_table_or_column_name
function vtorc($string)
{
	//if (preg_match('/["*\\/\\\\\\\:<>?|.]/', $string)) {
	//echo $string." herlloo: ".preg_quote('"*\/:<>?|.', '/');
	if (preg_match('/['.preg_quote('";*\/:<>?|.\'', '/').']/', $string)) { 
		echo "That does not appear to be a valid MySQL table or column name";
		die();
	}
	return $string;
}

function stmt_bind_assoc (&$stmt, &$out) {
    $data = mysqli_stmt_result_metadata($stmt);
    $fields = array();
    $out = array();

    $fields[0] = $stmt;
    $count = 1;

    while($field = mysqli_fetch_field($data)) {
        $fields[$count] = &$out[$field->name];
        $count++;
    }    
    call_user_func_array(mysqli_stmt_bind_result, $fields);
}



$pre_key="7heLkwo9";

// String EnCrypt + DeCrypt function 
// Author: halojoy, July 2006 
function convert($str,$ky=''){ 
if($ky=='')return $str; 
$ky=str_replace(chr(32),'',$ky); 
if(strlen($ky)<8)exit('key error'); 
$kl=strlen($ky)<32?strlen($ky):32; 
$k=array();for($i=0;$i<$kl;$i++){ 
$k[$i]=ord($ky{$i})&0x1F;} 
$j=0;for($i=0;$i<strlen($str);$i++){ 
$e=ord($str{$i}); 
$str{$i}=$e&0xE0?chr($e^$k[$j]):chr($e); 
$j++;$j=$j==$kl?0:$j;} 
return $str; 
} 
/////////////////////////////////// 

function myedb_encrypt($string, $key="") { 
	$key = empty($key)? $pre_key : $key;
$result = ''; 
$result = convert($string,$key);

return base64_encode($result); 
} 

function myedb_decrypt($string, $key="") { 
		$key = empty($key)? $pre_key : $key;
	
$result = ''; 
$string = base64_decode($string); 

$result = convert($string,$key);

return $result; 
} 

?>