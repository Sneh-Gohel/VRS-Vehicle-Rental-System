<?php
    $connetion = new mysqli("localhost","root","","vrs");

    $first_name = "";
    $last_name = "";
    $mobile_number = "";
    $gender = "";
    $birth_date = "";
    $city = "";
    $state = "";
    $country = "";
    $pin_code = "";
    $user_id = "";
    $password = "";
    $status = "";

    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $mobile_number = $_POST['mobile_number'];
    $gender = $_POST['gender'];
    $birth_date = $_POST['birth_date'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $pin_code = $_POST['pin_code'];
    $user_id = $_POST['user_id'];
    $password = $_POST['password'];

    try{
        $query = $connetion->prepare("insert into login(`first_name`, `last_name`, `mobile_number`, `birth_date`, `gender` , `city`, `state`, `country`, `pin_code`, `user_id`, `password`) values('$first_name','$last_name','$mobile_number','$birth_date','$gender','$city','$state','$country','$pin_code','$user_id','$password')");
        $query->execute();
        
        $query = $connetion->prepare("create table renter_{$user_id}_vehicle_list(vehicle_list bigint)");
        $query->execute();

        $query = $connetion->prepare("create table renter_{$user_id}_current_booking(vehicle_booking_id bigint, booking_code varchar(6))");
        $query->execute();

        $query = $connetion->prepare("create table visitor_{$user_id}_driver_history(driver_booking_id bigint)");
        $query->execute();

        $query = $connetion->prepare("create table visitor_{$user_id}_driver_active_booking(driver_booking_id bigint, booking_code varchar(6))");
        $query->execute();

        $query = $connetion->prepare("create table visitor_{$user_id}_vehicle_history(driver_booking_id bigint)");
        $query->execute();

        $query = $connetion->prepare("create table visitor_{$user_id}_vehicle_active_booking(vehicle_booking_id bigint, booking_code varchar(6))");
        $query->execute();

        $query = $connetion->prepare("create table visitor_{$user_id}_notification(id int, report_id int, module varchar(100),vehicle_id_report varchar(100), driver_id_report varchar(100))");
        $query->execute();

        $status = "success";
    }
    catch(Exception $e)
    {   
        echo($e);
        $status = "unsuccess";
    }
    print(json_encode($status));
?>