// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';

class Renter_vehicle_history_details_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String vehicle_image = "";
  String booking_information_starting_date = "";
  String booking_information_ending_date = "";
  String booking_information_booking_date = "";
  String booking_information_booking_time = "";
  String booking_information_total_days = "";
  String booking_information_price = "";
  String booking_information_description = "";
  String booker_information_owner_name = "";
  String booker_information_contact = "";
  String booker_information_birth_date = "";
  String booker_information_age = "";
  String booker_information_sex = "";
  String vehicle_information_model_name = "";
  String vehicle_information_company_name = "";
  String vehicle_information_passing_year = "";
  String vehicle_information_seater = "";
  String vehicle_information_fule = "";
  String vehicle_information_transmission = "";
  String vehicle_information_number = "";
  Renter_vehicle_history_details_screen(
      this.user_id,
      this.first_name_first_char,
      this.vehicle_image,
      this.booking_information_starting_date,
      this.booking_information_ending_date,
      this.booking_information_booking_date,
      this.booking_information_booking_time,
      this.booking_information_total_days,
      this.booking_information_price,
      this.booking_information_description,
      this.booker_information_owner_name,
      this.booker_information_contact,
      this.booker_information_birth_date,
      this.booker_information_age,
      this.booker_information_sex,
      this.vehicle_information_model_name,
      this.vehicle_information_company_name,
      this.vehicle_information_passing_year,
      this.vehicle_information_seater,
      this.vehicle_information_fule,
      this.vehicle_information_transmission,
      this.vehicle_information_number,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Renter_vehicle_history_details_screen(
      user_id,
      first_name_first_char,
      vehicle_image,
      booking_information_starting_date,
      booking_information_ending_date,
      booking_information_booking_date,
      booking_information_booking_time,
      booking_information_total_days,
      booking_information_price,
      booking_information_description,
      booker_information_owner_name,
      booker_information_contact,
      booker_information_birth_date,
      booker_information_age,
      booker_information_sex,
      vehicle_information_model_name,
      vehicle_information_company_name,
      vehicle_information_passing_year,
      vehicle_information_seater,
      vehicle_information_fule,
      vehicle_information_transmission,
      vehicle_information_number);
}

class _Renter_vehicle_history_details_screen
    extends State<Renter_vehicle_history_details_screen> {
  String user_id = "";
  String renter_first_name_first_char = "";
  String vehicle_image = "";
  String booking_information_starting_date = "";
  String booking_information_ending_date = "";
  String booking_information_booking_date = "";
  String booking_information_booking_time = "";
  String booking_information_total_days = "";
  String booking_information_price = "";
  String booking_information_description = "";
  String booker_information_owner_name = "";
  String booker_information_contact = "";
  String booker_information_birth_date = "";
  String booker_information_age = "";
  String booker_information_sex = "";
  String vehicle_information_model_name = "";
  String vehicle_information_company_name = "";
  String vehicle_information_passing_year = "";
  String vehicle_information_seater = "";
  String vehicle_information_fule = "";
  String vehicle_information_transmission = "";
  String vehicle_information_number = "";
  String ip = Current_IP().getIP();

  _Renter_vehicle_history_details_screen(
    this.user_id,
    this.renter_first_name_first_char,
    this.vehicle_image,
    this.booking_information_starting_date,
    this.booking_information_ending_date,
    this.booking_information_booking_date,
    this.booking_information_booking_time,
    this.booking_information_total_days,
    this.booking_information_price,
    this.booking_information_description,
    this.booker_information_owner_name,
    this.booker_information_contact,
    this.booker_information_birth_date,
    this.booker_information_age,
    this.booker_information_sex,
    this.vehicle_information_model_name,
    this.vehicle_information_company_name,
    this.vehicle_information_passing_year,
    this.vehicle_information_seater,
    this.vehicle_information_fule,
    this.vehicle_information_transmission,
    this.vehicle_information_number,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Vehicle History"),
        backgroundColor: Colors.blue,
        elevation: 10,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.white,
                child: Text(renter_first_name_first_char,
                    style: const TextStyle(color: Colors.blue, fontSize: 25.0)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home_account_screen(
                        user_id, renter_first_name_first_char),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 10,
              child: SizedBox(
                height: 180,
                width: 340,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Center(
                    child: Image.network(
                      "http://$ip/VRS/$vehicle_image",
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
                              booking_information_total_days,
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
                "Booker Information :",
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
                              "Booker Name",
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
                              booker_information_owner_name,
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
                              booker_information_contact,
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
                              "Birth Date",
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
                              booker_information_birth_date,
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
                              "Age",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Text(
                              booker_information_age,
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
                                "Sex",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                booker_information_sex,
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
                "Vehicle Information :",
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
                              "Model",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Text(
                              vehicle_information_model_name,
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
                                "Company",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                vehicle_information_company_name,
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
                                "Seats",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                vehicle_information_seater,
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
                              vehicle_information_fule,
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
                                vehicle_information_transmission,
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
            padding:
                const EdgeInsets.only(top: 5, left: 23, right: 25, bottom: 50),
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
                              "Vehicle Number (As per Number Plate)",
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
                              vehicle_information_number,
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
    );
  }
}
