<?php

$connetion = new mysqli("localhost", "root", "", "vrs");

$user_id = "sneh";
$mobile_number = "9979150856";
$result = "false";

// $user_id = $_POST['user_id'];
// $mobile_number = $_POST['mobile_number'];

if($user_id != "" && $mobile_number != "")
{
    try {

        $result = $connetion->query("select * from block_user_id where user_id = '$user_id'");
        if ($result->num_rows > 0) {
            $result = "true";
        }

        $result = $connetion->query("select * from block_user_id where mobile_number = '$mobile_number'");
        if ($result->num_rows > 0) {
            $result = "true";
        }

    } catch (\Throwable $th) {
    }
}
else if ($user_id != "") {
    try {

        $result = $connetion->query("select * from block_user_id where user_id = '$user_id'");
        if ($result->num_rows > 0) {
            $result = "true";
        }

    } catch (\Throwable $th) {
    }
}
else
{
    try {

        $result = $connetion->query("select * from block_user_id where mobile_number = '$mobile_number'");
        if ($result->num_rows > 0) {
            $result = "true";
        }

    } catch (\Throwable $th) {
    }
}


print(json_encode($result));
