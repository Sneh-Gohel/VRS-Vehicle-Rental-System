// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, sized_box_for_whitespace, no_logic_in_create_state, must_be_immutable, depend_on_referenced_packages, prefer_typing_uninitialized_variables, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vrs/Add_driver_details_screen.dart';
import 'package:vrs/Driver_profile_current_booking_screen.dart';
import 'package:vrs/Home_account_screen.dart';
import 'Current_IP.dart';
import 'Edit_driver_profile.dart';

class Driver_profile_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Driver_profile_screen(this.user_id, this.first_name_first_char, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Driver_profile_screen(user_id, first_name_first_char);
}

class _Driver_profile_screen extends State<Driver_profile_screen> {
  String user_id = "";
  String driver_first_name_first_char = "";
  bool full_screen_loading_screen = false;
  bool history_loading_screen = false;
  bool has_account = false;
  var driver_information;
  var driver_history_information;
  String ip = Current_IP().getIP();

  _Driver_profile_screen(this.user_id, this.driver_first_name_first_char);

  get_data() async {
    print(user_id);
    String URL = "http://$ip/VRS/driver_account_checker.php";
    String responce;
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    setState(() {
      has_account = (jsonDecode(request.body));
    });

    print(has_account);

    if (has_account == true) {
      URL = "http://$ip/VRS/driver_profile_screen_get_data.php";
      request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
      setState(() {
        driver_information = (jsonDecode(request.body));
        full_screen_loading_screen = false;
        history_loading_screen = true;
      });

      if (int.parse(driver_information['drives']) != 0) {
        URL = "http://$ip/VRS/driver_screen_get_history_data.php";
        request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
        setState(() {
          driver_history_information = (jsonDecode(request.body));
          full_screen_loading_screen = false;
          history_loading_screen = false;
        });
      } else {
        setState(() {
          history_loading_screen = false;
        });
      }
    } else {
      setState(() {
        full_screen_loading_screen = false;
        history_loading_screen = false;
      });
    }
  }

