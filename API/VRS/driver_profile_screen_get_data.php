<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "temp";
    $driver_id = "";
    $driver_information;
    
    $user_id = $_POST['user_id'];

    $result = $connetion->query("select * FROM login where user_id = '$user_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_information['first_name'] = $row["first_name"];
            $driver_information['last_name'] = $row["last_name"];
            $driver_information['birth_date'] = $row["birth_date"];
            $driver_information['contact'] = $row["mobile_number"];
            $driver_information['driver_image'] = $row["driver_profile_pic"];
            $driver_information['driver_id'] = $row["driver_id"];
            $driver_id = $row["driver_id"];
        }
    }

    $year = explode("/", $driver_information['birth_date']);
    $current_year = date('Y');
    $driver_information['age'] = $current_year - $year[2];

    $result = $connetion->query("select count(*) FROM driver_{$user_id}_history");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_information['drives'] = $row["count(*)"];
        }
    }

    print(json_encode($driver_information));
?>