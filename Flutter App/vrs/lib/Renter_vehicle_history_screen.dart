// ignore_for_file: camel_case_types, file_names, no_logic_in_create_state, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Renter_vehicle_history_details_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'package:http/http.dart' as http;

class Renter_vehicle_history_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String vehicle_id = "";
  Renter_vehicle_history_screen(
      this.user_id, this.first_name_first_char, this.vehicle_id,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Renter_vehicle_history_screen(
      user_id, first_name_first_char, vehicle_id);
}

class _Renter_vehicle_history_screen
    extends State<Renter_vehicle_history_screen> {
  String user_id = "";
  String renter_first_name_first_char = "";
  String vehicle_id = "";
  String total_history_result_found = "0";
  var vehicle_history_information;
  bool is_history_is_null = false;
  bool loading_screen = false;

  _Renter_vehicle_history_screen(
      this.user_id, this.renter_first_name_first_char, this.vehicle_id);

  get_data() async {
    String ip = Current_IP().getIP();
    String URL = "http://$ip/VRS/renter_vehicle_history_get_count.php";
    String responce;
    var request = await http.post(
      Uri.parse(URL),
      body: {"vehicle_id": vehicle_id},
    );
    responce = (jsonDecode(request.body)).toString();
    setState(() {
      total_history_result_found = responce;
    });

    if (int.parse(total_history_result_found) != 0) {
      URL = "http://$ip/VRS/renter_vehicle_history_screen_get_data.php";
      request = await http.post(
        Uri.parse(URL),
        body: {"vehicle_id": vehicle_id},
      );
      setState(() {
        vehicle_history_information = (jsonDecode(request.body));
      });
    } else {
      setState(() {
        is_history_is_null = true;
      });
    }
    setState(() {
      loading_screen = false;
    });
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
                    builder: (context) => Home_account_screen(user_id,renter_first_name_first_char),
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
          : is_history_is_null
              ? ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          "No Data Found...",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: int.parse(total_history_result_found),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 20, left: 25, right: 25),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Renter_vehicle_history_details_screen(
                                  user_id,
                                  renter_first_name_first_char,
                                  vehicle_history_information[index]
                                      ['vehicle_image_1'],
                                  vehicle_history_information[index]
                                      ['starting_date'],
                                  vehicle_history_information[index]
                                      ['ending_date'],
                                  vehicle_history_information[index]
                                      ['booking_date'],
                                  vehicle_history_information[index]
                                      ['booking_time'],
                                  vehicle_history_information[index]['days'],
                                  vehicle_history_information[index]['price'],
                                  vehicle_history_information[index]
                                      ['description'],
                                  vehicle_history_information[index]
                                          ['first_name'] +
                                      " " +
                                      vehicle_history_information[index]
                                          ['last_name'],
                                  vehicle_history_information[index]['contact'],
                                  vehicle_history_information[index]
                                      ['birth_date'],
                                  vehicle_history_information[index]['age']
                                      .toString(),
                                  vehicle_history_information[index]['gender'],
                                  vehicle_history_information[index]
                                      ['vehicle_model'],
                                  vehicle_history_information[index]
                                      ['vehicle_company'],
                                  vehicle_history_information[index]
                                      ['passing_year'],
                                  vehicle_history_information[index]['seats'],
                                  vehicle_history_information[index]
                                      ['fule_type'],
                                  vehicle_history_information[index]
                                      ['transmission'],
                                  vehicle_history_information[index]
                                      ['vehicle_number'],
                                ),
                              ),
                            );
                          },
                          child: Material(
                            elevation: 10,
                            shadowColor:
                                const Color.fromARGB(255, 187, 219, 248),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 202,
                              width: 325,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(
                                        255, 187, 219, 248),
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(100),
                                      elevation: 10,
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Text(
                                            vehicle_history_information[index]
                                                ['first_name_first_char'],
                                            style: const TextStyle(
                                                fontSize: 40,
                                                color: Colors.blue),
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
                                          color: Colors.blue,
                                        ),
                                        const Text(
                                          " ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          vehicle_history_information[index]
                                                  ['first_name'] +
                                              " " +
                                              vehicle_history_information[index]
                                                  ['last_name'],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
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
                                          color: Colors.blue,
                                        ),
                                        const Text(
                                          " ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          vehicle_history_information[index]
                                              ['contact'],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
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
                                          vehicle_history_information[index]
                                              ['starting_date'],
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                        const Text(
                                          " To ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        // Icon(
                                        //   Icons.calendar_month_outlined,
                                        //   size: 20,
                                        //   color: Colors.black,
                                        // ),
                                        const Text(
                                          "",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          vehicle_history_information[index]
                                              ['ending_date'],
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.blue),
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
                                          color: Colors.black,
                                        ),
                                        const Text(
                                          " ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          vehicle_history_information[index]
                                              ['days'],
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                        const Text(
                                          " Days",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                        const Text(
                                          "          ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons.currency_rupee_sharp,
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
                                          vehicle_history_information[index]
                                              ['price'],
                                          style: const TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                        ),
                                        const Text(
                                          "/Day",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
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
                    );
                  },
                ),
    );
  }
}
