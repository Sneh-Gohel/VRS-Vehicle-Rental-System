// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names, no_logic_in_create_state, must_be_immutable, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vrs/Driver_details_screen.dart';
import 'package:vrs/Home_account_screen.dart';
import 'package:vrs/Plus_button_screen.dart';
import 'package:vrs/Vehicle_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'Block_user_screen.dart';
import 'Current_IP.dart';

class Home_screen extends StatefulWidget {
  String user_id = "";
  Home_screen(this.user_id, {super.key});
  @override
  State<StatefulWidget> createState() => _Home_screen(user_id);
}

class _Home_screen extends State<Home_screen> {
  String user_id;
  bool is_driver_menu = false;
  String? number_of_vehicle_found;
  String? number_of_driver_found;
  String current_city = "";
  String current_state = "";
  String current_country = "";
  String current_pin_code = "";
  List vehicle_information = [];
  List driver_information = [];
  bool vehicle_loading_screen = false;
  bool is_get_data_completed = false;
  String ip = Current_IP().getIP();
  String first_name_first_char = "";
  bool full_screen_loading_screen = true;
  String first_name = "";
  String last_name = "";
  bool is_search_click = false;
  final vehicle_search_Controller = TextEditingController();
  final vehicle_search = FocusNode();
  final location_search_Controller = TextEditingController();
  final location_search = FocusNode();

  _Home_screen(this.user_id);
  Future<void> getCurrentLocation() async {
    try {
      setState(() {
        is_get_data_completed = false;
      });
      bool serviceEnable = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnable) {
        print("Location services are disable.");
        return;
      } else {
        await Permission.location.request();
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            print("Permisstion denied");
            return;
          }
        }

        if (permission == LocationPermission.deniedForever) {
          print("Permission is denied for forever...");
          return;
        }

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        Placemark placemark = placemarks[0];

