<?php

    $connetion = new mysqli("localhost","root","","vrs"); 

    $vehicle_id = "1";
    $user_id = "sneh";
    $reason = "";
    $description = "";
    $date = "";
    $time = "";
    $renter_user_id = "";
    $id = 1;
    $result = "";

    $vehicle_id = $_POST['vehicle_id'];
    $user_id = $_POST['user_id'];
    $reason = $_POST['reason'];
    $description = $_POST['description'];
    $date = $_POST['date'];
    $time = $_POST['time'];
    
    $result = $connetion->query("select * FROM `vehicle_details` where vehicle_id = '$vehicle_id'");

    try {

        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $renter_user_id = $row['vehicle_owner_user_id'];
            }
        }

        $result = $connetion->query("select count(*) FROM `vehicle_{$vehicle_id}_report`");

        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connetion->prepare("INSERT INTO vehicle_{$vehicle_id}_report values('$id','$reason','$description','$date','$time','$user_id')");
            
        $query->execute();

        $result = $connetion->query("select count(*) from visitor_{$renter_user_id}_notification");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $notification_id = $row['count(*)'];
            }
        }

        $notification_id++;

        $query = $connetion->prepare("INSERT INTO visitor_{$renter_user_id}_notification VALUES($notification_id,$id,'vehicle_report','$vehicle_id','')");
        $query->execute();

        $result = "true";

    } catch (\Throwable $th) {

        $result = "false";

    }

    print(json_encode("$result"));

?>