<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $user_information;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT * FROM `login` WHERE user_id = '$user_id';");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $user_information['first_name'] = $row['first_name'];
            $user_information['last_name'] = $row['last_name'];
            $user_information['contact'] = $row['mobile_number'];
            $user_information['birth_date'] = $row['birth_date'];
            $user_information['gender'] = $row['gender'];
        }
    }

    $year = explode("/", $user_information['birth_date']);
    $current_year = date('Y');
    $user_information['age'] = $current_year - $year[2];

    print(json_encode($user_information)); 
?>