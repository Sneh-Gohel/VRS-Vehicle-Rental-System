<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $vehicle_id = 1;
    $count = 0;

    // $vehicle_id = $_POST['vehicle_id'];
    
    $result = $connetion->query("select count(*) from vehicle_${vehicle_id}_history;");
    if ($result->num_rows > 0)
    {
        while($row = $result->fetch_assoc())
        {
            $count = $row['count(*)'];
        }
    }

    print(json_encode($count));
?>