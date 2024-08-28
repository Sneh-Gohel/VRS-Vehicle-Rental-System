<?php

    $connection = new mysqli("localhost", "root", "", "vrs");

    $user_id = $_POST['user_id'];
    $driver_booking_id = $_POST['driver_booking_id'];
    $current_date = $_POST['current_date'];

    try {
        $result = $connection->query("SELECT * FROM `driver_booking` WHERE booking_id = $driver_booking_id;");
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $driver_id = $row['driver_id'];
            }
        }

        $result = $connection->query("SELECT * from driver_details where driver_id = '$driver_id'");
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $driver_user_id = $row['visitor_id'];
            }
        }

        $query = $connection->prepare("UPDATE `driver_booking` SET `cancel_date`='$current_date' WHERE booking_id = '$driver_booking_id'");
        $query->execute();

        $query = $connection->prepare("delete from driver_{$driver_user_id}_current_booking where driver_booking_id = '$driver_booking_id'");
        $query->execute();

        $query = $connection->prepare("delete from visitor_{$user_id}_driver_active_booking where driver_booking_id = '$driver_booking_id'");
        $query->execute();

        $result = $connection->query("select count(*) from visitor_{$driver_user_id}_notification");
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connection->prepare("INSERT INTO visitor_{$driver_user_id}_notification VALUES($id,$driver_booking_id,'drivers_booking_cancel','','')");
        $query->execute();

        $result = $connection->query("select count(*) from visitor_{$user_id}_notification");
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $id = $row['count(*)'];
            }
        }

        $id++;

        $query = $connection->prepare("INSERT INTO visitor_{$user_id}_notification VALUES($id,$driver_booking_id,'driver_booking_cancel','','')");
        $query->execute();

        $result = "successful";
    } catch(Exception $e) {
        $result = "unsuccessful";
    }

    print(json_encode($result));

?>
