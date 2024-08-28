// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, duplicate_ignore, use_build_context_synchronously, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Block_user_screen.dart';
import 'package:vrs/Forgot_password_screen_1.dart';
import 'package:vrs/Signup_screen_1.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'Current_IP.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<StatefulWidget> createState() => _Login_screen();
}

class _Login_screen extends State<Login_screen> {
  final user_id_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  var show_password_bool = true;
  final user_id = FocusNode();
  final password = FocusNode();
  String info_string = "";
  var status;
  Current_IP? current_ip;
  bool loading_screen = false;

  _Login_screen() {
    // Navigator.of(context).popUntil((route) => true);
    // Navigator.popUntil(
    //     context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  show_password() {
    setState(
      () {
        if (show_password_bool == true) {
          show_password_bool = false;
        } else {
          show_password_bool = true;
        }
      },
    );
  }

  forget_password_click() async {
    setState(() {
      loading_screen = true;
    });
    String ip = Current_IP().getIP();
    String responce;
    String URL = "http://" + ip + "/VRS/user_checking_for_forget_passsword.php";
    var request = await http.post(Uri.parse(URL), body: {
      "user_id": user_id_Controller.text,
    });
    responce = (jsonDecode(request.body)).toString();
    if (responce == "true") {
      setState(() {
        loading_screen = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Forgot_password_screen_1(user_id_Controller.text),
        ),
      );
    } else {
      setState(() {
        loading_screen = false;
        info_string = " *** User Not Found *** ";
      });
    }
  }

  login_press() async {
    if (user_id_Controller.text == "") {
      FocusScope.of(context).requestFocus(user_id);
    } else {
      if (password_Controller.text == "") {
        FocusScope.of(context).requestFocus(password);
      } else {
        setState(() {
          loading_screen = true;
        });
        try {
          String ip = Current_IP().getIP();
          String URL = "http://" + ip + "/VRS/user_checking.php";
          print("");
          String responce;
          var request = await http.post(Uri.parse(URL), body: {
            "user_id": user_id_Controller.text,
            "mobile_number": "",
          });
          responce = (jsonDecode(request.body)).toString();
          if (responce == "true") {
            setState(() {
              loading_screen = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Block_user_screen(),
              ),
            );
          } else {
            String responce;
            String URL = "http://" + ip + "/VRS/login.php";
            var request = await http.post(Uri.parse(URL), body: {
              "user_id": user_id_Controller.text,
              "password": password_Controller.text,
            });
            responce = (jsonDecode(request.body)).toString();
            if (responce == "success") {
              PermissionStatus storagePermissionStatus =
                  await Permission.storage.status;
              if (storagePermissionStatus.isDenied) {
                status = await Permission.storage.request();
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/user_id.txt');
                await file.writeAsString(user_id_Controller.text);
              } else {
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/user_id.txt');
                await file.writeAsString(user_id_Controller.text);
              }
              setState(() {
                loading_screen = false;
              });
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Home_screen(user_id_Controller.text)),
                (Route<dynamic> route) => false,
              );
            } else if (responce == "incorrect_password") {
              setState(() {
                loading_screen = false;
                info_string = " *** Invaild Password *** ";
              });
              FocusScope.of(context).requestFocus(password);
            } else {
              setState(() {
                loading_screen = false;
                info_string = " *** User Not Found *** ";
              });
              FocusScope.of(context).requestFocus(user_id);
            }
          }
        } catch (e) {
          setState(() {
            loading_screen = false;
          });
          print("Unable to login getting exception : " + e.toString());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                  child: GestureDetector(
                    onTap: () {
                      user_id.unfocus();
                      password.unfocus();
                    },
                    child: Container(
                      height: 640,
                      width: 393,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                              child: Text(
                                info_string,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.red),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 44, left: 40, right: 40),
                            child: TextField(
                              controller: user_id_Controller,
                              focusNode: user_id,
                              onEditingComplete: () {
                                if (password_Controller.text == "") {
                                  FocusScope.of(context).requestFocus(password);
                                } else {
                                  user_id.unfocus();
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                suffix: GestureDetector(
                                  child: const Icon(Icons.clear),
                                  onTap: () {
                                    user_id_Controller.clear();
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
                                hintText: "User Name",
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
                              controller: password_Controller,
                              focusNode: password,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: show_password_bool,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.key),
                                suffix: GestureDetector(
                                  child: Icon(show_password_bool
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onTap: () {
                                    show_password();
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
                                hintText: "Password",
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
                                top: 50, left: 50, right: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                login_press();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                shape: const StadiumBorder(),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                forget_password_click();
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(fontSize: 16),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Signup_screen_1(
                                            "",
                                            "",
                                            "",
                                            "",
                                            "",
                                            "",
                                            "",
                                            "",
                                            "",
                                            "",
                                            "",
                                            ""),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Signup",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              const Positioned(
                top: 173,
                left: 23,
                child: Image(
                  image: AssetImage("pictures/Login_car.png"),
                  height: 86,
                  width: 149,
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
        ),
      ),
    );
  }
}
