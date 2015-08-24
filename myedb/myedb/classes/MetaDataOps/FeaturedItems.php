<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/MetaDataOps_RecordSys.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/GroupedItems.php');


class FeaturedItems extends GroupedItems
{
	function __construct()
	{
		$this->grouping_type = AppSettings::gv("eg_type__featured");
		parent::__construct();
	}



}

?>