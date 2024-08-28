// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, no_logic_in_create_state, prefer_typing_uninitialized_variables, use_build_context_synchronously, depend_on_referenced_packages, must_be_immutable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:vrs/vehicle_booking_done_screen.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'package:http/http.dart' as http;

class Vehicle_booking_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String vehicle_id = "";
  String vehicle_owner_id = "";
  String vehicle_price = "";

  Vehicle_booking_screen(this.user_id, this.first_name_first_char,
      this.vehicle_id, this.vehicle_owner_id, this.vehicle_price,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Vehicle_booking_screen(user_id,
      first_name_first_char, vehicle_id, vehicle_owner_id, vehicle_price);
}

class _Vehicle_booking_screen extends State<Vehicle_booking_screen> {
  String user_id = "";
  String vehicle_id = "";
  String vehicle_owner_user_id = "";
  String vehicle_price = "";
  String visitor_first_name_first_char = "";
  DateTime? booking_information_starting_date;
  DateTime? booking_information_ending_date;
  final booking_information_starting_date_Controller = TextEditingController();
  final booking_information_ending_date_Controller = TextEditingController();
  final booking_information_total_days_Controller = TextEditingController();
  final booking_information_current_date_Controller = TextEditingController();
  final booking_information_current_time_Controller = TextEditingController();
  final booking_information_description_Controller = TextEditingController();
  final booker_information_name = TextEditingController();
  final booker_information_contact = TextEditingController();
  final booker_information_birthdate = TextEditingController();
  final booker_information_age = TextEditingController();
  final booker_information_sex = TextEditingController();
  final booking_information_description = FocusNode();
  String? formattedDate;
  String? Available_status;
  var user_information;
  bool loading_screen = false;

  _Vehicle_booking_screen(
    this.user_id,
    this.visitor_first_name_first_char,
    this.vehicle_id,
    this.vehicle_owner_user_id,
    this.vehicle_price,
  );

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
    String URL = "http://$ip/VRS/vehicle_availablity_check.php";
    String responce;
    var request = await http.post(Uri.parse(URL), body: {
      "vehicle_id": vehicle_id,
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
      if (booking_information_description_Controller.text != "") {
        String ip = Current_IP().getIP();
        String URL = "http://$ip/VRS/vehicle_booking.php";
        String responce;
        var request = await http.post(Uri.parse(URL), body: {
          "starting_date": booking_information_starting_date_Controller.text,
          "ending_date": booking_information_ending_date_Controller.text,
          "days": booking_information_total_days_Controller.text,
          "booking_date": booking_information_current_date_Controller.text,
          "booking_time": booking_information_current_time_Controller.text,
          "descripion": booking_information_description_Controller.text,
          "visitor_id": user_id,
          "vehicle_id": vehicle_id,
          "vehicle_owner_user_id": vehicle_owner_user_id,
          "price": vehicle_price,
        });
        responce = (jsonDecode(request.body)).toString();
        if (responce == "sucessfull") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Vehicle_booking_done_screen(
                  user_id, visitor_first_name_first_char, vehicle_id),
            ),
          );
        }
      } else {
        FocusScope.of(context).requestFocus(booking_information_description);
      }
    }
  }

  get_date() async {
    String ip = Current_IP().getIP();
    String URL = "http://$ip/VRS/vehicle_booking_screen_get_date.php";
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    user_information = (jsonDecode(request.body));
    setState(() {
      booker_information_name.text =
          user_information['first_name'] + " " + user_information['last_name'];
      booker_information_contact.text = user_information['contact'];
      booker_information_birthdate.text = user_information['birth_date'];
      booker_information_age.text = user_information['age'].toString();
      booker_information_sex.text = user_information['gender'];
    });
  }

  @override
  void initState() {
    super.initState();
    get_date();
    booking_information_current_date_Controller.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    booking_information_current_time_Controller.text =
        DateFormat('hh:mm a').format(DateTime.now());
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
                  backgroundColor: Colors.white,
                  child: Text(visitor_first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
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
      body: loading_screen
          ? const Center(
              child: SpinKitWave(size: 35, color: Colors.blue),
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
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 5,
                      child: SizedBox(
                        height: 170,
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
                        "Booker Information(Your Information) :",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 25, right: 25),
                    child: TextField(
                      controller: booker_information_name,
                      // focusNode: booking_information_description,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
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
                        hintText: "Booker Name",
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
                      controller: booker_information_contact,
                      // focusNode: booking_information_description,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
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
                        hintText: "Booker Contact Number",
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
                      controller: booker_information_birthdate,
                      // focusNode: booking_information_description,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
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
                        hintText: "Booker BirthDate",
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
                      controller: booker_information_age,
                      // focusNode: booking_information_description,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.onetwothree),
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
                        hintText: "Booker Age",
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
                      controller: booker_information_sex,
                      // focusNode: booking_information_description,
                      // onEditingComplete: () {
                      //   if (password_Controller.text == "") {
                      //     FocusScope.of(context).requestFocus(password);
                      //   } else {
                      //     user_id.unfocus();
                      //   }
                      // },
                      enabled: false,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outlined),
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
                        hintText: "Booker Gender",
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
