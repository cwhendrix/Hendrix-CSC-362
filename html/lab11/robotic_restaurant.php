<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);   // <- this is the new addition
    $config = parse_ini_file('/home/cooperhendrix/mysqli.ini');
    $dbname = 'robo_rest_fall_2023';
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
                // echo "Connected Successfully!" . "<br>";
                // echo "YAY!" . "<br>";
            }
    $getmenu = $conn->query("SELECT DishID, DishName, DishPrice FROM Dishes");
    

    if (isset($_POST["order"])) {
        // echo "ORDER SET\n";
        if (isset($_POST["fname"]) && isset($_POST["lname"]) && isset($_POST["lat"]) && isset($_POST["lon"])) {
            $customeradd = $conn->prepare("CALL add_customer(?, ?, ?, ?, ?, ?, ?)");
            $new_fname = $_POST["fname"];
            $new_lname = $_POST["lname"];
            $new_email = "example@gmail.com";
            $new_lat = floatval($_POST["lat"]);
            $new_lon = floatval($_POST["lon"]);
            for ($i = 0; $i <= $getmenu->num_rows; $i++) { 
                if (isset($_POST["quantity$i"]) && $_POST["quantity$i"] != 0) {
                    $dish_1_id = $i;
                    $dish_1_quant = $_POST["quantity$i"];
                    break;
                }
            }
            // Debugging output
            // echo '$new_fname = ' . $new_fname . "\n";
            // echo '$new_lname = ' . $new_lname . "\n";
            // echo '$new_email = ' . $new_email . "\n";
            // echo '$new_lat = ' . $new_lat . "\n";
            // echo '$new_lon = ' . $new_lon . "\n";
            // echo '$dish_1_id = ' . $dish_1_id . "\n";
            // echo '$dish_1_quant = ' . $dish_1_quant. "\n";
            // 
            $customeradd->bind_param(
                "sssdddd", 
                $new_fname, 
                $new_lname, 
                $new_email, 
                $new_lat, 
                $new_lon, 
                $dish_1_id, 
                $dish_1_quant);
            $customeradd->execute();
            // header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
        }

        $modify_order = $conn->prepare("CALL add_orderdish(?, ?, ?)");
        for ($i = 0; $i <= $getmenu->num_rows; $i++) { 
            if (isset($_POST["quantity$i"]) && $_POST["quantity$i"] != 0) {
                for ($j = 1; $j <= intval($_POST["quantity$i"]); $j++) {
                    $placeholder = 0;
                    $emptynote = "";
                    $modify_order->bind_param('iis', $placeholder, $i, $emptynote);
                }
            }
        }
    }
?>
<?php
function result_to_html_table($result) {
    // $result is a mysqli result object. This function formats the object as an
    // HTML table. Note that there is no return, simply call this function at the 
    // position in your page where you would like the table to be located.

    $result_body = $result->fetch_all();
    $num_rows = $result->num_rows;
    $num_cols = $result->field_count;
    $fields = $result->fetch_fields();
    ?>
    <!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
    <!-- <p>This table has <?php //echo $num_rows; ?> rows and <?php //echo $num_cols; ?> columns.</p> -->
    
    <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
    <table>
    <thead>
    <tr>
    <?php for ($i=0; $i<$num_cols; $i++){ ?>
        <td><b><?php echo $fields[$i]->name; ?></b></td>
    <?php } ?>
    <th> <?php echo "Quantity" ?> </th>
    </tr>
    </thead>
    
    <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
    <tbody>
    <?php for ($i=0; $i<$num_rows; $i++){ ?>
        <?php $id = $result_body[$i][0]; ?>
        <tr>     
        <?php for($j=0; $j<$num_cols; $j++){ ?>
            <td><?php echo $result_body[$i][$j]; ?></td>
        <?php } ?>
        <td><input type="number"
            name="quantity<?php echo $id; ?>"
            value=0
              /></td>
        </tr>
    <?php } ?>
    </tbody></table>
<?php } ?>
<head>
    <title>Robotic Restaurant</title>
</head>
<h1>Alice's Robotic Restaurant!</h1>

<h2>Menu</h2>
<form action="robotic_restaurant.php" method=POST>
<?php result_to_html_table($getmenu); ?>
<label for="fname">First Name:</label>
<input name="fname" id="db" type="text">
<label for="lname">Last Name:</label>
<input name="lname" id="db" type="text">
<label for="lat">Latitude:</label>
<input name="lat" id="db" type="text" value=0.0>
<!-- <input name="lat" id="db" type="text" pattern="[0-9]+.[0-9]" value=0.0> -->
<label for="lon">Longitude:</label>
<input name="lon" id="db" type="text" value=0.0>
<!-- <input name="lon" id="db" type="text" pattern="[0-9]+.[0-9]" value=0.0> -->
<input type="submit" value="Submit Order" name = "order" method=POST/>
</form>
<h2>Cancel an Order</h2>

<h2>Pending orders</h2>
