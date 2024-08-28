<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "temp";
    $vehicle_id = "2";
    $vehicle_booking_id = "";
    $checker = "false";
    $fetch_vehicle_id = "";

    $user_id = $_POST['user_id'];
    $vehicle_id = $_POST['vehicle_id'];

    $result = $connetion->query("SELECT * FROM `renter_{$user_id}_current_booking`");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $vehicle_booking_id = $row['vehicle_booking_id'];

            $temp_result = $connetion->query("SELECT * FROM `vehicle_booking` where booking_id = '$vehicle_booking_id'");
    
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {

                    $fetch_vehicle_id = $temp_row['vehicle_id'];

                    if($vehicle_id == $fetch_vehicle_id)
                    {
                        $checker = "true";
                    }

                }
            }

        }
    }

    print(json_encode($checker)); 

?>