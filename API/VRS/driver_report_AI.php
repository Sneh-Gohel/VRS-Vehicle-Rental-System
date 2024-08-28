<?php

$connetion = new mysqli("localhost", "root", "", "vrs");

$driver_id = "2";
$driver_user_id = "";
$result = "";
$report_reason = "";
$fetch_report_reason = "";
$current_id = "";
$driver_owner_user_id = "";
$mismatch_documents_count = 1;
$Wrong_information_of_driver_count = 1;
$other_count = 1;
$Mismatch_documents = false;
$Wrong_information_of_driver = false;
$other = false;
$checker = false;
$id = 0;
$driver_out_of_booking = false;
$driver_out_of_booking_miss_match_information_id = "";
$driver_out_of_booking_wrong_information_of_driver_user_id = "";
$driver_out_of_booking_other_id = "";
$user_block = false;

$driver_id = $_POST['driver_id'];

$result = $connetion->query("select * from driver_details where driver_id = $driver_id");
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $driver_user_id = $row['visitor_id'];
    }
}

try {

    $result = $connetion->query("SELECT * FROM `driver_{$driver_user_id}_report`");
    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {

            $report_reason = $row['reason'];
            $current_id = $row['id'];

            if ($report_reason == "Mismatch documents") {
                if ($Mismatch_documents == false) {
                    $temp_result = $connetion->query("SELECT * FROM `driver_{$driver_user_id}_report` where id != $current_id");

                    if ($temp_result->num_rows > 0) {
                        while ($temp_row = $temp_result->fetch_assoc()) {

                            $fetch_report_reason = $temp_row['reason'];
                            $fetch_temp_report_id = $temp_row['id'];

                            if ($report_reason == $fetch_report_reason) {
                                $mismatch_documents_count++;

                                if ($mismatch_documents_count == 5) {

                                    $Mismatch_documents = true;

                                    $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
                                    $query->execute();

                                    $temp_result_2 = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
                                    if ($temp_result_2->num_rows > 0) {
                                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                            $id = $temp_row_2['count(*)'];
                                        }
                                    }

                                    $id++;

                                    $query = $connetion->prepare("INSERT INTO visitor_{$driver_user_id}_notification values($id,'$fetch_temp_report_id',\"driver_out_of_booking\",'','$driver_user_id')");
                                    $query->execute();
                                }
                                if ($mismatch_documents_count == 10) {

                                    $Mismatch_documents = true;

                                    $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
                                    $query->execute();

                                    $temp_result_1 = $connetion->query("select * from login where user_id = $driver_user_id");
                                    if ($temp_result_1->num_rows > 0) {
                                        while ($temp_row_1 = $result->fetch_assoc()) {
                                            $mobile_number = $temp_row_1['mobile_number'];
                                        }
                                    }

                                    $query = $connetion->prepare("INSERT INTO block_user_id values ($driver_user_id,$mobile_number)");
                                    $query->execute();
                                } else {
                                    $Mismatch_documents = true;
                                }
                            }
                        }
                    }
                }
            } elseif ($report_reason == "Wrong information of driver") {
                if ($Wrong_information_of_driver == false) {
                    $temp_result = $connetion->query("SELECT * FROM `driver_{$driver_user_id}_report` where id != $current_id");

                    if ($temp_result->num_rows > 0) {
                        while ($temp_row = $temp_result->fetch_assoc()) {

                            $fetch_report_reason = $temp_row['reason'];
                            $fetch_temp_report_id = $temp_row['id'];

                            if ($report_reason == $fetch_report_reason) {
                                $Wrong_information_of_driver_count++;

                                if ($Wrong_information_of_driver_count == 5) {

                                    $Wrong_information_of_driver = true;

                                    $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
                                    $query->execute();

                                    $temp_result_2 = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
                                    if ($temp_result_2->num_rows > 0) {
                                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                            $id = $temp_row_2['count(*)'];
                                        }
                                    }

                                    $id++;

                                    $query = $connetion->prepare("INSERT INTO visitor_{$driver_user_id}_notification values($id,'$fetch_temp_report_id',\"driver_out_of_booking\",'','$driver_user_id')");
                                    $query->execute();
                                }
                                if ($Wrong_information_of_driver_count == 10) {

                                    $Wrong_information_of_driver = true;

                                    $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
                                    $query->execute();

                                    $temp_result_1 = $connetion->query("select * from login where user_id = $driver_user_id");
                                    if ($temp_result_1->num_rows > 0) {
                                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                                            $mobile_number = $temp_row_1['mobile_number'];
                                        }
                                    }

                                    $query = $connetion->prepare("INSERT INTO block_user_id values ($driver_user_id,$mobile_number)");
                                    $query->execute();
                                }
                            }
                        }
                    }
                }
            } elseif ($report_reason == "other") {
                if ($other == false) {
                    $temp_result = $connetion->query("SELECT * FROM `driver_{$driver_user_id}_report` where id != $current_id");

                    if ($temp_result->num_rows > 0) {
                        while ($temp_row = $temp_result->fetch_assoc()) {

                            $fetch_report_reason = $temp_row['reason'];
                            $fetch_temp_report_id = $temp_row['id'];

                            if ($report_reason == $fetch_report_reason) {
                                $other_count++;

                                if ($other_count == 5) {

                                    $other = true;

                                    $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
                                    $query->execute();

                                    $temp_result_2 = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
                                    if ($temp_result_2->num_rows > 0) {
                                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                            $id = $temp_row_2['count(*)'];
                                        }
                                    }

                                    $id++;

                                    $query = $connetion->prepare("INSERT INTO visitor_{$driver_user_id}_notification values($id,'$fetch_temp_report_id',\"driver_out_of_booking\",'','$driver_user_id')");
                                    $query->execute();
                                }
                                if ($other_count == 10) {

                                    $other = true;

                                    $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
                                    $query->execute();

                                    $temp_result_2 = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
                                    if ($temp_result_2->num_rows > 0) {
                                        while ($temp_row_2 = $temp_result_2->fetch_assoc()) {
                                            $id = $temp_row_2['count(*)'];
                                        }
                                    }

                                    $id++;

                                    $query = $connetion->prepare("INSERT INTO visitor_{$driver_user_id}_notification values($id,'$fetch_temp_report_id',\"driver_out_of_booking\",'','$driver_user_id')");
                                    $query->execute();
                                }
                                if ($other_count == 15) {

                                    $other = true;

                                    $query = $connetion->prepare("UPDATE driver_details set active = 'false' where driver_id = '$driver_id'");
                                    $query->execute();

                                    $temp_result_1 = $connetion->query("select * from login where user_id = $driver_user_id");
                                    if ($temp_result_1->num_rows > 0) {
                                        while ($temp_row_1 = $temp_result_1->fetch_assoc()) {
                                            $mobile_number = $temp_row_1['mobile_number'];
                                        }
                                    }

                                    $query = $connetion->prepare("INSERT INTO block_user_id values ($driver_user_id,$mobile_number)");
                                    $query->execute();
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    $checker = "true";
} catch (\Throwable $th) {
    $checker = "false";
}

print(json_encode($checker)); 
    // print(json_encode($mismatch_documents_count)); 
