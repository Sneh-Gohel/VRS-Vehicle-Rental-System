<?php

    $connetion = new mysqli("localhost","root","","vrs"); 

    $driver_id = "2";
    $user_id = "sneh";
    $reason = "";
    $description = "";
    $date = "";
    $time = "";
    $driver_user_id = "";
    $id;
    $result = "";

    $driver_id = $_POST['driver_id'];
    $user_id = $_POST['user_id'];
    $reason = $_POST['reason'];
    $description = $_POST['description'];
    $date = $_POST['date'];
    $time = $_POST['time'];
    
    try {

        $result = $connetion->query("select * FROM `driver_details` where driver_id = '$driver_id'");
        
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $driver_user_id = $row['visitor_id'];
            }
        }

        $result = $connetion->query("select count(*) FROM `driver_{$driver_user_id}_report`");

        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connetion->prepare("INSERT INTO driver_{$driver_user_id}_report values('$id','$reason','$description','$date','$time','$user_id')");
            
        $query->execute();
        
        // notification

        $result = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $notification_id = $row['count(*)'];
            }
        }

        $notification_id++;

        $query = $connetion->prepare("INSERT INTO visitor_{$driver_user_id}_notification VALUES($notification_id,$id,'driver_report','','$driver_user_id')");
        $query->execute();

        $result = "true";

    } catch (\Throwable $th) {

        $result = "false";

    }

    print(json_encode("$result"));

?>