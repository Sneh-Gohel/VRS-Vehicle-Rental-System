<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $vehicle_id = "2";
    $result = "";
    $report_reason = "";
    $fetch_report_reason = "";
    $current_id = "";
    $vehicle_owner_user_id = "";
    $mismatch_documents_count = 1;
    $Wrong_information_of_vehicle_count = 1;
    $other_count = 1;
    $Mismatch_documents = false;
    $Wrong_information_of_vehicle = false;
    $other = false;
    $checker = false;
    $id = 0;
    $vehicle_out_of_rent = false;
    $vehicle_out_of_rent_miss_match_information_id = "";
    $vehicle_out_of_rent_wrong_information_of_vehicle_id = "";
    $vehicle_out_of_rent_other_id = "";
    $user_block = false;

    $vehicle_id = $_POST['vehicle_id'];

    try 
    {

        $result = $connetion->query("SELECT * FROM `vehicle_{$vehicle_id}_report`");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {

                $report_reason = $row['reason'];
                $current_id = $row['id'];

                if($report_reason == "Mismatch documents")
                {
                    if($Mismatch_documents == false)
                    {
                        $temp_result = $connetion->query("SELECT * FROM `vehicle_{$vehicle_id}_report` where id != $current_id");
        
                        if ($temp_result->num_rows > 0) 
                        {
                            while($temp_row = $temp_result->fetch_assoc()) 
                            {

                                $fetch_report_reason = $temp_row['reason'];
                                $fetch_temp_report_id = $temp_row['id'];

                                if($report_reason == $fetch_report_reason)
                                {
                                    $mismatch_documents_count++;

                                    if($mismatch_documents_count == 5)
                                    {

                                        $Mismatch_documents = true;

                                        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
                                        $query->execute();

                                        $temp_result_1 = $connetion->query("select * from vehicle_details where vehicle_id = $vehicle_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                                            {
                                                $vehicle_owner_user_id = $temp_row_1['vehicle_owner_user_id'];

                                                $temp_result_2 = $connetion->query("select count(*) from visitor_{$vehicle_owner_user_id}_notification");
                                                if ($temp_result_2->num_rows > 0)
                                                {
                                                    while($temp_row_2 = $temp_result_2->fetch_assoc()) 
                                                    {
                                                        $id = $temp_row_2['count(*)'];
                                                    }
                                                }

                                                $id++;

                                                $query = $connetion->prepare("INSERT INTO visitor_{$vehicle_owner_user_id}_notification values($id,'$fetch_temp_report_id',\"vehicle_out_of_rent\",'$vehicle_id','')");
                                                $query->execute();

                                            }
                                        }

                                    }
                                    if($mismatch_documents_count == 10)
                                    {

                                        $Mismatch_documents = true;

                                        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
                                        $query->execute();

                                        $temp_result_1 = $connetion->query("select * from vehicle_details where vehicle_id = $vehicle_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $result->fetch_assoc()) 
                                            {
                                                $vehicle_owner_user_id = $temp_row_1['vehicle_owner_user_id'];
                                            }
                                        }

                                        $temp_result_1 = $connetion->query("select * from login where user_id = $vehicle_owner_user_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $result->fetch_assoc()) 
                                            {
                                                $mobile_number = $temp_row_1['mobile_number'];
                                            }
                                        }

                                        $query = $connetion->prepare("INSERT INTO block_user_id values ($vehicle_owner_user_id,$mobile_number)");
                                        $query->execute();

                                    }
                                    else
                                    {
                                        $Mismatch_documents = true;
                                    }
                                }

                            }
                        }
                    }
                }
                elseif($report_reason == "Wrong information of vehicle")
                {
                    if($Wrong_information_of_vehicle == false)
                    {
                        $temp_result = $connetion->query("SELECT * FROM `vehicle_{$vehicle_id}_report` where id != $current_id");
        
                        if ($temp_result->num_rows > 0) 
                        {
                            while($temp_row = $temp_result->fetch_assoc()) 
                            {

                                $fetch_report_reason = $temp_row['reason'];
                                $fetch_temp_report_id = $temp_row['id'];

                                if($report_reason == $fetch_report_reason)
                                {
                                    $Wrong_information_of_vehicle_count++;

                                    if($Wrong_information_of_vehicle_count == 5)
                                    {

                                        $Wrong_information_of_vehicle = true;

                                        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
                                        $query->execute();

                                        $temp_result_1 = $connetion->query("select * from vehicle_details where vehicle_id = $vehicle_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $result->fetch_assoc()) 
                                            {
                                                $vehicle_owner_user_id = $temp_row_1['vehicle_owner_user_id'];

                                                $temp_result_2 = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
                                                if ($temp_result_2->num_rows > 0)
                                                {
                                                    while($temp_row_2 = $temp_result_2->fetch_assoc()) 
                                                    {
                                                        $id = $temp_row_2['count(*)'];
                                                    }
                                                }

                                                $id++;

                                                $query = $connetion->prepare("INSERT INTO visitor_{$vehicle_owner_user_id}_notification values($id,'$fetch_temp_report_id',\"vehicle_out_of_rent\",'$vehicle_id','')");
                                                $query->execute();

                                            }
                                        }

                                    }
                                    if($Wrong_information_of_vehicle_count == 10)
                                    {

                                        $Wrong_information_of_vehicle = true;

                                        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
                                        $query->execute();

                                        $temp_result_1 = $connetion->query("select * from vehicle_details where vehicle_id = $vehicle_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                                            {
                                                $vehicle_owner_user_id = $temp_row_1['vehicle_owner_user_id'];
                                            }
                                        }

                                        $temp_result_1 = $connetion->query("select * from login where user_id = $vehicle_owner_user_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                                            {
                                                $mobile_number = $temp_row_1['mobile_number'];
                                            }
                                        }

                                        $query = $connetion->prepare("INSERT INTO block_user_id values ($vehicle_owner_user_id,$mobile_number)");
                                        $query->execute();

                                    }
                                }

                            }
                        }
                    }
                }
                elseif($report_reason == "other")
                {
                    if($other == false)
                    {
                        $temp_result = $connetion->query("SELECT * FROM `vehicle_{$vehicle_id}_report` where id != $current_id");
        
                        if ($temp_result->num_rows > 0) 
                        {
                            while($temp_row = $temp_result->fetch_assoc()) 
                            {

                                $fetch_report_reason = $temp_row['reason'];
                                $fetch_temp_report_id = $temp_row['id'];

                                if($report_reason == $fetch_report_reason)
                                {
                                    $other_count++;

                                    if($other_count == 5)
                                    {

                                        $other = true;

                                        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
                                        $query->execute();

                                        $temp_result_1 = $connetion->query("select * from vehicle_details where vehicle_id = $vehicle_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                                            {
                                                $vehicle_owner_user_id = $temp_row_1['vehicle_owner_user_id'];

                                                $temp_result_2 = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
                                                if ($temp_result_2->num_rows > 0)
                                                {
                                                    while($temp_row_2 = $temp_result_2->fetch_assoc()) 
                                                    {
                                                        $id = $temp_row_2['count(*)'];
                                                    }
                                                }

                                                $id++;

                                                $query = $connetion->prepare("INSERT INTO visitor_{$vehicle_owner_user_id}_notification values($id,'$fetch_temp_report_id',\"vehicle_out_of_rent\",'$vehicle_id','')");
                                                $query->execute();

                                            }
                                        }

                                    }
                                    if($other_count == 10)
                                    {

                                        $other = true;

                                        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
                                        $query->execute();

                                        $temp_result_1 = $connetion->query("select * from vehicle_details where vehicle_id = $vehicle_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                                            {
                                                $vehicle_owner_user_id = $temp_row_1['vehicle_owner_user_id'];

                                                $temp_result_2 = $connetion->query("select count(*) from visitor_{$driver_user_id}_notification");
                                                if ($temp_result_2->num_rows > 0)
                                                {
                                                    while($temp_row_2 = $temp_result_2->fetch_assoc()) 
                                                    {
                                                        $id = $temp_row_2['count(*)'];
                                                    }
                                                }

                                                $id++;

                                                $query = $connetion->prepare("INSERT INTO visitor_{$vehicle_owner_user_id}_notification values($id,'$fetch_temp_report_id',\"vehicle_out_of_rent\",'$vehicle_id','')");
                                                $query->execute();

                                            }
                                        }

                                    }
                                    if($other_count == 15)
                                    {

                                        $other = true;

                                        $query = $connetion->prepare("UPDATE vehicle_details set active = 'false' where vehicle_id = '$vehicle_id'");
                                        $query->execute();

                                        $temp_result_1 = $connetion->query("select * from vehicle_details where vehicle_id = $vehicle_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                                            {
                                                $vehicle_owner_user_id = $temp_row_1['vehicle_owner_user_id'];
                                            }
                                        }

                                        $temp_result_1 = $connetion->query("select * from login where user_id = $vehicle_owner_user_id");
                                        if ($temp_result_1->num_rows > 0)
                                        {
                                            while($temp_row_1 = $temp_result_1->fetch_assoc()) 
                                            {
                                                $mobile_number = $temp_row_1['mobile_number'];
                                            }
                                        }

                                        $query = $connetion->prepare("INSERT INTO block_user_id values ($vehicle_owner_user_id,$mobile_number)");
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

    } 
    catch (\Throwable $th) 
    {
        $checker = "false";
    }

    print(json_encode($checker)); 
    // print(json_encode($mismatch_documents_count)); 

?>