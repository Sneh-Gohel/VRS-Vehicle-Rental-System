<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $booking_id = "";
    $starting_date = "";
    $ending_date = "";
    $booking_date = "";
    $booking_time = "";
    $days = "";
    $price = "";
    $descripion = "";
    $visitor_id = "sneh";
    $vehicle_id = "1";
    $count = "";
    $result = "";
    $vehicle_owner_user_id = "sneh";
    $booking_code = "";
    $id;

    $starting_date = $_POST['starting_date'];
    $ending_date = $_POST['ending_date'];
    $ending_date = $_POST['ending_date'];
    $booking_date = $_POST['booking_date'];
    $booking_time = $_POST['booking_time'];
    $days = $_POST['days'];
    $price = $_POST['price'];
    $descripion = $_POST['descripion'];
    $visitor_id = $_POST['visitor_id'];
    $vehicle_id = $_POST['vehicle_id'];
    $vehicle_owner_user_id = $_POST['vehicle_owner_user_id'];
    $booking_code = generateCode();

    try
    {
        $result = $connetion->query("select count(*) from vehicle_booking;");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $booking_id = $row['count(*)'];
            }
        }

    $booking_id++;

        $query = $connetion->prepare("INSERT INTO `vehicle_booking` VALUES ('$booking_id','$starting_date','$ending_date','$booking_date ','$booking_time','$days','$price','$descripion','$visitor_id','$vehicle_id','');");
        $query->execute();
        
        $query = $connetion->prepare("INSERT INTO renter_{$vehicle_owner_user_id}_current_booking values($booking_id,'$booking_code')");
        $query->execute();
        
        $query = $connetion->prepare("INSERT INTO visitor_{$visitor_id}_vehicle_active_booking values($booking_id,'$booking_code')");
        $query->execute();

        $result = $connetion->query("select count(*) from visitor_{$visitor_id}_notification");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connetion->prepare("INSERT INTO visitor_{$visitor_id}_notification values($id,'$booking_id',\"vehicle_booking\",'','')");
        $query->execute();

        $result = $connetion->query("select count(*) from visitor_{$vehicle_owner_user_id}_notification");
        if ($result->num_rows > 0)
        {
            while($row = $result->fetch_assoc()) 
            {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connetion->prepare("INSERT INTO visitor_{$vehicle_owner_user_id}_notification values($id,'$booking_id',\"renters_vehicle_booking\",'','')");
        $query->execute();

        $result = "sucessfull";
    }
    catch(Exception $e)
    {
        $result = "unsucessfull" . $e;
    }

    print(json_encode($result)); 

    function generateCode() 
    {
        $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$*_+';
        $code = '';
        $max = strlen($characters) - 1;
        
        for ($i = 0; $i < 6; $i++) {
          $code .= $characters[mt_rand(0, $max)];
        }
        
        return $code;
    }

?>