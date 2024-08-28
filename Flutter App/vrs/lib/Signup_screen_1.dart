// ignore_for_file: non_constant_identifier_names, camel_case_types, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vrs/Login_screen.dart';
import 'package:vrs/Signup_screen_2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class Signup_screen_1 extends StatefulWidget {
  String? first_name;
  String? last_name;
  String? mobile_number;
  String gender = "";
  String? date_of_birth;
  String? city;
  String? state;
  String? country;
  String? pin_code;
  String? user_id;
  String? enter_password;
  String? reenter_password;
  Signup_screen_1(
      String this.first_name,
      String this.last_name,
      String this.mobile_number,
      this.gender,
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
  State<StatefulWidget> createState() => _Singup_screen_1(
      first_name!,
      last_name!,
      mobile_number!,
      gender,
      date_of_birth!,
      city!,
      state!,
      country!,
      pin_code!,
      user_id!,
      enter_password!,
      reenter_password!);
}

class _Singup_screen_1 extends State<Signup_screen_1> {
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
  String? formattedDate;
  bool signup_screen_show_loading_screen = false;
  bool next_pressed_without_gender = false;

  final first_name = FocusNode();
  final last_name = FocusNode();
  final mobile_number = FocusNode();
  final date_of_birth = FocusNode();

  void gender_option_selected(String value) {
    setState(() {
      gender = value;
    });
  }

  _Singup_screen_1(
      String first_name,
      String last_name,
      String mobile_number,
      String gender,
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
    this.gender;
    date_of_birth_Controller.text = date_of_birth;
    city_Controller.text = city;
    state_Controller.text = state;
    country_Controller.text = country;
    pin_code_Controller.text = pin_code;
    user_id_Controller.text = user_id;
    password_Controller.text = enter_password;
    reenter_password_Controller.text = reenter_password;
    getCurrentLocation();
    print(gender);
  }

  birth_day_picker() async {
    DateTime? picked_birth_date;
    int current_date = DateTime.now().day;
    int current_month = DateTime.now().month;
    int current_year = DateTime.now().year;
    // print(current_year);

    setState(() {
      formattedDate = "";
    });

    picked_birth_date = await showDatePicker(
        context: context,
        initialDate: DateTime(current_year - 18, current_month, current_date),
        firstDate: DateTime(current_year - 150),
        lastDate: DateTime(current_year - 18, current_month, current_date),
        helpText: "Select Birthdate");

    if (picked_birth_date != null) {
      formattedDate = DateFormat('dd/MM/yyyy').format(picked_birth_date);
      setState(() {
        date_of_birth_Controller.text = formattedDate.toString();
      });
    }
    // print("${birth_date!.day} : ${birth_date.month} : ${birth_date!.year}");
  }

