<?php
    $connetion = new mysqli("localhost","root","","vrs");

    $city = "Anand";
    $state = "Gujarat";
    $country = "India";
    $pin_code = "388001";
    $count = "";
    $user_id = "";

    $city = $_POST['city'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $pin_code = $_POST['pin_code'];
    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT count(*) FROM `driver_details`where (((pin_code = '$pin_code' OR city = '$city') AND state = '$state' AND country = '$country') AND active = 'true' AND visitor_id != '$user_id')");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $count = $row['count(*)'];
        }
    }
    else
    {
        echo("No item found...");
    }

    print(json_encode($count)); 
?>  