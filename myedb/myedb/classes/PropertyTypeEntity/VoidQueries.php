<?php
//include_once (dirname(__FILE__) .'/../PropertyTypeEntity/UpdaterSprocsContainer.php');

class VoidQueries
{ 
	function finalize_order($eid, $details_xml)
	{
		UpdaterSprocsContainer::finalize_order($eid, $details_xml);
	}

	static function update_repeat_prop_qualifier($eid, $prop_group_id, $prop_id, $ron, $prop_qual_id)
	{
		UpdaterSprocsContainer::update_repeat_prop_qualifier($eid, $prop_group_id, $prop_id, $ron, $prop_qual_id);
	}
	
	static function delete_eid($eid)
	{
		UpdaterSprocsContainer::delete_eid($eid);
	}
	
	static function del_prop_group_by_ron($type_id, $prop_group_id, $ron, $eid)
	{
		UpdaterSprocsContainer::del_prop_group_by_ron($type_id, $prop_group_id, $ron, $eid);
	}

	static function del_prop_by_ron($prop_id, $ron, $eid)
	{
		UpdaterSprocsContainer::del_prop_by_ron($prop_id, $ron, $eid);
	}
	
	static function create_transaction($eidsrc,$eiddst,$prop_group_id,$prop_id,$ron,$qty)
	{
		UpdaterSprocsContainer::create_transaction($eidsrc,$eiddst,$prop_group_id,$prop_id,$ron,$qty);
	}
	
	static function create_standalone_order($details_xml,$eidsrc,$eiddst,$type_id)
	{
		UpdaterSprocsContainer::create_standalone_order($details_xml, $eidsrc,$eiddst,$type_id);
	}
	
	static function delete_transaction($trans_id)
	{
		UpdaterSprocsContainer::delete_transaction($trans_id);
	}

}

?>