  next_press() {
    if (first_name_Controller.text == "") {
      FocusScope.of(context).requestFocus(first_name);
    } else {
      if (last_name_Controller.text == "") {
        FocusScope.of(context).requestFocus(last_name);
      } else {
        if (mobile_number_Controller.text == "") {
          FocusScope.of(context).requestFocus(mobile_number);
        } else {
          if (date_of_birth_Controller.text == "") {
            birth_day_picker();
          } else {
            if (gender == "") {
              setState(() {
                next_pressed_without_gender = true;
              });
            } else {
              // print(gender);
              Navigator.push(
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
                      signup_screen_show_loading_screen),
                ),
              );
            }
          }
        }
      }
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      print("Location services are disable.");
      return;
    } else {
      await Permission.location.request();
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print("Permisstion denied");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print("Permission is denied for forever...");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placemark = placemarks[0];

      if (city_Controller.text == "" &&
          state_Controller.text == "" &&
          country_Controller.text == "" &&
          pin_code_Controller.text == "") {
        setState(() {
          city_Controller.text = placemark.locality.toString();
          state_Controller.text = placemark.administrativeArea.toString();
          country_Controller.text = placemark.country.toString();
          pin_code_Controller.text = placemark.postalCode.toString();
          signup_screen_show_loading_screen = true;
        });
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
                        } else if (details.primaryVelocity! < 0) {
                          // User swiped Right
                          next_press();
                        }
                      },
                      onTap: () {
                        first_name.unfocus();
                        last_name.unfocus();
                        mobile_number.unfocus();
                        // date_of_birth.unfocus();
                      },
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 40, right: 40),
                            child: TextField(
                              controller: first_name_Controller,
                              focusNode: first_name,
                              keyboardType: TextInputType.text,
                              onEditingComplete: () {
                                if (last_name_Controller.text == "") {
                                  FocusScope.of(context)
                                      .requestFocus(last_name);
                                } else {
                                  first_name.unfocus();
                                }
                              },
                              inputFormatters: [
                                CapitalizeFirstLetterFormatter(),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                suffix: GestureDetector(
                                  child: const Icon(Icons.clear),
                                  onTap: () {
                                    first_name_Controller.clear();
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
                                hintText: "First Name",
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
                              controller: last_name_Controller,
                              focusNode: last_name,
                              keyboardType: TextInputType.text,
                              onEditingComplete: () {
                                if (mobile_number_Controller.text == "") {
                                  FocusScope.of(context)
                                      .requestFocus(mobile_number);
                                } else {
                                  last_name.unfocus();
                                }
                              },
                              inputFormatters: [
                                CapitalizeFirstLetterFormatter(),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                suffix: GestureDetector(
                                  child: const Icon(Icons.clear),
                                  onTap: () {
                                    last_name_Controller.clear();
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
                                hintText: "Last Name",
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
                              controller: mobile_number_Controller,
                              focusNode: mobile_number,
                              keyboardType: TextInputType.phone,
                              onEditingComplete: () {
                                if (date_of_birth_Controller.text == "") {
                                  birth_day_picker();
                                  mobile_number.unfocus();
                                } else {
                                  mobile_number.unfocus();
                                }
                              },
                              inputFormatters: [
                                CapitalizeFirstLetterFormatter(),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.phone),
                                suffix: GestureDetector(
                                  child: const Icon(Icons.clear),
                                  onTap: () {
                                    mobile_number_Controller.clear();
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
                                hintText: "Mobile Number",
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
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              shadowColor: next_pressed_without_gender
                                  ? Colors.blue
                                  : null,
                              elevation: 10,
                              child: SizedBox(
                                height: 200,
                                width: 313,
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 5, left: 5),
                                        child: Text(
                                          "Gender : ",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: RadioListTile(
                                        title: const Text('Male'),
                                        value: 'Male',
                                        groupValue: gender,
                                        onChanged: (String? value) {
                                          gender_option_selected(value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: RadioListTile(
                                        title: const Text('Female'),
                                        value: 'Female',
                                        groupValue: gender,
                                        onChanged: (String? value) {
                                          gender_option_selected(value!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: RadioListTile(
                                        title: const Text('Other'),
                                        value: 'Other',
                                        groupValue: gender,
                                        onChanged: (String? value) {
                                          gender_option_selected(value!);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 40, right: 40),
                            child: InkWell(
                              onTap: () {
                                birth_day_picker();
                              },
                              child: TextField(
                                enabled: false,
                                controller: date_of_birth_Controller,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.calendar_month_sharp),
                                  suffix: GestureDetector(
                                    child: const Icon(
                                        Icons.calendar_month_outlined),
                                    onTap: () {},
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
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Birth Date",
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 50, right: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                next_press();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
            ],
          ),
        ),
      ),
    );
  }
}

class CapitalizeFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      return TextEditingValue(
        text: newValue.text.substring(0, 1).toUpperCase() +
            newValue.text.substring(1),
        selection: newValue.selection,
      );
    }
    return newValue;
  }
}
