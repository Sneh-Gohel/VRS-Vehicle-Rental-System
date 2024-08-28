// ignore_for_file: camel_case_types, file_names, constant_identifier_names, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'Current_IP.dart';
import 'Driver_details_screen.dart';
import 'Home_account_screen.dart';
import 'package:http/http.dart' as http;

import 'driver_booking_done_screen.dart';

const List<String> flue_list = <String>[
  'Petrol',
  'Diesel',
  'Electric',
];

const List<String> transmission_mode_list = <String>[
  'Manual',
  'Automatic',
  'None',
];
String flue_type = flue_list.first;
String tranmission_mode = transmission_mode_list.first;

class Driver_booking_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String driver_id = "";
  String price = "";
  String driver_user_id = "";
  Driver_booking_screen(this.user_id, this.first_name_first_char,
      this.driver_id, this.price, this.driver_user_id,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Driver_booking_screen(
      user_id, first_name_first_char, driver_id, price, driver_user_id);
}

class _Driver_booking_screen extends State<Driver_booking_screen> {
  String user_id = "";
  String first_name_first_char = "";
  String driver_id = "";
  String driver_user_id = "";
  DateTime? booking_information_starting_date;
  DateTime? booking_information_ending_date;
  final booking_information_starting_date_Controller = TextEditingController();
  final booking_information_ending_date_Controller = TextEditingController();
  final booking_information_total_days_Controller = TextEditingController();
  final booking_information_current_date_Controller = TextEditingController();
  final booking_information_current_time_Controller = TextEditingController();
  final booking_information_price_Controller = TextEditingController();
  final booking_information_description_Controller = TextEditingController();
  final vehicle_information_model_name_Controller = TextEditingController();
  final vehicle_information_company_name_Controller = TextEditingController();
  final vehicle_information_passing_year_Controller = TextEditingController();
  final vehicle_information_wheeler_Controller = TextEditingController();
  final owner_information_name_Controller = TextEditingController();
  final owner_information_contact_Controller = TextEditingController();
  final booking_information_description = FocusNode();
  final vehicle_information_model_name = FocusNode();
  final vehicle_information_company_name = FocusNode();
  final vehicle_information_passing_year = FocusNode();
  final vehicle_information_wheeler = FocusNode();
  String? formattedDate;
  String? Available_status;
  String ip = Current_IP().getIP();
  bool loading_screen = false;

  _Driver_booking_screen(this.user_id, this.first_name_first_char,
      this.driver_id, String price, this.driver_user_id) {
    booking_information_price_Controller.text = price;
  }

  starting_date_picker() async {
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
        initialDate: DateTime(current_year, current_month, current_date),
        firstDate: DateTime(current_year, current_month, current_date),
        lastDate: DateTime(current_year, current_month + 2, current_date),
        helpText: "Select Stating Date");

