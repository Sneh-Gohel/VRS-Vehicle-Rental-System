<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $renter_information;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("select * from login where user_id = '$user_id';");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $renter_information['first_name'] = $row['first_name'];
            $renter_information['last_name'] = $row['last_name'];
            $renter_information['age'] = $row['birth_date'];
            $renter_information['contact'] = $row['mobile_number'];
        }
    }

    $year = explode("/", $renter_information['age']);
    $current_year = date('Y');
    $renter_information['age'] = $current_year - $year[2];

    print(json_encode($renter_information));

?>