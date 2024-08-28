<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "temp";
    $result = "";

    $user_id = $_POST['user_id'];

    try{
        $result = $connetion->query("SELECT password FROM `login` where user_id = '$user_id'");
        if ($result->num_rows > 0) 
        {
            $result = "true";
        }
        else 
        {
            $result = "false";
        }
    } catch (Exception $e) {
    }
    print(json_encode($result));
?>