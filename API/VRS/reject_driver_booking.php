<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $driver_booking_id = 0;
    $result = "";
    $visitor_id = "";
    $id = "";

    $user_id = $_POST['user_id'];
    $driver_booking_id = $_POST['driver_booking_id'];

    try
    {
        $result = $connetion->query("SELECT * driver_booking where booking_id = '$driver_booking_id'");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $visitor_id = $row['visitor_id'];
            }
        }

        $query = $connetion->prepare("delete from driver_{$user_id}_current_booking where driver_booking_id = '$driver_booking_id'");
        $query->execute();

        $query = $connetion->prepare("delete from visitor_{$visitor_id}_driver_active_booking where driver_booking_id = '$driver_booking_id'");
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

        $result = "sccessful";
    }
    catch(Exception $e)
    {
        $result = "unsccessful";
    }

    print(json_encode($result));

?>