<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $driver_id = "1";
    $driver_user_id = "";
    $booking_starting_date = "29/04/2023";
    $booking_ending_date = "03/05/2023";
    $ending_date = "";
    $available = false;
    $count = 0;
    $booking_id = "";

    $driver_id = $_POST['driver_id'];
    $booking_starting_date = $_POST['booking_starting_date'];
    $booking_ending_date = $_POST['booking_ending_date'];

    $result = $connetion->query("SELECT * FROM `driver_details` where driver_id = '$driver_id'");
    if ($result->num_rows > 0) 
    {
        while($row = $result->fetch_assoc()) 
        {

            $driver_user_id = $row['visitor_id'];

            $result_1 = $connetion->query("SELECT * FROM `driver_{$driver_user_id}_current_booking`");
            if ($result_1->num_rows > 0) 
            {
                while($row_1 = $result_1->fetch_assoc()) 
                {

                    $booking_id = $row_1['driver_booking_id'];

                    $result_2 = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$booking_id'");
                    if ($result_2->num_rows > 0) 
                    {
                        while($row_2 = $result_2->fetch_assoc()) 
                        {

                            $starting_date = $row_2['starting_date'];
                            $ending_date = $row_2['ending_date'];

                            $count = $count + avaiblity_cheker($starting_date,$ending_date,$booking_starting_date,$booking_ending_date);

                        }
                    }

                }
            }

        }
    }

    print(json_encode($count));

    function avaiblity_cheker($fetch_starting_date,$fetch_ending_date,$starting_date,$ending_date)
    {

        // $fetch_starting_date_parts = explode("/", $fetch_starting_date);
        // $fetch_ending_date_parts = explode("/", $fetch_ending_date);
        // $starting_date_parts = explode("/", $starting_date);
        // $ending_date_parts = explode("/", $ending_date);

        $counter = 0;
        // $available = true;
        if(dateInRange($fetch_starting_date,$starting_date,$ending_date))
        {
            $available = false;
            $counter++;
            // echo ($fetch_starting_date ." " . $starting_date. " " . $ending_date . "<br>");
        }
        if(dateInRange($fetch_ending_date,$starting_date,$ending_date))
        {
            $available = false;
            $counter++;
            // echo ($fetch_ending_date ." " . $starting_date. " " . $ending_date . "<br>");
        }
        if(dateRangeInRange($fetch_starting_date,$fetch_ending_date,$starting_date,$ending_date))
        {
            $available = false;
            $counter++;
            // echo ($fetch_starting_date . " " . $fetch_ending_date. " " . $starting_date. " " . $ending_date . "<br>");
        }
        if(dateInRange($starting_date,$fetch_starting_date,$fetch_ending_date))
        {
            $available = false;
            $counter++;
            // echo ($starting_date ." " . $fetch_starting_date. " " . $fetch_ending_date . "<br>");
        }
        if(dateInRange($ending_date,$fetch_starting_date,$fetch_ending_date))
        {
            $available = false;
            $counter++;
            // echo ($ending_date ." " . $fetch_starting_date. " " . $fetch_ending_date . "<br>");
        }
        if(dateRangeInRange($starting_date,$ending_date,$fetch_starting_date,$fetch_ending_date))
        {
            $available = false;
            $counter++;
            // echo ($starting_date . " " . $ending_date. " " . $fetch_starting_date. " " . $fetch_ending_date . "<br>");
        }

        return $counter;

    }

    function dateInRange($date, $startDate, $endDate) 
    {
        $dateObj = DateTime::createFromFormat('d/m/Y', $date);
        $startObj = DateTime::createFromFormat('d/m/Y', $startDate);
        $endObj = DateTime::createFromFormat('d/m/Y', $endDate);
      
        if ($dateObj >= $startObj && $dateObj <= $endObj) 
        {
          return true;
        } 
        else 
        {
          return false;
        }
    }

    function dateRangeInRange($rangeStartDate, $rangeEndDate, $startDate, $endDate) 
    {
        $rangeStartObj = DateTime::createFromFormat('d/m/Y', $rangeStartDate);
        $rangeEndObj = DateTime::createFromFormat('d/m/Y', $rangeEndDate);
        $startObj = DateTime::createFromFormat('d/m/Y', $startDate);
        $endObj = DateTime::createFromFormat('d/m/Y', $endDate);
      
        if ($rangeStartObj <= $startObj && $rangeEndObj >= $endObj) 
        {
          return true;
        } 
        else 
        {
          return false;
        }
      
    }

?>
