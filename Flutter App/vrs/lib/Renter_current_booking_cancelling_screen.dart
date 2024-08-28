// ignore_for_file: camel_case_types, file_names, use_build_context_synchronously, no_logic_in_create_state, non_constant_identifier_names, depend_on_referenced_packages, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:vrs/Renter_profile_current_booking_screen.dart';
import 'package:vrs/Renter_profile_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';

class Renter_current_booking_cancelling_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String booking_id = "";
  String starting_date = "";
  String ending_date = "";
  String booking_date = "";
  String booking_time = "";
  String days = "";
  String price = "";
  Renter_current_booking_cancelling_screen(
      this.user_id,
      this.first_name_first_char,
      this.booking_id,
      this.starting_date,
      this.ending_date,
      this.booking_date,
      this.booking_time,
      this.days,
      this.price,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Renter_current_booking_cancelling_screen(
          user_id,
          first_name_first_char,
          booking_id,
          starting_date,
          ending_date,
          booking_date,
          booking_time,
          days,
          price);
}

class _Renter_current_booking_cancelling_screen
    extends State<Renter_current_booking_cancelling_screen> {
  String user_id = "";
  String renter_first_name_first_char = "";
  String booking_id = "";
  String starting_date = "";
  String ending_date = "";
  String booking_date = "";
  String booking_time = "";
  String days = "";
  String price = "";
  bool loading_screen = false;
  DateTime now = DateTime.now();
  String current_date = "";
  String current_time = "";
  final booking_cancel_information_reason_for_cancle_Controller =
      TextEditingController();
  final booking_cancel_information_reason_for_cancle = FocusNode();

  _Renter_current_booking_cancelling_screen(
    this.user_id,
    this.renter_first_name_first_char,
    this.booking_id,
    this.starting_date,
    this.ending_date,
    this.booking_date,
    this.booking_time,
    this.days,
    this.price,
  );

  @override
  void initState() {
    super.initState();
    current_date = DateFormat('dd/MM/yyyy').format(now);
    now = DateTime.now();
    current_time = DateFormat('hh:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cancelling Booking..?"),
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
                child: Text(renter_first_name_first_char,
                    style: const TextStyle(color: Colors.blue, fontSize: 25.0)),
                // child: Image.asset('pictures/Landing page image.png'),
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
      body: loading_screen
          ? const Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 35.0,
              ),
            )
          : GestureDetector(
              onTap: () {
                booking_cancel_information_reason_for_cancle.unfocus();
              },
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
                                      starting_date,
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
                                        ending_date,
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
                                      booking_date,
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
                                        booking_time,
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
                                      days,
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
                                        "$price/days",
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
                        "Booking cancelling Information :",
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
                                      current_date,
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
                                      current_time,
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
                                      "Reason For cancel",
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
                                          booking_cancel_information_reason_for_cancle_Controller,
                                      focusNode:
                                          booking_cancel_information_reason_for_cancle,
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
                        onPressed: () async {
                          if (booking_cancel_information_reason_for_cancle_Controller
                                  .text !=
                              "") {
                            setState(() {
                              loading_screen = true;
                            });
                            String ip = Current_IP().getIP();
                            String URL =
                                "http://$ip/VRS/cancle_vehicle_current_booking.php";
                            String responce;
                            var request = await http.post(
                              Uri.parse(URL),
                              body: {
                                "booking_id": booking_id,
                                "user_id": user_id,
                                "request_from": "renter",
                              },
                            );
                            responce = (jsonDecode(request.body)).toString();
                            if (responce == "sucessful") {
                              Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Renter_profile_screen(
                  user_id, renter_first_name_first_char),
            ),
            (route) => route.isFirst,
          );
                            } else {
                              print("cannot cancle");
                            }
                            setState(() {
                              loading_screen = false;
                            });
                          } else {
                            FocusScope.of(context).requestFocus(
                                booking_cancel_information_reason_for_cancle);
                          }
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
