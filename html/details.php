<?php 
$dbhost = 'localhost';
$dbuser = 'cooperhendrix'; // Hard-coding credentials directly in code is not ideal: (1) we might have to 
$dbpass = 'charizard';       // change them in multiple places, and (2) this creates security concerns. 
                            // We'll fix that in the next lab.
$conn = new mysqli($dbhost, $dbuser, $dbpass);

$tablelist = "SHOW TABLES FROM " . htmlspecialchars($_POST['db']);
$result = $conn->query($tablelist);


while ($tablelist = $result->fetch_array()) {
    echo $tablelist[0] . "<br>";
}

?>