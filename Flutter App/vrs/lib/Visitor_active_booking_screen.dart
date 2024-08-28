// ignore_for_file: depend_on_referenced_packages, must_be_immutable, camel_case_types, non_constant_identifier_names, no_logic_in_create_state, prefer_typing_uninitialized_variables, file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:vrs/Visitor_vehicle_active_booking_details_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'Visitor_driver_active_booking_deatils_screen.dart';

class Visitor_active_booking_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Visitor_active_booking_screen(this.user_id, this.first_name_first_char,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Visitor_active_booking_screen(user_id, first_name_first_char);
}

class _Visitor_active_booking_screen
    extends State<Visitor_active_booking_screen> {
  String user_id = "";
  String first_name_first_char = "";
  bool is_driver_menu = false;
  String vehicle_count = "";
  String driver_count = "";
  var vehicle_booking_details;
  var driver_booking_details;
  String ip = Current_IP().getIP();
  bool full_screen_loading_screen = false;
  bool loading_screen = false;

  _Visitor_active_booking_screen(this.user_id, this.first_name_first_char);

  get_data() async {
    String URL = "http://$ip/VRS/visitor_vehicle_active_booking_get_count.php";
    String responce;
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    responce = (jsonDecode(request.body));
    setState(() {
      vehicle_count = responce;
    });
    // print(vehicle_count);
    URL = "http://$ip/VRS/visitor_driver_active_booking_get_count.php";
    responce;
    request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    responce = (jsonDecode(request.body));
    setState(() {
      driver_count = responce;
      full_screen_loading_screen = false;
      loading_screen = true;
    });
    // print(driver_count);
    if (int.parse(vehicle_count) != 0) {
      URL = "http://$ip/VRS/visitor_vehicle_active_booking_get_data.php";
      responce;
      request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
      setState(() {
        vehicle_booking_details = (jsonDecode(request.body));
      });
      // print(vehicle_booking_details);
    }
    if (int.parse(driver_count) != 0) {
      URL = "http://$ip/VRS/visitor_driver_active_booking_get_data.php";
      responce;
      request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
      setState(() {
        driver_booking_details = (jsonDecode(request.body));
      });
      // print(driver_booking_details);
    }
    setState(() {
      loading_screen = false;
    });
  }

  @override
  void initState() {
    super.initState();
    full_screen_loading_screen = true;
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Active Booking (Current Booking)"),
        backgroundColor: Colors.blue,
        elevation: 10,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.white,
                child: Text(
                  first_name_first_char,
                  style: const TextStyle(color: Colors.blue, fontSize: 25.0),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Home_account_screen(user_id, first_name_first_char),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: full_screen_loading_screen
          ? const Center(
              child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 35.0,
              ),
            )
          : Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 50,
                      width: 393,
                      child: Padding(
                        padding: const EdgeInsets.only(),
                        child: Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: is_driver_menu ? 2 : 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    is_driver_menu = false;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 196.5,
                                  decoration: BoxDecoration(
                                    color: is_driver_menu
                                        ? Colors.white
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Vehicles",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.blue),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: is_driver_menu ? 0 : 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    is_driver_menu = true;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 196.2,
                                  decoration: BoxDecoration(
                                    color: is_driver_menu
                                        ? Colors.transparent
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Drivers",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.blue),
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
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: is_driver_menu
                        ? GestureDetector(
                            onHorizontalDragEnd: (DragEndDetails details) {
                              if (details.primaryVelocity! > 0) {
                                // User swiped Left
                                // print("Swiped left");
                                setState(() {
                                  is_driver_menu = false;
                                });
                              } else if (details.primaryVelocity! < 0) {
                                // User swiped Right
                                // print("Swiped rigth");
                              }
                            },
                            child: loading_screen
                                ? const Center(
                                    child: SpinKitFadingFour(
                                      color: Colors.blue,
                                      size: 35.0,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: int.parse(driver_count),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 20,
                                            left: 25,
                                            right: 25),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 10,
                                          child: SizedBox(
                                            height: 200,
                                            width: 343,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 20,
                                                  left: 15,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    elevation: 10,
                                                    child: Container(
                                                      height: 150,
                                                      width: 125,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Image.network(
                                                          "http://$ip/VRS/" +
                                                              driver_booking_details[
                                                                      index][
                                                                  'profile_pic'],
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  Progress) {
                                                            if (Progress ==
                                                                null) {
                                                              return child;
                                                            }
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: Progress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? Progress
                                                                            .cumulativeBytesLoaded /
                                                                        Progress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  left: 150,
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
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        driver_booking_details[
                                                                    index]
                                                                ['first_name'] +
                                                            ' ' +
                                                            driver_booking_details[
                                                                    index]
                                                                ['last_name'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 35,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.call,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        driver_booking_details[
                                                            index]['contact'],
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 60,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .directions_car_sharp,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Color.fromARGB(
                                                              255,
                                                              194,
                                                              187,
                                                              187),
                                                        ),
                                                      ),
                                                      Text(
                                                        driver_booking_details[
                                                                index]
                                                            ['vehicle_model'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 85,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        driver_booking_details[
                                                                index]
                                                            ['starting_date'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const Text(
                                                        "   To ",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 110,
                                                  left: 175,
                                                  child: Text(
                                                    driver_booking_details[
                                                        index]['ending_date'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 135,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.today,
                                                        color: Colors.blue,
                                                        size: 20,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        driver_booking_details[
                                                                index]['days']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const Text(
                                                        " Days",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  right: 20,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => Visitor_driver_active_booking_deatils_screen(
                                                              user_id,
                                                              first_name_first_char,
                                                              driver_booking_details[index][
                                                                  'starting_date'],
                                                              driver_booking_details[index][
                                                                  'ending_date'],
                                                              driver_booking_details[index][
                                                                  'booking_date'],
                                                              driver_booking_details[index][
                                                                  'booking_time'],
                                                              driver_booking_details[index]
                                                                      ['days']
                                                                  .toString(),
                                                              driver_booking_details[index]
                                                                  ['price'],
                                                              driver_booking_details[index][
                                                                  'description'],
                                                              driver_booking_details[index]
                                                                  [
                                                                  'vehicle_model'],
                                                              driver_booking_details[index]
                                                                  [
                                                                  'vehicle_company'],
                                                              driver_booking_details[index]
                                                                  [
                                                                  'passing_year'],
                                                              driver_booking_details[index]
                                                                  [
                                                                  'wheeler_type'],
                                                              driver_booking_details[index]
                                                                  ['fule'],
                                                              driver_booking_details[index]
                                                                  ['transmission'],
                                                              driver_booking_details[index]['first_name'] + ' ' + driver_booking_details[index]['last_name'],
                                                              driver_booking_details[index]['contact'],
                                                              driver_booking_details[index]['booking_id'],
                                                              driver_booking_details[index]['driver_id'],
                                                              driver_booking_details[index]['profile_pic']),
                                                        ),
                                                      );
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets
                                                          .symmetric(),
                                                      child: Icon(Icons
                                                          .arrow_forward_ios_rounded),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          )
                        : GestureDetector(
                            onHorizontalDragEnd: (DragEndDetails details) {
                              if (details.primaryVelocity! > 0) {
                                // User swiped Left
                                // print("Swiped left");
                              } else if (details.primaryVelocity! < 0) {
                                // User swiped Right
                                // print("Swiped rigth");
                                setState(() {
                                  is_driver_menu = true;
                                });
                              }
                            },
                            child: loading_screen
                                ? const Center(
                                    child: SpinKitFadingFour(
                                      color: Colors.white,
                                      size: 35.0,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: int.parse(vehicle_count),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 20,
                                            left: 25,
                                            right: 25),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          elevation: 10,
                                          child: SizedBox(
                                            height: 200,
                                            width: 343,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 20,
                                                  left: 15,
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    elevation: 10,
                                                    child: Container(
                                                      height: 150,
                                                      width: 125,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Image.network(
                                                          "http://$ip/VRS/" +
                                                              vehicle_booking_details[
                                                                      index][
                                                                  'vehicle_image_1'],
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  Progress) {
                                                            if (Progress ==
                                                                null) {
                                                              return child;
                                                            }
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: Progress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? Progress
                                                                            .cumulativeBytesLoaded /
                                                                        Progress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 10,
                                                  left: 150,
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
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        vehicle_booking_details[
                                                                    index]
                                                                ['first_name'] +
                                                            ' ' +
                                                            vehicle_booking_details[
                                                                    index]
                                                                ['last_name'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 35,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.call,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        vehicle_booking_details[
                                                            index]['contact'],
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 60,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .directions_car_sharp,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        vehicle_booking_details[
                                                                index]
                                                            ['vehicle_model'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 85,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        vehicle_booking_details[
                                                                index]
                                                            ['starting_date'],
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      const Text(
                                                        "   To ",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.blue),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 110,
                                                  left: 175,
                                                  child: Text(
                                                    vehicle_booking_details[
                                                        index]['ending_date'],
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 135,
                                                  left: 150,
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.today,
                                                        color: Colors.blue,
                                                        size: 20,
                                                      ),
                                                      const Text(
                                                        " ",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        vehicle_booking_details[
                                                            index]['days'],
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      const Text(
                                                        " Days",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 10,
                                                  right: 20,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => Visitor_vehicle_active_booking_details_screen(
                                                              user_id,
                                                              first_name_first_char,
                                                              vehicle_booking_details[index]['vehicle_id'],
                                                              vehicle_booking_details[index][
                                                                  'booking_id'],
                                                              vehicle_booking_details[index][
                                                                  'vehicle_image_1'],
                                                              vehicle_booking_details[index][
                                                                  'starting_date'],
                                                              vehicle_booking_details[index][
                                                                  'ending_date'],
                                                              vehicle_booking_details[index][
                                                                  'booking_date'],
                                                              vehicle_booking_details[index][
                                                                  'booking_time'],
                                                              vehicle_booking_details[index]
                                                                  ['days'],
                                                              vehicle_booking_details[index]
                                                                  ['price'],
                                                              vehicle_booking_details[index][
                                                                  'description'],
                                                              vehicle_booking_details[index]['first_name'] +
                                                                  ' ' +
                                                                  vehicle_booking_details[index]
                                                                      [
                                                                      'last_name'],
                                                              vehicle_booking_details[index]
                                                                  ['contact'],
                                                              vehicle_booking_details[index]
                                                                      ['age']
                                                                  .toString(),
                                                              vehicle_booking_details[index]
                                                                  [
                                                                  'birth_date'],
                                                              vehicle_booking_details[index]
                                                                  ['gender'],
                                                              vehicle_booking_details[index]
                                                                  ['vehicle_model'],
                                                              vehicle_booking_details[index]['vehicle_company'],
                                                              vehicle_booking_details[index]['passing_year'],
                                                              vehicle_booking_details[index]['seats'],
                                                              vehicle_booking_details[index]['fule_type'],
                                                              vehicle_booking_details[index]['transmission']),
                                                        ),
                                                      );
                                                    },
                                                    child: const Padding(
                                                      padding: EdgeInsets
                                                          .symmetric(),
                                                      child: Icon(Icons
                                                          .arrow_forward_ios_rounded),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}
