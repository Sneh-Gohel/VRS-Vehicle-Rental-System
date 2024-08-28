// ignore_for_file: camel_case_types, file_names,, sized_box_for_whitespace, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state, depend_on_referenced_packages, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Vehicle_booking_screen.dart';
import 'package:vrs/Vehicle_report_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'package:http/http.dart' as http;

class Vehicle_detail_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String vehicle_id = "";
  Vehicle_detail_screen(
      this.user_id, this.first_name_first_char, this.vehicle_id,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Vehicle_detail_screen(user_id, first_name_first_char, vehicle_id);
}

class _Vehicle_detail_screen extends State<Vehicle_detail_screen> {
  String user_id = "";
  String vehicle_id = "";
  String visitor_first_name_first_char = "";
  String ip = Current_IP().getIP();
  var vehicle_information;
  bool loading_screen = false;
  bool has_vehicle_image_2 = true;
  bool has_vehicle_image_3 = true;
  bool has_vehicle_image_4 = true;
  bool has_vehicle_image_5 = true;
  bool current_vehicle_image_1 = true;
  bool current_vehicle_image_2 = false;
  bool current_vehicle_image_3 = false;
  bool current_vehicle_image_4 = false;
  bool current_vehicle_image_5 = false;
  int current_vehicle_image_count = 1;
  bool current_rc_image_1 = true;
  bool current_rc_image_2 = false;
  int current_rc_image_count = 1;
  String rc_image_string = "front";

  _Vehicle_detail_screen(
    this.user_id,
    this.visitor_first_name_first_char,
    this.vehicle_id,
  );

  get_data() async {
    String URL = "http://$ip/VRS/vehicle_details_screen.php";
    var request =
        await http.post(Uri.parse(URL), body: {"vehicle_id": vehicle_id});
    setState(() {
      vehicle_information = (jsonDecode(request.body));
      loading_screen = false;
    });
    images_analyzer();
  }

  images_analyzer() {
    setState(() {
      if (vehicle_information['vehicle_image_5'] == "") {
        has_vehicle_image_5 = false;
        if (vehicle_information['vehicle_image_4'] == "") {
          has_vehicle_image_4 = false;
          if (vehicle_information['vehicle_image_3'] == "") {
            has_vehicle_image_3 = false;
            if (vehicle_information['vehicle_image_2'] == "") {
              has_vehicle_image_2 = false;
            } else {
              has_vehicle_image_2 = true;
            }
          } else {
            has_vehicle_image_3 = true;
          }
        } else {
          has_vehicle_image_4 = true;
        }
      } else {
        has_vehicle_image_5 = true;
      }
    });
  }

