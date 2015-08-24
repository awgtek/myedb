<?


class XSLT_Catalog
{
	var $_catalog = array();
	
	function XSLT_Catalog()
	{
		$this->_catalog['search_member_user_results'] = APP_ROOT."/XSLTemplates/AdminTemplates/SearchResults/search_member_user_results.xsl";
		$this->_catalog['search_admin_user_results'] = APP_ROOT."/XSLTemplates/AdminTemplates/SearchResults/search_admin_user_results.xsl";
		$this->_catalog['output_msg'] = APP_ROOT."/XSLTemplates/include/page_parts/output_msg.xsl";
		$this->_catalog['travel_order_rec_for_DS'] = APP_ROOT."/XSLTemplates/XMLTransforms/travel_order_rec_for_DS.xsl";
		$this->_catalog['print_order_invoice'] = APP_ROOT."/XSLTemplates/AdminTemplates/OrderItems/print_order_invoice.xsl";
		$this->_catalog['print_travel_request'] = APP_ROOT."/XSLTemplates/AdminTemplates/OrderItems/print_travel_request.xsl";
		$this->_catalog['edit_entity_groupings'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_entity_groupings.xsl";
		$this->_catalog['subcat_select'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/SubFrames/subcat_select.xsl";
		$this->_catalog['subcat_edit_search_results'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/SearchResults/subcat_edit_search_results.xsl";
		$this->_catalog['sublookuptable_editor_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/sublookuptable_editor.xsl";
		$this->_catalog['show_record_history_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/show_record_history.xsl";
		$this->_catalog['show_order_history_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/OrderHistory/show_order_history.xsl";
		$this->_catalog['show_order_history_travel'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/OrderHistory/show_order_history_travel.xsl";
		$this->_catalog['show_travel_order_history'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/show_travel_order_history.xsl";
		$this->_catalog['show_order_details_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/show_order_details.xsl";
		$this->_catalog['checkout_cart_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/TransactionTemplates/checkout_cart.xsl";
		$this->_catalog['purchasable_product_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/show_purchasable_product.xsl";
		$this->_catalog['edit_trade_of_the_day_properties'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_trade_of_the_day_properties.xsl";
		$this->_catalog['edit_site_message'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_site_message.xsl";
		$this->_catalog['edit_travel_policy_message'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_travel_policy_message.xsl";
		$this->_catalog['show_record_for_edit_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/RecordEditor.xsl";
		$this->_catalog['show_info_record_for_edit_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/RecordEditor_info.xsl";
		$this->_catalog['person_editor_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/PersonEditor.xsl";
		$this->_catalog['edit_person_admin'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_person_admin.xsl";
		$this->_catalog['approve_member_registration'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/approve_member_registration.xsl";
		$this->_catalog['edit_person_member'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_person_member.xsl";
		$this->_catalog['public_welcome_page'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/public_welcome_page.xsl";
		$this->_catalog['barter_loop'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/barter_loop.xsl";
		$this->_catalog['barter_loop1'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/barter_loop1.xsl";
		$this->_catalog['barter_loop2'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/barter_loop2.xsl";
		$this->_catalog['barter_loop3'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/barter_loop3.xsl";
		$this->_catalog['paged_public_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/paged_public.xsl";
		$this->_catalog['show_travel_item_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/show_travel_item.xsl";
		$this->_catalog['paged_admin_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/showrecs.xsl";
		$this->_catalog['welcome_page_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/welcome_page.xsl";
		$this->_catalog['showpersonrecs_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/showpersonrecs.xsl";
		$this->_catalog['show_admin_personrecs'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/show_admin_personrecs.xsl";
		$this->_catalog['show_member_personrecs'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/show_member_personrecs.xsl";
		$this->_catalog['pending_transactions_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/TransactionTemplates/pending_transactions.xsl";
		$this->_catalog['show_login_tpl'] = dirname(__FILE__)."/../../XSLTemplates/SecurityTemplates/login.xsl";
		$this->_catalog['request_new_password'] = dirname(__FILE__)."/../../XSLTemplates/SecurityTemplates/request_new_password.xsl";
		$this->_catalog['reset_password'] = dirname(__FILE__)."/../../XSLTemplates/SecurityTemplates/reset_password.xsl";
		$this->_catalog['lookuptable_editor_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/lookuptable_editor.xsl";
		$this->_catalog['edit_travel_type_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_travel_type.xsl";
		$this->_catalog['user_reservation_page_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/TransactionTemplates/user_reservation_page.xsl";
		$this->_catalog['user_reservation_travel_policy'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/TransactionTemplates/user_reservation_travel_policy.xsl";
		$this->_catalog['confirm_travel_reservation_page_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/TransactionTemplates/confirm_travel_reservation_page.xsl";
		$this->_catalog['travel_reservation_confirmation_page_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/TransactionTemplates/travel_reservation_confirmation_page.xsl";
		$this->_catalog['order_confirmation_page_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/TransactionTemplates/order_confirmation_page.xsl";
		$this->_catalog['admin_product_search_results_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/admin_product_search_results.xsl";
		$this->_catalog['public_product_search_results_tpl'] = dirname(__FILE__)."/../../XSLTemplates/PublicViewTemplates/public_product_search_results.xsl";
		$this->_catalog['admin_order_history_table_tpl'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/OrderHistory/order_history_table.xsl";
		$this->_catalog['order_history_table_travel'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/OrderHistory/order_history_table_travel.xsl";
		$this->_catalog['manage_products'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/manage_products.xsl";
		$this->_catalog['edit_site_variables'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_site_variables.xsl";
		$this->_catalog['edit_site_email_entities'] = dirname(__FILE__)."/../../XSLTemplates/AdminTemplates/edit_site_email_entities.xsl";
	}

	function get_template($template_name)
	{
		$xslt_cat = new XSLT_Catalog;
		return $xslt_cat->_catalog[$template_name];
	}

//	function get_paged_public_tpl()
//	{
//		return $_SERVER['DOCUMENT_ROOT']."/XSLTemplates/testrecs.xsl";
//	}

}

?>