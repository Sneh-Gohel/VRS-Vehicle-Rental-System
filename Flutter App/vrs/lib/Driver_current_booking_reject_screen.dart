// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, no_logic_in_create_state, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:vrs/Driver_profile_current_booking_screen.dart';
import 'package:http/http.dart' as http;
import 'Current_IP.dart';
import 'Home_account_screen.dart';

class Driver_current_booking_reject_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String booking_information_starting_date = "";
  String booking_information_ending_date = "";
  String booking_information_booking_date = "";
  String booking_information_booking_time = "";
  String booking_information_total_booking_days = "";
  String booking_information_price = "";
  String driver_booking_id = "";
  Driver_current_booking_reject_screen(
      this.user_id,
      this.first_name_first_char,
      this.booking_information_starting_date,
      this.booking_information_ending_date,
      this.booking_information_booking_date,
      this.booking_information_booking_time,
      this.booking_information_total_booking_days,
      this.booking_information_price,
      this.driver_booking_id,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Driver_current_booking_reject_screen(
      user_id,
      first_name_first_char,
      booking_information_starting_date,
      booking_information_ending_date,
      booking_information_booking_date,
      booking_information_booking_time,
      booking_information_total_booking_days,
      booking_information_price,driver_booking_id);
}

class _Driver_current_booking_reject_screen
    extends State<Driver_current_booking_reject_screen> {
  String user_id = "";
  String driver_first_name_first_char = "";
  final reject_information_reason_for_reject_Controller =
      TextEditingController();
  String booking_information_starting_date = "";
  String booking_information_ending_date = "";
  String booking_information_booking_date = "";
  String booking_information_booking_time = "";
  String booking_information_total_booking_days = "";
  String booking_information_price = "";
  String booking_reject_information_current_date = "";
  String booking_reject_information_current_time = "";
  final reject_information_reason_for_reject = FocusNode();
  DateTime now = DateTime.now();
  bool loading_screen = false;
  String driver_booking_id = "";

  _Driver_current_booking_reject_screen(
    this.user_id,
    this.driver_first_name_first_char,
    this.booking_information_starting_date,
    this.booking_information_ending_date,
    this.booking_information_booking_date,
    this.booking_information_booking_time,
    this.booking_information_total_booking_days,
    this.booking_information_price,
    this.driver_booking_id
  );

  click_submit() async {
    if (reject_information_reason_for_reject_Controller.text != "") {
      setState(() {
        loading_screen = false;
      });
      String ip = Current_IP().getIP();
      String URL = "http://$ip/VRS/reject_driver_booking.php";
      String responce;
      var request = await http.post(Uri.parse(URL), body: {"user_id": user_id,"driver_booking_id": driver_booking_id});
      responce = (jsonDecode(request.body)).toString();
      setState(() {
        if (responce == "success") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Driver_profile_current_booking_screen(
                  user_id, driver_first_name_first_char),
            ),
          );
          setState(() {
            loading_screen = false;
          });
        } else {
          setState(() {
            loading_screen = false;
          });
        }
      });
    } else {
      FocusScope.of(context).requestFocus(reject_information_reason_for_reject);
    }
  }

  @override
  void initState() {
    super.initState();
    booking_reject_information_current_date =
        DateFormat('dd/MM/yyyy').format(now);
    now = DateTime.now();
    booking_reject_information_current_time = DateFormat('hh:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rejecting Booking..?"),
        automaticallyImplyLeading: true,
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
                child: Text(
                  driver_first_name_first_char,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 25.0,
                  ),
                ),
                // child: Image.asset('pictures/Landing page image.png'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home_account_screen(user_id,driver_first_name_first_char),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          reject_information_reason_for_reject.unfocus();
        },
        child: loading_screen
            ? const Center(
                child: SpinKitWave(
                  color: Colors.blue,
                  size: 35.0,
                ),
              )
            : ListView(
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
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Booking Rejecting Information :",
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
                                      "Date",
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
                                      booking_reject_information_current_date,
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
                                      "Time",
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
                                      booking_reject_information_current_time,
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
                        height: 180,
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
                                      "Reason For Reject",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 10),
                                    child: TextField(
                                      controller:
                                          reject_information_reason_for_reject_Controller,
                                      focusNode:
                                          reject_information_reason_for_reject,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            255, 230, 230, 230),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.blue),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        hintText: 'Tell Us Why...',
                                        // border: OutlineInputBorder(),
                                      ),
                                      // keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      maxLines: 3,
                                      // textAlign: TextAlign.center,
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
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          click_submit();
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
