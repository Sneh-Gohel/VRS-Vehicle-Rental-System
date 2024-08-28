// ignore_for_file: camel_case_types, file_names, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:vrs/Add_vehicle_screen.dart';
import 'package:vrs/Driver_profile_screen.dart';
import 'package:vrs/Renter_profile_screen.dart';
import 'Home_screen.dart';

class Plus_button_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Plus_button_screen(this.user_id, this.first_name_first_char, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Plus_button_screen(user_id, first_name_first_char);
}

class _Plus_button_screen extends State<Plus_button_screen> {
  String user_id = "";
  String first_name_first_char = "";

  _Plus_button_screen(this.user_id, this.first_name_first_char);

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
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home_screen(user_id),
                        ),
                      );
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Profile Viewer",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Driver_profile_screen(user_id,first_name_first_char),
                      ),
                    );
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      height: 70,
                      width: 340,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: const [
                          Positioned(
                            top: 13,
                            left: 10,
                            child: Icon(
                              Icons.person_2,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                          Positioned(
                            top: 17,
                            left: 60,
                            child: Text(
                              "Driver Profile...",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Renter_profile_screen(
                            user_id, first_name_first_char),
                      ),
                    );
                  },
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    child: Container(
                      height: 70,
                      width: 340,
                      decoration: BoxDecoration(
                        // border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: const [
                          Positioned(
                            top: 13,
                            left: 10,
                            child: Icon(
                              Icons.drive_eta_rounded,
                              size: 40,
                              color: Colors.blue,
                            ),
                          ),
                          Positioned(
                            top: 18,
                            left: 60,
                            child: Text(
                              "Renter Profile...",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ],
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
