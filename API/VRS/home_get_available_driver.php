<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $city = "Anand";
    $state = "Gujarat";
    $country = "India";
    $pin_code = "388001";
    $available_driver_list;
    $count = 0;
    $visitor_id = "";
    $user_id = "";

    $city = $_POST['city'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $pin_code = $_POST['pin_code'];
    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT visitor_id FROM `driver_details`where (((pin_code = '$pin_code' OR city = '$city') AND state = '$state' AND country = '$country') AND active = 'true' AND visitor_id != '$user_id' )");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $visitor_id = $row['visitor_id'];

            $temp_result = $connetion->query("SELECT * from login where user_id = '$visitor_id'");

            if($temp_result->num_rows > 0)
            {
                while($temp_row = $temp_result->fetch_assoc())
                {
                    $available_driver_list[$count]['driver_id'] = $temp_row['driver_id'];
                    $available_driver_list[$count]['driver_profile_pic'] = $temp_row['driver_profile_pic'];
                    $available_driver_list[$count]['price'] = $temp_row['driver_price'];
                    $available_driver_list[$count]['first_name'] = $temp_row['first_name'];
                    $available_driver_list[$count]['last_name'] = $temp_row['last_name'];
                    $available_driver_list[$count]['skill'] = $temp_row['skill'];
                    $count++;
                }
            }

        }
    }
    else
    {
        echo("No item found...");
    }

    print(json_encode($available_driver_list)); 

?>