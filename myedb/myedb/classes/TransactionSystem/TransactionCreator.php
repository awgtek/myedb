<?
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_EntityManagementSystems.php");
//include_once ($_SERVER['DOCUMENT_ROOT']."/classes/TransactionSystem/TransMgmt_SecuritySystem.php");

class TransactionCreator
{

	function create_transaction()
	{
		if ($_REQUEST['groups_to_add_to_transactions'])
		{
			foreach ($_REQUEST['groups_to_add_to_transactions'] as $pgidNridN)
			{
				if (ereg("^pgid([0-9]+)rid([0-9]+)qty([0-9]+)$",$pgidNridN,$subpatterns))
				{
					$eiddst = $_REQUEST['rec_eid'];
					$eidsrc = TransMgmt_SecuritySystem::get_user_eid();
					$prop_group_id = $subpatterns[1];
					$ron = $subpatterns[2];
					$qty = $subpatterns[3];
					$prop_id = 0; //not relevant
					TransMgmt_EntityManagementSystems::create_transaction($eidsrc,$eiddst,$prop_group_id,$prop_id,$ron,$qty);
				}
			}
		}
		
	}


}


?>