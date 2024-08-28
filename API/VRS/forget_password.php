<?php

$connetion = new mysqli("localhost", "root", "", "vrs");

$user_id = "temp";
$password = "123";
$result = "false";

$user_id = $_POST['user_id'];
$password = $_POST['password'];

try
{

    $query = $connetion->prepare("UPDATE login set password = '$password' where user_id = '$user_id'");
    $query->execute();

    $result = "true";

}
catch(Throwable $e)
{
    $result = "false";
}

print(json_encode($result));
