<?


$sql = "SET NAMES utf8";
$result = mysql_query($sql);

$sql = "select @@CHARACTER_SET_CLIENT ";
$result = mysql_query($sql);
$ar = mysql_fetch_array($result);
//print_r($ar);
echo "<br> character set: " . $ar[0];


?>