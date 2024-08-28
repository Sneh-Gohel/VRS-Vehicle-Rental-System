<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $vehicle_id = "2";
    $result = "123";

    $vehicle_id = $_POST['vehicle_id'];

    try 
    {

        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
        $query->execute();

        $result = "true";

    } 
    catch (\Throwable $th) 
    {
        $result = "false";
    }

    print(json_encode($result)); 

?>