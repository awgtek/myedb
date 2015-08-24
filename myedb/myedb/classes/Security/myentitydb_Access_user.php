<?php
include_once (dirname(__FILE__) .'/../Security/thirdparty/access_user/access_user_class.php');
//include_once (dirname(__FILE__) .'/../Security/EntDict.php');
//include_once (dirname(__FILE__) .'/../Security/EntityManagementSystems.php');

class myentitydb_Access_user extends Access_user
{
	var $xml_string;
	var $xslt_file;
	var $templates_dir;
	var $email_url;
	var $loggedin_key;
	var $loggedin_key_user;
	var $loggedin_key_pass;
	var $debug =false;

	function myentitydb_Access_user($redirect = true, $_debug=false)
	{ 
		$this->debug = $_debug;
		$myedbsess = new MyEDB_SESSION();
		//$this->templates_dir = $_SERVER['DOCUMENT_ROOT']."/XSLTemplates/SecurityTemplates/";
		$this->cookie_path = $myedbsess->get_session_path(); //dirname($_SERVER['PHP_SELF']); 
		$this->cookie_name = (strstr(dirname($_SERVER['PHP_SELF']),"admin"))? adm : mem;
		$this->loggedin_key = $this->cookie_path ."loggedin";
		$this->loggedin_key_user = $this->cookie_path ."usr";
		$this->loggedin_key_pass = $this->cookie_path ."pw";
		//parent::Access_user(); //
		if (empty($_SESSION[$this->loggedin_key])) {// echo "<br>in Access_user()";
			$this->login_reader(); 
			if ($this->is_cookie) {//echo "calling set_user";
				$this->set_user($redirect); //echo "is cookie..." .$this->cookie_name." is cookie name -- logged in, cookie path: ".$this->cookie_path."<br>";
			}
		}
//echo "<br>yoo2";echo microtime(true); debug_print_backtrace ( );
//var_dump(debug_backtrace());
		if (isset($_SESSION[$this->loggedin_key_user], $_SESSION[$this->loggedin_key_pass])) 
		{
			$this->user = $_SESSION[$this->loggedin_key_user];
			$this->user_pw = $_SESSION[$this->loggedin_key_pass];
			if ($this->debug)
			{
			//debug_print_backtrace() ;
			echo "<br>myentitydb_Access_user,".$this->cookie_name." is cookie name, cookie path: ".$this->cookie_path." user: ".$this->user.
				" pass: ".$this->user_pw."<br>";
			}
		}
		
		//$this->login_page = '/classes/Security/thirdparty/access_user/login.php';
		$this->xml_string = "<login_form><temp></temp></login_form>";
	//	$this->xslt_file = $this->templates_dir."login.xsl";
		
	}
	
	function check_user($pass = "") {
		switch ($pass) {
		/*	case "new": 
			$sql = sprintf("SELECT COUNT(*) AS test FROM %s WHERE email = %s OR login = %s", $this->table_name, $this->ins_string($this->user_email), $this->ins_string($this->user));
			break;*/
			case "lost":
				//$sql = sprintf("SELECT COUNT(*) AS test FROM %s WHERE email = %s AND active = 'y'", $this->table_name, $this->ins_string($this->user_email));
				if (!$this->user_exists())
				{
					return false;
				}
				if (!$this->is_active())
				{
					return false;
				}
				return true;
			break;
			case "new_pass":
				//$sql = sprintf("SELECT COUNT(*) AS test FROM %s WHERE MD5(pw) = %s AND id = %d", $this->table_name, $this->ins_string($this->user_pw), $this->id);
				//echo $this->user_pw." yo";
				return $this->user_pw == md5($this->get_user_password());
				
			break;
		/*	case "active":
			$sql = sprintf("SELECT COUNT(*) AS test FROM %s WHERE id = %d AND active = 'n'", $this->table_name, $this->id);
			break;
			case "validate":
			$sql = sprintf("SELECT COUNT(*) AS test FROM %s WHERE id = %d AND tmp_mail <> ''", $this->table_name, $this->id);
			break;*/
			default: 
				//echo "checking logins:";
				$passed = $this->myedb_check_logins($this->user,$this->user_pw); //echo $passed;
				return $passed;
	//		$sql = sprintf("SELECT COUNT(*) AS test FROM %s WHERE BINARY login = %s AND pw = %s AND active = 'y'", $this->table_name, $this->ins_string($this->user), $this->ins_string($this->user_pw));
		}
/*		$result = mysql_query($sql) or die(mysql_error());
		if (mysql_result($result, 0, "test") == 1) {
			return true;
		} else {
			return false;
		} */
	}

