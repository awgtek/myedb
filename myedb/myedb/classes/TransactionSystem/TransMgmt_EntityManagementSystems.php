<?
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/VoidQueries.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/MixedQueries.php');
//include_once ($_SERVER['DOCUMENT_ROOT'].'/classes/PropertyTypeEntity/medb_order.php');


class TransMgmt_EntityManagementSystems
{
	static 	function update_medb_order_res_field_name_value($order_id, $res_field_name, $new_value)
	{
		$medb_order = new medb_order($order_id);
		return $medb_order->update_medb_order_res_field_name_value($res_field_name, $new_value);
		
	}
	
	static function set_approved_value($order_id, $_value)
	{
		$medb_order = new medb_order($order_id);
		return $medb_order->set_approved_value($_value);
	}

	function finalize_order($eid, $details_xml)
	{	
		VoidQueries::finalize_order($eid, $details_xml);
	}

	static function create_transaction($eidsrc,$eiddst,$prop_group_id,$prop_id,$ron,$qty)
	{
		VoidQueries::create_transaction($eidsrc,$eiddst,$prop_group_id,$prop_id,$ron,$qty);
	}

	static function create_standalone_order($details_xml,$eidsrc,$eiddst,$type_id)
	{
		VoidQueries::create_standalone_order($details_xml,$eidsrc,$eiddst,$type_id);
	}

	static function get_unrealized_transactions_by_eidsrc($eidsrc)
	{
		return MixedQueries::get_unrealized_transactions_by_eidsrc($eidsrc);
	}
	
	static function delete_transaction($trans_id)
	{
		VoidQueries::delete_transaction($trans_id);
	}

}

?>