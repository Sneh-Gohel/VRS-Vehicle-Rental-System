<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $city = "Anand";
    $state = "Gujarat";
    $country = "India";
    $pin_code = "388001";
    $availavle_vehicle_list;
    $count = 0;
    $user_id = "";

    $city = $_POST['city'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $pin_code = $_POST['pin_code'];
    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT * FROM `vehicle_details`where (((pin_code = '$pin_code' OR city = '$city') AND state = '$state' AND country = '$country') And active = 'true' And vehicle_owner_user_id != '$user_id')");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $availavle_vehicle_list[$count]['vehicle_id'] = $row['vehicle_id'];
            $availavle_vehicle_list[$count]['vehicle_image_1'] = $row['vehicle_image_1'];
            $availavle_vehicle_list[$count]['vehicle_model'] = $row['vehicle_model'];
            $availavle_vehicle_list[$count]['vehicle_company'] = $row['vehicle_company'];
            $availavle_vehicle_list[$count]['price'] = $row['vehicle_price'];
            $count++;

        }
    }
    else
    {
        echo("No item found...");
    }

    print(json_encode($availavle_vehicle_list)); 

?>