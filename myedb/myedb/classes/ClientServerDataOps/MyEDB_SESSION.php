<?php


class MyEDB_SESSION
{
	var $myedb_session_key;
	
	function __construct()
	{
		$this->myedb_session_key= $this->get_session_path();
		if (!is_array($_SESSION[$this->myedb_session_key]))
		{
			$_SESSION[$this->myedb_session_key] = array();
		}
	}
	
	function get_session_path()
	{
		return dirname($_SERVER['PHP_SELF']);
	}

    public function __set($name, $value) {
        //echo "Setting '$name' to '$value'\n";
        $_SESSION[$this->myedb_session_key][$name] = $value;
    }

    public function __get($name) {
        //echo "Getting '$name'\n";
        if (array_key_exists($name, $_SESSION[$this->myedb_session_key])) {
            return $_SESSION[$this->myedb_session_key][$name];
        }

   /*     $trace = debug_backtrace();
        trigger_error(
            'Undefined property via __get(): ' . $name .
            ' in ' . $trace[0]['file'] .
            ' on line ' . $trace[0]['line'],
            E_USER_NOTICE);
            */
        return null;
    }

    /**  As of PHP 5.1.0  */
    public function __isset($name) {
        //echo "Is '$name' set?\n";
        return isset($_SESSION[$this->myedb_session_key][$name]);
    }

    /**  As of PHP 5.1.0  */
    public function __unset($name) {
       // echo "Unsetting '$name'\n";
        unset($_SESSION[$this->myedb_session_key][$name]);
    }

    
}
?>