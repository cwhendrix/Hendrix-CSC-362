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
                echo "Connected Successfully!" . "<br>";
                echo "YAY!" . "<br>";
            }

            $result = $conn->query("SELECT instruments.instrument_id, instruments.instrument_type, students.student_name AS checked_out_to FROM instruments
                            LEFT JOIN open_rentals ON instruments.instrument_id = open_rentals.instrument_id
                            LEFT JOIN students ON open_rentals.student_id = students.student_id");

    if (isset($_POST["delete"])) {
        //echo "POST IS SET";
        $deletion = $conn->prepare("DELETE FROM instruments where instrument_id = ?");
        $deletion->bind_param('i', $id);
        $idnums = $result->fetch_all();
        for ($i = 0; $i<$result->num_rows; $i++) {
            $id = $idnums[$i][0];
            if (isset($_POST["checkbox$id"])) {
                // echo $id;
                $deletion->execute();
            }
        }
        header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
    }

    if (isset($_POST["addition"])) {
        $addition = $conn->query("INSERT INTO instruments (instrument_type)
        VALUES ('Guitar'),      -- 1
               ('Trumpet'),     -- 2
               ('Flute'),       -- 3
               ('Theramin'),    -- 4
               ('Violin'),      -- 5
               ('Tuba'),        -- 6
               ('Melodica'),    -- 7
               ('Trombone'),    -- 8
               ('Melodica'),    -- 9
               ('Keyboard'),    -- 10
               ('Melodica');    -- 11");
        header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
    }
    // 0 = Light
    // 1 = Dark

    if (!isset($_POST["lightdark"])) {
        setcookie(
            "mode_pref",  // name; name of the stored value
            "0",    // value; the stored value
            time()+60*60*24*30,     // expires; UNIX timestamp (int; seconds since the epoch) when cookie expires
            "/",        // path; which subdirectories within the domain the cookie will be available
            "",         // domain; empty string so that our entire website can use the cookie
            false,      // secure; false, because we aren't using HTTPS
            true);    
    } else if (isset($_POST["lightdark"])) {
        if ($_COOKIE["mode_pref"] == "0") {
            setcookie(
                "mode_pref",  // name; name of the stored value
                "1",    // value; the stored value
                time()+60*60*24*30,     // expires; UNIX timestamp (int; seconds since the epoch) when cookie expires
                "/",        // path; which subdirectories within the domain the cookie will be available
                "",         // domain; empty string so that our entire website can use the cookie
                false,      // secure; false, because we aren't using HTTPS
                true);    
        } else if ($_COOKIE["mode_pref"] == "1") {
            setcookie(
                "mode_pref",  // name; name of the stored value
                "0",    // value; the stored value
                time()+60*60*24*30,     // expires; UNIX timestamp (int; seconds since the epoch) when cookie expires
                "/",        // path; which subdirectories within the domain the cookie will be available
                "",         // domain; empty string so that our entire website can use the cookie
                false,      // secure; false, because we aren't using HTTPS
                true);    
        }
    }
    if ($_COOKIE["mode_pref"] == "1") { ?>
        <style>
        <?php include 'dark_mode.css'; ?>
        </style> <?php
    } else if ($_COOKIE["mode_pref"] == "0") { ?>
        <style>
        <?php include 'basic.css'; ?>
        </style> <?php
    }

?>

<form action="manage_instruments.php" method=POST>
<input type="submit" value="Light/Dark Mode Toggle" name = "lightdark" method=POST/>
</form>

<?php 
    if (isset($_POST["username"])) {
        echo "Welcome ".$_POST["username"];
    }
?>

<form action="manage_instruments.php" method="POST">
            <label for="username">Enter Username:</label>
            <input name="username" id="db" type="text">

            <button type="submit">Submit</button>
        </form>


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

<form action="manage_instruments.php" method=POST>
<?php result_to_html_table($result); ?>
<input type="submit" value="Delete Selected Records" name = "delete" method=POST/>
</form>

<form action="manage_instruments.php" method=POST>
<input type="submit" value="Add To Table" name = "addition" method=POST/>
</form>