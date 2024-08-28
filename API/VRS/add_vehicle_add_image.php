<?php

    $connetion = new mysqli("localhost","root","","vrs");  

    $is_vehicle_image = "";

    $is_rc_image = $_POST['is_rc_image'];

    if($is_rc_image == "false")
    {
        $vehicle_id = $_POST['vehicle_id'];
        $image_count = $_POST['vehicle_image_count'];
        
        $vehicle_image_name = "vehicle_image_$image_count.png";
        
        $vehicle_image = $_POST['vehicle_image'];
        
        file_put_contents("images/images_of_" .$vehicle_id. "/" .$vehicle_image_name,base64_decode($vehicle_image));
        
        $query = $connetion->prepare("UPDATE `vehicle_details` SET `vehicle_image_$image_count`='images/images_of_$vehicle_id/$vehicle_image_name' WHERE vehicle_id = $vehicle_id");
        
        $query->execute();

        print(json_encode("Done"));
    }
    else
    {
        $vehicle_id = $_POST['vehicle_id'];
        $image_count = $_POST['rc_image_count'];
        
        $rc_image_name = "rc_image_$image_count.png";
        
        $rc_image = $_POST['rc_image'];
        
        file_put_contents("images/images_of_" .$vehicle_id. "/" .$rc_image_name,base64_decode($rc_image));
        
        if($image_count == "1")
        {
            $query = $connetion->prepare("UPDATE `vehicle_details` SET vehicle_rc_image_front = 'images/images_of_$vehicle_id/$rc_image_name' WHERE vehicle_id = $vehicle_id");
            $query->execute();
        }
        else if($image_count == "2")
        {
            $query = $connetion->prepare("UPDATE `vehicle_details` SET vehicle_rc_image_bottom = 'images/images_of_$vehicle_id/$rc_image_name' WHERE vehicle_id = $vehicle_id");
            $query->execute();
        }
        
        print(json_encode("Done"));
    }

?>