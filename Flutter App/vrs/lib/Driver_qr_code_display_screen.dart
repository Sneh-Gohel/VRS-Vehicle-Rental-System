// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names, camel_case_types, must_be_immutable, depend_on_referenced_packages, prefer_typing_uninitialized_variables, unused_local_variable, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;
import 'Current_IP.dart';
import 'Home_account_screen.dart';

class Driver_qr_code_display_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String booking_id = "";
  Driver_qr_code_display_screen(
      this.user_id, this.first_name_first_char, this.booking_id,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Driver_qr_code_display_screen(
      user_id, first_name_first_char, booking_id);
}

class _Driver_qr_code_display_screen
    extends State<Driver_qr_code_display_screen> {
  String user_id = "";
  String visitor_first_name_first_char = "";
  String booking_id = "";
  var booking_information;
  bool loading_screen = false;

  _Driver_qr_code_display_screen(
      this.user_id, this.visitor_first_name_first_char, this.booking_id);

  get_data() async {
    String ip = Current_IP().getIP();
    String URL = "http://$ip/VRS/driver_qr_code_display_screen_get_data.php";
    var request = await http.post(Uri.parse(URL),
        body: {"user_id": user_id, "booking_id": booking_id});
    setState(() {
      booking_information = (jsonDecode(request.body));
      loading_screen = false;
    });
  }

  @override
  void initState() {
    loading_screen = true;
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Make QR Code"),
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
      body: Stack(
        children: [
          Positioned(
            child: Container(
              height: 800,
              width: 393,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 238, 238, 238),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              height: 182,
              width: 393,
              decoration: const BoxDecoration(color: Colors.blue),
            ),
          ),
          const Positioned(
            left: 0,
            // top: 50,
            child: Image(
              image: AssetImage(
                "pictures/city2.png",
              ),
              height: 182,
            ),
          ),
          const Positioned(
            right: 0,
            top: 40,
            child: Image(
              image: AssetImage(
                "pictures/car2.png",
              ),
              height: 182,
            ),
          ),
          Positioned(
            top: 250,
            left: 37,
            child: Center(
              child: Container(
                height: 394,
                width: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: loading_screen
                    ? const Center(
                        child: SpinKitSquareCircle(
                          color: Colors.blue,
                          size: 35.0,
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                booking_information['first_name'] +
                                    ' ' +
                                    booking_information['last_name'],
                                style: const TextStyle(
                                    fontSize: 26,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: QrImageView( 
                                data: booking_information['booking_code'],
                                version: QrVersions.min,
                                size: 200.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Code : ",
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    booking_information['booking_code'],
                                    style: const TextStyle(
                                        fontSize: 26,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
