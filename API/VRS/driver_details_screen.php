<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $driver_id = "1";
    $driver_information;
    $visitor_id = "";

    $driver_id = $_POST['driver_id'];

    $result = $connetion->query("SELECT visitor_id FROM `driver_details`where driver_id = '$driver_id'");
    
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $visitor_id = $row['visitor_id'];
            $driver_information['driver_user_id'] = $visitor_id;

            $temp_result = $connetion->query("SELECT * from login where user_id = '$visitor_id'");

            if($temp_result->num_rows > 0)
            {
                while($temp_row = $temp_result->fetch_assoc())
                {
                    $driver_information['driver_profile_pic'] = $temp_row['driver_profile_pic'];
                    $driver_information['first_name'] = $temp_row['first_name'];
                    $driver_information['last_name'] = $temp_row['last_name'];
                    $driver_information['contact'] = $temp_row['mobile_number'];
                    $driver_information['birth_date'] = $temp_row['birth_date'];
                    $driver_information['gender'] = $temp_row['gender'];
                    $driver_information['skill'] = $temp_row['skill'];
                    $driver_information['fule'] = $temp_row['fule'];
                    $driver_information['transmission'] = $temp_row['transmission'];
                    $driver_information['licence_image_1'] = $temp_row['licence_image_front'];
                    $driver_information['licence_image_2'] = $temp_row['licence_image_back'];
                    $driver_information['price'] = $temp_row['driver_price'];
                }
            }

        }

        $year = explode("/", $driver_information['birth_date']);
        $current_year = date('Y');
        $driver_information['age'] = $current_year - $year[2];
    }
    else
    {
        echo("No item found...");
    }

    print(json_encode($driver_information)); 

?>