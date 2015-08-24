<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/myedbPager.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/MyEDB_XSLTProcessor.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/XSLT_Catalog.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/XMLProcessor.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/WelcomePageXMLProcessor.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/Output_SecuritySystem.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/ApplicationEntities/AppEntities_Facade.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/AppSettings.php');

class OutputProcessor
{
	function echo_serialized_data($serialized_string) //e.g. xml string, json string
	{
		echo $serialized_string;	
	}
	
	public function __call($name, $arguments) {
        // Note: value of $name is case sensitive.
     //   echo "Calling object method '$name' "
     //        . implode(', ', $arguments). "\n";
		//$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template($name);
		//echo $xslt_file; die();
		if ($_REQUEST['ntctf'])
		{
			$xmlproc = new XMLProcessor(true);
			$xmlproc->encap_with_lists_non_static();
			$xml_string = $xmlproc->doc->saveXML();
		}
		elseif ($_REQUEST['noencaps'])
		{
			$xmlprocessor = XMLProcessor::prepare_doc($arguments[0]);
			$xml_string = $xmlprocessor->doc->saveXML();
	
		}
		else
		{ //print_r($arguments);
			$xmlprocessor = XMLProcessor::encap_with_lists($arguments[0]); //$arguments['xml_string']
			
			$xmlprocessor->add_city_state_zip_lists();
			$xml_string = $xmlprocessor->doc->saveXML();
		}
	
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
		
             
    }
		
