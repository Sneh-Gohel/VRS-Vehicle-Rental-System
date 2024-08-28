// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, duplicate_ignore, depend_on_referenced_packages, must_be_immutable, no_logic_in_create_state, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Login_screen.dart';
import 'package:http/http.dart' as http;
import 'Current_IP.dart';

class Forgot_password_screen_2 extends StatefulWidget {
  String user_id = "";
  Forgot_password_screen_2(this.user_id, {super.key});

  @override
  State<StatefulWidget> createState() => _Forgot_password_screen_2(user_id);
}

class _Forgot_password_screen_2 extends State<Forgot_password_screen_2> {
  String user_id = "";
  final enter_new_password_Controller = TextEditingController();
  final reenter_new_password_Controller = TextEditingController();
  final enter_new_password = FocusNode();
  final reenter_new_password = FocusNode();
  bool enter_new_password_hide = true;
  bool reenter_new_password_hide = true;
  String ip = Current_IP().getIP();
  bool loading_screen = false;

  _Forgot_password_screen_2(this.user_id);

  show_enter_new_password() {
    setState(
      () {
        if (enter_new_password_hide == false) {
          enter_new_password_hide = true;
        } else {
          enter_new_password_hide = false;
        }
      },
    );
  }

  show_reenter_new_password() {
    setState(
      () {
        if (reenter_new_password_hide == false) {
          reenter_new_password_hide = true;
        } else {
          reenter_new_password_hide = false;
        }
      },
    );
  }

  reset_password_btn_click() async {
    if (enter_new_password_Controller.text == "") {
      FocusScope.of(context).requestFocus(enter_new_password);
    } else {
      if (reenter_new_password_Controller.text == "") {
        FocusScope.of(context).requestFocus(reenter_new_password);
      } else {
        if (enter_new_password_Controller.text ==
            reenter_new_password_Controller.text) {
          setState(() {
            loading_screen = true;
          });
          String responce;
          String URL = "http://$ip/VRS/forget_password.php";
          var request = await http.post(Uri.parse(URL), body: {
            "user_id": user_id,
            "password": enter_new_password_Controller.text
          });
          responce = (jsonDecode(request.body)).toString();
          if (responce == "true") {
            setState(() {
              loading_screen = false;
            });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Login_screen()),
              (Route<dynamic> route) => false,
            );
          } else {
            setState(() {
              loading_screen = false;
            });
          }
        } else {
          FocusScope.of(context).requestFocus(reenter_new_password);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                          enter_new_password.unfocus();
                          reenter_new_password.unfocus();
                        },
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 80, left: 40, right: 40),
                              child: TextField(
                                controller: enter_new_password_Controller,
                                focusNode: enter_new_password,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: enter_new_password_hide,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  suffix: GestureDetector(
                                    child: Icon(enter_new_password_hide
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onTap: () {
                                      show_enter_new_password();
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
                                  hintText: "Enter New Password",
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
                                  top: 40, left: 40, right: 40),
                              child: TextField(
                                controller: reenter_new_password_Controller,
                                focusNode: reenter_new_password,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: reenter_new_password_hide,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  suffix: GestureDetector(
                                    child: Icon(reenter_new_password_hide
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onTap: () {
                                      show_reenter_new_password();
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
                                  hintText: "ReEnter New Password",
                                  // errorBorder: InputBorder.none,
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, left: 50, right: 50),
                              child: ElevatedButton(
                                onPressed: () {
                                  reset_password_btn_click();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  shape: const StadiumBorder(),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "Reset Password",
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
          loading_screen
              ? Positioned(
                  child: SizedBox(
                    height: screenSize.height,
                    width: screenSize.width,
                    child: const Center(
                      child: SpinKitPouringHourGlassRefined(
                        color: Colors.blue,
                        size: 35.0,
                      ),
                    ),
                  ),
                )
              : const Center(),
        ],
      ),
    );
  }
}
