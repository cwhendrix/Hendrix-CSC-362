<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    $config = parse_ini_file('/home/cooperhendrix/mysqli.ini');
    $dbname = 'red_river_climbs';
    $conn = new mysqli(
            $config['mysqli.default_host'],
            $config['mysqli.default_user'],
            $config['mysqli.default_pw'],
            $dbname);
    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit this PHP script if the connection fails.
    } else {
        echo "Connected Successfully!" . "<br>";
        echo "YAY!" . "<br>";
    }

    $dblist = "SHOW databases";
    $result = $conn->query($dblist);
    while ($dbname = $result->fetch_array()) {
        echo $dbname['Database'] . "<br>";
    }
?>
<body>
<form action="details.php" method="post">
            <label for="db">Database:</label>
            <input name="db" id="db" type="text">

            <button type="submit">Submit</button>
        </form>
</body>
<?php
    echo "<h2>Check back soon!</h2>";
?>