<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $vehicle_id = 0;
    $availavle_vehicle_list;
    $count = 0;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("select * from renter_${user_id}_vehicle_list;");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $vehicle_id = $row['vehicle_list'];

            $temp_result = $connetion->query("SELECT * FROM vehicle_details WHERE vehicle_id = $vehicle_id;");
            if($temp_result->num_rows > 0)
            {
                while($temp_row = $temp_result->fetch_assoc())
                {
                    $availavle_vehicle_list[$count]['vehicle_id'] = $temp_row['vehicle_id'];
                    $availavle_vehicle_list[$count]['vehicle_image_1'] = $temp_row['vehicle_image_1'];
                    $availavle_vehicle_list[$count]['vehicle_model'] = $temp_row['vehicle_model'];
                    $availavle_vehicle_list[$count]['vehicle_company'] = $temp_row['vehicle_company'];
                    $availavle_vehicle_list[$count]['price'] = $temp_row['vehicle_price'];
                    $count++;
                }
            }
        }
    }

    print(json_encode($availavle_vehicle_list));

?>