<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $count = 0; 

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT count(*) FROM visitor_${user_id}_driver_history");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $count = $row['count(*)'];

        }
    }

    print(json_encode($count)); 

?>