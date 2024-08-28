<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $user_id = "sneh";
    $count = 0;

    $user_id = $_POST['user_id'];

    $result = $connetion->query("select count(*) from renter_${user_id}_current_booking;");
    if ($result->num_rows > 0)
    {
        while($row = $result->fetch_assoc())
        {
            $count = $row['count(*)'];
        }
    }

    print(json_encode($count));

?>