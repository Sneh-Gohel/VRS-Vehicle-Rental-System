<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $driver_booking_id = 0;
    $count = 0;
    $visitor_id = "";
    $driver_current_booking_information;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT * FROM `driver_${user_id}_current_booking`;");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_booking_id = $row["driver_booking_id"];
            $driver_current_booking_information[$count]['driver_booking_id'] = $row['driver_booking_id'];

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = $driver_booking_id;");
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {
                    $driver_current_booking_information[$count]['starting_date'] = $temp_row["starting_date"];
                    $driver_current_booking_information[$count]['ending_date'] = $temp_row["ending_date"];
                    $driver_current_booking_information[$count]['booking_date'] = $temp_row["booking_date"];
                    $driver_current_booking_information[$count]['booking_time'] = $temp_row["booking_time"];
                    $driver_current_booking_information[$count]['days'] = $temp_row["days"];
                    $driver_current_booking_information[$count]['price'] = $temp_row["price"];
                    $driver_current_booking_information[$count]['description'] = $temp_row["description"];
                    $driver_current_booking_information[$count]['vehicle_model'] = $temp_row["vehicle_model"];
                    $driver_current_booking_information[$count]['vehicle_company'] = $temp_row["vehicle_company"];
                    $driver_current_booking_information[$count]['passing_year'] = $temp_row["passing_year"];
                    $driver_current_booking_information[$count]['wheeler_type'] = $temp_row["wheeler_type"];
                    $driver_current_booking_information[$count]['fule'] = $temp_row["fule"];
                    $driver_current_booking_information[$count]['transmission'] = $temp_row["transmission"];
                    $visitor_id = $temp_row['visitor_id'];
                }

                $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id';");
                if ($temp_result_1->num_rows > 0) 
                {
                    while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                    {
                        $driver_current_booking_information[$count]['first_name'] = $temp_row_1['first_name'];
                        $driver_current_booking_information[$count]['last_name'] = $temp_row_1['last_name'];
                        $driver_current_booking_information[$count]['contact'] = $temp_row_1['mobile_number'];
                    }
                }

                $driver_current_booking_information[$count]['first_name_first_char'] = substr($driver_current_booking_information[$count]['first_name'], 0, 1);

            }
            $count++;
        }

        
    }

    print(json_encode($driver_current_booking_information));

?>