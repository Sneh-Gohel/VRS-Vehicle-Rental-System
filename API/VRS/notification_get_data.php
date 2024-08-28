<?php

$connetion = new mysqli("localhost", "root", "", "vrs");

$user_id = "temp";
$notification_information;
$count = 0;
$id = "4";
$report_id = "1";
$module = "driver_booking";
$visitor_id = "";
$driver_id = "";
$vehicle_id = "";
$reported_vehicle_id = "";
$reported_driver_id = "";

$user_id = $_POST['user_id'];

$result = $connetion->query("SELECT * FROM `visitor_{$user_id}_notification`");

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {

        $id = $row['id'];
        $report_id = $row['report_id'];
        $module = $row['module'];
        $reported_vehicle_id = $row['vehicle_id_report'];
        $reported_driver_id = $row['driver_id_report'];
        $notification_information[$count]['module'] = $module;


        //in visitor // vehicle booking notification // white color notification
        if ($module == "vehicle_booking") {
            $temp_result = $connetion->query("SELECT * FROM `vehicle_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $visitor_id = $temp_row['visitor_id'];
                    $vehicle_id = $temp_row['vehicle_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$vehicle_id'");

                    if ($temp_result_1->num_rows > 0) {
                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['pic']   = $temp_row_1['vehicle_image_1'];
                            $visitor_id = $temp_row_1['vehicle_owner_user_id'];

                            $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                            if ($temp_result_2->num_rows > 0) {
                                while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                    $notification_information[$count]['first_name']   = $temp_row_2['first_name'];
                                    $notification_information[$count]['last_name'] = $temp_row_2['last_name'];
                                }
                            }
                        }
                    }
                }
            }

        //in visitor // driver booking notification // white color notification    
        } elseif ($module == "driver_booking") {

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {

                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $driver_id = $temp_row['driver_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM `driver_details` where driver_id = '$driver_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {

                            $driver_id = $temp_row_1['visitor_id'];

                            $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$driver_id'");

                            if ($temp_result_2->num_rows > 0) {

                                while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                    $notification_information[$count]['first_name'] = $temp_row_2['first_name'];
                                    $notification_information[$count]['last_name'] = $temp_row_2['last_name'];
                                    $notification_information[$count]['pic'] = $temp_row_2['driver_profile_pic'];
                                }   
                            }
                        }
                    }
                }
            }
        
        //in renter // vehicle booking notification // blue color notification    
        } elseif ($module == "renters_vehicle_booking") {
            $temp_result = $connetion->query("SELECT * FROM `vehicle_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $visitor_id = $temp_row['visitor_id'];
                    $vehicle_id = $temp_row['vehicle_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                    if ($temp_result_1->num_rows > 0) {
                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_1['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_1['last_name'];
                        }
                    }

                    $temp_result_1 = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$vehicle_id'");

                    if ($temp_result_1->num_rows > 0) {
                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['pic']   = $temp_row_1['vehicle_image_1'];
                        }
                    }
                }
            }

        //in driver // driver booking notification // pink color notification    
        } elseif ($module == "drivers_booking") {

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {

                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $driver_id = $temp_row['visitor_id'];

                    $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                    if ($temp_result_2->num_rows > 0) {

                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_2['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_2['last_name'];
                        }
                    }

                    $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$user_id'");

                    if ($temp_result_2->num_rows > 0) {

                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                            $notification_information[$count]['pic'] = $temp_row_2['driver_profile_pic'];
                        }
                    }
                }
            }
        
        //in renter // vehicle report notification // red color notification
        } elseif ($module == "report_of_vehicle") {
            $temp_result = $connetion->query("SELECT * FROM `vehicle_{$reported_vehicle_id}_report` where id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['reason'] = $temp_row['reason'];
                    $notification_information[$count]['date'] = $temp_row['date'];
                    $notification_information[$count]['time'] = $temp_row['time'];
                    $notification_information[$count]['reported_id'] = $report_id;
                    $visitor_id = $temp_row['visitor_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_1['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_1['last_name'];
                        }
                    }
                }
            }

            $temp_result = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$reported_vehicle_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['pic'] = $temp_result['vehicle_image_1'];
                }
            }
            
        //in driver // driver report notification // red color notification
        } elseif ($module == "report_of_driver") {
            $temp_result = $connetion->query("SELECT * FROM `driver_{$reported_driver_id}_report` where id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['reason'] = $temp_row['reason'];
                    $notification_information[$count]['date'] = $temp_row['date'];
                    $notification_information[$count]['time'] = $temp_row['time'];
                    $notification_information[$count]['reported_id'] = $report_id;
                    $visitor_id = $temp_row['visitor_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_1['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_1['last_name'];
                        }
                    }
                }
            }

            $temp_result = $connetion->query("SELECT * FROM `login` where user_id = '$reported_vehicle_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['pic'] = $temp_row['driver_profile_pic'];
                }
            }
        }
        
        //in renter // vehicle booking cancel notification // blue color notification
        elseif ($module == "renter_vehicle_cancel") {
            $temp_result = $connetion->query("SELECT * FROM `vehicle_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $notification_information[$count]['cancel_date'] = $temp_row['cancel_date'];
                    $visitor_id = $temp_row['visitor_id'];
                    $vehicle_id = $temp_row['vehicle_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                    if ($temp_result_1->num_rows > 0) {
                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_1['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_1['last_name'];
                        }
                    }

                    $temp_result_1 = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$vehicle_id'");

                    if ($temp_result_1->num_rows > 0) {
                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['pic']   = $temp_row_1['vehicle_image_1'];
                        }
                    }
                }
            }
        }
        
        //in visitor // vehicle booking cancle notification // white color notification
        elseif ($module == "vehicle_booking_cancel") {
            $temp_result = $connetion->query("SELECT * FROM `vehicle_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $notification_information[$count]['cancel_date'] = $temp_row['cancel_date'];
                    $visitor_id = $temp_row['visitor_id'];
                    $vehicle_id = $temp_row['vehicle_id'];

                    $temp_result_1 = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$vehicle_id'");

                    if ($temp_result_1->num_rows > 0) {
                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['pic']   = $temp_row_1['vehicle_image_1'];
                            $visitor_id = $temp_row_1['vehicle_owner_user_id'];

                            $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                            if ($temp_result_2->num_rows > 0) {
                                while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                    $notification_information[$count]['first_name']   = $temp_row_2['first_name'];
                                    $notification_information[$count]['last_name'] = $temp_row_2['last_name'];
                                }
                            }
                        }
                    }
                }
            }
        }

        //in driver // driver booking cancel notification // pink color notification
        elseif ($module == "drivers_booking_cancel") {

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {

                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $notification_information[$count]['cancel_date'] = $temp_row['cancel_date'];
                    $visitor_id = $temp_row['visitor_id'];
                    $driver_id = $temp_row['driver_id'];

                    $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                    if ($temp_result_2->num_rows > 0) {

                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_2['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_2['last_name'];
                            $notification_information[$count]['pic'] = $temp_row_2['driver_profile_pic'];
                        }
                    }

                    $temp_result_2 = $connetion->query("SELECT * FROM `driver_details` where driver_id = '$driver_id'");

                    if ($temp_result_2->num_rows > 0) {

                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                            $driver_id = $temp_row_2['visitor_id'];
                        }
                    }

                    $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$driver_id'");

                    if ($temp_result_2->num_rows > 0) {

                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                            $notification_information[$count]['pic'] = $temp_row_2['driver_profile_pic'];
                        }
                    }
                }
            }
        }

        //in visitor // driver booking cancel notification // white color notification
        elseif ($module == "driver_booking_cancel") {

            $temp_result = $connetion->query("SELECT * FROM `driver_booking` where booking_id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {

                    $notification_information[$count]['starting_date'] = $temp_row['starting_date'];
                    $notification_information[$count]['ending_date'] = $temp_row['ending_date'];
                    $notification_information[$count]['price'] = $temp_row['price'];
                    $notification_information[$count]['booking_date'] = $temp_row['booking_date'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $notification_information[$count]['cancel_date'] = $temp_row['cancel_date'];
                    $driver_id = $temp_row['driver_id'];


                    $temp_result_1 = $connetion->query("SELECT * FROM `driver_details` where driver_id = '$driver_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $driver_id = $temp_row_1['visitor_id'];

                            $temp_result_2 = $connetion->query("SELECT * FROM `login` where user_id = '$visitor_id'");

                            if ($temp_result_2->num_rows > 0) {

                                while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                    $notification_information[$count]['first_name'] = $temp_row_2['first_name'];
                                    $notification_information[$count]['last_name'] = $temp_row_2['last_name'];
                                    $notification_information[$count]['pic'] = $temp_row_2['driver_profile_pic'];
                                }
                            }
                        }
                    }
                }
            }
        }
        //in renter // vehicle report // red color notification
        elseif ($module == "vehicle_report") {

            $temp_result = $connetion->query("SELECT * FROM `vehicle_{$reported_vehicle_id}_report` where id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {

                    $notification_information[$count]['id'] = $temp_row['id'];
                    $notification_information[$count]['reason'] = $temp_row['reason'];
                    $notification_information[$count]['description'] = $temp_row['description'];
                    $notification_information[$count]['date'] = $temp_row['date'];
                    $notification_information[$count]['time'] = $temp_row['time'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $reporter_id = $temp_row['visitor_id'];


                    $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$reporter_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_1['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_1['last_name'];
                        }
                    }

                    $temp_result_1 = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$reported_vehicle_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['pic'] = $temp_row_1['vehicle_image_1'];
                        }
                    }
                }
            }
        }
        //in driver // driver report // red color notification
        elseif ($module == "driver_report") {

            $temp_result = $connetion->query("SELECT * FROM `driver_{$reported_driver_id}_report` where id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {

                    $notification_information[$count]['id'] = $temp_row['id'];
                    $notification_information[$count]['reason'] = $temp_row['reason'];
                    $notification_information[$count]['description'] = $temp_row['description'];
                    $notification_information[$count]['date'] = $temp_row['date'];
                    $notification_information[$count]['time'] = $temp_row['time'];
                    $notification_information[$count]['visitor_id'] = $temp_row['visitor_id'];
                    $reporter_id = $temp_row['visitor_id'];


                    $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$reporter_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['first_name'] = $temp_row_1['first_name'];
                            $notification_information[$count]['last_name'] = $temp_row_1['last_name'];
                        }
                    }

                    $temp_result_1 = $connetion->query("SELECT * FROM `login` where user_id = '$reported_driver_id'");

                    if ($temp_result_1->num_rows > 0) {

                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                            $notification_information[$count]['pic'] = $temp_row_1['driver_profile_pic'];
                        }
                    }
                }
            }
        }
        //in renter // vehicle out of rent notification // gradiant red and blue color notification
        elseif ($module == "vehicle_out_of_rent") {
            $temp_result = $connetion->query("SELECT * FROM `vehicle_{$reported_vehicle_id}_report` where id = '$report_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['date'] = $temp_row['date'];
                    $notification_information[$count]['time'] = $temp_row['time'];
                    $notification_information[$count]['reported_id'] = $report_id;
                    $visitor_id = $temp_row['visitor_id'];

                }
            }

            $temp_result = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_id = '$reported_vehicle_id'");

            if ($temp_result->num_rows > 0) {

                while ($temp_row = $temp_result->fetch_assoc()) {
                    $notification_information[$count]['pic'] = $temp_row['vehicle_image_1'];
                    $notification_information[$count]['vehicle_model'] = $temp_row['vehicle_model'];
                }
            }
            
        }

            $count++;
        }
}

print(json_encode($notification_information));

?>