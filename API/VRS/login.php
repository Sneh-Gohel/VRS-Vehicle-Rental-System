<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $current_user_id = "sneh";
    $current_password = "123";
    $password = "";
    $status = "";

    // $current_user_id = $_POST['user_id'];
    // $current_password = $_POST['password'];

    try{
        $result = $connetion->query("SELECT password FROM `login` where user_id = '$current_user_id'");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $password = $row["password"];
            }
            if($current_password == $password)
            {
                $status = "success";
            }
            else
            {
                $status = "incorrect_password";
            }
        }
        else 
        {
            $status = "user_not_found";
        }
    } catch (Exception $e) {
    }
    print(json_encode($status));
?>