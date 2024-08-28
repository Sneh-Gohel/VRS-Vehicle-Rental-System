<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $booking_id = "";
    $ending_date = "";
    $current_date = date("d/m/Y");
    $days_indeicator = 0;
    $vehicle_id = "";
    $vehicle_owner_user_id = "";
    $driver_id = "";
    $driver_user_id = "";
    $visitor_id = "";

    $user_id = $_POST['user_id'];

    $result = $connetion->query("SELECT * FROM `visitor_{$user_id}_vehicle_active_booking`");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $booking_id = $row['vehicle_booking_id'];

            $temp_result = $connetion->query("SELECT * FROM `vehicle_booking` where booking_id = '$booking_id'");
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {
                    $ending_date = $temp_row["ending_date"]; 
                    $vehicle_id = $temp_row['vehicle_id'];
                    
                    $days_indeicator = get_days_count_indicator($current_date,$ending_date);

                    if($days_indeicator < 0)
                    {
                        $temp_result_1 = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$vehicle_id'");
                        if ($temp_result_1->num_rows > 0) 
                        {
                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                            {
                                $vehicle_owner_user_id = $temp_row_1["vehicle_owner_user_id"];

                                $query = $connetion->prepare("delete from renter_{$vehicle_owner_user_id}_current_booking where vehicle_booking_id = $booking_id");
                                $query->execute();

                                $query = $connetion->prepare("insert into vehicle_{$vehicle_id}_history values($booking_id);");
                                $query->execute();

                                $query = $connetion->prepare("delete from visitor_{$user_id}_vehicle_active_booking where vehicle_booking_id = $booking_id");
                                $query->execute();

                                $query = $connetion->prepare("insert into visitor_{$user_id}_vehicle_history values($booking_id);");
                                $query->execute();
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    $result = $connetion->query("SELECT * FROM `visitor_{$user_id}_driver_active_booking`");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $booking_id = $row['driver_booking_id'];

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$booking_id'");
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {
                    $ending_date = $temp_row["ending_date"];
                    $driver_id = $temp_row['driver_id'];
                    
                    $days_indeicator = get_days_count_indicator($current_date,$ending_date);

                    if($days_indeicator < 0)
                    {
                        $temp_result_1 = $connetion->query("SELECT * FROM `driver_details` where driver_id = '$driver_id'");
                        if ($temp_result_1->num_rows > 0) 
                        {
                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                            {
                                $driver_user_id = $temp_row_1["visitor_id"];

                                $query = $connetion->prepare("delete from driver_{$driver_user_id}_current_booking where driver_booking_id = $booking_id");
                                $query->execute();

                                $query = $connetion->prepare("insert into driver_{$driver_user_id}_history values($booking_id);");
                                $query->execute();

                                $query = $connetion->prepare("delete from visitor_{$user_id}_driver_active_booking where driver_booking_id = $booking_id");
                                $query->execute();

                                $query = $connetion->prepare("insert into visitor_{$user_id}_driver_history values($booking_id);");
                                $query->execute();

                            }
                        }
                    }
                }
            }
        }
    }

    $result = $connetion->query("SELECT * FROM `renter_{$user_id}_current_booking`");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $booking_id = $row['vehicle_booking_id'];

            $temp_result = $connetion->query("SELECT * FROM `vehicle_booking` where booking_id = '$booking_id'");
            if ($temp_result->num_rows > 0) 
            {
                while($temp_row = $temp_result->fetch_assoc()) 
                {
                    $ending_date = $temp_row["ending_date"];
                    $vehicle_id = $temp_row['vehicle_id'];
                    $visitor_id = $temp_row['visitor_id'];
                    
                    $days_indeicator = get_days_count_indicator($current_date,$ending_date);

                    if($days_indeicator < 0)
                    {

                        $query = $connetion->prepare("delete from renter_{$user_id}_current_booking where vehicle_booking_id = $booking_id");
                        $query->execute();

                        $query = $connetion->prepare("insert into vehicle_{$vehicle_id}_history values($booking_id);");
                        $query->execute();

                        $query = $connetion->prepare("delete from visitor_{$visitor_id}_vehicle_active_booking where vehicle_booking_id = $booking_id");
                                $query->execute();

                        $query = $connetion->prepare("insert into visitor_{$visitor_id}_vehicle_history values($booking_id);");
                        $query->execute();
     
                    }
                }
            }
        }
    }

    $result = $connetion->query("select driver_id FROM login where user_id = '$user_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_id = $row["driver_id"];
        }
    }

    if($driver_id != "")
    {
        $result = $connetion->query("SELECT * FROM `driver_{$user_id}_current_booking`");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $booking_id = $row['driver_booking_id'];

                $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$booking_id'");
                if ($temp_result->num_rows > 0) 
                {
                    while($temp_row = $temp_result->fetch_assoc()) 
                    {
                        $ending_date = $temp_row["ending_date"];
                        $driver_id = $temp_row['driver_id'];
                        $visitor_id = $temp_row['visitor_id'];
                        
                        $days_indeicator = get_days_count_indicator($current_date,$ending_date);

                        if($days_indeicator < 0)
                        {

                            $query = $connetion->prepare("delete from driver_{$user_id}_current_booking where driver_booking_id = $booking_id");
                            $query->execute();

                            $query = $connetion->prepare("insert into driver_{$user_id}_history values($booking_id);");
                            $query->execute();

                            $query = $connetion->prepare("delete from visitor_{$visitor_id}_driver_active_booking where driver_booking_id = $booking_id");
                                    $query->execute();

                            $query = $connetion->prepare("insert into visitor_{$visitor_id}_driver_history values($booking_id);");
                            $query->execute();
        
                        }
                    }
                }
            }
        }
    }

    print(json_encode("done"));

    function get_days_count_indicator($current_date,$ending_date)
    {

        $days_indeicator = 0;

        $current_date_parts = explode("/", $current_date);

        // print_r($current_date_parts);

        $current_date_day = $current_date_parts[0];
        $current_date_month = $current_date_parts[1];

        $ending_date_parts = explode("/",$ending_date);
        
        // print_r($ending_date_parts);

        $ending_date_day = $ending_date_parts[0];
        $ending_date_month = $ending_date_parts[1];
        
        if(($ending_date_month - $current_date_month) > 0)
        {
            $days_indeicator = 1;
        }
        else if(($ending_date_month - $current_date_month) < 0)
        {
            $days_indeicator = -1;
        }
        else
        {
            $days_indeicator = 0;
        }

        if($days_indeicator == 0)
        {
            if(($ending_date_day - $current_date_day) >= 0)
            {
                $days_indeicator = 1;
            }
            elseif(($ending_date_day - $current_date_day) < 0)
            {
                $days_indeicator = -1;
            }
            else
            {
                $days_indeicator = 0;
            }
        }

        return $days_indeicator;

    }

?>