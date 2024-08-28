// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, no_logic_in_create_state, must_be_immutable, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Current_IP.dart';
import 'package:http/http.dart' as http;

import 'Home_account_screen.dart';

class Visitor_edit_profile_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Visitor_edit_profile_screen(this.user_id, this.first_name_first_char,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Visitor_edit_profile_screen(user_id, first_name_first_char);
}

class _Visitor_edit_profile_screen extends State<Visitor_edit_profile_screen> {
  String user_id = "";
  String visitor_first_name_first_char = "";
  final first_name_Controller = TextEditingController();
  final last_name_Controller = TextEditingController();
  final mobile_number_Controller = TextEditingController();
  final date_of_birth_Controller = TextEditingController();
  final city_Controller = TextEditingController();
  final state_Controller = TextEditingController();
  final country_Controller = TextEditingController();
  final pin_code_Controller = TextEditingController();
  final first_name = FocusNode();
  final last_name = FocusNode();
  final mobile_number = FocusNode();
  final date_of_birth = FocusNode();
  final city = FocusNode();
  final state = FocusNode();
  final country = FocusNode();
  final pin_code = FocusNode();
  bool next_pressed_without_gender = false;
  String gender = "";
  String? formattedDate;
  bool loading_screen = false;
  var visitor_information;

  _Visitor_edit_profile_screen(
      this.user_id, this.visitor_first_name_first_char);

  get_data() async {
    String ip = Current_IP().getIP();
    String URL = "http://$ip/VRS/visitor_edit_details_get_data.php";
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    setState(() {
      visitor_information = (jsonDecode(request.body));
      first_name_Controller.text = visitor_information['first_name'];
      last_name_Controller.text = visitor_information['last_name'];
      mobile_number_Controller.text = visitor_information['mobile_number'];
      gender = visitor_information['gender'];
      date_of_birth_Controller.text = visitor_information['birth_date'];
      city_Controller.text = visitor_information['city'];
      state_Controller.text = visitor_information['state'];
      country_Controller.text = visitor_information['country'];
      pin_code_Controller.text = visitor_information['pin_code'];
      loading_screen = false;
    });
  }

  void gender_option_selected(String value) {
    setState(() {
      gender = value;
    });
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
          loading_screen = false;
        });
      }
    }
  }

  submit_button_click() async {
    if (first_name_Controller.text != "") {
      if (last_name_Controller.text != "") {
        if (mobile_number_Controller.text != "") {
          if (gender != "") {
            if (date_of_birth_Controller.text != "") {
              if (city_Controller.text != "") {
                if (state_Controller.text != "") {
                  if (country_Controller.text != "") {
                    if (pin_code_Controller.text != "") {
                      if (pin_code_Controller.text.length == 6) {
                        setState(() {
                          loading_screen = true;
                        });
                        String ip = Current_IP().getIP();
                        String responce = "";
                        String URL = "http://$ip/VRS/visitor_edit_details.php";
                        var request = await http.post(Uri.parse(URL), body: {
                          "user_id": user_id,
                          "first_name": first_name_Controller.text,
                          "last_name": last_name_Controller.text,
                          "mobile_number": mobile_number_Controller.text,
                          "gender": gender,
                          "birth_date": date_of_birth_Controller.text,
                          "city": city_Controller.text,
                          "state": state_Controller.text,
                          "country": country_Controller.text,
                          "pin_code": pin_code_Controller.text
                        });
                        responce = (jsonDecode(request.body)).toString();
                        if (responce == "sucessfull") {
                          setState(() {
                            loading_screen = false;
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home_account_screen(
                                  user_id, visitor_first_name_first_char),
                            ),
                            (route) => route.isFirst,
                          );
                        } else {
                          setState(() {
                            loading_screen = false;
                          });
                        }
                      } else {
                        FocusScope.of(context).requestFocus(pin_code);
                      }
                    } else {
                      FocusScope.of(context).requestFocus(pin_code);
                    }
                  } else {
                    FocusScope.of(context).requestFocus(country);
                  }
                } else {
                  FocusScope.of(context).requestFocus(state);
                }
              } else {
                FocusScope.of(context).requestFocus(city);
              }
            } else {
              FocusScope.of(context).requestFocus(date_of_birth);
            }
          } else {
            setState(() {
              next_pressed_without_gender = true;
            });
          }
        }
        else
        {
          FocusScope.of(context).requestFocus(mobile_number);
        }
      }
      else
      {
        FocusScope.of(context).requestFocus(last_name);
      }
    }
    else
    {
      FocusScope.of(context).requestFocus(first_name);
    }
  }

  @override
  void initState() {
    super.initState();
    loading_screen = true;
    // getCurrentLocation();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Edit Profile..."),
        backgroundColor: Colors.blue,
        elevation: 10,
      ),
      body: Center(
        child: loading_screen
            ? const SpinKitWanderingCubes(
                color: Colors.blue,
                size: 35.0,
              )
            : ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 25, right: 25),
                    child: TextField(
                      controller: first_name_Controller,
                      focusNode: first_name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            first_name_Controller.clear();
                          },
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 230, 230, 230),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: TextField(
                      controller: last_name_Controller,
                      focusNode: last_name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            last_name_Controller.clear();
                          },
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 230, 230, 230),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: TextField(
                      controller: mobile_number_Controller,
                      focusNode: mobile_number,
                      keyboardType: TextInputType.phone,
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
                        fillColor: const Color.fromARGB(255, 230, 230, 230),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      shadowColor:
                          next_pressed_without_gender ? Colors.blue : null,
                      elevation: 10,
                      child: SizedBox(
                        height: 200,
                        width: 313,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 5, left: 5),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: InkWell(
                      onTap: () {
                        birth_day_picker();
                      },
                      child: TextField(
                        enabled: false,
                        controller: date_of_birth_Controller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.calendar_month_sharp),
                          suffix: GestureDetector(
                            child: const Icon(Icons.calendar_month_outlined),
                            onTap: () {},
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 230, 230, 230),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: TextField(
                      controller: city_Controller,
                      focusNode: city,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            city_Controller.clear();
                          },
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 230, 230, 230),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
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
                        prefixIcon: const Icon(Icons.location_city_rounded),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            state_Controller.clear();
                          },
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 230, 230, 230),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
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
                        fillColor: const Color.fromARGB(255, 230, 230, 230),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
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
                        fillColor: const Color.fromARGB(255, 230, 230, 230),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.blue),
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
                      top: 40,
                      left: 50,
                      right: 50,
                      bottom: 50,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        submit_button_click();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        shape: const StadiumBorder(),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
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
