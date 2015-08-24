<?
function __autoload($Class) {
	include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/dbops.php');
	include_once($_SERVER['DOCUMENT_ROOT'].'/classes/AppLibrary/AppSettings.php');
}

class EntityGrouping
{
	var $grouping_type;

	function __construct($grouping_type)
	{
		$this->grouping_type = $grouping_type;
	}

	function add_entity($eid)
	{
		$dbh = dbops::getpdo();
		$stmt = $dbh->prepare("INSERT INTO entity_grouping (eg_type, eid) VALUES (:eg_type, :eid)");
		$stmt->bindParam(":eg_type",$this->grouping_type);
		$stmt->bindParam(":eid",$eid);//echo $grptype."Yii".$this->grouping_type."--".$eid."--";
		$stmt->execute() or die("an error occurred: EntityGrouping,83kjfsl8890");
	}
	
	function remove_entity($eid)
	{
		$dbh = dbops::getpdo();
		$stmt = $dbh->prepare("DELETE FROM entity_grouping WHERE eid=:eid AND eg_type=:eg_type");
		$stmt->bindParam(":eid",$eid);
		$stmt->bindParam(":eg_type",$this->grouping_type);
		$stmt->execute() or die("an error occurred: EntityGrouping,8165730");
	}
	
	static function remove_entity_by_id($eg_id)
	{
		$dbh = dbops::getpdo();
		$stmt = $dbh->prepare("DELETE FROM entity_grouping WHERE eg_id=:eg_id");
		$stmt->bindParam(":eg_id",$eg_id);
		$stmt->execute() or die("an error occurred: EntityGrouping,8952165730");
	}

	function max_reached()
	{
		$dbh = dbops::getpdo();
		$stmt = $dbh->prepare("SELECT COUNT(*) FROM entity_grouping WHERE eg_type=:eg_type");
		$stmt->bindParam(":eg_type",$this->grouping_type);
		$stmt->execute() or die("an error occurred: EntityGrouping,+8465410");
		$result = $stmt->fetchColumn();
		return ($result >= AppSettings::gv("NumGroupedItemsType".$this->grouping_type."Max")) ? 1 : 0;
	}

}



?>