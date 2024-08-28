<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "temp";
    $driver_id = "1";
    $driver_booking_id = "";
    $checker = "false";
    $fetch_driver_id = "";

    $user_id = $_POST['user_id'];
    $driver_id = $_POST['driver_id'];

    $result = $connetion->query("SELECT * FROM `driver_{$user_id}_current_booking`");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $driver_booking_id = $row['driver_booking_id'];

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$driver_booking_id'");
    
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {

                    $fetch_driver_id = $temp_row['driver_id'];

                    if($driver_id == $fetch_driver_id)
                    {
                        $checker = "true";
                    }

                }
            }

        }
    }

    print(json_encode($checker)); 

?>