<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $vehicle_id = 1;
    $vehicle_model = "ndhd";
    $vehicle_company = "sheh";
    $vehicle_price = "2580";
    $vehicle_passing_year = "208";
    $vehicle_wheeler = "2";
    $vehicle_seater = "4";
    $vehicle_fule_type = "Petorl";
    $vehicle_transmission = "Manual";
    $vehicle_number = "1234567890";

    $vehicle_id = $_POST['vehicle_id'];
    $vehicle_model = $_POST['vehicle_model'];
    $vehicle_company = $_POST['vehicle_company'];
    $vehicle_price = $_POST['vehicle_price'];
    $vehicle_passing_year = $_POST['vehicle_passing_year'];
    $vehicle_wheeler = $_POST['vehicle_wheeler'];
    $vehicle_seater = $_POST['vehicle_seater'];
    $vehicle_fule_type = $_POST['vehicle_fule_type'];
    $vehicle_transmission = $_POST['vehicle_tranmission'];
    $vehicle_number = $_POST['vehicle_number'];
    
    try {
        $query = $connetion->prepare("UPDATE `vehicle_details` SET `vehicle_model`='$vehicle_model',`vehicle_company`='$vehicle_company',`vehicle_price`='$vehicle_price',`vehicle_passing_year`='$vehicle_passing_year',`vehicle_wheeler`='$vehicle_wheeler',`vehicle_seater`='$vehicle_seater',`vehicle_fule_type`='$vehicle_fule_type',`vehicle_transmission`='$vehicle_transmission',`vehicle_number`='$vehicle_number' WHERE vehicle_id = $vehicle_id");
        
    $query->execute();

    $result = "pass";
    
    } catch (\Throwable $th) {
        $result = "fail";
    }

    print(json_encode("$result"));
    
?>