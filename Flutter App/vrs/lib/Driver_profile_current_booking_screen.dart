// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vrs/Driver_current_booking_details_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';

class Driver_profile_current_booking_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Driver_profile_current_booking_screen(
      this.user_id, this.first_name_first_char,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Driver_profile_current_booking_screen(user_id, first_name_first_char);
}

class _Driver_profile_current_booking_screen
    extends State<Driver_profile_current_booking_screen> {
  String user_id = "";
  String driver_first_name_first_char = "";
  String total_count_of_current_booking = "0";
  var current_booking_information;
  bool loading_screen = false;

  _Driver_profile_current_booking_screen(
      this.user_id, this.driver_first_name_first_char);

  get_data() async {
    String ip = Current_IP().getIP();
    String URL = "http://$ip/VRS/driver_current_booking_screen_get_count.php";
    String responce;
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    responce = (jsonDecode(request.body)).toString();
    setState(() {
      total_count_of_current_booking = responce;
    });

    if (int.parse(total_count_of_current_booking) != 0) {
      URL = "http://$ip/VRS/driver_current_booking_screen_get_data.php";
      request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
      setState(() {
        current_booking_information = (jsonDecode(request.body));
      });
      print(current_booking_information);
    }
    loading_screen = false;
  }

  @override
  void initState() {
    super.initState();
    loading_screen = true;
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Bookings..."),
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
                child: Text(driver_first_name_first_char,
                    style: const TextStyle(color: Colors.blue, fontSize: 25.0)),
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
      body: loading_screen
          ? const Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 35.0,
              ),
            )
          : (int.parse(total_count_of_current_booking) == 0)
              ? ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          "No Booking Yet...",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: ListView.builder(
                      itemCount: int.parse(total_count_of_current_booking),
                      // itemCount: 0,
                      itemBuilder: (Contax, Index) {
                        if (int.parse(total_count_of_current_booking) == 0) {
                          return const Center(
                            child: Text(
                              "No bookings yet...",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          );
                        } else {
                          if (Index == 0) {
                            return Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 20, left: 10, right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Driver_current_booking_details_screen(
                                            user_id,
                                            driver_first_name_first_char,
                                            current_booking_information[Index]
                                                ['starting_date'],
                                            current_booking_information[Index]
                                                ['ending_date'],
                                            current_booking_information[Index]
                                                ['booking_date'],
                                            current_booking_information[Index]
                                                ['booking_time'],
                                            current_booking_information[Index]
                                                ['days'],
                                            current_booking_information[Index]
                                                ['price'],
                                                current_booking_information[Index]['description'],
                                            current_booking_information[Index]
                                                ['vehicle_model'],
                                            current_booking_information[Index]
                                                ['vehicle_company'],
                                            current_booking_information[Index]
                                                ['passing_year'],
                                            current_booking_information[Index]
                                                ['wheeler_type'],
                                            current_booking_information[Index]
                                                ['fule'],
                                            current_booking_information[Index]
                                                ['transmission'],
                                            current_booking_information[Index]
                                                    ['first_name'] +
                                                " " +
                                                current_booking_information[
                                                    Index]['last_name'],
                                            current_booking_information[Index]
                                                ['contact'],
                                            current_booking_information[Index]
                                                ['driver_booking_id']),
                                      ),
                                    );
                                  },
                                  child: Material(
                                    borderRadius: BorderRadius.circular(15),
                                    elevation: 10,
                                    child: Container(
                                      height: 100,
                                      width: 369,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 10,
                                            left: 5,
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              elevation: 10,
                                              child: CircleAvatar(
                                                radius: 35,
                                                backgroundColor: Colors.white,
                                                child: Text(
                                                  current_booking_information[
                                                          Index]
                                                      ['first_name_first_char'],
                                                  style: const TextStyle(
                                                      fontSize: 40,
                                                      color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 5,
                                            left: 85,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                const Text(
                                                  " ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  current_booking_information[
                                                          Index]['first_name'] +
                                                      " " +
                                                      current_booking_information[
                                                          Index]['last_name'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 30,
                                            left: 85,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 20,
                                                  color: Colors.black,
                                                ),
                                                const Text(
                                                  " ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  current_booking_information[
                                                      Index]['starting_date'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.blue),
                                                ),
                                                const Text(
                                                  " To ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                const Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  current_booking_information[
                                                      Index]['ending_date'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 55,
                                            left: 85,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.album_rounded,
                                                  size: 20,
                                                  color: Colors.blue,
                                                ),
                                                const Text(
                                                  " ",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  current_booking_information[
                                                      Index]['wheeler_type'],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                                const Text(
                                                  " Wheeler",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 15,
                                            right: 5,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Driver_current_booking_details_screen(
                                                      user_id,
                                                      driver_first_name_first_char,
                                                      current_booking_information[
                                                              Index]
                                                          ['starting_date'],
                                                      current_booking_information[
                                                          Index]['ending_date'],
                                                      current_booking_information[
                                                              Index]
                                                          ['booking_date'],
                                                      current_booking_information[
                                                              Index]
                                                          ['booking_time'],
                                                      current_booking_information[
                                                          Index]['days'],
                                                      current_booking_information[
                                                          Index]['price'],
                                                          current_booking_information[Index]['description'],
                                                      current_booking_information[
                                                              Index]
                                                          ['vehicle_model'],
                                                      current_booking_information[
                                                              Index]
                                                          ['vehicle_company'],
                                                      current_booking_information[
                                                              Index]
                                                          ['passing_year'],
                                                      current_booking_information[
                                                              Index]
                                                          ['wheeler_type'],
                                                      current_booking_information[
                                                          Index]['fule'],
                                                      current_booking_information[
                                                              Index]
                                                          ['transmission'],
                                                      current_booking_information[
                                                                  Index]
                                                              ['first_name'] +
                                                          " " +
                                                          current_booking_information[
                                                                  Index]
                                                              ['last_name'],
                                                      current_booking_information[
                                                          Index]['contact'],
                                                      current_booking_information[
                                                              Index]
                                                          ['driver_booking_id'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Material(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                elevation: 10,
                                                child: Container(
                                                  height: 60,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 20,
                                                      color: Colors.white,
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
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 20, left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Driver_current_booking_details_screen(
                                              user_id,
                                              driver_first_name_first_char,
                                              current_booking_information[Index]
                                                  ['starting_date'],
                                              current_booking_information[Index]
                                                  ['ending_date'],
                                              current_booking_information[Index]
                                                  ['booking_date'],
                                              current_booking_information[Index]
                                                  ['booking_time'],
                                              current_booking_information[Index]
                                                  ['days'],
                                              current_booking_information[Index]
                                                  ['price'],
                                                  current_booking_information[Index]['description'],
                                              current_booking_information[Index]
                                                  ['vehicle_model'],
                                              current_booking_information[Index]
                                                  ['vehicle_company'],
                                              current_booking_information[Index]
                                                  ['passing_year'],
                                              current_booking_information[Index]
                                                  ['wheeler_type'],
                                              current_booking_information[Index]
                                                  ['fule'],
                                              current_booking_information[Index]
                                                  ['transmission'],
                                              current_booking_information[Index]
                                                      ['first_name'] +
                                                  " " +
                                                  current_booking_information[
                                                      Index]['last_name'],
                                              current_booking_information[Index]
                                                  ['contact'],
                                              current_booking_information[Index]
                                                  ['driver_booking_id']),
                                    ),
                                  );
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  elevation: 10,
                                  child: Container(
                                    height: 100,
                                    width: 369,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: 10,
                                          left: 5,
                                          child: Material(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            elevation: 10,
                                            child: CircleAvatar(
                                              radius: 35,
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                current_booking_information[
                                                        Index]
                                                    ['first_name_first_char'],
                                                style: const TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          left: 85,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.person,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              const Text(
                                                " ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                current_booking_information[
                                                        Index]['first_name'] +
                                                    " " +
                                                    current_booking_information[
                                                        Index]['last_name'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 30,
                                          left: 85,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_month_outlined,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                              const Text(
                                                " ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                current_booking_information[
                                                    Index]['starting_date'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              ),
                                              const Text(
                                                " To ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              const Text(
                                                "",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                current_booking_information[
                                                    Index]['ending_date'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 55,
                                          left: 85,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.album_rounded,
                                                size: 20,
                                                color: Colors.blue,
                                              ),
                                              const Text(
                                                " ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                current_booking_information[
                                                    Index]['wheeler_type'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              const Text(
                                                " Wheeler",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 15,
                                          right: 5,
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Driver_current_booking_details_screen(
                                                    user_id,
                                                    driver_first_name_first_char,
                                                    current_booking_information[
                                                        Index]['starting_date'],
                                                    current_booking_information[
                                                        Index]['ending_date'],
                                                    current_booking_information[
                                                        Index]['booking_date'],
                                                    current_booking_information[
                                                        Index]['booking_time'],
                                                    current_booking_information[
                                                        Index]['days'],
                                                    current_booking_information[
                                                        Index]['price'],
                                                        current_booking_information[Index]['description'],
                                                    current_booking_information[
                                                        Index]['vehicle_model'],
                                                    current_booking_information[
                                                            Index]
                                                        ['vehicle_company'],
                                                    current_booking_information[
                                                        Index]['passing_year'],
                                                    current_booking_information[
                                                        Index]['wheeler_type'],
                                                    current_booking_information[
                                                        Index]['fule'],
                                                    current_booking_information[
                                                        Index]['transmission'],
                                                    current_booking_information[
                                                                Index]
                                                            ['first_name'] +
                                                        " " +
                                                        current_booking_information[
                                                            Index]['last_name'],
                                                    current_booking_information[
                                                        Index]['contact'],
                                                    current_booking_information[
                                                            Index]
                                                        ['driver_booking_id'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              elevation: 10,
                                              child: Container(
                                                height: 60,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
                                                    size: 20,
                                                    color: Colors.white,
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
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
    );
  }
}
