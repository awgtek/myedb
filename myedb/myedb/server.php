<?php
//a session is required(you can also set session.auto_start=1 in php.ini)
session_start();

require_once 'HTML/AJAX/Server.php';

$server = new HTML_AJAX_Server();
$server->handleRequest();
?>
