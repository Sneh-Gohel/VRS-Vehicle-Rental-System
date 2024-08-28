// ignore_for_file: no_logic_in_create_state, camel_case_types, file_names, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'Driver_details_screen.dart';
import 'Vehicle_detail_screen.dart';

class Driver_booking_done_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String driver_id = "";
  Driver_booking_done_screen(
      this.user_id, this.first_name_first_char, this.driver_id,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Driver_booking_done_screen(user_id, first_name_first_char, driver_id);
}

class _Driver_booking_done_screen extends State<Driver_booking_done_screen> {
  String user_id = "";
  String visitor_first_name_first_char = "";
  String driver_id = "";

  _Driver_booking_done_screen(
      this.user_id, this.visitor_first_name_first_char, this.driver_id);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Driver_details_screen(
                                  user_id, visitor_first_name_first_char, driver_id),
                            ),
                            (route) => route.isFirst,
                          );
        },
        child: Center(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Color.fromARGB(255, 223, 230, 240),
                  child: Center(
                    child: Icon(
                      Icons.done_rounded,
                      color: Colors.blue,
                      size: 100,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 50,
                  width: 317,
                  child: Center(
                    child: Text(
                      "Congratulations",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: SizedBox(
                  height: 50,
                  width: 238,
                  child: Center(
                    child: Text(
                      "Your Driver Is Book",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 54, 144, 250),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 55),
                child: SizedBox(
                  height: 60,
                  width: 360,
                  child: Center(
                    child: Text(
                      "Note : We’ve sends the information about your booking to the Driver & You also need to inform Driver about your booking",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 98, 101, 176),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 200),
                child: SizedBox(
                  height: 20,
                  width: 360,
                  child: Center(
                    child: Text(
                      "Click any were to Continue...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 98, 101, 176),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
