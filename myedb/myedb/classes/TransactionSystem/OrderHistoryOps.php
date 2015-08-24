<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/AppLibrary/MyEDB_Pager.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/medb_order_DS.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransXMLElement.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/OrderInfoNode.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TravelRequestInfoNode.php");

class OrderHistoryOps
{
	//not used
	function create_product_order_history_page_xml()
	{
		$myedbsess = new MyEDB_SESSION();
		
		$limit_clause = MyEDB_Pager::get_sql_limit_clause();
		$table = "medb_order inner join medb_order_eiddst using (order_id)";
		$select_fields = "DISTINCT medb_order.*";
		$order_ds = new medb_order_DS($table, $select_fields);
		$order_ds->where_clause = "WHERE submitted = 1 AND  medb_order_eiddst.eiddst = ".$_REQUEST['eid'];
		$order_ds->limit_clause = $limit_clause;
		//$_SESSION['search_res_row_cnt'] = $order_ds->get_total_recs_count(); 
		$myedbsess->search_res_row_cnt = $order_ds->get_total_recs_count(); 
		$encap_element = "medb_order_elem";
		return $order_ds->get_order_history_xml_dataset($encap_element);
	}

	function create_order_history_page_xml()
	{
		$myedbsess = new MyEDB_SESSION();
		
		$obj_DS = "";
		if ($_REQUEST['type_id'])
		{ 
			$table = "medb_order natural 
join medb_order_eiddst 
left join view_varchar_prop_to_e_p_to_e act on 
(act.eid = medb_order_eiddst.eiddst and act.prop_id = 33) 
left join view_varchar_prop_to_e_p_to_e ref on 
(ref.eid = medb_order_eiddst.eiddst and ref.prop_id = 57) ";
			if (!is_numeric($_REQUEST['type_id'])) die ("type_id must be int! Security alert!");
			$where_clause = "WHERE submitted = 1 AND (medb_order_eiddst.type_id = {$_REQUEST['type_id']})";
			$obj_DS = "travel_order_DS";
		}
		else 
		{
		/*	$table = "medb_order natural 
left join medb_order_eiddst 
left join view_varchar_prop_to_e_p_to_e act on 
(act.eid = medb_order_eiddst.eiddst and act.prop_id = 33) 
left join view_varchar_prop_to_e_p_to_e ref on 
(ref.eid = medb_order_eiddst.eiddst and ref.prop_id = 57) ";
			$where_clause = "WHERE submitted = 1 AND (medb_order_eiddst.type_id <> 4 or 
				medb_order_eiddst.type_id is null)";*/ //travel type = 4
			$table = "order_history_cache";
			$where_clause = "";
			$obj_DS = "medb_order_DS";
		}
		if (isset($_REQUEST['eid']))
		{
			$where_clause .= " AND  medb_order_eiddst.eiddst = ".sanitize($_REQUEST['eid']);
		}
		$limit_clause = MyEDB_Pager::get_sql_limit_clause();
		//$table = "medb_order natural left join medb_order_eiddst";
		$select_fields = "medb_order.*,act.varchar_val as acct_no, ref.varchar_val as ref_no, medb_order_eiddst.eiddst ";
		$order_ds = new $obj_DS($table, $select_fields);
	//	$order_ds->select_clause = "SELECT DISTINCT"; 
		$order_ds->distinct_field = "order_id";
		$order_ds->where_clause = $where_clause;
		$order_ds->limit_clause = $limit_clause;
		$order_ds->limit_offset = MyEDB_Pager::get_sql_limit_offset();
		$order_ds->limit_rows = MyEDB_Pager::get_sql_limit_rows();
		$order_by = sanitize($_REQUEST["o"]);
		$order_direction = sanitize($_REQUEST['od']);
		$order_ds->order_by_field = $order_by;
		$order_ds->order_by_direction = $order_direction;
		$order_by_clause = "order by $order_by $order_direction";
		$order_ds->order_by = $order_by_clause;
		//$_SESSION['search_res_row_cnt'] = $order_ds->get_total_recs_count(); //echo "recs count".$order_ds->get_total_recs_count()."--";
		$myedbsess->search_res_row_cnt = $order_ds->get_total_recs_count(); 
		$encap_element = "medb_order_elem";
		return $order_ds->get_order_history_xml_dataset($encap_element);
	}

	function create_order_details_page_xml()
	{
		$order_ds = new medb_order_DS("medb_order");
		$order_ds->where_clause = "WHERE order_id = ".$_REQUEST['order_id'];
		$encap_element = "medb_order_elem";
		
		$tri_node = new TravelRequestInfoNode();
		$oi_node = new OrderInfoNode();
		
		$trans_xml_element_hash = array($tri_node->encap_elem=>$tri_node,$oi_node->encap_elem=>$oi_node);
		return $order_ds->get_order_details_xml($encap_element,$trans_xml_element_hash);
	}


}


?>