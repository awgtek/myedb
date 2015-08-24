<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/MyEDB_XSLTProcessor.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/myedbPager.php');
//include_once (dirname(__FILE__) .'/../OutputSystem/ssc_OutputProcessor.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/ClientServerDataOps/ClientServerDataOps.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/MetaDataOps.php');

class ssc_OutputOperationsFacadeOld
{

	function output_function_passthru($xml_string, $output_function_passthru)
	{
		$op = new ssc_OutputProcessor();
		$op->$output_function_passthru($xml_string);
	}
    
	function edit_person($xml_string)
	{
		ssc_OutputProcessor::edit_person($xml_string);
	}

	function show_record_for_edit($xml_string)
	{
		ssc_OutputProcessor::show_record_for_edit($xml_string);
	}

	function output_template($xml_string, $xslt_file)//get rid
	{
		MyEDB_XSLTProcessor::output_template($xml_string, $xslt_file);
	}

	function output_paged_templated_content($xml_string, $xslt_file)
	{
		ssc_OutputProcessor::produce_paged_public_tpl_output($xml_string);
	}

	function admin_paged_content($xml_string)
	{
		ssc_OutputProcessor::admin_paged_content($xml_string);
	}

	function show_purchasable_product($xml_string, $xslt_file)
	{
		ssc_OutputProcessor::show_purchasable_product($xml_string);
	}

	function output_person_links($xml_string, $xslt_file)
	{
		$params = myedbPager::get_person_xsl_pager_params($xml_string);
		echo $params["page_links"];
	}

	function output_html($xml_string, $xslt_file)
	{
		$params = myedbPager::get_xsl_pager_params($xml_string);
		echo "&nbsp;&nbsp;&nbsp;&nbsp;Results ".$params["from_row"]." to ".$params["to_row"]." out of ".$params["total_rows"].
		"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;".$params["page_links"];
	}

	function output_process_result($xml_string)
	{
		echo $_SESSION['process_result'];
	}

	function show_pending_transactions($xml_string, $xslt_file)
	{
		ssc_OutputProcessor::show_pending_transactions($xml_string);
	}

	function show_login($xml_string)
	{
		ssc_OutputProcessor::show_login($xml_string);
	}

	function max_grouped_items_reached($xml_string)
	{
		$mdo = new MetaDataOps;
		echo $mdo->GroupedItems_max_reached();
	}
	
	function do_nothing($xml_string)
	{
		echo "Done!"; //print_r($_REQUEST);
	}
}

?>