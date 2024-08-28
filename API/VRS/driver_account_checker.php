<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "ayan";
    $result = false;
    $driver_id = "";
    
    $user_id = $_POST['user_id'];

    $result = $connetion->query("select driver_id FROM login where user_id = '$user_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_id = $row["driver_id"];
        }
    }

    if($driver_id == "")
    {
        $result = false;
    }
    else
    {
        $result = true;
    }

    print(json_encode($result));
?>