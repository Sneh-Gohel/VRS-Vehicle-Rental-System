<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "ayan";
    $booking_id = 0;
    $booking_details;
    $visitor_id = "";
    $vehicle_id = 0; 
    $count = 0;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("select * from renter_${user_id}_current_booking;");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $booking_id = $row['vehicle_booking_id'];
            
            $booking_details[$count]['booking_id'] = $booking_id;
            
            $temp_result = $connetion->query("SELECT * FROM vehicle_booking WHERE booking_id = $booking_id;");
            if($temp_result->num_rows > 0)
            {
                while($temp_row = $temp_result->fetch_assoc())
                {
                    
                    $booking_details[$count]['starting_date'] = $temp_row['starting_date'];
                    $booking_details[$count]['ending_date'] = $temp_row['ending_date'];
                    $booking_details[$count]['booking_date'] = $temp_row['booking_date'];
                    $booking_details[$count]['booking_time'] = $temp_row['booking_time'];
                    $booking_details[$count]['days'] = $temp_row['days'];
                    $booking_details[$count]['price'] = $temp_row['price'];
                    $booking_details[$count]['description'] = $temp_row['description'];
                    $visitor_id = $temp_row['visitor_id'];
                    $vehicle_id = $temp_row['vehicle_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM login WHERE user_id = '$visitor_id';");
                    if($temp_result_1->num_rows > 0)
                    {
                        while($temp_row_1 = $temp_result_1->fetch_assoc())
                        {
                            $booking_details[$count]['first_name'] = $temp_row_1['first_name'];
                            $booking_details[$count]['last_name'] = $temp_row_1['last_name'];
                            $booking_details[$count]['contact'] = $temp_row_1['mobile_number'];
                            $booking_details[$count]['birth_date'] = $temp_row_1['birth_date'];
                            $booking_details[$count]['gender'] = $temp_row_1['gender'];
                        }
                    }
                    
                    $temp_result_1 = $connetion->query("SELECT * FROM vehicle_details WHERE vehicle_id = $vehicle_id;");
                    if($temp_result_1->num_rows > 0)
                    {
                        while($temp_row_1 = $temp_result_1->fetch_assoc())
                        {
                            $booking_details[$count]['vehicle_image_1'] = $temp_row_1['vehicle_image_1'];
                            $booking_details[$count]['vehicle_model'] = $temp_row_1['vehicle_model'];
                            $booking_details[$count]['vehicle_company'] = $temp_row_1['vehicle_company'];
                            $booking_details[$count]['passing_year'] = $temp_row_1['vehicle_passing_year'];
                            $booking_details[$count]['seats'] = $temp_row_1['vehicle_seater'];
                            $booking_details[$count]['fule_type'] = $temp_row_1['vehicle_fule_type'];
                            $booking_details[$count]['transmission'] = $temp_row_1['vehicle_transmission'];
                        }
                    }

                    $year = explode("/", $booking_details[$count]['birth_date']);
                    $current_year = date('Y');
                    $booking_details[$count]['age'] = $current_year - $year[2];

                    $booking_details[$count]['first_name_first_char'] = substr($booking_details[$count]['first_name'], 0, 1);

                    $count++;
                }
            }
        }
    }

    print(json_encode($booking_details));

?>