<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/RecordsSystem/RecordIniFacade.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmtFacade.php");
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/OutputSystem/OutputOperationsFacade.php');
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmtFacade.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/ClientServerDataOps/ClientServerDataOps.php");

class RequestProcessor
{
	var $xml_string;
	var $xslt_file;
	var $output_function;

	function process_request(&$xml_string, &$xslt_file)
	{ 
		//echo microtime()."RequestProcessor:process_request entering <br>";
		//$this->output_function = "output_template";
	//	echo "<br>RequestProcessor,  searcresrowcount".$_SESSION['search_res_row_cnt'];
		
		//if ()
		
		if ($this->request_exists())
		{
			for ($i = 0; $i < count($_REQUEST['target_component']); $i++)
			{ 
				$target_comp = new $_REQUEST['target_component'][$i];
			//	echo '$i:'.$i." -- ".$_REQUEST['target_function'][$i]."--".$_REQUEST['target_component'][$i];
				$target_comp->$_REQUEST['target_function'][$i]($this->xml_string, $this->xslt_file);
				//$this->xml_string = $target_comp->xml_string;
				//$this->xslt_file = $target_comp->xslt_file;
			//echo microtime()."RequestProcessor:process_request executed: ".$_REQUEST['target_component'][$i]." - ". $_REQUEST['target_function'][$i]."<br>";
			}
			if ($_REQUEST['output_function'])
			{
				$this->output_function = $_REQUEST['output_function']; //deprecated, ignored in case of OutputFunctionpassthru
			}
			else if ($_REQUEST['OF_passthru'])
			{
				$this->output_function = $_REQUEST['OF_passthru']; //deprecated, ignored in case of OutputFunctionpassthru
			}
			else
			{
				die ("No output function specified");
			} //echo $this->output_function."<br>";
		}
		else
		{ //This PLACE NEVER REACHED, REQUEST VARIABLES ARE SET IN MAIN!!
			$this->test2();
			//$this->testtransactions();
		}
		$xml_string = $this->xml_string;
		$xslt_file = $this->xslt_file;
		//echo microtime()."RequestProcessor:process_request returning <br>";
		return $this->output_function;
	}
	
	function request_exists()
	{
		if (empty($_REQUEST['target_component']))
		{ 
			$this->homepage();
		}
		return !empty($_REQUEST['target_component']);
	}

	function test1()
	{
/*		if (!empty($_POST)):
			print_r($_POST);
			if ($_REQUEST['target_component'] == "Records")
			{
				$rec = new Record($_POST['rec_eid'],1);
				$rec->update_record();
			}
		endif;
*/
		//$rec = new Record(5,1);
	//	$rec->glu->prop_ids_num_extra[6] = 1;
	//	$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		//$rec->glu->set_prop_ids_num_extra_by_group_id(1);
		$_REQUEST['eid'] = 4;
		$_REQUEST['type_id'] = 1;
		RecordIniFacade::initialize($this->xml_string, $this->xslt_file);
		
		//OutputOperationsFacade::output_template($xml_string, $xslt_file);
	//	$xml = $rec->create_xml_rec();	
	//	return $xml;
	

	}

	function test2()
	{
		$_REQUEST['eids'] = array(4,5,6);
		$_REQUEST['type_id'] = 1;
		RecordIniFacade::initializeRecordSet($this->xml_string);
		$this->output_function = "output_paged_templated_content";
	//	OutputOperationsFacade::paginateXML($this->xml_string, $this->xslt_file);

	}

	function testtransactions()
	{
		TransMgmtFacade::get_pending_transactions($this->xml_string, $this->xslt_file);
		$this->output_function = "show_pending_transactions";
	}


}

?>