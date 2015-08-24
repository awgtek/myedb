<?php
//include_once (dirname(__FILE__) .'/../MainClient/AppConfig.php');
//include_once (dirname(__FILE__) .'/../AppLibrary/MyEDB_Pager.php');
//include_once(dirname(__FILE__) .'/../ClientServerDataOps/ClientServerDataOps.php');
//include_once(dirname(__FILE__) .'/../../functions/commonfunc.php');


class RecordSearcher
{
	//note: request variables must contain both cspi and spi even if empty in order to reset possible prior session's values
	function filtered_search_by_mixed_criteria($apply_page_filter = true)
	{
		$myedbsess = new MyEDB_SESSION();
		$ret_val = 0;
		$this->persist_search_values(); //echo "here".microtime();
		//	echo "<br> session variabl: ".print_r($_SESSION,true);
		//	echo "<br> request variabl: ".print_r($_REQUEST,true);
			if (!isset($_REQUEST['init_post'])) // when POSTing, only do persisting of values, actual query done when called by ajax
		{
			//echo "<br> session variabl: ".print_r($_SESSION,true);
			$ctns_prop_ids = $myedbsess->cspi; //$_SESSION['cspi'];
			$ctns_prop_vals = $myedbsess->cspv; //$_SESSION['cspv'];
			$ctns_prop_types = $myedbsess->cspt; //$_SESSION['cspt'];
			$ctns_prop_vals_exact_match = $myedbsess->cspve; //$_SESSION['cspve'];
			$ctns_prop_vals_inverse_match = $myedbsess->cspvi; //$_SESSION['cspvi'];
			$prop_ids = $myedbsess->spi; //$_SESSION['spi'];
			$prop_vals = $myedbsess->spv; //$_SESSION['spv'];
			$prop_comps = $myedbsess->spc; //$_SESSION['spc'];
			$type_id = $myedbsess->type_id; //$_SESSION['type_id']; //deprecated. Use 'spt' to match type for product id
			$type_ids = $myedbsess->spt; //$_SESSION['spt'];
			$group_nums = $myedbsess->spg; //$_SESSION['spg'];//see leftnavmember.xsl for explanation
			$sort_prop_ids = $myedbsess->srtpi; //$_SESSION['srtpi'];
			//echo "ctns_prop_vals: '".$ctns_prop_vals."'".print_r($ctns_prop_vals,true);
			/*print_r(array($ctns_prop_ids,$ctns_prop_vals,$ctns_prop_vals_exact_match,$ctns_prop_vals_inverse_match,
			$prop_ids,
					$prop_vals,$type_id,$sort_prop_ids, $prop_comps, $type_ids, $group_nums,
					$ctns_prop_types));*/
					
			$eids = RecordSearcher::search_and_gather_eids($ctns_prop_ids,$ctns_prop_vals,$ctns_prop_vals_exact_match,$ctns_prop_vals_inverse_match,
			$prop_ids,
					$prop_vals,$type_id,$sort_prop_ids, $prop_comps, $type_ids, $group_nums,$ctns_prop_types);
			$_REQUEST["total_search_results"] = count($eids);
		//	echo "eids before apply_page_filter: ".print_r($eids,true);
			if ($apply_page_filter)
			{ 
			//	echo "<br>in apply_pge_fitler";
				$eids = RecordSearcher::apply_page_filter($eids);
			} 
			$ret_val = $eids;  
			//echo "eids after apply_page_filter: ".print_r($eids, true); //echo $apply_page_filter."|d";
		} 
		return $ret_val;
	}
	
	function persist_search_values()
	{ //echo "REQUEST VARIABLE: ".print_r($_REQUEST,true)."end of request variable<br>";
		$myedbsess = new MyEDB_SESSION();
		$persisted_paged_search_keys = AppConfig::get_app_config_var('persisted_paged_search_keys');
		foreach($persisted_paged_search_keys as $key => $val)
		{ //echo "key: $key, value: $val";
			if (is_numeric($key))
			{
				$session_key = $val;
			}
			else
			{
				$session_key = $key;
			//	if ($val == "remove_when_absent" &&
			//			isset($_REQUEST["cspve_input"]) //is an initial full form post not an ajax post
			//									)
			//	{ //echo "AAAAAAA".$key."aa<br>";
			//		unset($_SESSION[$session_key]);
			//	}
			}
			//now we're just going to always remove regardless of "remove_when_absent" is set
			if (isset($_REQUEST["cspve_input"]) || $_REQUEST['init_req'])//is an initial full form post not an ajax post
			{
				//echo "unsetting $session_key <br>";
				//unset($_SESSION[$session_key]);
				unset ($myedbsess->$session_key);
			}
			if (isset($_REQUEST[$session_key]))
			{//echo $session_key." --". print_r( $_REQUEST[$session_key],true)."<br>";
				//$_SESSION[$session_key] = sanitize($_REQUEST[$session_key]);
				$myedbsess->$session_key = sanitize($_REQUEST[$session_key]);
			//	echo "session key: ".print_r($_SESSION[$session_key],true)."<br>";
			}
			else
			{
				//if (isset($_SESSION[$session_key]))
				if (isset($myedbsess->$session_key))
				{
					//$_REQUEST[$session_key] = $_SESSION[$session_key];
					$_REQUEST[$session_key] = $myedbsess->$session_key;
				}
			/*	else
				{
					$_REQUEST[$session_key] = "";
				}*/
			}
		}
		//echo "<br>RecordSearcher persist_search_values,  searcresrowcount".$_SESSION['search_res_row_cnt'];
		
	//	print_r($_SESSION);
	}

