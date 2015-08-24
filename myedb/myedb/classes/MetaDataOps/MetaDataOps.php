<?
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/FeaturedItems.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/PopularTrades.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/TradeOfTheDay.php');
//include_once($_SERVER['DOCUMENT_ROOT'].'/classes/MetaDataOps/GroupedItems.php');

class MetaDataOps
{
	function GroupedItems_add_entity()
	{
		$eid = $_REQUEST['eid'];
		$grptype = $_REQUEST['grptype']; 
		$fi = new $grptype();
		$fi->add_entity($eid);
	}
	
	function GroupedItems_remove_entity()
	{
		$eid = $_REQUEST['eid'];
		$grptype = $_REQUEST['grptype'];
		if (!is_array($eid))
		{
			$eid = array($eid);
		}
		foreach($eid as $_eid)
		{
			$fi = new $grptype();
			$fi->remove_entity($_eid);
		}
	}
	
	function GroupedItems_remove_entity_by_id()
	{
		$eg_ids = $_REQUEST['eg_id'];
		foreach($eg_ids as $eg_id)
		{
			GroupedItems::remove_entity_by_id($eg_id);
		}
	}

	function GroupedItems_max_reached()
	{
		$grptype = $_REQUEST['grptype'];
		$fi = new $grptype();
		return $fi->maximum_reached();
	}

	function FI_get_xml_list(&$xml_string)
	{
		$fi = new GroupedItems;
		$xml_string = $fi->get_xml_list();
	}

}



?>