// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, duplicate_ignore, must_be_immutable, no_logic_in_create_state, unused_local_variable

import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:vrs/Forgot_password_screen_2.dart';
import 'package:vrs/Login_screen.dart';
import 'package:vrs/OTP_notification.dart';

class Forgot_password_screen_1 extends StatefulWidget {
  String user_id = "";
  Forgot_password_screen_1(this.user_id, {super.key});

  @override
  State<StatefulWidget> createState() => _Forgot_password_screen_1(user_id);
}

class _Forgot_password_screen_1 extends State<Forgot_password_screen_1> {
  String user_id = "";
  final OTP_Controller = TextEditingController();
  final otp_textfiled = FocusNode();
  var time_counter = 5;
  var resend_color = Colors.grey;
  bool focus = true;
  bool continue_enable = false;
  int OTP = 0000;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  OTP_notification otp_notification = OTP_notification();

  _Forgot_password_screen_1(this.user_id);

  @override
  void initState() {
    super.initState();

    // NotificationsServices otp_noti = NotificationsServices();
    // otp_noti.sendNotification("This is title", "This is body");
    OPT_generator();
    otp_notification.sendNotification("OTP is...", OTP.toString());
    Timer timer;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (focus == true) {
          if (focus == true) {
            setState(
              () {
                if (time_counter != 0) {
                  time_counter = time_counter - 1;
                } else {
                  if (resend_color == Colors.grey) {
                    resend_color = Colors.blue;
                    // timer.cancel();
                  }
                }
              },
            );
          } else {
            timer.cancel();
          }
        } else {
          timer.cancel();
        }
      },
    );
  }

  OPT_generator() {
    var random = Random();
    setState(() {
      OTP = random.nextInt(9000) + 1000;
    });
  }

  resend_press() {
    setState(
      () {
        resend_color = Colors.grey;
        time_counter = 3;
      },
    );
    OPT_generator();
    otp_notification.sendNotification("OTP is...", OTP.toString());
  }

  continue_press() {
    if (OTP_Controller.text == "") {
      FocusScope.of(context).requestFocus(otp_textfiled);
    } else {
      if (OTP_Controller.text == OTP.toString()) {
        focus = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Forgot_password_screen_2(user_id),
          ),
        );
      } else {
        FocusScope.of(context).requestFocus(otp_textfiled);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          focus = false;
          return true;
        },
        child: Scaffold(
          body: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 80, 162, 238)),
            child: Center(
              child: Stack(
                children: [
                  const Positioned(
                    top: 33,
                    child: Image(
                      image: AssetImage(
                        "pictures/city.png",
                      ),
                    ),
                  ),
                  Positioned(
                    top: 216,
                    child: Container(
                      height: 640,
                      width: 393,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          otp_textfiled.unfocus();
                        },
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const Padding(
                                padding: EdgeInsets.only(top: 60),
                                child: Center(
                                  child: Text(
                                    "(The OPT will be sends you via notification.)",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 40, left: 40, right: 40),
                              child: TextField(
                                controller: OTP_Controller,
                                focusNode: otp_textfiled,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.onetwothree_rounded),
                                  suffix: GestureDetector(
                                    child: const Icon(Icons.clear),
                                    onTap: () {
                                      OTP_Controller.clear();
                                    },
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 230, 230, 230),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "OTP",
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
                              padding:
                                  const EdgeInsets.only(top: 30, right: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "If you don't recive a code!",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      resend_press();
                                    },
                                    child: Text(
                                      "Resend",
                                      style: TextStyle(
                                          fontSize: 16, color: resend_color),
                                    ),
                                  ),
                                  const Text(
                                    "in ",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "$time_counter",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 50, right: 50),
                              child: ElevatedButton(
                                onPressed: () {
                                  continue_press();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Go back to login?",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      focus = false;
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login_screen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: const Text("Login",
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 173,
                    left: 23,
                    child: Image(
                      image: AssetImage("pictures/Login_car.png"),
                      height: 86,
                      width: 149,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
