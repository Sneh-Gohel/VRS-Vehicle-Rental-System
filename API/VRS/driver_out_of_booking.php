<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $driver_id = "2";
    $result = "";

    $driver_id = $_POST['driver_id'];

    try 
    {

        $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
        $query->execute();

        $result = "true";

    } 
    catch (\Throwable $th) 
    {
        $result = "false";
    }

    print(json_encode($result)); 

?>