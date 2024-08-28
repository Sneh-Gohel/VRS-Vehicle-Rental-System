<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $count = "";

    $user_id = $_POST['user_id'];

    try{
        $result = $connetion->query("select count(*) from renter_{$user_id}_vehicle_list;");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $count = $row['count(*)'];
        }
    }
    }catch(\Throwable $e)
    {
        $count = "getting error..." . $e;
    }

    print(json_encode($count));

?>