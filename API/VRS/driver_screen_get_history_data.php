<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $driver_history_information;
    $driver_booking_id;
    $visitor_id;
    $count = 0;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("select * FROM driver_{$user_id}_history;"); 
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_booking_id = $row["booking_id"];
            $driver_history_information[$count]['booking_id'] = $driver_booking_id;

            $temp_result = $connetion->query("select * FROM driver_booking where booking_id = '$driver_booking_id'");
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {
                    $driver_history_information[$count]['starting_date'] = $temp_row["starting_date"];
                    $driver_history_information[$count]['ending_date'] = $temp_row["ending_date"];
                    $driver_history_information[$count]['days'] = $temp_row["days"];
                    $driver_history_information[$count]['price'] = $temp_row["price"];
                    $visitor_id = $temp_row["visitor_id"];
                }
                $temp_result_1 = $connetion->query("select * FROM login where user_id = '$visitor_id'");
                if ($temp_result_1->num_rows > 0) 
                {
                    while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                    {
                        $driver_history_information[$count]['first_name'] = $temp_row_1["first_name"];
                        $driver_history_information[$count]['last_name'] = $temp_row_1["last_name"];
                        $driver_history_information[$count]['contact'] = $temp_row_1["mobile_number"];
                    }
                    $driver_history_information[$count]['first_name_first_char'] = substr($driver_history_information[$count]['first_name'], 0, 1);
                }
            }
            $count++;
        }

    }

    print(json_encode($driver_history_information));

?>