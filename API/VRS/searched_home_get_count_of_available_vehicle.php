<?php

    $connetion = new mysqli("localhost","root","","vrs");

    $city = "Anand";
    $state = "Gujarat";
    $country = "India";
    $pin_code = "388001";
    $count = 0;
    $user_id = "temp";
    $vehicle_search = "";
    $location_search = "bharuch";           
    $fetch_city = "";
    $fetch_state = "";
    $fetch_country = "";
    $fetch_pin_code = "";
    $fetch_vehicle_model = "";
    $fetch_vehicle_company = "";
    $fetch_vehicle_passing_year = "";

    $city = $_POST['city'];
    $state = $_POST['state'];
    $country = $_POST['country'];
    $pin_code = $_POST['pin_code'];
    $user_id = $_POST['user_id'];
    $vehicle_search = $_POST['vehicle_search'];
    $location_search = $_POST['location_search'];

    if($location_search != "")
    {
        $result = $connetion->query("SELECT * FROM `vehicle_details` where vehicle_owner_user_id != '$user_id'");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $fetch_city = $row['city'];
                $fetch_state = $row['state'];
                $fetch_country = $row['country'];
                $fetch_pin_code = $row['pin_code'];

                if (strcasecmp($fetch_city, $location_search) === 0)
                {
                    if($vehicle_search != "")
                    {
                        $temp_result = $connetion->query("SELECT * FROM `vehicle_details`where city = '$fetch_city' AND vehicle_owner_user_id != '$user_id'");
                        if ($temp_result->num_rows > 0) 
                        {
                            while($temp_row = $temp_result->fetch_assoc()) 
                            {
                                $fetch_vehicle_model = $temp_row['vehicle_model'];
                                $fetch_vehicle_company = $temp_row['vehicle_company'];
                                $fetch_vehicle_passing_year = $temp_row['vehicle_passing_year'];

                                if (strcasecmp($fetch_vehicle_model, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_company, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_passing_year, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                            }
                        }
                    }
                    else
                    {
                        $count++;
                    }
                }
                else if (strcasecmp($fetch_state, $location_search) === 0)
                {
                    if($vehicle_search != "")
                    {
                        $temp_result = $connetion->query("SELECT * FROM `vehicle_details` where state = '$fetch_state' AND vehicle_owner_user_id != '$user_id'");
                        if ($temp_result->num_rows > 0) 
                        {
                            while($temp_row = $temp_result->fetch_assoc()) 
                            {
                                $fetch_vehicle_model = $temp_row['vehicle_model'];
                                $fetch_vehicle_company = $temp_row['vehicle_company'];
                                $fetch_vehicle_passing_year = $temp_row['vehicle_passing_year'];

                                if (strcasecmp($fetch_vehicle_model, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_company, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_passing_year, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                            }
                        }
                    }
                    else
                    {
                        $count++;
                    }
                }
                else if (strcasecmp($fetch_country, $location_search) === 0)
                {
                    if($vehicle_search != "")
                    {
                        $temp_result = $connetion->query("SELECT * FROM `vehicle_details`where country = '$fetch_country' AND vehicle_owner_user_id != '$user_id'");
                        if ($temp_result->num_rows > 0) 
                        {
                            while($temp_row = $temp_result->fetch_assoc()) 
                            {
                                $fetch_vehicle_model = $temp_row['vehicle_model'];
                                $fetch_vehicle_company = $temp_row['vehicle_company'];
                                $fetch_vehicle_passing_year = $temp_row['vehicle_passing_year'];

                                if (strcasecmp($fetch_vehicle_model, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_company, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_passing_year, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                            }
                        }
                    }
                    else
                    {
                        $count++;
                    }
                }
                else if (strcasecmp($fetch_pin_code, $location_search) === 0)
                {
                    if($vehicle_search != "")
                    {
                        $temp_result = $connetion->query("SELECT * FROM `vehicle_details`where pin_code = '$fetch_pin_code' AND vehicle_owner_user_id != '$user_id'");
                        if ($temp_result->num_rows > 0) 
                        {
                            while($temp_row = $temp_result->fetch_assoc()) 
                            {
                                $fetch_vehicle_model = $temp_row['vehicle_model'];
                                $fetch_vehicle_company = $temp_row['vehicle_company'];
                                $fetch_vehicle_passing_year = $temp_row['vehicle_passing_year'];

                                if (strcasecmp($fetch_vehicle_model, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_company, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                                else if(strcasecmp($fetch_vehicle_passing_year, $vehicle_search) === 0)
                                {
                                    $count++;
                                }
                            }
                        }
                    }
                    else
                    {
                        $count++;
                    }
                }
            }
        }
    }
    else
    {
        $result = $connetion->query("SELECT * FROM `vehicle_details`where (((pin_code = '$pin_code' OR city = '$city') AND state = '$state' AND country = '$country') And active = 'true' And vehicle_owner_user_id != '$user_id')");
        if ($result->num_rows > 0) 
        {
            while($row = $result->fetch_assoc()) 
            {
                $fetch_vehicle_model = $row['vehicle_model'];
                $fetch_vehicle_company = $row['vehicle_company'];
                $fetch_vehicle_passing_year = $row['vehicle_passing_year'];

                if (strcasecmp($fetch_vehicle_model, $vehicle_search) === 0)
                {
                    $count++;
                }
                else if(strcasecmp($fetch_vehicle_company, $vehicle_search) === 0)
                {
                    $count++;
                }
                else if(strcasecmp($fetch_vehicle_passing_year, $vehicle_search) === 0)
                {
                    $count++;
                }
            }
        }
        else
        {
            echo("No item found...");
        }
    }

    print(json_encode($count)); 

?>