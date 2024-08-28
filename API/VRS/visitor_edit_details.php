<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $first_name = "";
    $last_name = "";
    $mobile_number = "";
    $gender = "";
    $birth_date = "";
    $city = "";
    $state = "";
    $country = "";
    $pin_code = "";
    $result = "";

    $user_id = $_POST['user_id'];
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $mobile_number = $_POST['mobile_number'];
    $gender = $_POST['gender'];
    $birth_date = $_POST['birth_date'];
    $city = $_POST['city'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $pin_code = $_POST['pin_code'];

    try 
    {

        $query = $connetion->prepare("UPDATE `login` SET `first_name`='$first_name',`last_name`='$last_name',`mobile_number`='$mobile_number',`birth_date`='$birth_date',`gender`='$gender',`city`='$city',`state`='$state',`country`='$country',`pin_code`='$pin_code' where user_id = '$user_id'");
        $query->execute();
        $result = "sucessfull";

    } catch (\Throwable $th) {
        $result = "unsucessfull";
    }

    print(json_encode($result));

?>