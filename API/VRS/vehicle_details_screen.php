<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $vehicle_id = "1";
    $vehicle_information;
    $vehicle_owner_user_id = "";

    $vehicle_id = $_POST['vehicle_id'];

    $result = $connetion->query("SELECT * FROM `vehicle_details` WHERE vehicle_id = '$vehicle_id';");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $vehicle_information['vehicle_image_1'] = $row['vehicle_image_1'];
            $vehicle_information['vehicle_image_2'] = $row['vehicle_image_2'];
            $vehicle_information['vehicle_image_3'] = $row['vehicle_image_3'];
            $vehicle_information['vehicle_image_4'] = $row['vehicle_image_4'];
            $vehicle_information['vehicle_image_5'] = $row['vehicle_image_5'];
            $vehicle_information['vehicle_model'] = $row['vehicle_model'];
            $vehicle_information['vehicle_company'] = $row['vehicle_company'];
            $vehicle_information['price'] = $row['vehicle_price'];
            $vehicle_information['passing_year'] = $row['vehicle_passing_year'];
            $vehicle_information['seater'] = $row['vehicle_seater'];
            $vehicle_information['fule_type'] = $row['vehicle_fule_type'];
            $vehicle_information['transmission'] = $row['vehicle_transmission'];
            $vehicle_information['vehicle_number'] = $row['vehicle_number'];
            $vehicle_information['vehicle_rc_image_front'] = $row['vehicle_rc_image_front'];
            // $vehicle_information['vehicle_rc_image_front'] = "http://192.168.0.105/VRS/images/images_of_1/rc_image_1.png";
            $vehicle_information['vehicle_rc_image_bottom'] = $row['vehicle_rc_image_bottom'];
            $vehicle_information['vehicle_owner_user_id'] = $row['vehicle_owner_user_id'];
            $vehicle_owner_user_id = $row['vehicle_owner_user_id'];
            $vehicle_information['city'] = $row['city'];
            $vehicle_information['state'] = $row['state'];
            $vehicle_information['country'] = $row['country'];
            $vehicle_information['pin_code'] = $row['pin_code'];

        }
    }

    $result = $connetion->query("SELECT * FROM `login` WHERE user_id = '$vehicle_owner_user_id';");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $vehicle_information['vehicle_owner_first_name'] = $row['first_name'];
            $vehicle_information['vehicle_owner_last_name'] = $row['last_name'];
            $vehicle_information['vehicle_owner_contact'] = $row['mobile_number'];
            $vehicle_information['vehicle_owner_birth_date'] = $row['birth_date'];
            $vehicle_information['vehicle_owner_gender'] = $row['gender'];
        }
    }

    $year = explode("/", $vehicle_information['vehicle_owner_birth_date']);
    $current_year = date('Y');
    $vehicle_information['vehicle_owner_age'] = $current_year - $year[2];

    $vehicle_information['vehicle_owner_first_name_first_char'] = substr($vehicle_information['vehicle_owner_first_name'], 0, 1);

    print(json_encode($vehicle_information)); 

?>