	function search_and_gather_eids($ctns_prop_ids,$ctns_prop_vals,$ctns_prop_vals_exact_match,$ctns_prop_vals_inverse_match,
		$prop_ids,$prop_vals,
				$type_id,$sort_prop_ids, $prop_comps, $type_ids, $group_nums,$ctns_prop_types)
	{
		//print_r(func_get_args());
		//$debug_time = "";
		$fin_eids = array();
		$filt_eids = null;
		$all_filts_any = true;
		//$debug_time .= microtime().'entering search_and_gather_eids<br>'; 
		
		//filter by set
		//Currently assumes ORing of match properties, need to do as below for text search!
		for ($i = 0; $i < count($prop_ids); $i++)
		{//echo '-- $search_prop_id'.$prop_ids[$i]." searchpropval: ".$prop_vals[$i]." , typeid: ".$type_id;
			$search_prop_val = $prop_vals[$i];
			$search_prop_id = $prop_ids[$i];
			$search_prop_comp = $prop_comps[$i]; //note: if using comparison function, must include spc[] post variable for all prop_ids
			$group_num = $group_nums[$i];
			if (count($type_ids) > 0)
			{
				$_type_id = $type_ids[$i];
			}
			else
			{
				$_type_id = $type_id;
			}
			if ($search_prop_val == 0 && strlen($search_prop_comp) == 0) //set spc[] on client form to "" to skip if search val is 0
			{ //echo '<br>$search_prop_val:'.$search_prop_val;
				continue;
			}
	//		elseif ($search_prop_val == 0) //e.g. "any category" selected
	//			continue;
			else
				$all_filts_any = false;
		//	$eids = RecordsSys_EntityManagementSystems::get_eids_by_prop_contains_search($search_prop_val, $search_prop_id, $type_id);
			if (strlen($search_prop_val) == 0)
			{
				$eids = RecordsSys_EntityManagementSystems::get_eids_by_prop_contains_search($search_prop_val, $search_prop_id, $_type_id);
			}
			else
			{
				$eids = RecordsSys_EntityManagementSystems::get_eids($search_prop_val, $search_prop_id, $_type_id, $search_prop_comp);
			}
			$arr2 = array();
			foreach ($eids as $eid)
			{
				array_push($arr2,$eid);
			}	
			if ($group_num) //OR (union) it
			{
				if (!isset($filt_eids))
				{
					$filt_eids = $arr2;
				}
				else
				{
					$filt_eids = array_unique(array_merge($filt_eids, $arr2));
				}
			}
			else //AND (intersect) it
			{
				if (!isset($filt_eids))
				{
			//echo "search_prop_val: ".$search_prop_val." -- search_prop_id: " . $search_prop_id." filt_eids: " . print_r($filt_eids,true).", arr2: " . print_r($arr2, true)."<br>";
					$filt_eids = $arr2;
				}
				else //intersect
				{
					$filt_eids = array_intersect($filt_eids, $arr2);
				}
			}
		}
		//echo "<br>all filters any? ".$all_filts_any." or the filteids:". print_r($filt_eids,true);
		//intersect with Contains search
		//echo count($ctns_prop_ids)."yo".print_r($ctns_prop_ids,true);
		if (empty($ctns_prop_ids) or count($ctns_prop_ids)==0) //request variable may be cspi or cspi[] respectively
		{
	//	echo '<br>;starting contains search. $all_filts_any: '.$all_filts_any.', $ctns_prop_ids: '.print_r($ctns_prop_ids,true);
	//			.'; count($cnts_prop_ids)'.count($ctns_prop_ids);
			$fin_eids = $filt_eids;
			//	echo 'n4ello'.print_r($fin_eids,true);
		}
		else
		{
				//$debug_time .= microtime().' starting contains filter'.print_r($fin_eids,true)."<br>";
			for ($i = 0; $i < count($ctns_prop_ids); $i++)
			{ 
				$search_prop_val = (count($ctns_prop_vals) > 1)? $ctns_prop_vals[$i] : $ctns_prop_vals[0];
				$search_prop_val_exact_match = (count($ctns_prop_vals_exact_match) > 1)? $ctns_prop_vals_exact_match[$i] : $ctns_prop_vals_exact_match[0];
					//not sure if this will work with more than one ctnse, need to test
				$search_prop_val_inverse_match = (count($ctns_prop_vals_inverse_match) > 1)? $ctns_prop_vals_inverse_match[$i] : $ctns_prop_vals_inverse_match[0];
					//not sure if this will work with more than one ctnse, need to test
				//echo "heeeelo".$search_prop_val_exact_match."end";
				$search_prop_val = trim($search_prop_val);
				$search_prop_id = $ctns_prop_ids[$i];
				$ctns_prop_type = empty($ctns_prop_types[$i])? $type_id : $ctns_prop_types[$i];
				//echo " <br>the ctns_prop_types[i]: ".$ctns_prop_types[$i];
					//echo "<br>SEARCH COUNT for $search_prop_val :". count($eids)."<br>";
				if ($search_prop_id == "by_eid")
				{
					$eids = (empty($search_prop_val))? array() : array($search_prop_val);
				}
				elseif ($search_prop_val_exact_match)
				{ //echo "BLOWBLOWBLOWBLWO".$search_prop_val_exact_match;
					//$eids = RecordsSys_EntityManagementSystems::get_eids_by_prop_contains_search($search_prop_val, $search_prop_id, $type_id);
					$eids = RecordsSys_EntityManagementSystems::get_eids($search_prop_val, $search_prop_id, $_type_id, $search_prop_comp);
				}
				else
				{
					//echo "<br>IN CONTAINS SEARCH!!$search_prop_val, $search_prop_id, $ctns_prop_type<BR>".empty($search_prop_val)."yo";
					$eids = RecordsSys_EntityManagementSystems::get_eids_by_prop_contains_search($search_prop_val, $search_prop_id, $ctns_prop_type);
					//echo "<BR>result eids: ".print_r($eids,true);
				}
				if ($search_prop_val_inverse_match)
				{
					$data_type = "varchar";
					if ($ctns_prop_type == 3)
					{
						$type_category = "user";
					}
					else
					{
						$type_category = "product";
					} 
					//echo $ctns_prop_type."type? ".$type_id;
					$all_product_eids = RecordsSys_EntityManagementSystems::get_all_eids_by_type_category_and_datatype($data_type, $type_category, $ctns_prop_type);
					$eids = array_diff($all_product_eids, $eids);
				}
				//echo "<br>HERE variables: eid: $eid, fin_eids: ".print_r($fin_eids,true).", filt_eids: ".print_r($filt_eids,true)." all_filts_any: $all_filts_any, ";
				foreach ($eids as $eid)
				{ 
					if (!in_array($eid,$fin_eids) && ($all_filts_any || in_array($eid, $filt_eids)))
					{//echo "<br>pusing eid: ".$eid;
						array_push($fin_eids,$eid);
					}
				}	
			}
		}
		//echo "<BR>COUNT OF FINEIDS:".count($fin_eids)."<br>";
		//$debug_time .= microtime().' starting sort'."<br>";
		//Currently assumes only 1 property to sort by
		if ($sort_prop_ids[0] == 0)
		{
			$sort_prop_ids[0] = 1; //customer wants sort by name by default
		}
		if ($sort_prop_ids[0] != 0 && count($fin_eids) > 0)
		{
			//get prop values for final eid set; do asort
			$sorted_eids = array();
			$desc = 0; //NOTE: sorting also takes place below for lookuptable values
			$eidsvalshash = RecordsSys_EntityManagementSystems::get_eids_values_hash($fin_eids, $sort_prop_ids[0], $type_id, $desc);//can't do page offset/limit filter here because there may be duplicate eids
			
			$prop_id = $sort_prop_ids[0];
			if (ClientServerDataOps::has_lookup_table($prop_id)) //replace integer value with value from lookuptable
			{
				foreach($eidsvalshash as $eid => $val)
				{
					$newval = ClientServerDataOps::get_value_by_id($val, $prop_id);
					$eidsvalshash[$eid] = $newval;
				}
				asort($eidsvalshash);
			}
			
			foreach($eidsvalshash as $eid => $val)
			{
				if (!in_array($eid,$sorted_eids))
				{
					array_push($sorted_eids,$eid);
				}
			}
			//any for which entity doesn't have set property, on which this function sorts -- means no match goes after all the matches 
			foreach ($fin_eids as $eid)
			{
				if (!in_array($eid,$sorted_eids))
				{
					array_push($sorted_eids,$eid);
				}
			}
			
			$fin_eids = $sorted_eids;
		}
		//$debug_time .= microtime().' end of search and gather eids'.print_r($fin_eids,true)."<br>";
		
		//echo $debug_time;
		//echo 'hello'.print_r($fin_eids,true);
		return $fin_eids;
	}
	
	function apply_page_filter($eids)
	{
	//echo "<br>RecordSearcher: in apply_page_filter func";
		$res = MyEDB_Pager::apply_page_filter($eids);
	//	echo "<br>RecordSearcher: after calling Myedb pager apply_page_filter, result:".$res;
		return $res;
	}




}




?>