<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "ayan";
    $booking_id = "20";
    $first_name = "";
    $last_name = "";
    $booking_information;

    $user_id = $_POST['user_id'];
    $booking_id = $_POST['booking_id'];

    $result = $connetion->query("select * from visitor_{$user_id}_driver_active_booking where driver_booking_id = '$booking_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $booking_information['booking_code'] = $row['booking_code'];
        }
    }

    $result = $connetion->query("select * from login where user_id = '$user_id';");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $booking_information['first_name'] = $row['first_name'];
            $booking_information['last_name'] = $row['last_name'];
        }
    }

    print(json_encode($booking_information));

?>