  @override
  void initState() {
    full_screen_loading_screen = true;
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Driver Profile"),
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
      body: full_screen_loading_screen
          ? const Center(
              child: SpinKitFadingCube(
                color: Colors.blue,
                size: 35.0,
              ),
            )
          : has_account
              ? Stack(
                  children: [
                    Positioned(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 10,
                              child: Container(
                                height: 200,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        height: 200,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(100),
                                              topLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(100),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 25,
                                      left: 10,
                                      child: Container(
                                        height: 150,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            "http://$ip/VRS/" +
                                                driver_information[
                                                    'driver_image'],
                                          ),
                                          // child: Image.asset(
                                          //     "pictures/driver_pic.JPG"),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 130,
                                      top: 10,
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(),
                                            child: Text(
                                              "Name : ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            driver_information['first_name'] +
                                                " " +
                                                driver_information['last_name'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 155,
                                      top: 50,
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(),
                                            child: Text(
                                              "Age : ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            driver_information['age']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 160,
                                      top: 90,
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(),
                                            child: Text(
                                              "Contact : ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 200,
                                      top: 115,
                                      child: Text(
                                        driver_information['contact'],
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.blue),
                                      ),
                                    ),
                                    Positioned(
                                      left: 145,
                                      top: 143,
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(),
                                            child: Text(
                                              "Drives : ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Text(
                                            driver_information['drives'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 160,
                                      left: 110,
                                      child: GestureDetector(
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.edit,
                                              size: 16,
                                              color: Colors.blue,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Edit_driver_profile(
                                                      user_id,
                                                      driver_first_name_first_char,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                "Edit Profile.",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.blue,
                                                  // decoration: TextDecoration.underline,
                                                  // decorationThickness: 2.0,
                                                  // decorationColor: Colors.blue,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          history_loading_screen
                              ? Expanded(
                                  child: ListView(
                                    children: const [
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              left: 20,
                                              right: 2,
                                              bottom: 20),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(),
                                              child: Text(
                                                " - : History : - ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 50),
                                          child: SpinKitFadingFour(
                                            color: Colors.blue,
                                            size: 35.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListView.builder(
                                      itemCount: int.parse(
                                              driver_information['drives']) +
                                          1,
                                      itemBuilder: (context, index) {
                                        if (int.parse(
                                                driver_information['drives']) ==
                                            0) {
                                          return Column(
                                            children: const [
                                              Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      left: 20,
                                                      right: 2,
                                                      bottom: 20),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.only(),
                                                      child: Text(
                                                        " - : History : - ",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 200),
                                                child: Center(
                                                  child: Text(
                                                    "Not Drives Yet...",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          if (index == 0) {
                                            return const Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    left: 20,
                                                    right: 2,
                                                    bottom: 20),
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(),
                                                    child: Text(
                                                      " - : History : - ",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 20),
                                                child: Material(
                                                  elevation: 10,
                                                  shadowColor:
                                                      const Color.fromARGB(
                                                          255, 187, 219, 248),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Container(
                                                    height: 202,
                                                    width: 325,
                                                    decoration: BoxDecoration(
                                                        // image: const DecorationImage(
                                                        //   image:
                                                        //       AssetImage("pictures/white_bg.jpg"),
                                                        //   fit: BoxFit.cover,
                                                        // ),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              187, 219, 248),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          top: 10,
                                                          left: 10,
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            elevation: 10,
                                                            child: CircleAvatar(
                                                              radius: 40,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              child: Center(
                                                                child: Text(
                                                                  driver_history_information[index -
                                                                              1]
                                                                          [
                                                                          'first_name_first_char']
                                                                      .toString()
                                                                      .toUpperCase(),
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          40,
                                                                      color: Colors
                                                                          .blue),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 20,
                                                          left: 100,
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.person,
                                                                size: 20,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                              const Text(
                                                                " ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                driver_history_information[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'first_name'] +
                                                                    " " +
                                                                    driver_history_information[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'last_name'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 60,
                                                          left: 100,
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.phone,
                                                                size: 20,
                                                                color:
                                                                    Colors.blue,
                                                              ),
                                                              const Text(
                                                                " ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                driver_history_information[
                                                                        index -
                                                                            1]
                                                                    ['contact'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 110,
                                                          left: 10,
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .calendar_month_outlined,
                                                                size: 20,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              const Text(
                                                                " ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                driver_history_information[
                                                                        index -
                                                                            1][
                                                                    'starting_date'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              const Text(
                                                                " To ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              // Icon(
                                                              //   Icons.calendar_month_outlined,
                                                              //   size: 20,
                                                              //   color: Colors.black,
                                                              // ),
                                                              const Text(
                                                                "",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                driver_history_information[
                                                                        index -
                                                                            1][
                                                                    'ending_date'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 150,
                                                          left: 10,
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.today,
                                                                size: 20,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              const Text(
                                                                " ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                driver_history_information[
                                                                        index -
                                                                            1]
                                                                    ['days'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              const Text(
                                                                " Days",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const Text(
                                                                "          ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .currency_rupee_sharp,
                                                                size: 20,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              const Text(
                                                                " ",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              Text(
                                                                driver_history_information[
                                                                        index -
                                                                            1]
                                                                    ['price'],
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              const Text(
                                                                "/Day",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
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
                        ],
                      ),
                    ),
                    // Positioned(
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       color: Color.fromARGB(255, 255, 255, 255),
                    //     ),
                    //     child: Center(
                    //       child: Align(
                    //         alignment: Alignment.center,
                    //         child: Column(
                    //           children: [
                    //             const Text(
                    //                 "You not have Driver Account edit your Profile to enter in driver queue"),
                    //             ElevatedButton(
                    //               onPressed: () {},
                    //               child: const Center(
                    //                 child: Text("Edit Profile"),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Positioned(
                      bottom: 50,
                      right: 10,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Driver_profile_current_booking_screen(
                                      user_id, driver_first_name_first_char),
                            ),
                          );
                        },
                        backgroundColor: Colors.blue,
                        splashColor: Colors.white,
                        // shape: const CircleBorder(
                        //   side: BorderSide(
                        //     width: 0.0,
                        //     color: Colors.blue,
                        //   ),
                        // ),
                        child: const Center(
                          child: Icon(
                            Icons.today,
                            color: Colors.white,
                            // size: 500,
                          ),
                        ),
                      ),
                    ),

                    // Positioned(
                    //   child: Container(
                    //     decoration: const BoxDecoration(
                    //       color: Color.fromARGB(230, 255, 255, 255),
                    //     ),
                    //     child: Center(
                    //       child: ListView(
                    //         children: [
                    //           const Padding(
                    //             padding: EdgeInsets.only(top: 315),
                    //             child: Center(
                    //               child: Text(
                    //                 "Complete Your Profile",
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     color: Colors.black,
                    //                     fontWeight: FontWeight.w500),
                    //               ),
                    //             ),
                    //           ),
                    //           const Padding(
                    //             padding: EdgeInsets.only(top: 10),
                    //             child: Center(
                    //               child: Text(
                    //                 "TO",
                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     color: Colors.black,
                    //                     fontWeight: FontWeight.w500),
                    //               ),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.symmetric(
                    //                 horizontal: 100, vertical: 10),
                    //             child: ElevatedButton(
                    //               onPressed: () {},
                    //               child: Row(
                    //                 children: const [
                    //                   Padding(
                    //                     padding: EdgeInsets.only(left: 30),
                    //                     child: Text(
                    //                       "Continue",
                    //                       style: TextStyle(fontSize: 20),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding: EdgeInsets.only(top: 4),
                    //                     child: Icon(
                    //                       Icons.arrow_forward_ios_rounded,
                    //                       size: 20,
                    //                       color: Colors.white,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(230, 255, 255, 255),
                  ),
                  child: Center(
                    child: ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 315),
                          child: Center(
                            child: Text(
                              "Complete Your Profile",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              "TO",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Add_driver_details_screen(user_id,
                                          driver_first_name_first_char),
                                ),
                              );
                            },
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                    color: Colors.white,
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
    );
  }
}
