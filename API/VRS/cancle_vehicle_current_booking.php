<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $booking_id = "3";
    $result = "";
    $user_id = "sneh";
    $vehicle_id = "";
    $request_from = "visitor";
    $vehicle_owner_user_id = "";
    $visitor_id = "";
    $current_date = "24/05/2023";
    $id = "";

    $booking_id = $_POST['booking_id'];
    $user_id = $_POST['user_id'];
    $request_from = $_POST['request_from'];
    $current_date = $_POST['current_date'];

    if($request_from == "visitor")
    {
        try
        {
            $result = $connetion->query("select * from vehicle_booking where booking_id = '$booking_id'");
            if ($result->num_rows > 0) 
            {
                while($row = $result->fetch_assoc()) 
                {
                    $vehicle_id = $row['vehicle_id'];
                }
            }

            $result = $connetion->query("select * from vehicle_details where vehicle_id = '$vehicle_id'");
            if ($result->num_rows > 0) 
            {
                while($row = $result->fetch_assoc()) 
                {
                    $vehicle_owner_user_id = $row['vehicle_owner_user_id'];
                }
            }

            $query = $connetion->prepare("UPDATE `vehicle_booking` SET `cancel_date`='$current_date' WHERE booking_id = '$booking_id'");
            $query->execute();

            $query = $connetion->prepare("DELETE FROM `renter_{$vehicle_owner_user_id}_current_booking` WHERE vehicle_booking_id = $booking_id");
            $query->execute();

            $query = $connetion->prepare("DELETE FROM `visitor_{$user_id}_vehicle_active_booking` WHERE vehicle_booking_id = $booking_id");
            $query->execute();

            $result = $connetion->query("SELECT count(*) FROM `visitor_{$user_id}_notification`");
            if ($result->num_rows > 0) 
            {
                while($row = $result->fetch_assoc()) 
                {
                    $id = $row['count(*)'];
                }
            }

            $id++;

            $query = $connetion->prepare("INSERT INTO visitor_{$user_id}_notification VALUES($id,$booking_id,'vehicle_booking_cancel','','')");
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

            $query = $connetion->prepare("INSERT INTO visitor_{$vehicle_owner_user_id}_notification VALUES($id,$booking_id,'renter_vehicle_cancel','','')");
            $query->execute();

            $result = "sucessful";
        }
        catch(Exception $e) 
        {
            $result = "unsucessful";
        }
    }
    else if($request_from == "renter")
    {
        try
        {

            $result = $connetion->query("select * from vehicle_booking where booking_id = '$booking_id'");
            if ($result->num_rows > 0) 
            {
                while($row = $result->fetch_assoc()) 
                {
                    $visitor_id = $row['visitor_id'];
                }
            }

            $query = $connetion->prepare("UPDATE `vehicle_booking` SET `cancel_date`='$current_date' WHERE booking_id = '$booking_id'");
            $query->execute();

            $query = $connetion->prepare("DELETE FROM `renter_{$user_id}_current_booking` WHERE vehicle_booking_id = $booking_id");
            $query->execute();

            $query = $connetion->prepare("DELETE FROM `visitor_{$visitor_id}_vehicle_active_booking` WHERE vehicle_booking_id = $booking_id");
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

            $query = $connetion->prepare("INSERT INTO visitor_{$visitor_id}_notification VALUES($id,$booking_id,'vehicle_booking_cancel','','')");
            $query->execute();

            $result = $connetion->query("select count(*) from visitor_{$user_id}_notification");
            if ($result->num_rows > 0) 
            {
                while($row = $result->fetch_assoc()) 
                {
                    $id = $row['count(*)'];
                }
            }

            $id++;

            $query = $connetion->prepare("INSERT INTO visitor_{$user_id}_notification VALUES($id,$booking_id,'renter_vehicle_cancel','','')");
            $query->execute();

            $result = "sucessful";
        }
        catch(Exception $e) 
        {
            $result = "unsucessful";
        }
    }

    print(json_encode($result));

?>