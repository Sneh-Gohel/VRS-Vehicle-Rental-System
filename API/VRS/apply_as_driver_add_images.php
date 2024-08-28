<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $image_identifier = "1";
    $driver_id = "";


    $user_id = $_POST['user_id'];
    // $driver_id = $_POST['driver_id'];
    $image_identifier = $_POST['image_identifier'];

        if($image_identifier == "1")
    {

        $image_name = "driver_profile_pic.png";

        $image = $_POST['image'];

        file_put_contents("images/images_of_driver_" .$user_id. "/" .$image_name,base64_decode($image));

        $query = $connetion->prepare("UPDATE `login` SET `driver_profile_pic` = 'images/images_of_driver_${user_id}/${image_name}' WHERE user_id = '$user_id'");
        $query->execute();

        print(json_encode("Done"));

    }
    elseif($image_identifier == "2")
    {
        $image_name = "driver_licence_pic_1.png";

        $image = $_POST['image'];

        file_put_contents("images/images_of_driver_" .$user_id. "/" .$image_name,base64_decode($image));

        $query = $connetion->prepare("UPDATE `login` SET `licence_image_front` = 'images/images_of_driver_${user_id}/${image_name}' WHERE user_id = '$user_id'");
        $query->execute();

        print(json_encode("Done"));
    }
    elseif($image_identifier == "3")
    {
        $image_name = "driver_licence_2.png";

        $image = $_POST['image'];

        file_put_contents("images/images_of_driver_" .$user_id. "/" .$image_name,base64_decode($image));

        $query = $connetion->prepare("UPDATE `login` SET `licence_image_back` = 'images/images_of_driver_${user_id}/${image_name}' WHERE user_id = '$user_id'");
        $query->execute();

        print(json_encode("Done"));
    }
?>