  image_changer(String side) {
    if (side == "left") {
      if (current_vehicle_image_count > 1) {
        if (current_vehicle_image_count == 2) {
          setState(() {
            current_vehicle_image_1 = true;
            current_vehicle_image_2 = false;
          });
        } else if (current_vehicle_image_count == 3) {
          setState(() {
            current_vehicle_image_2 = true;
            current_vehicle_image_3 = false;
          });
        } else if (current_vehicle_image_count == 4) {
          setState(() {
            current_vehicle_image_3 = true;
            current_vehicle_image_4 = false;
          });
        } else if (current_vehicle_image_count == 5) {
          setState(() {
            current_vehicle_image_4 = true;
            current_vehicle_image_5 = false;
          });
        }
        setState(() {
          current_vehicle_image_count--;
        });
      }
    } else {
      setState(() {
        if (current_vehicle_image_count < 5) {
          if (current_vehicle_image_count == 1) {
            if (has_vehicle_image_2 == true) {
              current_vehicle_image_count++;
              current_vehicle_image_1 = false;
              current_vehicle_image_2 = true;
            }
          } else if (current_vehicle_image_count == 2) {
            if (has_vehicle_image_3 == true) {
              current_vehicle_image_count++;
              current_vehicle_image_2 = false;
              current_vehicle_image_3 = true;
            }
          } else if (current_vehicle_image_count == 3) {
            if (has_vehicle_image_4 == true) {
              current_vehicle_image_count++;
              current_vehicle_image_3 = false;
              current_vehicle_image_4 = true;
            }
          } else if (current_vehicle_image_count == 4) {
            if (has_vehicle_image_5 == true) {
              current_vehicle_image_count++;
              current_vehicle_image_4 = false;
              current_vehicle_image_5 = true;
            }
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(user_id);
    loading_screen = true;
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 10,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                child: CircleAvatar(
                  radius: 20.0,
                  // backgroundImage: AssetImage("pictures/Landing page image.png"),
                  backgroundColor: Colors.white,
                  child: Text(visitor_first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_account_screen(
                          user_id, visitor_first_name_first_char),
                    ),
                  );
                },
              )
              // child: Image.asset("pictures/Landing page image.png"),
              ),
        ],
      ),
      body: loading_screen
          ? const Center(
              child: SpinKitCubeGrid(
                color: Colors.blue,
                size: 35.0,
              ),
            )
          : Stack(
              children: [
                Positioned(
                  child: Center(
                    child: ListView(
                      children: [
                        GestureDetector(
                          onHorizontalDragEnd: (DragEndDetails details) {
                            if (details.primaryVelocity! > 0) {
                              // User swiped Left
                              // print("Swiped left");
                              image_changer("left");
                            } else if (details.primaryVelocity! < 0) {
                              // User swiped Right
                              // print("Swiped rigth");
                              image_changer("right");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 20, right: 20),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 10,
                              child: Container(
                                height: 180,
                                width: 340,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Image.network(
                                            "http://$ip/VRS/" +
                                                vehicle_information[
                                                    'vehicle_image_' +
                                                        current_vehicle_image_count
                                                            .toString()],
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child, Progress) {
                                              if (Progress == null) {
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
                                    Positioned(
                                      left: 130,
                                      bottom: 10,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                current_vehicle_image_count = 1;
                                                current_vehicle_image_1 = true;
                                                current_vehicle_image_2 = false;
                                                current_vehicle_image_3 = false;
                                                current_vehicle_image_4 = false;
                                                current_vehicle_image_5 = false;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(),
                                              child: CircleAvatar(
                                                radius: 7.0,
                                                backgroundColor:
                                                    current_vehicle_image_1
                                                        ? Colors.grey
                                                        : Colors.blue,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (has_vehicle_image_2) {
                                                setState(() {
                                                  current_vehicle_image_count =
                                                      2;
                                                  current_vehicle_image_1 =
                                                      false;
                                                  current_vehicle_image_2 =
                                                      true;
                                                  current_vehicle_image_3 =
                                                      false;
                                                  current_vehicle_image_4 =
                                                      false;
                                                  current_vehicle_image_5 =
                                                      false;
                                                });
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: CircleAvatar(
                                                radius: 7.0,
                                                backgroundColor:
                                                    has_vehicle_image_2
                                                        ? current_vehicle_image_2
                                                            ? Colors.grey
                                                            : Colors.blue
                                                        : Colors
                                                            .lightBlueAccent,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (has_vehicle_image_3) {
                                                setState(() {
                                                  current_vehicle_image_count =
                                                      3;
                                                  current_vehicle_image_1 =
                                                      false;
                                                  current_vehicle_image_2 =
                                                      false;
                                                  current_vehicle_image_3 =
                                                      true;
                                                  current_vehicle_image_4 =
                                                      false;
                                                  current_vehicle_image_5 =
                                                      false;
                                                });
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: CircleAvatar(
                                                radius: 7.0,
                                                backgroundColor:
                                                    has_vehicle_image_3
                                                        ? current_vehicle_image_3
                                                            ? Colors.grey
                                                            : Colors.blue
                                                        : Colors
                                                            .lightBlueAccent,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (has_vehicle_image_4) {
                                                setState(() {
                                                  current_vehicle_image_count =
                                                      4;
                                                  current_vehicle_image_1 =
                                                      false;
                                                  current_vehicle_image_2 =
                                                      false;
                                                  current_vehicle_image_3 =
                                                      false;
                                                  current_vehicle_image_4 =
                                                      true;
                                                  current_vehicle_image_5 =
                                                      false;
                                                });
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: CircleAvatar(
                                                radius: 7.0,
                                                backgroundColor:
                                                    has_vehicle_image_4
                                                        ? current_vehicle_image_4
                                                            ? Colors.grey
                                                            : Colors.blue
                                                        : Colors
                                                            .lightBlueAccent,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (has_vehicle_image_5) {
                                                setState(() {
                                                  current_vehicle_image_count =
                                                      5;
                                                  current_vehicle_image_1 =
                                                      false;
                                                  current_vehicle_image_2 =
                                                      false;
                                                  current_vehicle_image_3 =
                                                      false;
                                                  current_vehicle_image_4 =
                                                      false;
                                                  current_vehicle_image_5 =
                                                      true;
                                                });
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: CircleAvatar(
                                                radius: 7.0,
                                                backgroundColor:
                                                    has_vehicle_image_5
                                                        ? current_vehicle_image_5
                                                            ? Colors.grey
                                                            : Colors.blue
                                                        : Colors
                                                            .lightBlueAccent,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                                    height: 65,
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
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            vehicle_information[
                                                'vehicle_model'],
                                            style:
                                                const TextStyle(fontSize: 20),
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
                                      height: 65,
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
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              vehicle_information[
                                                  'vehicle_company'],
                                              style:
                                                  const TextStyle(fontSize: 20),
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
                                    height: 65,
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
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            vehicle_information['passing_year'],
                                            style:
                                                const TextStyle(fontSize: 20),
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
                                      height: 65,
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
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              vehicle_information['seater'],
                                              style:
                                                  const TextStyle(fontSize: 20),
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
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                  elevation: 5,
                                  child: Container(
                                    width: 170,
                                    height: 65,
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
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            vehicle_information['fule_type'],
                                            style:
                                                const TextStyle(fontSize: 20),
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
                                      height: 65,
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
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              vehicle_information[
                                                  'transmission'],
                                              style:
                                                  const TextStyle(fontSize: 20),
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
                          padding: const EdgeInsets.only(
                              top: 5, left: 23, right: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: Container(
                              height: 80,
                              width: 340,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 15),
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            vehicle_information[
                                                'vehicle_number'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
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
                          padding: EdgeInsets.only(top: 30, left: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "More Information :",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "( * Compare the RC with Vehicle * )",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onHorizontalDragEnd: (DragEndDetails details) {
                            if (details.primaryVelocity! > 0) {
                              // User swiped Left
                              // print("Swiped left");
                              setState(() {
                                if (current_rc_image_count == 2) {
                                  current_rc_image_count = 1;
                                  rc_image_string = "front";
                                  current_rc_image_1 = true;
                                  current_rc_image_2 = false;
                                }
                              });
                            } else if (details.primaryVelocity! < 0) {
                              // User swiped Right
                              // print("Swiped rigth");
                              setState(() {
                                if (current_rc_image_count == 1) {
                                  current_rc_image_count = 2;
                                  rc_image_string = "bottom";
                                  current_rc_image_1 = false;
                                  current_rc_image_2 = true;
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 10,
                              child: Container(
                                height: 200,
                                width: 340,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Image.network(
                                            "http://$ip/VRS/" +
                                                vehicle_information[
                                                    'vehicle_rc_image_' +
                                                        rc_image_string],
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child, Progress) {
                                              if (Progress == null) {
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
                                    Positioned(
                                      left: 160,
                                      bottom: 10,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                current_vehicle_image_count = 1;
                                                rc_image_string = "front";
                                                current_rc_image_1 = true;
                                                current_rc_image_2 = false;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(),
                                              child: CircleAvatar(
                                                radius: 7.0,
                                                backgroundColor:
                                                    current_rc_image_1
                                                        ? Colors.grey
                                                        : Colors.blue,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                current_vehicle_image_count = 2;
                                                rc_image_string = "bottom";
                                                current_rc_image_1 = false;
                                                current_rc_image_2 = true;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: CircleAvatar(
                                                  radius: 7.0,
                                                  backgroundColor:
                                                      current_rc_image_2
                                                          ? Colors.grey
                                                          : Colors.blue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, left: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Owner Information :",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 100),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 10,
                            child: Container(
                              width: 340,
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 25,
                                    left: 10,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(100),
                                      elevation: 10,
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Text(
                                            vehicle_information[
                                                'vehicle_owner_first_name_first_char'],
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 120,
                                    child: Container(
                                      height: 130,
                                      width: 220,
                                      child: Stack(
                                        children: [
                                          const Positioned(
                                            top: 10,
                                            left: 0,
                                            child: Text(
                                              "Name",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Positioned(
                                            top: 30,
                                            child: Text(
                                              vehicle_information[
                                                      'vehicle_owner_first_name'] +
                                                  " " +
                                                  vehicle_information[
                                                      'vehicle_owner_last_name'],
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const Positioned(
                                            top: 67,
                                            child: Text(
                                              "Contanct No.",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 90,
                                            child: Text(
                                              vehicle_information[
                                                  'vehicle_owner_contact'],
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 90,
                    width: 393,
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          // height: 70,
                          // width: 340,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(100),
                          //   color: Colors.blue,
                          // ),
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            foregroundColor: Colors.lightBlue,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Vehicle_booking_screen(
                                    user_id,
                                    visitor_first_name_first_char,
                                    vehicle_id,
                                    vehicle_information[
                                        'vehicle_owner_user_id'],
                                    vehicle_information['price']),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, top: 5, bottom: 5),
                                child: Container(
                                  height: 60,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.lightBlue,
                                  ),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          "₹ ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(
                                        vehicle_information['price'],
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      const Text(
                                        " /Day",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  "Book",
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.white,
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
                Positioned(
                  bottom: 100,
                  right: 10,
                  child: FloatingActionButton(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    splashColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Vehicle_report_screen(
                            user_id,
                            visitor_first_name_first_char,
                            vehicle_id,
                            vehicle_information['vehicle_image_1'],
                          ),
                        ),
                      );
                    },
                    child: const Center(
                      child: Icon(
                        Icons.report,
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
