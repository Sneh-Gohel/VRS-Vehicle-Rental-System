<?php

    $connetion = new mysqli("localhost","root","","vrs");
    
    $user_id = "sneh";
    $price = "500";
    $result = "";
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

    try
    {
        $query = $connetion->prepare("UPDATE `login` SET  driver_price = $price , skill = '$skill', fule = '$fule_types', transmission = '$transmissions' where user_id  = '$user_id'");
        $query->execute();
        
        $result = "success";
    }
    catch(Exception $e)
    {
        $result = "unsuccess";
    }

    print(json_encode($result));

?>