<?php

    $connetion = new mysqli("localhost","root","","vrs");
    
    $user_id = "sneh";
    $price = "500";
    $result = "";
    $driver_id;
    $skill = "";
    $fule_types = "";
    $transmissions = "";
    $city = "";
    $state = "";
    $country = "";
    $pin_code = "";

    $user_id = $_POST['user_id'];
    $price = $_POST['price'];
    $skill = $_POST['skill'];
    $fule_types = $_POST['fule_type'];
    $transmissions = $_POST['transmission'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $pin_code = $_POST['pin_code'];

    $folder_name = "images/images_of_driver_$user_id";
    if (!is_dir($folder_name)) 
    {
        mkdir($folder_name);
        // echo "Folder created successfully.";
    } 
    else 
    {
        // echo "Folder already exists.";
        $files = glob($folder_name.'/*'); // Get all files in the directory
        foreach($files as $file)
        {
            if(is_file($file)) // Check if it's a file
            unlink($file); // Delete the file
        }
        // echo "All files deleted successfully.";
    }

    $result = $connetion->query("SELECT count(*) FROM `driver_details`;");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $driver_id = $row["count(*)"];
        }
    }

    $driver_id++;

    try
    {
        $query = $connetion->prepare("UPDATE `login` SET  driver_id = $driver_id,driver_price = $price , skill = '$skill', fule = '$fule_types', transmission = '$transmissions' where user_id  = '$user_id'");
        $query->execute();
        
        $query = $connetion->prepare("insert into driver_details values($driver_id,'$user_id','true','$city','$state','$country','$pin_code')");
        $query->execute();

        $query = $connetion->prepare("create table driver_{$user_id}_history(booking_id bigint)");
        $query->execute();

        $query = $connetion->prepare("create table driver_{$user_id}_current_booking(driver_booking_id bigint , booking_code varchar(6))");
        $query->execute();

        $query = $connetion->prepare("create table driver_{$user_id}_report (id int, reason varchar(50), description varchar(250), date varchar(10), time varchar(8), visitor_id varchar(100))");

        $query->execute();
        
        $result = "success";
    }
    catch(Exception $e)
    {
        $result = "unsuccess";
    }

    print(json_encode($result));

?>