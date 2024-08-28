<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $driver_id = "";
    $starting_date = "3";
    $ending_date = "4";
    $total_days = "1";
    $booking_date = "5";
    $booking_time = "6";
    $price = "4";
    $descrption = "sdf";
    $vehicle_model_name = "fg";
    $vehilce_company_name = "sdfg";
    $vehicle_passing_year = "3";
    $vehicle_total_wheels = "5      ";
    $vehicle_fule_type = "g";
    $vehicle_transmission = "dfg";
    $visitor_id = "sneh";
    $booking_id = "2";
    $status = "";
    $driver_user_id = "";
    $booking_code = "";

    $driver_id = $_POST['driver_id'];
    $starting_date = $_POST['starting_date'];
    $ending_date = $_POST['ending_date'];
    $total_days = $_POST['total_days'];
    $booking_date = $_POST['booking_date'];
    $booking_time = $_POST['booking_time'];
    $price = $_POST['price'];
    $descrption = $_POST['descrption'];  
    $vehicle_model_name = $_POST['vehicle_model_name'];
    $vehilce_company_name = $_POST['vehicle_company_name'];
    $vehicle_passing_year = $_POST['vehicle_passing_year'];
    $vehicle_total_wheels = $_POST['vehicle_total_wheels'];
    $vehicle_fule_type = $_POST['vehicle_fule_type'];
    $vehicle_transmission = $_POST['vehicle_tranmission'];
    $visitor_id = $_POST['visitor_id'];
    $driver_user_id = $_POST['driver_user_id'];
    $booking_code = generateCode();

    try {
        $result = $connetion->query("select count(*) from driver_booking;");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $booking_id = $row['count(*)'];
            }
        }
        
        $booking_id++;

        $query = $connetion->prepare("INSERT INTO `driver_booking` VALUES ('$booking_id','$starting_date','$ending_date','$booking_date','$booking_time',$total_days,$price,'$descrption','$vehicle_model_name','$vehilce_company_name',$vehicle_passing_year,$vehicle_total_wheels,'$vehicle_fule_type','$vehicle_transmission','$visitor_id',$driver_id,'');");
        $query->execute();
    
        $query = $connetion->prepare("insert into driver_{$driver_user_id}_current_booking values($booking_id,'$booking_code')");
        $query->execute(); 
    
        $query = $connetion->prepare("insert into visitor_{$visitor_id}_driver_active_booking values($booking_id,'$booking_code')");
        $query->execute();

        $result = $connetion->query("select count(*) from visitor_{$visitor_id}_notification");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connetion->prepare("INSERT INTO visitor_{$visitor_id}_notification values($id,'$booking_id',\"driver_booking\",'','')");
        $query->execute();

        $result = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
        if ($result->num_rows > 0)
        {
            while($row = $result->fetch_assoc()) 
            {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connetion->prepare("INSERT INTO visitor_{$driver_user_id}_notification values($id,'$booking_id',\"drivers_booking\",'','')");
        $query->execute();

        $status = "successfull";

    } catch (Exception $e) {
        $status = "unsuccessfull";
    }

    print(json_encode($status)); 

    function generateCode() 
    {
        $characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$*_+';
        $code = '';
        $max = strlen($characters) - 1;
        
        for ($i = 0; $i < 6; $i++) {
          $code .= $characters[mt_rand(0, $max)];
        }
        
        return $code;
    }

?>