    if (picked_birth_date != null) {
      formattedDate = DateFormat('dd/MM/yyyy').format(picked_birth_date);
      setState(() {
        booking_information_starting_date =
            DateFormat('dd/MM/yyyy').parse(formattedDate.toString());
        booking_information_starting_date_Controller.text =
            formattedDate.toString();
      });
      day_counter();
    }
  }

  ending_date_picker() async {
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
        initialDate: DateTime(current_year, current_month, current_date),
        firstDate: DateTime(current_year, current_month, current_date),
        lastDate: DateTime(current_year, current_month + 2, current_date),
        helpText: "Select Ending Date");

    if (picked_birth_date != null) {
      formattedDate = DateFormat('dd/MM/yyyy').format(picked_birth_date);
      setState(() {
        booking_information_ending_date =
            DateFormat('dd/MM/yyyy').parse(formattedDate.toString());
        booking_information_ending_date_Controller.text =
            formattedDate.toString();
      });
      day_counter();
    }
  }

  day_counter() {
    if (booking_information_starting_date_Controller.text != "") {
      if (booking_information_ending_date_Controller.text != "") {
        setState(() {
          int days = booking_information_ending_date!
              .difference(booking_information_starting_date!)
              .inDays;
          days++;
          if (days > 0) {
            booking_information_total_days_Controller.text = days.toString();
            available_status_checker();
          } else {
            booking_information_total_days_Controller.text = "Invaild";
          }
        });
      }
    }
  }

  available_status_checker() async {
    setState(() {
      loading_screen = true;
    });
    String ip = Current_IP().getIP();
    String URL = "http://$ip/VRS/driver_availablity_check.php";
    String responce;
    var request = await http.post(Uri.parse(URL), body: {
      "driver_id": driver_id,
      "booking_starting_date":
          booking_information_starting_date_Controller.text,
      "booking_ending_date": booking_information_ending_date_Controller.text,
    });
    responce = (jsonDecode(request.body)).toString();
    setState(() {
      if (int.parse(responce) == 0) {
        Available_status = "Available";
      } else {
        Available_status = "Not Available";
      }
      loading_screen = false;
    });
  }

  book_now_click() async {
    if (Available_status == "Available") {
      if (booking_information_current_date_Controller.text != "") {
        if (booking_information_current_time_Controller.text != "") {
          if (booking_information_description_Controller.text != "") {
            if (vehicle_information_model_name_Controller.text != "") {
              if (vehicle_information_company_name_Controller.text != "") {
                if (vehicle_information_passing_year_Controller.text != "") {
                  if (vehicle_information_passing_year_Controller.text !=
                      "Invaild") {
                    int passing_year_int = int.parse(
                        vehicle_information_passing_year_Controller.text);
                    int currentYear = DateTime.now().year;
                    if (passing_year_int > 1900 &&
                        passing_year_int <= currentYear) {
                      setState(() {
                        loading_screen = true;
                      });
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const Driver_details_screen(),
                      //   ),
                      // );
                      String URL = "http://$ip/VRS/driver_booking.php";
                      var request = await http.post(Uri.parse(URL), body: {
                        "driver_id": driver_id,
                        "starting_date":
                            booking_information_starting_date_Controller.text,
                        "ending_date":
                            booking_information_ending_date_Controller.text,
                        "total_days":
                            booking_information_total_days_Controller.text,
                        "booking_date":
                            booking_information_current_date_Controller.text,
                        "booking_time":
                            booking_information_current_time_Controller.text,
                        "price": booking_information_price_Controller.text,
                        "descrption":
                            booking_information_description_Controller.text,
                        "vehicle_model_name":
                            vehicle_information_model_name_Controller.text,
                        "vehicle_company_name":
                            vehicle_information_company_name_Controller.text,
                        "vehicle_passing_year":
                            vehicle_information_passing_year_Controller.text,
                        "vehicle_total_wheels":
                            vehicle_information_wheeler_Controller.text,
                        "vehicle_fule_type": flue_type,
                        "vehicle_tranmission": tranmission_mode,
                        "visitor_id": user_id,
                        "driver_user_id": driver_user_id
                      });
                      try {
                        String responce = (jsonDecode(request.body)).toString();
                        if (responce == "successfull") {
                          setState(() {
                            loading_screen = false;
                          });
                          print(responce);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Driver_booking_done_screen(
                                  user_id, first_name_first_char, driver_id),
                            ),
                          );
                        } else {
                          print('error');
                          setState(() {
                            loading_screen = false;
                          });
                        }
                      } catch (e) {
                        print("getting error..." + e.toString());
                        setState(() {
                          loading_screen = false;
                        });
                      }
                    } else {
                      setState(() {
                        vehicle_information_passing_year_Controller.text =
                            "Invaild";
                        FocusScope.of(context)
                            .requestFocus(vehicle_information_passing_year);
                      });
                    }
                  } else {
                    FocusScope.of(context)
                        .requestFocus(vehicle_information_passing_year);
                  }
                } else {
                  FocusScope.of(context)
                      .requestFocus(vehicle_information_wheeler);
                }
              } else {
                FocusScope.of(context)
                    .requestFocus(vehicle_information_passing_year);
              }
            } else {
              FocusScope.of(context)
                  .requestFocus(vehicle_information_model_name);
            }
          } else {
            FocusScope.of(context)
                .requestFocus(booking_information_description);
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    first_name_first_char = "A";
    booking_information_current_date_Controller.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    booking_information_current_time_Controller.text =
        DateFormat('hh:mm a').format(DateTime.now());
    owner_information_name_Controller.text = "Ayan Rana";
    owner_information_contact_Controller.text = "7016641560";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
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
                  child: Text(first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Home_account_screen(user_id, first_name_first_char),
                    ),
                  );
                },
              )
              // child: Image.asset("pictures/Landing page image.png"),
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
          : GestureDetector(
              onTap: () {
                booking_information_description.unfocus();
              },
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Booking Information :",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: InkWell(
                      onTap: () {
                        starting_date_picker();
                      },
                      child: TextField(
                        enabled: false,
                        controller:
                            booking_information_starting_date_Controller,
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
                          hintText: "Select Starting Date",
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
                    child: InkWell(
                      onTap: () {
                        ending_date_picker();
                      },
                      child: TextField(
                        enabled: false,
                        controller: booking_information_ending_date_Controller,
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
                          hintText: "Select Ending Date",
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
                  (booking_information_starting_date_Controller.text != "" &&
                          booking_information_ending_date_Controller.text != "")
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 40, right: 25),
                          child: (Available_status == "Available")
                              ? Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.green,
                                    ),
                                    const Text(
                                      " ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      Available_status!,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.green),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.red,
                                    ),
                                    const Text(
                                      " ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      Available_status!,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.red),
                                    ),
                                  ],
                                ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 25, right: 25),
                    child: TextField(
                      controller: booking_information_total_days_Controller,
                      // focusNode: user_id,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.today),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            // user_id_Controller.clear();
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
                        hintText: "Total Days",
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
                      controller: booking_information_current_date_Controller,
                      // focusNode: user_id,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.calendar_month_sharp),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            // user_id_Controller.clear();
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
                        hintText: "Current Date",
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
                      controller: booking_information_current_time_Controller,
                      // focusNode: booking_information_description,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.access_time_rounded),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            // user_id_Controller.clear();
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
                        hintText: "Current Time",
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
                      controller: booking_information_price_Controller,
                      // focusNode: booking_information_description,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.currency_rupee_rounded),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            // user_id_Controller.clear();
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
                        hintText: "Price",
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
                      elevation: 5,
                      child: SizedBox(
                        height: 150,
                        width: 340,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 15),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(),
                                    child: Text(
                                      "Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 10),
                                    child: TextField(
                                      controller:
                                          booking_information_description_Controller,
                                      focusNode:
                                          booking_information_description,
                                      decoration: InputDecoration(
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
                                        hintText:
                                            'Write Description About Booking...',
                                        // border: OutlineInputBorder(),
                                      ),
                                      // keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      maxLines: 3,
                                      // textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Vehicle Information (Your Vehicle Information) :",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: TextField(
                      controller: vehicle_information_model_name_Controller,
                      focusNode: vehicle_information_model_name,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.directions_car_sharp),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            vehicle_information_model_name_Controller.clear();
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
                        hintText: "Vehicle Model Name",
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
                      controller: vehicle_information_company_name_Controller,
                      focusNode: vehicle_information_company_name,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.directions_car_rounded),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            vehicle_information_company_name_Controller.clear();
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
                        hintText: "Vehicle Company Name",
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
                      controller: vehicle_information_passing_year_Controller,
                      focusNode: vehicle_information_passing_year,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.today),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            vehicle_information_model_name_Controller.clear();
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
                        hintText: "Vehicle Passing Year",
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
                      controller: vehicle_information_wheeler_Controller,
                      focusNode: vehicle_information_wheeler,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.album_rounded),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            vehicle_information_wheeler_Controller.clear();
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
                        hintText: "Total Count Of Wheels",
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
                        const EdgeInsets.only(left: 25, right: 25, top: 20),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(),
                          child: Text(
                            "Flue Type...",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 70),
                          child: Text(
                            "Tranmission Mode...",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 10, top: 0),
                    child: Row(
                      children: const [
                        DropdownButton_for_flue_type(),
                        Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: DropdownButton_for_transmission_mode(),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Vehicle Owner Information (Your Information) :",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: TextField(
                      controller: owner_information_name_Controller,
                      // focusNode: owner_information_name_Controller,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            owner_information_name_Controller.clear();
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
                        hintText: "Vehicle Owner Name",
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
                      controller: owner_information_contact_Controller,
                      // focusNode: user_id,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        suffix: GestureDetector(
                          child: const Icon(Icons.clear),
                          onTap: () {
                            owner_information_contact_Controller.clear();
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
                        hintText: "Vehicle Owner Contanct",
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
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: 70,
                      width: 393,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            book_now_click();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
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

class DropdownButton_for_flue_type extends StatefulWidget {
  const DropdownButton_for_flue_type({super.key});

  @override
  State<DropdownButton_for_flue_type> createState() =>
      _DropdownButton_for_flue_type();
}

class _DropdownButton_for_flue_type
    extends State<DropdownButton_for_flue_type> {
  // String tranmission_mode = flue_list.first;
  String dropdownValue = flue_list.first;
//   String dropdownValue = "Hello";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      hint: const Text("                             "),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(
          () {
            dropdownValue = value!;
            // flue_type = value;
          },
        );
      },
      items: flue_list.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}

class DropdownButton_for_transmission_mode extends StatefulWidget {
  const DropdownButton_for_transmission_mode({super.key});

  @override
  State<DropdownButton_for_transmission_mode> createState() =>
      _DropdownButton_for_transmission_mode();
}

class _DropdownButton_for_transmission_mode
    extends State<DropdownButton_for_transmission_mode> {
  String dropdownValue = transmission_mode_list.first;
//   String dropdownValue = "Hello";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      hint: const Text("                             "),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(
          () {
            dropdownValue = value!;
            // tranmission_mode = value;
          },
        );
      },
      items: transmission_mode_list.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}
