// ignore_for_file: non_constant_identifier_names, camel_case_types, no_logic_in_create_state, must_be_immutable, file_names, constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'Current_IP.dart';
import 'Driver_details_screen.dart';
import 'Home_account_screen.dart';

const List<String> report_reason_list = <String>[
  'Select Reason For Report',
  'Mismatch documents',
  'Wrong information of Driver',
  'Other'
];

String reason = report_reason_list.first;

class Driver_report_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String Driver_id = "";
  String Driver_image = "";
  Driver_report_screen(this.user_id, this.first_name_first_char, this.Driver_id,
      this.Driver_image,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Driver_report_screen(
      user_id, first_name_first_char, Driver_id, Driver_image);
}

class _Driver_report_screen extends State<Driver_report_screen> {
  String user_id = "";
  String visitor_first_name_first_char = "";
  String Driver_id = "";
  String Driver_image = "";
  String ip = Current_IP().getIP();
  String current_date = "";
  String current_time = "";
  DateTime now = DateTime.now();
  final report_descrption_Controller = TextEditingController();
  final report_descrption = FocusNode();
  bool done_without_reason = false;
  bool loading_screen = false;

  _Driver_report_screen(this.user_id, this.visitor_first_name_first_char,
      this.Driver_id, this.Driver_image);

  submit_press() async {
    if (reason != "Select Reason For Report") {
      if (report_descrption_Controller.text != "") {
        setState(() {
          loading_screen = true;
        });
        String responce;
        String URL = "http://$ip/VRS/report_driver.php";
        var request = await http.post(Uri.parse(URL), body: {
          "user_id": user_id,
          "driver_id": Driver_id,
          "reason": reason,
          "description": report_descrption_Controller.text,
          "date": current_date,
          "time": current_time
        });
        responce = (jsonDecode(request.body)).toString();
        if (responce == "true") {
          URL = "http://$ip/VRS/driver_report_AI.php";
          var request = await http.post(Uri.parse(URL), body: {
            "driver_id": Driver_id,
          });
          responce = (jsonDecode(request.body)).toString();
          if (responce == "true") {
            setState(() {
              loading_screen = false;
            });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Driver_details_screen(
                    user_id, visitor_first_name_first_char, Driver_id),
              ),
              (route) => route.isFirst,
            );
          } else {
            print("getting error");
            setState(() {
              loading_screen = false;
            });
          }
        } else {
          setState(() {
            loading_screen = false;
          });
        }
      } else {
        FocusScope.of(context).requestFocus(report_descrption);
      }
    } else {
      setState(() {
        done_without_reason = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    current_date = DateFormat('dd/MM/yyyy').format(now);
    now = DateTime.now();
    current_time = DateFormat('hh:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Report"),
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
                  child: Text(visitor_first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_account_screen(
                        user_id,
                        visitor_first_name_first_char,
                      ),
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
          : ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30, left: 121.5, right: 121.5),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: SizedBox(
                      height: 200,
                      width: 150,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "http://$ip/VRS/$Driver_image",
                            loadingBuilder:
                                (BuildContext context, Widget child, Progress) {
                              if (Progress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: Progress.expectedTotalBytes != null
                                      ? Progress.cumulativeBytesLoaded /
                                          Progress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
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
                      "Report Information :",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 80,
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
                                    "Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    current_date,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
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
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 80,
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
                                    "Time",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    current_time,
                                    style: const TextStyle(
                                        fontSize: 20, color: Colors.black),
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
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    shadowColor: done_without_reason ? Colors.blue : null,
                    child: SizedBox(
                      height: 100,
                      width: 340,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Column(
                            children: const [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text(
                                    "Reason",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: DropdownButton_for_report_reason(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 23, right: 25),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: SizedBox(
                      height: 180,
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
                                    "Describe Problem",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: TextField(
                                    controller: report_descrption_Controller,
                                    focusNode: report_descrption,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 230, 230, 230),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.blue),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: 'Tell Us Why...',
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        submit_press();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class DropdownButton_for_report_reason extends StatefulWidget {
  const DropdownButton_for_report_reason({super.key});

  @override
  State<DropdownButton_for_report_reason> createState() =>
      _DropdownButton_for_report_reason();
}

class _DropdownButton_for_report_reason
    extends State<DropdownButton_for_report_reason> {
  String dropdownValue = report_reason_list.first;
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
            reason = value;
          },
        );
      },
      items: report_reason_list.map<DropdownMenuItem<String>>(
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
