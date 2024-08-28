<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $first_name_first_char = ""; 

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT first_name FROM `login` WHERE user_id = '$user_id'");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $first_name_first_char = $row['first_name'];

        }
    }

    print(json_encode(substr($first_name_first_char, 0, 1))); 

?>