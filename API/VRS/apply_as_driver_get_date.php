<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $driver_id = "";
    $driver_information;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("select * FROM login where user_id = '$user_id';"); 
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_information['first_name'] = $row['first_name'];
            $driver_information['last_name'] = $row['last_name'];
            $driver_information['contact'] = $row['mobile_number'];
            $driver_information['city'] = $row['city'];
            $driver_information['state'] = $row['state'];
            $driver_information['country'] = $row['country'];
            $driver_information['pin_code'] = $row['pin_code'];
            $driver_information['price'] = $row['driver_price'];
            $driver_information['profile_pic'] = $row['driver_profile_pic'];
            $driver_information['licence_image_1'] = $row['licence_image_front'];
            $driver_information['licence_image_2'] = $row['licence_image_back'];
            $driver_information['driver_id'] = $row['driver_id'];
            $driver_id = $row['driver_id'];
        }
    }

    $result = $connetion->query("select * FROM driver_details where driver_id = '$driver_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_information['active'] = $row["active"];
        }
    }

    print(json_encode($driver_information));

?>