// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:vrs/Driver_current_booking_reject_screen.dart';
import 'Driver_qr_code_display_screen.dart';
import 'Home_account_screen.dart';

class Driver_current_booking_details_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String booking_information_starting_date = "";
  String booking_information_ending_date = "";
  String booking_information_booking_date = "";
  String booking_information_booking_time = "";
  String booking_information_total_booking_days = "";
  String booking_information_price = "";
  String booking_information_description = "";
  String vehicle_information_vehicle_model = "";
  String vehicle_information_vehicle_company = "";
  String vehicle_information_passing_year = "";
  String vehicle_information_wheeler_type = "";
  String vehicle_information_flue_type = "";
  String vehicle_information_transmission_type = "";
  String owner_information_owner_name = "";
  String owner_information_contact = "";
  String driver_booking_id = "";
  Driver_current_booking_details_screen(
      this.user_id,
      this.first_name_first_char,
      this.booking_information_starting_date,
      this.booking_information_ending_date,
      this.booking_information_booking_date,
      this.booking_information_booking_time,
      this.booking_information_total_booking_days,
      this.booking_information_price,
      this.booking_information_description,
      this.vehicle_information_vehicle_model,
      this.vehicle_information_vehicle_company,
      this.vehicle_information_passing_year,
      this.vehicle_information_wheeler_type,
      this.vehicle_information_flue_type,
      this.vehicle_information_transmission_type,
      this.owner_information_owner_name,
      this.owner_information_contact,
      this.driver_booking_id,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Driver_current_booking_details_screen(
      user_id,
      first_name_first_char,
      booking_information_starting_date,
      booking_information_ending_date,
      booking_information_booking_date,
      booking_information_booking_time,
      booking_information_total_booking_days,
      booking_information_price,
      booking_information_description,
      vehicle_information_vehicle_model,
      vehicle_information_vehicle_company,
      vehicle_information_passing_year,
      vehicle_information_wheeler_type,
      vehicle_information_flue_type,
      vehicle_information_transmission_type,
      owner_information_owner_name,
      owner_information_contact,
      driver_booking_id);
}

class _Driver_current_booking_details_screen
    extends State<Driver_current_booking_details_screen> {
  String user_id = "";
  String driver_first_name_first_char = "";
  String booking_information_starting_date = "";
  String booking_information_ending_date = "";
  String booking_information_booking_date = "";
  String booking_information_booking_time = "";
  String booking_information_total_booking_days = "";
  String booking_information_price = "";
  String booking_information_description = "";
  String vehicle_information_vehicle_model = "";
  String vehicle_information_vehicle_company = "";
  String vehicle_information_passing_year = "";
  String vehicle_information_wheeler_type = "";
  String vehicle_information_flue_type = "";
  String vehicle_information_transmission_type = "";
  String owner_information_owner_name = "";
  String owner_information_contact = "";
  String driver_booking_id = "";

  _Driver_current_booking_details_screen(
    this.user_id,
    this.driver_first_name_first_char,
    this.booking_information_starting_date,
    this.booking_information_ending_date,
    this.booking_information_booking_date,
    this.booking_information_booking_time,
    this.booking_information_total_booking_days,
    this.booking_information_price,
    this.booking_information_description,
    this.vehicle_information_vehicle_model,
    this.vehicle_information_vehicle_company,
    this.vehicle_information_passing_year,
    this.vehicle_information_wheeler_type,
    this.vehicle_information_flue_type,
    this.vehicle_information_transmission_type,
    this.owner_information_owner_name,
    this.owner_information_contact,
    this.driver_booking_id,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Booking Information"),
        backgroundColor: Colors.blue,
        elevation: 10,
        // scrolledUnderElevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: CircleAvatar(
                radius: 20.0,
                // backgroundImage: AssetImage("pictures/Landing page image.png"),
                backgroundColor: Colors.white,
                child: Text(driver_first_name_first_char,
                    style: const TextStyle(color: Colors.blue, fontSize: 25.0)),
                // child: Image.asset('pictures/Landing page image.png'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home_account_screen(
                        user_id, driver_first_name_first_char),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Booking Information :",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 5,
                          child: Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: const Border(
                              //   right: BorderSide(width: 1.0, color: Colors.black),
                              // ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Starting Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    booking_information_starting_date,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Ending date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Text(
                                      booking_information_ending_date,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 5,
                          child: Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: const Border(
                              //   right: BorderSide(width: 1.0, color: Colors.black),
                              // ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Booking Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    booking_information_booking_date,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Booking Time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Text(
                                      booking_information_booking_time,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 5,
                          child: Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Days",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    booking_information_total_booking_days,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Price",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Text(
                                      booking_information_price,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 240,
                      width: 340,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    "Description",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    booking_information_description,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Vehicle Information :",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 80,
                      width: 340,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    "Vehicle Model",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    vehicle_information_vehicle_model,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 80,
                      width: 340,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    "Vehicle Company",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    vehicle_information_vehicle_company,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 5,
                          child: Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: const Border(
                              //   right: BorderSide(width: 1.0, color: Colors.black),
                              // ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Passing Year",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    vehicle_information_passing_year,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Wheeler Type",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Text(
                                      vehicle_information_wheeler_type,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Row(
                      children: [
                        Material(
                          borderRadius: BorderRadiusDirectional.circular(10),
                          elevation: 5,
                          child: Container(
                            width: 170,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // border: const Border(
                              //   right: BorderSide(width: 1.0, color: Colors.black),
                              // ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Fule",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Text(
                                    vehicle_information_flue_type,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Transmision",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 7),
                                    child: Text(
                                      vehicle_information_transmission_type,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 25),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Owner Information :",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 80,
                      width: 340,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    "Owner Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    owner_information_owner_name,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, left: 23, right: 25, bottom: 90),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 80,
                      width: 340,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    "Contact",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    owner_information_contact,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              height: 70,
              width: 393,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, //New
                    blurRadius: 25.0,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: Container(
                          height: 60,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                              "Report",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Driver_current_booking_reject_screen(
                                    user_id,
                                    driver_first_name_first_char,
                                    booking_information_starting_date,
                                    booking_information_ending_date,
                                    booking_information_booking_date,
                                    booking_information_booking_time,
                                    booking_information_total_booking_days,
                                    booking_information_price,
                                    driver_booking_id),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 33),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 10,
                          child: Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                            child: const Center(
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 110,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Driver_qr_code_display_screen(
                      user_id,
                      driver_first_name_first_char,
                      driver_booking_id,
                    ),
                  ),
                );
              },
              splashColor: Colors.white,
              child: const Center(
                child: Icon(
                  Icons.qr_code_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