	function no_xslt_processing($xml_string)
	{
		$xmlproc = new XMLProcessor();
		$xmlproc->append_child_from_xml($xml_string);

		$xml_string = $xmlproc->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function edit_site_variables($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('edit_site_variables');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
		
	}

	function edit_entity_groupings($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('edit_entity_groupings');
		$xmlproc = new XMLProcessor();
		$xmlproc->append_child_from_xml($xml_string);
		$xmlproc->add_entity_grouping_featured_list();
		$xmlproc->add_entity_grouping_featured_type_list();

		$xml_string = $xmlproc->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function barter_loop($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('barter_loop');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function barter_loop1($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('barter_loop1');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function barter_loop2($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('barter_loop2');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function barter_loop3($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('barter_loop3');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function public_welcome_page($xml_string)
	{ 
		//$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('public_welcome_page');

		//XMLProcessor::encap_with_lists($xml_string);
		$xmlproc = new WelcomePageXMLProcessor();
		
		$xmlproc->encap_with_lists_non_static($xml_string);
		//		$xmlproc = new XMLProcessor();
//		$xmlproc->append_child_from_xml($xml_string);
	//	$xmlproc->add_entity_grouping_featured_list();
	//	$xmlproc->add_entity_grouping_featured_type_list();

	//	$xml_string = $xmlproc->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
		
	}

	function subcat_select($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('subcat_select');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function subcat_edit_search_results($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('subcat_edit_search_results');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function sublookuptable_editor($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('sublookuptable_editor_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function lookuptable_editor($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('lookuptable_editor_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function checkout_cart($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('checkout_cart_tpl');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function user_reservation_page($xml_string)
	{ 
		foreach ($_SESSION as $post_key => $post_val)
		{
			if (ereg("^travel_res__(.*)$",$post_key,$regs))
			{
				$_REQUEST[$post_key] = $post_val;
			}
		}
		$xslt_file = XSLT_Catalog::get_template('user_reservation_page_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function user_reservation_travel_policy($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('user_reservation_travel_policy');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function confirm_travel_reservation_page($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('confirm_travel_reservation_page_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function travel_reservation_confirmation_page($xml_string)
	{ 
		$xslt_file = XSLT_Catalog::get_template('travel_reservation_confirmation_page_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function order_confirmation_page($xml_string)
	{ //echo "yooo".$xml_string;
		$xslt_file = XSLT_Catalog::get_template('order_confirmation_page_tpl'); 
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function showpersonrecs($xml_string)
	{
		$_params = myedbPager::get_person_xsl_pager_params($xml_string);
		$params["n_pages"] = $_params["n_pages"]; 
		$xslt_file = XSLT_Catalog::get_template('showpersonrecs_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function show_admin_personrecs($xml_string)
	{
	//	$_params = myedbPager::get_person_xsl_pager_params($xml_string);
	//	$params["n_pages"] = $_params["n_pages"]; 
		$xslt_file = XSLT_Catalog::get_template('show_admin_personrecs');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function edit_person($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('person_editor_tpl');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		$params["pswd_prefix"] = AppSettings::$pswd_prefix;
		$params["pswd_chk_prefix"] = AppSettings::$pswd_chk_prefix;
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function produce_paged_public_tpl_output($xml_string)
	{
		$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('paged_public_tpl');

		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function welcome_page($xml_string)
	{ 
		$xml_string = "<empty></empty>";
		$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('welcome_page_tpl');

		XMLProcessor::encap_with_lists($xml_string);

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function admin_paged_content($xml_string)
	{
		$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('paged_admin_tpl');

		XMLProcessor::encap_with_lists($xml_string);

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function public_product_search_results($xml_string)
	{
		$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('public_product_search_results_tpl');

		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function admin_product_search_results($xml_string)
	{
		//echo microtime()." in OutputProcessor::admin_product_search_results<br>";
		$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('admin_product_search_results_tpl');

		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();

		$params["eg_type__featured"] = AppSettings::gv("eg_type__featured");
		$params["NumFeaturedMax"] = AppSettings::gv("NumGroupedItemsType".$params["eg_type__featured"]."Max");
		$params["eg_type__populartrades"] = AppSettings::gv("eg_type__populartrades");
		$params["NumPopularTradesMax"] = AppSettings::gv("NumGroupedItemsType".$params["eg_type__populartrades"]."Max");
		$params["eg_type__tradeoftheday"] = AppSettings::gv("eg_type__tradeoftheday");
		$params["NumTradeOfTheDayMax"] = AppSettings::gv("NumGroupedItemsType".$params["eg_type__tradeoftheday"]."Max");
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function admin_order_history_table($xml_string)
	{
		//$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('admin_order_history_table_tpl');

		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function show_purchasable_product($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('purchasable_product_tpl');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function show_pending_transactions($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('pending_transactions_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	
	}

	function show_travel_item($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('show_travel_item_tpl');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
		
	}

	function show_record_history($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('show_record_history_tpl');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string);
		$xmlprocessor->add_property_list();
		$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	
	}

	function show_login($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('show_login_tpl');
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function show_info_record_for_edit($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('show_info_record_for_edit_tpl');

		$xmlproc = new XMLProcessor();
		$xmlproc->append_child_from_xml($xml_string);
		$xmlproc->add_lookup_table_lists();
/*		$xmlproc->add_category_list();
		$xmlproc->add_subcategory_list();
		$xmlproc->add_type_list();
		$xmlproc->add_status_list();
		$xmlproc->add_city_state_zip_lists();*/
		$xml_string = $xmlproc->doc->saveXML();

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function show_record_for_edit($xml_string)
	{
		//echo "<br>".microtime()."OutputProcessor:entering show_record_for_edit ";
		$xslt_file = XSLT_Catalog::get_template('show_record_for_edit_tpl');
//echo "XSLT FILE: ".$xslt_file."<br>";
		$xmlproc = new XMLProcessor();
		$xmlproc->append_child_from_xml($xml_string);
		$xmlproc->add_lookup_table_lists();
		$xml_string = $xmlproc->doc->saveXML();
		//echo "<br>".microtime()."OutputProcessor:before preprocess_output";
		
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
		//echo "<br>".microtime()."OutputProcessor:after preprocess_output<br>";
	}

	function edit_trade_of_the_day_properties($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('edit_trade_of_the_day_properties');

		$xmlproc = new XMLProcessor();
		$xmlproc->append_child_from_xml($xml_string);
		$xml_string = $xmlproc->doc->saveXML();

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function edit_travel_policy_message($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('edit_travel_policy_message');

		$xmlproc = new XMLProcessor();
		$xmlproc->append_child_from_xml($xml_string);
		$xml_string = $xmlproc->doc->saveXML();

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function edit_site_message($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('edit_site_message');

		$xmlproc = new XMLProcessor();
		$xmlproc->append_child_from_xml($xml_string);
		$xml_string = $xmlproc->doc->saveXML();

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function edit_travel_type($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('edit_travel_type_tpl');
		XMLProcessor::encap_with_lists($xml_string);
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}

	function show_travel_order_history($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('show_travel_order_history');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	
	}

	function show_order_history($xml_string)
	{
		$xmlproc = new XMLProcessor(true);
		//$xmlproc->append_child_from_xml($xml_string);
		$xmlproc->encap_with_lists_non_static();
		$xml_string = $xmlproc->doc->saveXML();
		$xslt_file = XSLT_Catalog::get_template('show_order_history_tpl');
	//	$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
	//	$xmlprocessor->add_city_state_zip_lists();
	//	$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	
	}

	function show_order_details($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('show_order_details_tpl');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	
	}
	
	//outputs to screen
	function preprocess_output($xml_string, $xslt_file, $params)
	{
		//echo microtime()." starting OutputProcessor::preprocess_output<br>";
		//print_r($_SERVER);
		foreach ($_REQUEST as $getkey => $getval)
		{
			if (!in_array($getkey,array_keys($_COOKIE)))
			{
				if (is_array($getval))
				{
					$getval = array_pop($getval);
				}
				$params[$getkey] = $getval;
			}
		}
				
		$logged_in_user = AppEntities_Facade::get_user_instance();
		$logged_in_user_id = $logged_in_user->user_id;
		$logged_in_user_full_name = $logged_in_user->full_name;
		
		if ($_REQUEST['eid'])
		{
			$entity = RecordsSys_EntityManagementSystems::get_entity($_REQUEST['eid']);
			$params['date_last_modified'] = $entity->date_last_modified;
			$params['date_added'] = $entity->date_added;
			$params['user_last_modified'] = $entity->user_last_modified;
			$params['user_added'] = $entity->user_added;
		}
		else
		{
			$params['date_last_modified'] = "";
			$params['date_added'] = "";
			$params['user_last_modified'] = "";
			$params['user_added'] = "";
		}

		$params['php_self'] = $_SERVER['PHP_SELF'];
		$params['httphost'] = $_SERVER['HTTP_HOST'];
		$params['logged_in_user_full_name'] = $logged_in_user_full_name;
		$params['cur_user'] = Output_SecuritySystem::get_user_eid(); 
		$params['auth_level'] = Output_SecuritySystem::get_user_auth_level(); 
		$params['app_root_client'] =  URL_APP_ROOT;
		$params['current_date_time'] = date("F j, Y, g:i a");                 // March 10, 2001, 5:16 pm
		
		//echo microtime()." OutputProcessor::preprocess_output, calling MyEDB_XSLTProcessor::output_template<br>";
		MyEDB_XSLTProcessor::output_template($xml_string, $xslt_file, $params);
		//echo microtime()." ending OutputProcessor::preprocess_output<br>";
	}
	
	function manage_products($xml_string)
	{
		$xml_string = "<empty></empty>";
		$params = myedbPager::get_xsl_pager_params($xml_string);
		$xslt_file = XSLT_Catalog::get_template('manage_products');

		XMLProcessor::encap_with_lists($xml_string);

		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function edit_person_member($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('edit_person_member');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		$params["pswd_prefix"] = AppSettings::$pswd_prefix;
		$params["pswd_chk_prefix"] = AppSettings::$pswd_chk_prefix;
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function reset_password($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('reset_password');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		//$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		$params["pswd_prefix"] = AppSettings::$pswd_prefix;
		$params["pswd_chk_prefix"] = AppSettings::$pswd_chk_prefix;
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function edit_person_admin($xml_string)
	{
		$xslt_file = XSLT_Catalog::get_template('edit_person_admin');
		$xmlprocessor = XMLProcessor::encap_with_lists($xml_string); 
		
		$xmlprocessor->add_city_state_zip_lists();
		$xml_string = $xmlprocessor->doc->saveXML();
		$params["pswd_prefix"] = AppSettings::$pswd_prefix;
		$params["pswd_chk_prefix"] = AppSettings::$pswd_chk_prefix;
		OutputProcessor::preprocess_output($xml_string, $xslt_file, $params);
	}
	
	function hash_to_csv($output_data)
	{
	//	$csv_output =  "\"e\",\"1\",\"3\",\"2\",\"34\"\nf,\"2\",\"3\",\"4\",\"3\"\n";
		
	/*	$list = array (
    'aaa,bbb,ccc,dddd',
    '123,456,789',
    '"aaa","bbb"'
		);
		*/
		$fp = tmpfile();//fopen('file.csv', 'w');
		
	//	foreach ($list as $line) {
	//	    fputcsv($fp, split(',', $line));
	//	}
		foreach ($output_data as $row)
		{
			fputcsv($fp, $row);
		}
		fseek($fp, 0);
			//		echo fread($fp, 1024);
		$contents = '';

		while (!feof($fp)) {
		  $contents .= fread($fp, 8192);
		}

		fclose($fp);
		
		
		header("Content-type: application/vnd.ms-excel");
   			header("Content-disposition: csv; filename=document_" . date("Y-m-d") . ".csv");
   			print $contents;
   			exit;  
		
		
	}
	
	function echo_data($output_data)
	{
		echo $output_data;
	}
}


?>