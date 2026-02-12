<?php
$ip = getenv("REMOTE_ADDR");
$date = date("d/m/Y H:i:s");
$useragent = $_SERVER['HTTP_USER_AGENT'];

$file = fopen('ip.txt', 'a');
fwrite($file, "IP: " . $ip . " | Date: " . $date . " | User-Agent: " . $useragent . "\n");
fclose($file);
?>