	function myedb_check_logins($user="", $pass, $email="")
	{// echo "<br>in myedbchecklogin ".$user." - pass;".$pass;
		if (!empty($pass))
		{ 
			//$eids = EntityManagementSystems::get_eids($user, EntDict::get_prop_id("userid"), EntDict::get_type_id("user"));
			//$eid = $eids[0]; //assumes only 1 matching user in the database
			$eid = $this->get_user_eid();
			$passeids = EntityManagementSystems::get_eids($pass, EntDict::get_prop_id("userpass"), EntDict::get_type_id("user"));
			
			return in_array($eid,$passeids);
				
		}
	}
	
	function get_user_eid()
	{
		$eids = EntityManagementSystems::get_eids($this->user, EntDict::get_prop_id("userid"), EntDict::get_type_id("user"));
		if (empty($eids))
		{
			return false;
		}
		$eid = $eids[0]; //assumes only 1 matching user in the database
		return $eid;
	}
	
	function get_user_password()
	{
		$passar = EntityManagementSystems::get_vals($this->get_user_eid(), EntDict::get_prop_id("userpass"), EntDict::get_type_id("user"));
		$userpassword = $passar[0]; //only one result; assumes user has only one level
		return $userpassword;
	}
	
	function get_user_auth_level()
	{
		$authar = EntityManagementSystems::get_vals($this->get_user_eid(), EntDict::get_prop_id("userauthlevel"), EntDict::get_type_id("user"));
		$userauthlevel = $authar[0]; //only one result; assumes user has only one level
		return $userauthlevel;
	}
	
	function access_page($refer = "", $qs = "", $level = DEFAULT_ACCESS_LEVEL) {
		$refer_qs = $refer;
		$refer_qs .= ($qs != "") ? "?".$qs : "";
		if (!$this->check_user()) {
			$_SESSION['referer'] = $refer_qs;//echo "I'm in access page!!".$_SESSION['referer'];
			//header("Location: ".$this->login_page);
			//exit;
			return false;
		}
		if ($this->get_access_level() < $level) { //always true for now (doing function level access checks)
			//echo "testing.";
			header("Location: ".$this->deny_access_page);
			exit;
		} //echo "I'm in access page!!".$_SESSION['referer'];
		return true;
	}
	
	//stub for now
	function get_access_level() 
	{
	return 10;
	}
	
	function connect_db() 
	{ //leave empty connecting elsewhere
	}
	
	function set_user($goto_page) {
		$_SESSION[$this->loggedin_key_user] = $this->user;
		$_SESSION[$this->loggedin_key_pass] = $this->user_pw;
		$_SESSION[$this->loggedin_key] =  time(); // to offer a time limited access (later)
		return;
		//echo "in heeer".$_SESSION['referer'];
		if (!empty($_SESSION['referer'])) {
			$next_page = $_SESSION['referer'];
			unset($_SESSION['referer']);
			if ($goto_page) {
				header("Location: ".$next_page);
				exit;
			}
		} 
	}
	
	######### additional functions
	function process_login()
	{ 
		$this->save_login = (isset($_POST['remember'])) ? $_POST['remember'] : "no"; // use a cookie to remember the login
		$this->count_visit = false; // if this is true then the last visitdate is saved in the database (field extra info)
//echo "helbbbooeor";
	//	$this->cookie_name .= $_POST['login'];
		//$this->cookie_path = dirname($_SERVER['PHP_SELF']); //echo 'yo'.$_SERVER['PHP_SELF'];
		//echo "<br>checkinguser: ".$_POST['login']." pass:".$_POST['password'];
		$this->login_user($_POST['login'], $_POST['password']); // call the login method
		if ($this->the_msg)
		{
			$this->xml_string = "<login_form><errormsg>".$this->the_msg."</errormsg><login>".$_POST['login']."</login>".
			"<password>".$_POST['password']."</password></login_form>";
			//$this->xslt_file = $this->templates_dir."login.xsl"; //delete this
		}
		$process_success = $this->is_logged_in(); //echo "success?".$process_success."<br>";//die(); 
		return $process_success;
	}
	
