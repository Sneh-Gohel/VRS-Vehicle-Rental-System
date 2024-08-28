// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names, no_logic_in_create_state, use_build_context_synchronously, depend_on_referenced_packages, must_be_immutable, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vrs/Block_user_screen.dart';
import 'package:vrs/Home_screen.dart';
import 'package:vrs/Login_screen.dart';
import 'package:vrs/Signup_screen_2.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'Current_IP.dart';


class Signup_screen_3 extends StatefulWidget {
  String? first_name;
  String? last_name;
  String? mobile_number;
  String? gender;
  String? date_of_birth;
  String? city;
  String? state;
  String? country;
  String? pin_code;
  String? user_id;
  String? enter_password;
  String? reenter_password;
  Signup_screen_3(
      String this.first_name,
      String this.last_name,
      String this.mobile_number,
      String this.gender,
      String this.date_of_birth,
      String this.city,
      String this.state,
      String this.country,
      String this.pin_code,
      String this.user_id,
      String this.enter_password,
      String this.reenter_password,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Singup_screen_3(
      first_name!,
      last_name!,
      mobile_number!,
      gender!,
      date_of_birth!,
      city!,
      state!,
      country!,
      pin_code!,
      user_id!,
      enter_password!,
      reenter_password!);
}

class _Singup_screen_3 extends State<Signup_screen_3> {
  final first_name_Controller = TextEditingController();
  final last_name_Controller = TextEditingController();
  final mobile_number_Controller = TextEditingController();
  String gender = "";
  final date_of_birth_Controller = TextEditingController();
  final city_Controller = TextEditingController();
  final state_Controller = TextEditingController();
  final country_Controller = TextEditingController();
  final pin_code_Controller = TextEditingController();
  final user_id_Controller = TextEditingController();
  final password_Controller = TextEditingController();
  final reenter_password_Controller = TextEditingController();
  final city = FocusNode();
  final state = FocusNode();
  final country = FocusNode();
  final pin_code = FocusNode();
  var show_password_bool = true;
  final user_id = FocusNode();
  final password = FocusNode();
  final reenter_password = FocusNode();
  bool enter_password_hide = true;
  bool reenter_password_hide = true;
  bool is_sucessfull = true;
  var status;

  _Singup_screen_3(
      String first_name,
      String last_name,
      String mobile_number,
      this.gender,
      String date_of_birth,
      String city,
      String state,
      String country,
      String pin_code,
      String user_id,
      String enter_password,
      String reenter_password) {
    first_name_Controller.text = first_name;
    last_name_Controller.text = last_name;
    mobile_number_Controller.text = mobile_number;
    date_of_birth_Controller.text = date_of_birth;
    city_Controller.text = city;
    state_Controller.text = state;
    country_Controller.text = country;
    pin_code_Controller.text = pin_code;
    user_id_Controller.text = user_id;
    password_Controller.text = enter_password;
    reenter_password_Controller.text = reenter_password;
    print(gender);
  }

  show_enter_password() {
    setState(
      () {
        if (enter_password_hide == true) {
          enter_password_hide = false;
        } else {
          enter_password_hide = true;
        }
      },
    );
  }

  show_reenter_password() {
    setState(
      () {
        if (reenter_password_hide == true) {
          reenter_password_hide = false;
        } else {
          reenter_password_hide = true;
        }
      },
    );
  }

  signup_press() async {
    if (user_id_Controller.text == "") {
      FocusScope.of(context).requestFocus(user_id);
    } else {
      if (password_Controller.text == "") {
        FocusScope.of(context).requestFocus(password);
      } else {
        if (reenter_password_Controller.text == "") {
          FocusScope.of(context).requestFocus(reenter_password);
        } else {
          if (password_Controller.text == reenter_password_Controller.text) {
            try {
              String ip = Current_IP().getIP();
              String URL = "http://" + ip + "/VRS/user_checking.php";
              String responce;
              var request = await http.post(Uri.parse(URL), body: {
                "user_id": user_id_Controller.text,
                "mobile_number": mobile_number_Controller.text,
              });
              responce = (jsonDecode(request.body)).toString();
              if (responce == "true") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Block_user_screen(),
                  ),
                );
              } else {
                URL = "http://" + ip + "/VRS/signup.php";
                var request = await http.post(Uri.parse(URL), body: {
                  "first_name": first_name_Controller.text,
                  "last_name": last_name_Controller.text,
                  "mobile_number": mobile_number_Controller.text,
                  "gender": gender,
                  "birth_date": date_of_birth_Controller.text,
                  "city": city_Controller.text,
                  "state": state_Controller.text,
                  "country": country_Controller.text,
                  "pin_code": pin_code_Controller.text,
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Home_screen(user_id_Controller.text)),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  setState(() {
                    is_sucessfull = false;
                    FocusScope.of(context).requestFocus(user_id);
                  });
                }
              }
            } catch (e) {
              print("Getting error on signup error is..." + e.toString());
            }
          } else {
            FocusScope.of(context).requestFocus(reenter_password);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        // User swiped Left
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup_screen_2(
                                first_name_Controller.text,
                                last_name_Controller.text,
                                mobile_number_Controller.text,
                                gender,
                                date_of_birth_Controller.text,
                                city_Controller.text,
                                state_Controller.text,
                                country_Controller.text,
                                pin_code_Controller.text,
                                user_id_Controller.text,
                                password_Controller.text,
                                reenter_password_Controller.text,
                                false),
                          ),
                        );
                      } else if (details.primaryVelocity! < 0) {
                        // User swiped Right
                      }
                    },
                    onTap: () {
                      user_id.unfocus();
                      password.unfocus();
                      reenter_password.unfocus();
                    },
                    child: ListView(
                      children: [
                        is_sucessfull
                            ? const Padding(
                                padding: EdgeInsets.only(top: 30),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 30, left: 50),
                                child: Text(
                                  "User ID Already Taken By Other",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 40, right: 40),
                          child: TextField(
                            controller: user_id_Controller,
                            focusNode: user_id,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () {
                              if (password_Controller.text == "") {
                                FocusScope.of(context).requestFocus(password);
                              } else {
                                user_id.unfocus();
                              }
                            },
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
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "User Id",
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
                            onEditingComplete: () {
                              if (reenter_password_Controller.text == "") {
                                FocusScope.of(context)
                                    .requestFocus(reenter_password);
                              } else {
                                password.unfocus();
                              }
                            },
                            obscureText: enter_password_hide,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.key),
                              suffix: GestureDetector(
                                child: Icon(enter_password_hide
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onTap: () {
                                  show_enter_password();
                                },
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 230, 230, 230),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
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
                              top: 40, left: 40, right: 40),
                          child: TextField(
                            controller: reenter_password_Controller,
                            focusNode: reenter_password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: reenter_password_hide,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.key),
                              suffix: GestureDetector(
                                child: Icon(reenter_password_hide
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onTap: () {
                                  show_reenter_password();
                                },
                              ),
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 230, 230, 230),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "ReEnter Password",
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
                              top: 40, left: 50, right: 50),
                          child: ElevatedButton(
                            onPressed: () {
                              signup_press();
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              shape: const StadiumBorder(),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "Signup",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                "Already have account?",
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
    );
  }
}
