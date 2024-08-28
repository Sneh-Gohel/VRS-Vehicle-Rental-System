<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $vehicle_id = "1";
    $vehicle_details;

    $vehicle_id = $_POST['vehicle_id'];

    $result = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$vehicle_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $vehicle_details['vehicle_image_1'] = $row["vehicle_image_1"];
            $vehicle_details['vehicle_image_2'] = $row["vehicle_image_2"];
            $vehicle_details['vehicle_image_3'] = $row["vehicle_image_3"];
            $vehicle_details['vehicle_image_4'] = $row["vehicle_image_4"];
            $vehicle_details['vehicle_image_5'] = $row["vehicle_image_5"];
            $vehicle_details['vehicle_model'] = $row["vehicle_model"];
            $vehicle_details['vehicle_company'] = $row["vehicle_company"];
            $vehicle_details['vehicle_price'] = $row["vehicle_price"];
            $vehicle_details['vehicle_passing_year'] = $row["vehicle_passing_year"];
            $vehicle_details['vehicle_wheeler'] = $row["vehicle_wheeler"];
            $vehicle_details['vehicle_seater'] = $row["vehicle_seater"];
            $vehicle_details['vehicle_fule_type'] = $row["vehicle_fule_type"];
            $vehicle_details['vehicle_transmission'] = $row["vehicle_transmission"];
            $vehicle_details['vehicle_number'] = $row["vehicle_number"];
            $vehicle_details['vehicle_rc_image_1'] = $row["vehicle_rc_image_front"];
            $vehicle_details['vehicle_rc_image_2'] = $row["vehicle_rc_image_bottom"];
            $vehicle_details['vehicle_owner_user_id'] = $row["vehicle_owner_user_id"];
            $vehicle_details['city'] = $row["city"];
            $vehicle_details['state'] = $row["state"];
            $vehicle_details['country'] = $row["country"];
            $vehicle_details['pin_code'] = $row["pin_code"];
        }
    }

    print(json_encode($vehicle_details));

?>