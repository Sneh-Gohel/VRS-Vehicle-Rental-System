// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, prefer_interpolation_to_compose_strings, no_logic_in_create_state, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vrs/Driver_booking_screen.dart';
import 'Current_IP.dart';
import 'Driver_report_screen.dart';
import 'Home_account_screen.dart';

class Driver_details_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String driver_id = "";
  Driver_details_screen(
      this.user_id, this.first_name_first_char, this.driver_id,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Driver_details_screen(user_id, first_name_first_char, driver_id);
}

class _Driver_details_screen extends State<Driver_details_screen> {
  String user_id = "";
  String first_name_first_char = "";
  String driver_id = "";
  String ip = Current_IP().getIP();
  var driver_information;
  bool loading_screen = false;
  bool oversized = false;
  int current_licence_image_count = 1;
  bool current_licence_image_1 = true;
  bool current_licence_image_2 = false;

  _Driver_details_screen(
      this.user_id, this.first_name_first_char, this.driver_id);

  get_data() async {
    String URL = "http://$ip/VRS/driver_details_screen.php";
    var request =
        await http.post(Uri.parse(URL), body: {"driver_id": driver_id});
    setState(() {
      driver_information = (jsonDecode(request.body));
      loading_screen = false;
    });
    size_setter();
  }

  size_setter() {
    if (driver_information['fule'].toString().length > 15) {
      setState(() {
        oversized = true;
      });
    }
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
                  child: Text(first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
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
              )
              // child: Image.asset("pictures/Landing page image.png"),
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
          : Stack(
              children: [
                Positioned(
                  child: Center(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 121.5, right: 121.5),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 10,
                            child: SizedBox(
                              height: 200,
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  "http://$ip/VRS/" +
                                      driver_information['driver_profile_pic'],
                                  loadingBuilder: (BuildContext context,
                                      Widget child, Progress) {
                                    if (Progress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: Progress.expectedTotalBytes !=
                                                null
                                            ? Progress.cumulativeBytesLoaded /
                                                Progress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
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
                              "Driver Information :",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 23, right: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: SizedBox(
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
                                            "Driver Name",
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
                                            driver_information['first_name'] +
                                                ' ' +
                                                driver_information['last_name'],
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
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 23, right: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: SizedBox(
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            driver_information['contact'],
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
                                            "Age",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            driver_information['age']
                                                .toString(),
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
                                              "B Date",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              driver_information['birth_date'],
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
                                            "Gender",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            driver_information['gender'],
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
                                              "Skills",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              driver_information['skill'],
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
                                    height: oversized ? 90 : 60,
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
                                            driver_information['fule'],
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
                                      height: oversized ? 90 : 60,
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
                                              driver_information[
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
                              "( * Checks The Details In Licence Carefully * )",
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
                                if (current_licence_image_count == 2) {
                                  current_licence_image_count = 1;
                                  current_licence_image_1 = true;
                                  current_licence_image_2 = false;
                                }
                              });
                            } else if (details.primaryVelocity! < 0) {
                              // User swiped Right
                              // print("Swiped rigth");
                              setState(() {
                                if (current_licence_image_count == 1) {
                                  current_licence_image_count = 2;
                                  current_licence_image_1 = false;
                                  current_licence_image_2 = true;
                                }
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 20, right: 20, bottom: 100),
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
                                    Center(
                                      child: Image.network(
                                        "http://$ip/VRS/" +
                                            driver_information[
                                                'licence_image_' +
                                                    current_licence_image_count
                                                        .toString()],
                                        loadingBuilder: (BuildContext context,
                                            Widget child, Progress) {
                                          if (Progress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
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
                                                current_licence_image_count = 1;
                                                current_licence_image_1 = true;
                                                current_licence_image_2 = false;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(),
                                              child: CircleAvatar(
                                                radius: 7.0,
                                                backgroundColor:
                                                    current_licence_image_1
                                                        ? Colors.grey
                                                        : Colors.blue,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                current_licence_image_count = 2;
                                                current_licence_image_1 = false;
                                                current_licence_image_2 = true;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: CircleAvatar(
                                                  radius: 7.0,
                                                  backgroundColor:
                                                      current_licence_image_2
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
                                builder: (context) => Driver_booking_screen(
                                    user_id,
                                    first_name_first_char,
                                    driver_id,
                                    driver_information['price'],
                                    driver_information['driver_user_id']),
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
                                        driver_information['price'],
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
                          builder: (context) => Driver_report_screen(
                            user_id,
                            first_name_first_char,
                            driver_id,
                            driver_information['driver_profile_pic'],
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
