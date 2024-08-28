// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, no_logic_in_create_state

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Renter_current_booking_details_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'package:http/http.dart' as http;

class Renter_profile_current_booking_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Renter_profile_current_booking_screen(
      this.user_id, this.first_name_first_char,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Renter_profile_current_booking_screen(user_id, first_name_first_char);
}

class _Renter_profile_current_booking_screen
    extends State<Renter_profile_current_booking_screen> {
  String user_id = "";
  String renter_first_name_first_char = "";
  String ip = Current_IP().getIP();
  String total_result_found = "0";
  var current_booking_information;
  bool is_current_booking_null = false;
  bool loading_screen = false;

  _Renter_profile_current_booking_screen(
      this.user_id, this.renter_first_name_first_char);

  get_data() async {
    String URL = "http://$ip/VRS/renter_current_booking_screen_get_count.php";
    String responce;
    var request = await http.post(
      Uri.parse(URL),
      body: {"user_id": user_id},
    );
    responce = (jsonDecode(request.body)).toString();
    setState(() {
      total_result_found = responce;
    });

    if (int.parse(total_result_found) != 0) {
      URL = "http://$ip/VRS/renter_current_booking_screen_get_data.php";
      request = await http.post(
        Uri.parse(URL),
        body: {"user_id": user_id},
      );
      setState(() {
        current_booking_information = (jsonDecode(request.body));
      });
    } else {
      setState(() {
        is_current_booking_null = true;
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
        automaticallyImplyLeading: true,
        title: const Text("Current Booking"),
        backgroundColor: Colors.blue,
        elevation: 10,
        // scrolledUnderElevation: 1,
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
          : is_current_booking_null
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
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      itemCount: int.parse(total_result_found),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 12, right: 12),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Renter_current_booking_details_screen(
                                    user_id,
                                    renter_first_name_first_char,
                                    current_booking_information[index]
                                        ['booking_id'],
                                    current_booking_information[index]
                                        ['vehicle_image_1'],
                                    current_booking_information[index]
                                        ['starting_date'],
                                    current_booking_information[index]
                                        ['ending_date'],
                                    current_booking_information[index]
                                        ['booking_date'],
                                    current_booking_information[index]
                                        ['booking_time'],
                                    current_booking_information[index]['days'],
                                    current_booking_information[index]['price'],
                                    current_booking_information[index]
                                        ['description'],
                                    current_booking_information[index]
                                            ['first_name'] +
                                        " " +
                                        current_booking_information[index]
                                            ['last_name'],
                                    current_booking_information[index]
                                        ['contact'],
                                    current_booking_information[index]
                                        ['birth_date'],
                                    current_booking_information[index]['age']
                                        .toString(),
                                    current_booking_information[index]
                                        ['gender'],
                                    current_booking_information[index]
                                        ['vehicle_model'],
                                    current_booking_information[index]
                                        ['vehicle_company'],
                                    current_booking_information[index]
                                        ['passing_year'],
                                    current_booking_information[index]['seats'],
                                    current_booking_information[index]
                                        ['fule_type'],
                                    current_booking_information[index]
                                        ['transmission'],
                                  ),
                                ),
                              );
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              elevation: 10,
                              child: SizedBox(
                                height: 200,
                                width: 369,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 13,
                                      left: 15,
                                      child: Material(
                                        borderRadius: BorderRadius.circular(5),
                                        elevation: 10,
                                        child: Container(
                                          height: 170,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              "http://$ip/VRS/" +
                                                  current_booking_information[
                                                      index]['vehicle_image_1'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 175,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.directions_car_filled_sharp,
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
                                            current_booking_information[index]
                                                ['vehicle_model'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 45,
                                      left: 175,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.build,
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
                                            current_booking_information[index]
                                                ['vehicle_company'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 80,
                                      left: 175,
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
                                            current_booking_information[index]
                                                    ['first_name'] +
                                                " " +
                                                current_booking_information[
                                                    index]['last_name'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 115,
                                      left: 175,
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month_outlined,
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
                                            current_booking_information[index]
                                                ['starting_date'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          const Text(
                                            "   To",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: 140,
                                      left: 175,
                                      child: Text(
                                        current_booking_information[index]
                                            ['ending_date'],
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 10,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Renter_current_booking_details_screen(
                                                user_id,
                                                renter_first_name_first_char,
                                                current_booking_information[
                                                    index]['booking_id'],
                                                current_booking_information[
                                                    index]['vehicle_image_1'],
                                                current_booking_information[
                                                    index]['starting_date'],
                                                current_booking_information[
                                                    index]['ending_date'],
                                                current_booking_information[
                                                    index]['booking_date'],
                                                current_booking_information[
                                                    index]['booking_time'],
                                                current_booking_information[
                                                    index]['days'],
                                                current_booking_information[
                                                    index]['price'],
                                                current_booking_information[
                                                    index]['description'],
                                                current_booking_information[
                                                        index]['first_name'] +
                                                    " " +
                                                    current_booking_information[
                                                        index]['last_name'],
                                                current_booking_information[
                                                    index]['contact'],
                                                current_booking_information[
                                                    index]['birth_date'],
                                                current_booking_information[
                                                        index]['age']
                                                    .toString(),
                                                current_booking_information[
                                                    index]['gender'],
                                                current_booking_information[
                                                    index]['vehicle_model'],
                                                current_booking_information[
                                                    index]['vehicle_company'],
                                                current_booking_information[
                                                    index]['passing_year'],
                                                current_booking_information[
                                                    index]['seats'],
                                                current_booking_information[
                                                    index]['fule_type'],
                                                current_booking_information[
                                                    index]['transmission'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
    );
  }
}
