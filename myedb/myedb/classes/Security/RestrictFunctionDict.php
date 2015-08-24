<?php

class RestrictFunctionDict
{

	function get_output_function_auth_level($output_function_name)
	{
		$outfunchash = array();
		$outfunchash["admin_paged_content"] = 1;
		$outfunchash["edit_person"] = 4;
		$outfunchash["show_record_for_edit"] = 1;
		$outfunchash["output_person_links"] = 4;
		$outfunchash["sublookuptable_editor"] = 4;
		$outfunchash["lookuptable_editor"] = 4;
		$outfunchash["showpersonrecs"] = 4;
		$outfunchash["show_admin_personrecs"] = 4;
		$outfunchash["admin_product_search_results"] = 1;
		$outfunchash["admin_order_history_table"] = 1;
		$outfunchash["show_record_history"] = 1;
		$outfunchash["show_order_history"] = 1;
		$outfunchash["show_order_details"] = 1;
		$outfunchash["edit_person_admin"] = 4;
		$outfunchash["edit_entity_groupings"] = 4;
		$outfunchash["show_info_record_for_edit"] = 1;
		$outfunchash["manage_products"] = 1;
		if (array_key_exists($output_function_name,$outfunchash))
		{
			$retval = $outfunchash[$output_function_name];
		}
		else
		{
			$reval = false;
		}
		return $retval;
	}



}


?>