	function process_logout()
	{
		$this->save_login = "no";
		$this->login_saver();//unset cookie
		$this->log_out();
	}
	
	//overrides
	function log_out()
	{
		unset($_SESSION[$this->loggedin_key_user]);
		unset($_SESSION[$this->loggedin_key_pass]);
		unset($_SESSION[$this->loggedin_key]);
		session_destroy(); // new in version 1.92
	}
	
	function is_logged_in()
	{//echo "hello".$this->loggedin_key.(!empty($_SESSION[$this->loggedin_key]));
		return !empty($_SESSION[$this->loggedin_key]);
	}
	
	function user_exists()
	{
		$eid = $this->get_user_eid();
		if (!$eid)
		{
			$this->the_msg = "User does not exist";
			return false;
		}
		return true;
	}
	
	function is_active()
	{
		$activar = EntityManagementSystems::get_vals($this->get_user_eid(), EntDict::get_prop_id("active"), EntDict::get_type_id("user"));
		$is_active = $activar[0]; //only one result; assumes user has only one active setting
		if (!$is_active)
		{
			$this->xml_string = "<login_form><errormsg>User is not active</errormsg><login>".$_POST['login']."</login>".
			"<password>".$_POST['password']."</password></login_form>";
			$this->the_msg = "User is not active";
		}
		return $is_active;
	}

	function check_activation_password($controle_str, $id) { 
		if ($controle_str != "" && strlen($controle_str) == 32 && strlen($id) > 0) { 
			$this->user_pw = $controle_str;
			//$this->id = $id;
			if ($this->check_user("new_pass")) {
				// this is a fix for version 1.76
			//	$sql_get_user = sprintf("SELECT login FROM %s WHERE MD5(pw) = %s AND id = %d", $this->table_name, $this->ins_string($this->user_pw), $this->id);
			//	$get_user = mysql_query($sql_get_user);
			//	$this->user = mysql_result($get_user, 0, "login"); // end fix
				return true;
			} else { 
				$this->the_msg = $this->messages(21);
				die($this->the_msg);
				return false;
			}
		} else {
			$this->the_msg = $this->messages(21);
			die($this->the_msg);
			return false;
		}
	}
	
	function forgot_password($forgot_email="") { 
		if (empty($forgot_email))
		{
			$forgot_email = $this->user;
		}
		if ($this->check_email($forgot_email)) {
			$this->user_email = $forgot_email;
			if (!$this->check_user("lost")) {
				if (empty($this->the_msg)) $this->the_msg = $this->messages(22); //check_user sets the_msg 
			} else {
					$this->id = $this->user_email = $this->user; //for gary site, userid is same as email
					$this->user_pw = $this->get_user_password();

					$host = "http://".$_SERVER['HTTP_HOST'];
					
					$this_user_eid = $this->get_user_eid();
					$this_user = $this->user;
					$this_activate_user_pw = md5($this->user_pw);
					$url_str = "					
\$target_component = array();	
\$target_function = array();				
\$target_component[]=\"SecurityOperationsFacade\";
\$target_function[]=\"check_activation_password\";
\$target_component[]=\"RecordIniFacade\";
\$target_function[]=\"initialize\";
\$_REQUEST['target_component'] = \$target_component;
\$_REQUEST['target_function'] = \$target_function;
\$_REQUEST['eid']=$this_user_eid;
\$_REQUEST['type_id']=3;
\$_REQUEST['OF_passthru']=\"reset_password\";
\$_REQUEST['id']=\"$this_user\";
\$_REQUEST['activate']=\"$this_activate_user_pw\";
";
			$enc_req_obj = myedb_encrypt($url_str);				
					$this->email_url = $host."/index.php?er=".$enc_req_obj;
					if ($this->send_mail($this->get_user_eid(), 35, 26)) {
						$this->the_msg = $this->messages(23);
					} else {
						$this->the_msg = $this->messages(14);
					}
				
			}
		} else {
			$this->the_msg = $this->messages(16);
		}
	}
	
	function set_xml_string_using_msg()
	{
			$this->xml_string = "<myedb_user_access><the_msg>{$this->the_msg}</the_msg></myedb_user_access>";
		
	}
	
}

?>