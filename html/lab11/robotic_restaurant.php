<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    $config = parse_ini_file('/home/cooperhendrix/mysqli.ini');
    $dbname = 'instrument_rentals';
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
    $result = $conn->query("SELECT DishName, DishPrice FROM Dishes;");
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
    <p>This table has <?php echo $num_rows; ?> and <?php echo $num_cols; ?> columns.</p>
    
    <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
    <table>
    <thead>
    <tr>
    <?php for ($i=0; $i<$num_cols; $i++){ ?>
        <td><b><?php echo $fields[$i]->name; ?></b></td>
    <?php } ?>
    <th> <?php echo "Delete?" ?> </th>
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
        <td><input type="checkbox"
            name="checkbox<?php echo $id; ?>"
            value=<?php echo $id; ?>    /></td>
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
<?php result_to_html_table($result); ?>
<input type="submit" value="Submit Order" name = "order" method=POST/>
</form>
<h2>Cancel an Order</h2>

<h2>Pending orders</h2>
