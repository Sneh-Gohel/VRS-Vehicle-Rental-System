<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $vehicle_id = 0;
    $vehicle_model = "a";
    $vehicle_company = "b";
    $vehicle_price = "3";
    $vehicle_passing_year = "2003";
    $vehicle_wheeler = "2";
    $vehicle_seater = "2";
    $vehicle_fule_type = "petrol";
    $vehicle_transmission = "auto";
    $vehicle_number = "asldkfh";
    $vehicle_owner_user_id = "sneh";
    $city = "";
    $state = "";
    $country = "";
    $pin_code = "";


    $result = $connetion->query("select count(vehicle_id) FROM vehicle_details");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $vehicle_id = $row["count(vehicle_id)"];
        }
    }
    $vehicle_id++;
    
    $folder_name = "images/images_of_$vehicle_id";
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

    $vehicle_model = $_POST['vehicle_model'];
    $vehicle_company = $_POST['vehicle_company'];
    $vehicle_price = $_POST['vehicle_price'];
    $vehicle_passing_year = $_POST['vehicle_passing_year'];
    $vehicle_wheeler = $_POST['vehicle_wheeler'];
    $vehicle_seater = $_POST['vehicle_seater'];
    $vehicle_fule_type = $_POST['vehicle_fule_type'];
    $vehicle_transmission = $_POST['vehicle_tranmission'];
    $vehicle_number = $_POST['vehicle_number'];
    $vehicle_owner_user_id = $_POST['vehicle_owner_user_id'];

    $result = $connetion->query("select * FROM login where user_id = '$vehicle_owner_user_id'");

    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {
            $city = $row['city'];
            $state = $row['state'];
            $country = $row['country'];
            $pin_code = $row['pin_code'];
        }
    }
    
    $query = $connetion->prepare("INSERT INTO vehicle_details VALUES ('$vehicle_id','v','','','','','$vehicle_model','$vehicle_company','$vehicle_price','$vehicle_passing_year','$vehicle_wheeler','$vehicle_seater','$vehicle_fule_type','$vehicle_transmission','$vehicle_number','r','r','$vehicle_owner_user_id','$city','$state','$country','$pin_code','true')");
        
    $query->execute();
    
    $query = $connetion->prepare("INSERT INTO `renter_{$vehicle_owner_user_id}_vehicle_list` VALUES ($vehicle_id)");
    
    $query->execute();
    
    $query = $connetion->prepare("create table vehicle_{$vehicle_id}_history (vehicle_booking_id bigint)");

    $query->execute();

    $query = $connetion->prepare("create table vehicle_{$vehicle_id}_report (id int, reason varchar(50), description varchar(250), date varchar(10), time varchar(8), visitor_id varchar(100))");

    $query->execute();

    print(json_encode("$vehicle_id"));
    
?>