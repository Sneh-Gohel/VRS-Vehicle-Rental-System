// ignore_for_file: no_logic_in_create_state, camel_case_types, file_names, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'Vehicle_detail_screen.dart';

class Vehicle_booking_done_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String vehicle_id = "";
  Vehicle_booking_done_screen(
      this.user_id, this.first_name_first_char, this.vehicle_id,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Vehicle_booking_done_screen(user_id, first_name_first_char, vehicle_id);
}

class _Vehicle_booking_done_screen extends State<Vehicle_booking_done_screen> {
  String user_id = "";
  String visitor_first_name_first_char = "";
  String vehicle_id = "";

  _Vehicle_booking_done_screen(
      this.user_id, this.visitor_first_name_first_char, this.vehicle_id);

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
              builder: (context) => Vehicle_detail_screen(
                  user_id, visitor_first_name_first_char, vehicle_id),
            ),
            (route) => route.isFirst,
          );
        },
        child: const Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 60),
                child: CircleAvatar(
                  radius: 100,
                  // backgroundColor: Color.fromARGB(255, 223, 230, 240),
                  backgroundColor: Colors.blue,
                  child: Center(
                    child: Icon(
                      Icons.done_rounded,
                      color: Colors.white,
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
                      "Your Vehicle Is Book",
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
                      "Note : W’ve sends the information about your booking to the Renter & You also need to inform Renter about your booking",
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
