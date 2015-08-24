<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/MetaDataOps_RecordSys.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/GroupedItems.php');


class PopularTrades extends GroupedItems
{
	function __construct()
	{
		$this->grouping_type = AppSettings::gv("eg_type__populartrades");
		parent::__construct();
	}



}

?>