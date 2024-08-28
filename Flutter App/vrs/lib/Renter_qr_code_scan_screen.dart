// ignore_for_file: camel_case_types, no_logic_in_create_state, non_constant_identifier_names, must_be_immutable, depend_on_referenced_packages, prefer_typing_uninitialized_variables, empty_catches

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'Renter_profile_current_booking_screen.dart';
import 'package:vibration/vibration.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Reter_qr_code_scan_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String booking_id = "";
  Reter_qr_code_scan_screen(
      this.user_id, this.first_name_first_char, this.booking_id,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Renter_qr_code_scan_screen(user_id, first_name_first_char, booking_id);
}

class _Renter_qr_code_scan_screen extends State<Reter_qr_code_scan_screen> {
  String user_id = "";
  String renter_first_name_first_char = "";
  String booking_id = "";
  var booking_information;
  bool loading_screen = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String result = '';
  final code_Controller = TextEditingController();
  final code = FocusNode();
  double screen_width = 0;
  double screen_height = 0;
  bool is_qr_correct = true;
  bool is_code_correct = true;

  _Renter_qr_code_scan_screen(
      this.user_id, this.renter_first_name_first_char, this.booking_id);

  get_data() async {
    String ip = Current_IP().getIP();
    String URL = "http://$ip/VRS/renter_qr_code_scan_screen_get_data.php";
    var request = await http.post(Uri.parse(URL),
        body: {"user_id": user_id, "booking_id": booking_id});
    setState(() {
      booking_information = (jsonDecode(request.body));
      loading_screen = false;
    });
    print(booking_information);
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        setState(() {
          result = scanData.code!;
        });
        controller.pauseCamera();
        print(result);
        if (result == booking_information['booking_code']) {
          try {
            Fluttertoast.showToast(
                msg: "Done",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() async {
              is_code_correct = false;
              code_Controller.clear();
              Vibration.vibrate(duration: 100, amplitude: 128);
            });
          } catch (e) {}
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Renter_profile_current_booking_screen(
                  user_id, renter_first_name_first_char),
            ),
            (route) => route.isFirst,
          );
        } else {
          try {
            Fluttertoast.showToast(
                msg: "This Not Booker...",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() async {
              is_qr_correct = false;
              Vibration.vibrate(duration: 500, amplitude: 128);
            });
          } catch (e) {}
        }
        controller.resumeCamera();
      },
    );
  }

  code_textfiled_text_changed(String text) {
    int length = text.length;
    if (length == 6) {
      if (text == booking_information['booking_code']) {
        try {
          Fluttertoast.showToast(
              msg: "Done",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() async {
            is_code_correct = false;
            code_Controller.clear();
            Vibration.vibrate(duration: 100, amplitude: 128);
          });
        } catch (e) {}
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Renter_profile_current_booking_screen(
                user_id, renter_first_name_first_char),
          ),
          (route) => route.isFirst,
        );
      } else {
        try {
          Fluttertoast.showToast(
              msg: "This Not Booker...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() async {
            is_code_correct = false;
            code_Controller.clear();
            Vibration.vibrate(duration: 500, amplitude: 128);
          });
        } catch (e) {}
      }
    }
  }

  @override
  void initState() {
    loading_screen = true;
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screen_width = size.width;
    screen_height = size.height;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Scan QR Code"),
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
                  child: Text(renter_first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_account_screen(
                          user_id, renter_first_name_first_char),
                    ),
                  );
                },
              )
              // child: Image.asset("pictures/Landing page image.png"),
              ),
        ],
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                child: Container(
                  height: screen_height,
                  width: screen_width,
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
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      border: Border.all(
                                          width: 1,
                                          color: is_qr_correct
                                              ? Colors.transparent
                                              : Colors.red),
                                    ),
                                    child: QRView(
                                      key: qrKey,
                                      onQRViewCreated: _onQRViewCreated,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "- : OR : -",
                                    style: TextStyle(
                                        fontSize: 26, color: Colors.blue),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: TextField(
                                        maxLength: 6,
                                        onChanged: (value) {
                                          code_textfiled_text_changed(value);
                                        },
                                        controller: code_Controller,
                                        focusNode: code,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          suffix: GestureDetector(
                                            child: const Icon(Icons.clear),
                                            onTap: () {
                                              code_Controller.clear();
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
                                          hintText: "Code",

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
        ],
      ),
    );
  }
}
