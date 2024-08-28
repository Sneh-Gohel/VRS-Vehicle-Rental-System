// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names, no_logic_in_create_state, unused_local_variable, no_leading_underscores_for_local_identifiers, must_be_immutable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Login_screen.dart';
import 'package:vrs/Signup_screen_1.dart';
import 'package:vrs/Signup_screen_3.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:permission_handler/permission_handler.dart';

class Signup_screen_2 extends StatefulWidget {
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
  bool? show_loading_screen;
  // Signup_screen_2();
  Signup_screen_2(
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
      bool this.show_loading_screen,
      {super.key});
  @override
  State<StatefulWidget> createState() => _Singup_screen_2(
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
      reenter_password!,
      show_loading_screen!);
}

class _Singup_screen_2 extends State<Signup_screen_2> {
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
  double loading_screen_continer_height = 640;
  double loading_screen_continer_width = 393;
  bool show_loading_screen = false;
  bool focus = true;

  _Singup_screen_2(
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
      String reenter_password,
      this.show_loading_screen) {
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
    loading_screen();
  }

  next_press() {
    if (city_Controller.text == "") {
      FocusScope.of(context).requestFocus(city);
    } else {
      if (state_Controller.text == "") {
        FocusScope.of(context).requestFocus(state);
      } else {
        if (country_Controller.text == "") {
          FocusScope.of(context).requestFocus(country);
        } else {
          if (pin_code_Controller.text == "") {
            FocusScope.of(context).requestFocus(pin_code);
          } else {
            focus = false;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Signup_screen_3(
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
                    reenter_password_Controller.text),
              ),
            );
          }
        }
      }
    }
  }

  loading_screen() {
    if (show_loading_screen == true) {
      Timer _timer;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (focus == true) {
            setState(
              () {
                loading_screen_continer_height = 0;
                loading_screen_continer_width = 0;
              },
            );
          } else {
            // _timer.cancel();
          }
          // _timer.cancel();
        },
      );
    } else {
      loading_screen_continer_height = 0;
      loading_screen_continer_width = 0;
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
                        focus = false;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup_screen_1(
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
                                reenter_password_Controller.text),
                          ),
                        );
                      } else if (details.primaryVelocity! < 0) {
                        // User swiped Right
                        next_press();
                      }
                    },
                    onTap: () {
                      city.unfocus();
                      state.unfocus();
                      country.unfocus();
                      pin_code.unfocus();
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 40, right: 40),
                          child: TextField(
                            controller: city_Controller,
                            focusNode: city,
                            keyboardType: TextInputType.streetAddress,
                            onEditingComplete: () {
                              if (state_Controller.text == "") {
                                FocusScope.of(context).requestFocus(state);
                              } else {
                                city.unfocus();
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.location_city),
                              suffix: GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () {
                                  city_Controller.clear();
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
                              hintText: "City",
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
                            controller: state_Controller,
                            focusNode: state,
                            keyboardType: TextInputType.streetAddress,
                            onEditingComplete: () {
                              if (country_Controller.text == "") {
                                FocusScope.of(context).requestFocus(country);
                              } else {
                                state.unfocus();
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.location_city_rounded),
                              suffix: GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () {
                                  state_Controller.clear();
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
                              hintText: "State",
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
                            controller: country_Controller,
                            focusNode: country,
                            keyboardType: TextInputType.streetAddress,
                            onEditingComplete: () {
                              if (pin_code_Controller.text == "") {
                                FocusScope.of(context).requestFocus(pin_code);
                              } else {
                                country.unfocus();
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.flag),
                              suffix: GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () {
                                  country_Controller.clear();
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
                              hintText: "County",
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
                            controller: pin_code_Controller,
                            focusNode: pin_code,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.pin_drop),
                              suffix: GestureDetector(
                                child: const Icon(Icons.clear),
                                onTap: () {
                                  pin_code_Controller.clear();
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
                              // disabledBorder: OutlineInputBorder(
                              //   borderSide:
                              //       const BorderSide(color: Colors.transparent),
                              //   borderRadius: BorderRadius.circular(20),
                              // ),
                              hintText: "Pin Code",
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
                              next_press();
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              shape: const StadiumBorder(),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "Next",
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
              Positioned(
                top: 216,
                child: Container(
                  height: loading_screen_continer_height,
                  width: loading_screen_continer_width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: SpinKitCubeGrid(
                      color: Colors.blue,
                      size: 35.0,
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
