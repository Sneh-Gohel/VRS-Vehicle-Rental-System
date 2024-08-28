<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $info; 

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT * FROM `login` WHERE user_id = '$user_id'");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $info['first_name'] = $row['first_name'];
            $info['last_name'] = $row['last_name'];

        }
    }

    print(json_encode($info)); 

?>