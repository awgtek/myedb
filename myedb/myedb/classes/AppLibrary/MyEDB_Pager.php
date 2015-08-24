<?php
//include_once (dirname(__FILE__) .'/../MainClient/AppConfig.php');

class MyEDB_Pager
{
	var $per_page = 0;
	
	function __construct()
	{
		$this->per_page = AppConfig::get_app_config_var('default_rows_per_page');
	}
	
	static function get_num_per_page()
	{
		$myedbpager = new myedbPager(); //in OutputSystem/
		return $myedbpager->per_page;
	}

	function get_person_xsl_pager_params($xml_string)
	{ 
$xml = new SimpleXMLElement($xml_string);

/* Search for <a><b><c> */
$rows = count($xml->xpath('/records/record'));
//		$rows = $_SESSION['search_res_row_cnt'];
require_once 'Pager/Pager.php';
$data = range(1, $rows); //an array of data to paginate
$pager_params = array(
  //  'mode'  => 'Sliding',    //try switching modes
    'mode'  => 'Jumping',
    'append'   => false,  //don't append the GET parameters to the url
    'path'     => '',
    'fileName' => 'javascript:revealDiv(%d)',  //Pager replaces "%d" with the page number..',  //Pager replaces "%d" with the page number...
    'perPage'  => myedbPager::get_num_per_page(), //show 10 items per page
    'delta'    => 5,
    'itemData' => $data,
);
$pager = & Pager::factory($pager_params);
$n_pages = $pager->numPages();
$links = $pager->getLinks(); 
		return array("n_pages"=>$n_pages, "page_links"=>$links['all'], "numrows" => $rows);
	}
	
	function get_xsl_pager_params($xml_string)
	{
		$myedbsess = new MyEDB_SESSION();
		//$xml = new SimpleXMLElement($xml_string);
		
		/* Search for <a><b><c> */
		//$rows = count($xml->xpath('/records/record'));
	//	echo "<br>MyEDB_Pager, setting rows results from Session searcres_rowcnt: ".$_SESSION['search_res_row_cnt']." time is ".microtime();
			//	$rows = $_SESSION['search_res_row_cnt']; 
				$rows = $myedbsess->search_res_row_cnt;
		require_once 'Pager/Pager.php';
		$data = range(1, $rows); //an array of data to paginate
		$pager_params = array(
		  //  'mode'  => 'Sliding',    //try switching modes
		    'mode'  => 'Jumping',
		    'append'   => false,  //don't append the GET parameters to the url
		    'path'     => '',
		    'fileName' => 'javascript:revealDiv(%d)',  //Pager replaces "%d" with the page number..',  //Pager replaces "%d" with the page number...
		    'perPage'  => myedbPager::get_num_per_page(), //show 10 items per page
		    'delta'    => 5,
		    'itemData' => $data,
	//		'altPage'  => ' -pg ',
	//		'nextImg'  => ' Nxt>> ',
		);
		$pager = & Pager::factory($pager_params);
		$n_pages = $pager->numPages();//print_r($data); echo $n_pages;
		$links = $pager->getLinks(); 
		list($from_row,$to_row) = $pager->getOffsetByPageId ();
		return array("n_pages"=>$n_pages, "page_links"=>$links['all'], "numrows" => $rows, "from_row" => $from_row, 
		"to_row" => $to_row, "total_rows" => $rows);
	}
	
	//Requires: 
	// $_REQUEST['pgn']
	function apply_page_filter($ids)
	{ 
		$myedbsess = new MyEDB_SESSION();
		
		//save in global for pager routine
		//$_SESSION['search_res_row_cnt'] = count($ids);
		$myedbsess->search_res_row_cnt = count($ids);
		//echo "<br>MyEDB_Pager, applied searcresrowcount".$_SESSION['search_res_row_cnt']." from counteids: ".count($ids)." timeis: ".microtime();
		//trim eid set down by page offset and limit
		$per_page = AppConfig::get_app_config_var('default_rows_per_page');
		$page_num = (isset($_REQUEST['pgn']))? $_REQUEST['pgn'] : 1;
		$fin_ids = array();
		$offset = ($page_num - 1) * $per_page;
		for ($i = $offset; $i < $offset + $per_page; $i++)
		{
			if (isset($ids[$i]))
			{
				array_push($fin_ids, $ids[$i]);
			}
		}
		return $fin_ids;
	}

	function get_sql_limit_clause()
	{
	//	$_SESSION['search_res_row_cnt'] = count($ids);
		$page_num = (isset($_REQUEST['pgn']))? $_REQUEST['pgn'] : 1;
		$rowsPerPage = AppConfig::get_app_config_var('default_rows_per_page');
		// counting the offset
		$offset = ($page_num - 1) * $rowsPerPage;
		return    " LIMIT $offset, $rowsPerPage";

	}
	
	function get_sql_limit_offset()
	{
	//	$_SESSION['search_res_row_cnt'] = count($ids);
		$page_num = (isset($_REQUEST['pgn']))? $_REQUEST['pgn'] : 1;
		$rowsPerPage = AppConfig::get_app_config_var('default_rows_per_page');
		// counting the offset
		$offset = ($page_num - 1) * $rowsPerPage;
		return    $offset;

	}
	
	function get_sql_limit_rows()
	{
		return    AppConfig::get_app_config_var('default_rows_per_page');

	}
	
}

?>