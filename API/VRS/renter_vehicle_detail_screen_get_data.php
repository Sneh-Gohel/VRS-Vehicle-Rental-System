<?php

    $connetion = new mysqli("localhost","root","","vrs");
    
    $vehicle_id = 1;
    $vehicle_information;

    $vehicle_id = $_POST['vehicle_id'];

    $result = $connetion->query("SELECT * FROM vehicle_details WHERE vehicle_id = $vehicle_id;");
    if($result->num_rows > 0)
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
            $vehicle_information['vehicle_passing_year'] = $row['vehicle_passing_year'];
            $vehicle_information['vehicle_seater'] = $row['vehicle_seater'];
            $vehicle_information['vehicle_fule_type'] = $row['vehicle_fule_type'];
            $vehicle_information['vehicle_transmission'] = $row['vehicle_transmission'];
            $vehicle_information['vehicle_number'] = $row['vehicle_number'];
            $vehicle_information['vehicle_rc_image_front'] = $row['vehicle_rc_image_front'];
            $vehicle_information['vehicle_rc_image_bottom'] = $row['vehicle_rc_image_bottom'];
            $vehicle_information['city'] = $row['city'];
            $vehicle_information['state'] = $row['state'];
            $vehicle_information['country'] = $row['country'];
            $vehicle_information['pin_code'] = $row['pin_code'];
            $vehicle_information['active'] = $row['active'];
        }
    }
    
    print(json_encode($vehicle_information));

?>