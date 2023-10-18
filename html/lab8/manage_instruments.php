<?php
    $config = parse_ini_file('/home/cooperhendrix/mysqli.ini');
    $dbname = 'instrument_rentals';
    $conn = new mysqli(
            $config['mysqli.default_host'],
            $config['mysqli.default_user'],
            $config['mysqli.default_pw'],
            $dbname);
    
?>