        setState(() {
          current_city = placemark.locality.toString();
          current_state = placemark.administrativeArea.toString();
          current_country = placemark.country.toString();
          current_pin_code = placemark.postalCode.toString();
        });
        get_data();
      }
    } catch (e) {
      setState(() {
        current_city = "Bharuch";
        current_state = "Gujarat";
        current_country = "India";
        current_pin_code = "388001";
      });
    }
  }

  position_changer_ai_call() async {
    String responce;
    String URL = "http://" + ip + "/VRS/position_changer_AI.php";
    var request = await http.post(Uri.parse(URL), body: {
      "user_id": user_id,
    });
    responce = (jsonDecode(request.body)).toString();
    print(responce);
  }

  get_data() async {
    String URL = "http://" + ip + "/VRS/user_checking.php";
    String responce;
    var request = await http
        .post(Uri.parse(URL), body: {"user_id": user_id, 'mobile_number': ""});
    responce = (jsonDecode(request.body)).toString();
    if (responce == "true") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Block_user_screen(),
        ),
      );
    } else {
      URL = "http://" + ip + "/VRS/home_get_first_name_first_char.php";
      responce;
      request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
      responce = (jsonDecode(request.body)).toString().toUpperCase();
      setState(() {
        first_name_first_char = responce;
        full_screen_loading_screen = false;
        vehicle_loading_screen = true;
      });

      URL = "http://" + ip + "/VRS/home_get_count_of_available_vehicle.php";
      request = await http.post(Uri.parse(URL), body: {
        "city": current_city,
        "state": current_state,
        "country": current_country,
        "pin_code": current_pin_code,
        "user_id": user_id,
      });
      responce = (jsonDecode(request.body)).toString();
      setState(() {
        number_of_vehicle_found = responce;
      });
      // print(responce);
      if (int.parse(number_of_vehicle_found!) != 0) {
        URL = "http://" + ip + "/VRS/home_get_available_vehicle.php";

        request = await http.post(Uri.parse(URL), body: {
          "city": current_city,
          "state": current_state,
          "country": current_country,
          "pin_code": current_pin_code,
          "user_id": user_id,
        });

        setState(() {
          vehicle_information = (jsonDecode(request.body));
        });
      }

      URL = "http://" + ip + "/VRS/home_get_count_of_available_driver.php";
      request = await http.post(Uri.parse(URL), body: {
        "city": current_city,
        "state": current_state,
        "country": current_country,
        "pin_code": current_pin_code,
        "user_id": user_id,
      });
      responce = (jsonDecode(request.body)).toString();
      setState(() {
        number_of_driver_found = responce;
      });

      if (int.parse(number_of_driver_found!) != 0) {
        URL = "http://" + ip + "/VRS/home_get_available_driver.php";

        request = await http.post(Uri.parse(URL), body: {
          "city": current_city,
          "state": current_state,
          "country": current_country,
          "pin_code": current_pin_code,
          "user_id": user_id,
        });

        setState(() {
          driver_information = (jsonDecode(request.body));
          is_get_data_completed = true;
        });
      }

      setState(() {
        vehicle_loading_screen = false;
      });

      position_changer_ai_call();
    }
  }

  Future<void> _handleRefresh() async {
    getCurrentLocation();
    return await Future.delayed(const Duration(seconds: 0));
  }

  searched_get_data() async {
    if (vehicle_search_Controller.text != "" ||
        location_search_Controller.text != "") {
      setState(() {
        vehicle_loading_screen = true;
        is_search_click = false;
      });
      String URL = "";
      String responce;
      URL = "http://" +
          ip +
          "/VRS/searched_home_get_count_of_available_vehicle.php";
      var request = await http.post(Uri.parse(URL), body: {
        "city": current_city,
        "state": current_state,
        "country": current_country,
        "pin_code": current_pin_code,
        "user_id": user_id,
        "vehicle_search": vehicle_search_Controller.text,
        "location_search": location_search_Controller.text,
      });
      responce = (jsonDecode(request.body)).toString();
      setState(() {
        number_of_vehicle_found = responce;
      });
      print(responce);
      if (int.parse(number_of_vehicle_found!) != 0) {
        URL = "http://" + ip + "/VRS/searched_home_get_available_vehicle.php";

        request = await http.post(Uri.parse(URL), body: {
          "city": current_city,
          "state": current_state,
          "country": current_country,
          "pin_code": current_pin_code,
          "user_id": user_id,
          "vehicle_search": vehicle_search_Controller.text,
          "location_search": location_search_Controller.text,
        });

        setState(() {
          vehicle_information = (jsonDecode(request.body));
          vehicle_loading_screen = false;
        });
      } else {
        setState(() {
          vehicle_loading_screen = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(user_id);
    full_screen_loading_screen = true;
    getCurrentLocation();
  }

  void search_click() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>
    //         Home_screen_Search_screen(user_id, first_name_first_char),
    //   ),
    // );
    setState(() {
      is_search_click = true;
    });
  }

  void refresh() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
        ),
      ),
      body: full_screen_loading_screen
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              decoration: const BoxDecoration(color: Colors.white),
              curve: accelerateEasing,
              child: const Center(
                child: SpinKitCubeGrid(
                  color: Colors.blue,
                  size: 35.0,
                ),
              ),
            )
          : LiquidPullToRefresh(
              color: Colors.blue,
              height: 200,
              backgroundColor: Colors.white,
              onRefresh: _handleRefresh,
              child: Container(
                decoration: const BoxDecoration(),
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 70,
                        left: 0,
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
                                      width: 196.5,
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
                      Positioned(
                        top: 10,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Container(
                            height: 60,
                            width: 393,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 25, right: 25),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      search_click();
                                      // print("search tapped");
                                    },
                                    child: const SizedBox(
                                      height: 55,
                                      width: 341,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Icon(
                                                Icons.my_location,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                "Search'City', 'Vehicle'",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 0,
                        child: is_driver_menu
                            ? SizedBox(
                                height: 670,
                                width: 393,
                                child: GestureDetector(
                                  onHorizontalDragEnd:
                                      (DragEndDetails details) {
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
                                  //Driver side
                                  child: ListView.builder(
                                    itemCount:
                                        int.parse(number_of_driver_found!) + 1,
                                    itemBuilder: (contax, index) {
                                      if (int.parse(number_of_driver_found!) ==
                                          0) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20,
                                                  left: 20,
                                                  right: 2,
                                                  bottom: 20),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          number_of_driver_found!,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const Text(
                                                          " Result found",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 231),
                                                    child: Icon(Icons
                                                        .filter_alt_outlined),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Center(
                                                child: Text("No Driver Found."),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        if (index == 0) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 2,
                                                bottom: 20),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        number_of_driver_found!,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      const Text(
                                                        " Result found",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 231),
                                                  child: Icon(Icons
                                                      .filter_alt_outlined),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 32,
                                                right: 32,
                                                top: 10,
                                                bottom: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Driver_details_screen(
                                                            user_id,
                                                            first_name_first_char,
                                                            driver_information[
                                                                    index - 1]
                                                                ['driver_id']),
                                                  ),
                                                );
                                              },
                                              child: Material(
                                                elevation: 10,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Container(
                                                  height: 202,
                                                  width: 325,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2,
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        top: 10,
                                                        left: 15,
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          elevation: 10,
                                                          child: Container(
                                                            height: 170,
                                                            width: 125,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              child:
                                                                  Image.network(
                                                                "http://$ip/VRS/" +
                                                                    driver_information[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'driver_profile_pic'],
                                                                loadingBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        Widget
                                                                            child,
                                                                        Progress) {
                                                                  if (Progress ==
                                                                      null) {
                                                                    return child;
                                                                  }
                                                                  return Center(
                                                                    child:
                                                                        CircularProgressIndicator(
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
                                                      Positioned(
                                                        top: 20,
                                                        left: 160,
                                                        child: Row(
                                                          children: [
                                                            // Text(
                                                            //   "Name : ",
                                                            //   style: TextStyle(
                                                            //       fontSize: 16,
                                                            //       color: Colors.blue),
                                                            // ),
                                                            Text(
                                                              driver_information[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'first_name'] +
                                                                  ' ' +
                                                                  driver_information[
                                                                          index -
                                                                              1]
                                                                      [
                                                                      'last_name'],
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Positioned(
                                                        top: 50,
                                                        left: 160,
                                                        child: Text(
                                                          "Skills ",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 70,
                                                        left: 160,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              driver_information[
                                                                      index - 1]
                                                                  ['skill'],
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          20),
                                                              selectionColor:
                                                                  Colors.black,
                                                            ),
                                                            const Text(
                                                              " Wheeler",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                              selectionColor:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 120,
                                                        left: 160,
                                                        child: Material(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          elevation: 10,
                                                          child: Container(
                                                            height: 40,
                                                            width: 150,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100),
                                                            ),
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                    child: Text(
                                                                      driver_information[index -
                                                                              1]
                                                                          [
                                                                          'price'],
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              24,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  const Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(),
                                                                    child: Text(
                                                                      " /Day",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              24,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    child: Icon(
                                                                      Icons
                                                                          .navigate_next_outlined,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .white,
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
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ), // Your child widget here
                              )
                            : vehicle_loading_screen
                                ? Container(
                                    height: 670,
                                    width: 393,
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    child: const Center(
                                      child: SpinKitFadingFour(
                                        color: Colors.blue,
                                        size: 35.0,
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 670,
                                    width: 393,
                                    child: GestureDetector(
                                      onHorizontalDragEnd:
                                          (DragEndDetails details) {
                                        if (details.primaryVelocity! > 0) {
                                          // User swiped Left
                                          // print("Swiped left");
                                        } else if (details.primaryVelocity! <
                                            0) {
                                          // User swiped Right
                                          // print("Swiped rigth");
                                          setState(() {
                                            is_driver_menu = true;
                                          });
                                        }
                                      },
                                      child: ListView.builder(
                                        itemCount: int.parse(
                                                number_of_vehicle_found!) +
                                            1,
                                        itemBuilder: (contax, index) {
                                          if (int.parse(
                                                  number_of_vehicle_found!) ==
                                              0) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20,
                                                          left: 20,
                                                          right: 2,
                                                          bottom: 20),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              number_of_vehicle_found!,
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            const Text(
                                                              " Result found",
                                                              style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 231),
                                                        child: Icon(Icons
                                                            .filter_alt_outlined),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Center(
                                                    child: Text(
                                                        "No Vehicle Found"),
                                                  ),
                                                ),
                                              ],
                                            );
                                          } else {
                                            if (index == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20,
                                                    left: 20,
                                                    right: 2,
                                                    bottom: 20),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            number_of_vehicle_found!,
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const Text(
                                                            " Result found",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 231),
                                                      child: Icon(Icons
                                                          .filter_alt_outlined),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 32,
                                                    right: 32,
                                                    top: 10,
                                                    bottom: 20),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Vehicle_detail_screen(
                                                          user_id,
                                                          first_name_first_char,
                                                          vehicle_information[
                                                                  index - 1]
                                                              ['vehicle_id'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Material(
                                                    elevation: 10,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Container(
                                                      height: 202,
                                                      width: 325,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                            width: 2,
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 7),
                                                                child: SizedBox(
                                                                  height: 140,
                                                                  width: 280,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                    child:
                                                                        Center(
                                                                      child: Image
                                                                          .network(
                                                                        "http://$ip/VRS/" +
                                                                            vehicle_information[index -
                                                                                1]['vehicle_image_1'],
                                                                        loadingBuilder: (BuildContext
                                                                                context,
                                                                            Widget
                                                                                child,
                                                                            Progress) {
                                                                          // return const Center(
                                                                          //     child:
                                                                          //   SpinKitThreeBounce(
                                                                          // color: Colors.blue,
                                                                          // size: 35.0,
                                                                          //     ),
                                                                          //   );
                                                                          if (Progress ==
                                                                              null) {
                                                                            return child;
                                                                          }
                                                                          return Center(
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              value: Progress.expectedTotalBytes != null ? Progress.cumulativeBytesLoaded / Progress.expectedTotalBytes! : null,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 19,
                                                            top: 148,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(),
                                                              child: Text(
                                                                // vehicle_name[index - 1],
                                                                vehicle_information[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'vehicle_company'] +
                                                                    " " +
                                                                    vehicle_information[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'vehicle_model'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 19,
                                                            top: 166,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(),
                                                              child: Row(
                                                                children: [
                                                                  const Text(
                                                                    "Price : ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  Text(
                                                                    // vehicle_price[
                                                                    //     index - 1],
                                                                    vehicle_information[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'price'],
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .blue,
                                                                        fontWeight:
                                                                            FontWeight.w500),
                                                                  ),
                                                                  const Text(
                                                                    "Rs/Day",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 145,
                                                            left: 240,
                                                            child:
                                                                ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Vehicle_detail_screen(
                                                                      user_id,
                                                                      first_name_first_char,
                                                                      vehicle_information[index -
                                                                              1]
                                                                          [
                                                                          'vehicle_id'],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: const Icon(
                                                                  Icons
                                                                      .arrow_forward_ios),
                                                            ),
                                                          ),
                                                          // Positioned(
                                                          //   top: 13,
                                                          //   left: 13,
                                                          //   child: Container(
                                                          //     height: 20,
                                                          //     width: 90,
                                                          //     decoration: BoxDecoration(
                                                          //       color: const Color.fromARGB(
                                                          //           255, 254, 199, 4),
                                                          //       borderRadius:
                                                          //           BorderRadius.circular(20),
                                                          //     ),
                                                          //     child: Center(
                                                          //       child: Row(
                                                          //         children: const [
                                                          //           Padding(
                                                          //             padding:
                                                          //                 EdgeInsets.only(
                                                          //                     left: 4,
                                                          //                     right: 4),
                                                          //             child: Text(
                                                          //               "40",
                                                          //               style: TextStyle(
                                                          //                   color:
                                                          //                       Colors.white,
                                                          //                   fontSize: 11),
                                                          //             ),
                                                          //           ),
                                                          //           Padding(
                                                          //             padding:
                                                          //                 EdgeInsets.only(
                                                          //                     right: 4),
                                                          //             child: Text(
                                                          //               "Times Rents",
                                                          //               style: TextStyle(
                                                          //                   fontSize: 11,
                                                          //                   color:
                                                          //                       Colors.white),
                                                          //             ),
                                                          //           ),
                                                          //         ],
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
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
                      ),
                      // ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          height: 50,
                          width: 393,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 66.5),
                                child: Icon(
                                  Icons.home,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Home_account_screen(
                                                user_id, first_name_first_char),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ),
                      Positioned(
                        top: 730,
                        left: 142,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Plus_button_screen(
                                    user_id, first_name_first_char),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            shape: const CircleBorder(),
                            elevation: 10,
                            backgroundColor: Colors.white,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(13),
                            child: Icon(
                              Icons.add,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: is_search_click
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: ListView(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              is_search_click = false;
                                            });
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 210, left: 20),
                                      child: Text(
                                        "Vehicle Search :-",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: TextField(
                                        controller: vehicle_search_Controller,
                                        focusNode: vehicle_search,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                              Icons.directions_car_rounded),
                                          suffix: GestureDetector(
                                            child: const Icon(Icons.clear),
                                            onTap: () {
                                              vehicle_search_Controller.clear();
                                            },
                                          ),
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
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderSide:
                                          //       const BorderSide(color: Colors.transparent),
                                          //   borderRadius: BorderRadius.circular(20),
                                          // ),
                                          hintText:
                                              "Model Name, Company Name, Passing Year",
                                          // errorBorder: InputBorder.none,
                                          border: const OutlineInputBorder(
                                              //   borderRadius:
                                              //       BorderRadius.all(Radius.circular(5)),
                                              //   borderSide: BorderSide(width: 3),
                                              // ),
                                              ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 25, left: 20),
                                      child: Text(
                                        "Location Search :-",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: TextField(
                                        controller: location_search_Controller,
                                        focusNode: location_search,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.pin_drop),
                                          suffix: GestureDetector(
                                            child: const Icon(Icons.clear),
                                            onTap: () {
                                              location_search_Controller
                                                  .clear();
                                            },
                                          ),
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
                                          // disabledBorder: OutlineInputBorder(
                                          //   borderSide:
                                          //       const BorderSide(color: Colors.transparent),
                                          //   borderRadius: BorderRadius.circular(20),
                                          // ),
                                          hintText: "City, State, Pin Code",
                                          // errorBorder: InputBorder.none,
                                          border: const OutlineInputBorder(
                                              //   borderRadius:
                                              //       BorderRadius.all(Radius.circular(5)),
                                              //   borderSide: BorderSide(width: 3),
                                              // ),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 30),
                                      child: Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            searched_get_data();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Text(
                                              "Search",
                                              style: TextStyle(fontSize: 28),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const Center(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
    // );
  }
}
