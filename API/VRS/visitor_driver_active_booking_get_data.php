<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "ayan";
    $driver_booking_id = 0;
    $count = 0;
    $driver_id = "";
    $driver_user_id = "";
    $booking_info;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT * FROM `visitor_{$user_id}_driver_active_booking`;");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_booking_id = $row["driver_booking_id"];
            $booking_info[$count]['driver_booking_id'] = $row['driver_booking_id'];

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = $driver_booking_id;");
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {
                    $booking_info[$count]['starting_date'] = $temp_row["starting_date"];
                    $booking_info[$count]['ending_date'] = $temp_row["ending_date"];
                    $booking_info[$count]['booking_date'] = $temp_row["booking_date"];
                    $booking_info[$count]['booking_time'] = $temp_row["booking_time"];
                    $booking_info[$count]['days'] = $temp_row["days"];
                    $booking_info[$count]['price'] = $temp_row["price"];
                    $booking_info[$count]['description'] = $temp_row["description"];
                    $booking_info[$count]['vehicle_model'] = $temp_row["vehicle_model"];
                    $booking_info[$count]['vehicle_company'] = $temp_row["vehicle_company"];
                    $booking_info[$count]['passing_year'] = $temp_row["passing_year"];
                    $booking_info[$count]['wheeler_type'] = $temp_row["wheeler_type"];
                    $booking_info[$count]['fule'] = $temp_row["fule"];
                    $booking_info[$count]['transmission'] = $temp_row["transmission"];
                    $booking_info[$count]['driver_id'] = $temp_row["driver_id"];
                    $booking_info[$count]['booking_id'] = $driver_booking_id;
                    $driver_id = $temp_row['driver_id'];
                }

                $temp_result_1 = $connetion->query("SELECT * FROM `driver_details` where driver_id = '$driver_id';");
                if ($temp_result_1->num_rows > 0) 
                {
                    while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                    {
                        $driver_user_id = $temp_row_1['visitor_id'];

                        $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$driver_user_id';");
                        if ($temp_result_2->num_rows > 0) 
                        {
                            while($temp_row_2 = $temp_result_2->fetch_assoc()) 
                            {
                                $booking_info[$count]['first_name'] = $temp_row_2['first_name'];
                                $booking_info[$count]['last_name'] = $temp_row_2['last_name'];
                                $booking_info[$count]['contact'] = $temp_row_2['mobile_number'];
                                $booking_info[$count]['profile_pic'] = $temp_row_2['driver_profile_pic'];   
                            }
                        }
                    }
                }

                $booking_info[$count]['first_name_first_char'] = substr($booking_info[$count]['first_name'], 0, 1);

            }
            $count++;
        }
    }

    print(json_encode($booking_info));

?>