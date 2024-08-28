// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, no_logic_in_create_state, must_be_immutable, depend_on_referenced_packages, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Add_vehicle_screen.dart';
import 'package:vrs/Renter_profile_current_booking_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'Renter_vehicle_details_screen.dart';
import 'package:http/http.dart' as http;

class Renter_profile_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char;
  Renter_profile_screen(this.user_id, this.first_name_first_char, {super.key});
  @override
  State<StatefulWidget> createState() =>
      _Renter_profile_screen(user_id, first_name_first_char);
}

class _Renter_profile_screen extends State<Renter_profile_screen> {
  bool is_up_arrow_clicked = false;
  String user_id = "";
  String renter_first_name_first_char = "";
  String renter_total_vehicle = "0";
  bool full_loading_screen = false;
  bool vehicle_loading_screen = true;
  var renter_information;
  String ip = Current_IP().getIP();
  var renter_vehicle_information;

  _Renter_profile_screen(this.user_id, this.renter_first_name_first_char);

  get_data() async {
    print(user_id);
    String URL = "http://$ip/VRS/renter_screen_get_renter_details.php";
    String responce;
    var request = await http.post(
      Uri.parse(URL),
      body: {"user_id": user_id},
    );
    setState(() {
      renter_information = (jsonDecode(request.body));
    });

    URL = "http://$ip/VRS/renter_screen_get_count_of_vehicle.php";
    request = await http.post(
      Uri.parse(URL),
      body: {"user_id": user_id.toString()},
    );
    responce = (jsonDecode(request.body)).toString();
    setState(() {
      renter_total_vehicle = responce;
      full_loading_screen = false;
      vehicle_loading_screen = true;
    });

    if (int.parse(renter_total_vehicle) != 0) {
      URL = "http://$ip/VRS/renter_screen_get_vehicle_data.php";
      request = await http.post(
        Uri.parse(URL),
        body: {"user_id": user_id.toString()},
      );
      setState(() {
        renter_vehicle_information = (jsonDecode(request.body));
        vehicle_loading_screen = false;
      });
    } else {
      setState(() {
        vehicle_loading_screen = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    full_loading_screen = true;
    vehicle_loading_screen = false;
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Renter Profile"),
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
                    builder: (context) => Home_account_screen(user_id,renter_first_name_first_char),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: full_loading_screen
          ? Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(200, 255, 255, 255),
              ),
              child: const Center(
                child: SpinKitCubeGrid(
                  color: Colors.blue,
                  size: 35.0,
                ),
              ),
            )
          : Stack(
              children: [
                Positioned(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 10,
                            child: SizedBox(
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
                                    top: 40,
                                    left: 10,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.white,
                                      child: Center(
                                        child: Text(
                                          renter_first_name_first_char,
                                          style: const TextStyle(
                                              fontSize: 56, color: Colors.blue),
                                        ),
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
                                          renter_information['first_name'] +
                                              " " +
                                              renter_information['last_name'],
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.blue),
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
                                          renter_information['age'].toString(),
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Positioned(
                                    left: 160,
                                    top: 90,
                                    child: Row(
                                      children: [
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
                                      renter_information['contact'].toString(),
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.blue),
                                    ),
                                  ),
                                  Positioned(
                                    left: 145,
                                    top: 150,
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(),
                                          child: Text(
                                            "Total Vehicle : ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          renter_total_vehicle,
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        vehicle_loading_screen
                            ? Expanded(
                                child: ListView(
                                  children: const [
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 2,
                                            bottom: 20),
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(),
                                            child: Text(
                                              " - : Your Vehicles : - ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
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
                                child: ListView.builder(
                                  itemCount:
                                      int.parse(renter_total_vehicle) + 1,
                                  // 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              left: 20,
                                              right: 2,
                                              bottom: 20),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(),
                                              child: Text(
                                                " - : Your Vehicles : - ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 202,
                                              width: 325,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.transparent,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 7),
                                                        child: SizedBox(
                                                          height: 140,
                                                          width: 280,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                            child: Center(
                                                              child:
                                                                  Image.network(
                                                                "http://$ip/VRS/" +
                                                                    renter_vehicle_information[
                                                                            index -
                                                                                1]
                                                                        [
                                                                        'vehicle_image_1'],
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
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: Text(
                                                        renter_vehicle_information[
                                                                    index - 1][
                                                                'vehicle_company'] +
                                                            " " +
                                                            renter_vehicle_information[
                                                                    index - 1][
                                                                'vehicle_model'],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 19,
                                                    top: 166,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Price : ",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          Text(
                                                            renter_vehicle_information[
                                                                    index - 1]
                                                                ['price'],
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.blue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          const Text(
                                                            "Rs/Day",
                                                            style: TextStyle(
                                                                fontSize: 15,
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
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => Renter_vehicle_details_screen(
                                                                user_id,
                                                                renter_first_name_first_char,
                                                                renter_vehicle_information[
                                                                        index -
                                                                            1][
                                                                    'vehicle_id']),
                                                          ),
                                                        );
                                                      },
                                                      child: const Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: is_up_arrow_clicked ? 200 : 50,
                  right: 10,
                  child: FloatingActionButton(
                    heroTag: "Add_vehicle",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Add_vehicle_screen(
                              user_id, renter_first_name_first_char),
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
                        Icons.add,
                        color: Colors.white,
                        // size: 500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: is_up_arrow_clicked ? 125 : 50,
                  right: 10,
                  child: FloatingActionButton(
                    heroTag: "Current_booking",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Renter_profile_current_booking_screen(
                                  user_id, renter_first_name_first_char),
                        ),
                      );
                    },
                    backgroundColor: Colors.blue,
                    splashColor: Colors.white,
                    child: const Center(
                      child: Icon(
                        Icons.date_range,
                        color: Colors.white,
                        // size: 500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 10,
                  child: FloatingActionButton(
                    heroTag: "Up_key",
                    onPressed: () {
                      setState(() {
                        if (is_up_arrow_clicked == true) {
                          is_up_arrow_clicked = false;
                        } else {
                          is_up_arrow_clicked = true;
                        }
                      });
                    },
                    backgroundColor:
                        is_up_arrow_clicked ? Colors.white : Colors.blue,
                    splashColor:
                        is_up_arrow_clicked ? Colors.blue : Colors.white,
                    // shape: const CircleBorder(
                    //   side: BorderSide(
                    //     width: 0.0,
                    //     color: Colors.blue,
                    //   ),
                    // ),
                    child: Center(
                      child: Icon(
                        is_up_arrow_clicked
                            ? Icons.cancel_outlined
                            : Icons.arrow_upward_sharp,
                        color: is_up_arrow_clicked ? Colors.blue : Colors.white,
                        // size: 500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
