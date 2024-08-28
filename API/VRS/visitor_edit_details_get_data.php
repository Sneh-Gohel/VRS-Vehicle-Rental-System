<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $visitor_deatils;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT * FROM `login` where user_id = '$user_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $visitor_deatils['first_name'] = $row["first_name"];
            $visitor_deatils['last_name'] = $row["last_name"];
            $visitor_deatils['mobile_number'] = $row["mobile_number"];
            $visitor_deatils['birth_date'] = $row["birth_date"];
            $visitor_deatils['gender'] = $row["gender"];
            $visitor_deatils['city'] = $row["city"];
            $visitor_deatils['state'] = $row["state"];
            $visitor_deatils['country'] = $row["country"];
            $visitor_deatils['pin_code'] = $row["pin_code"];
        }
    }

    print(json_encode($visitor_deatils));

?>