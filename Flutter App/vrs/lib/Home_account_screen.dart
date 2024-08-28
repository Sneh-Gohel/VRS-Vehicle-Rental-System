// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, use_build_context_synchronously, no_logic_in_create_state, must_be_immutable, depend_on_referenced_packages, unused_local_variable, prefer_typing_uninitialized_variables, empty_catches

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vrs/Current_IP.dart';
import 'package:vrs/Login_screen.dart';
import 'package:vrs/Visitor_active_booking_screen.dart';
import 'package:vrs/Visitor_edit_profile_screen.dart';
import 'package:vrs/Visitor_history_screen.dart';
import 'package:http/http.dart' as http;

import 'Notification_screen.dart';

class Home_account_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Home_account_screen(this.user_id, this.first_name_first_char, {super.key});
  // const Home_account_screen({super.key});

  @override
  State<StatefulWidget> createState() =>
      _Home_account_screen(user_id, first_name_first_char);
}

class _Home_account_screen extends State<Home_account_screen> {
  String user_id = "";
  String first_name_first_char = "";
  String ip = Current_IP().getIP();
  String first_name = "";
  String last_name = "";
  bool loading_screen = false;

  _Home_account_screen(this.user_id, this.first_name_first_char);

  get_data() async {
    String URL = "http://$ip/VRS/account_screen_get_data.php";
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    var info = (jsonDecode(request.body));
    setState(() {
      first_name = info['first_name'];
      last_name = info['last_name'];
      loading_screen = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loading_screen = true;
    get_data();
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
      body: loading_screen
          ? const Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 35,
              ),
            )
          : Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                child: Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Container(
                          height: 150,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            // border: Border.all(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 15,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      first_name_first_char,
                                      style: const TextStyle(
                                          fontSize: 56, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 135,
                                child: Text(
                                  '$first_name $last_name',
                                  style: const TextStyle(
                                      fontSize: 32,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Positioned(
                                top: 80,
                                left: 140,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Visitor_edit_profile_screen(
                                                user_id, first_name_first_char),
                                      ),
                                    );
                                  },
                                  child: const Row(
                                    children: [
                                      Text(
                                        "View Or Edit Profile",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 100,
                                left: 160,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      var status;
                                      PermissionStatus storagePermissionStatus =
                                          await Permission.storage.status;
                                      if (storagePermissionStatus.isDenied) {
                                        status =
                                            await Permission.storage.request();
                                        final directory =
                                            await getApplicationDocumentsDirectory();
                                        final file = File(
                                            '${directory.path}/user_id.txt');
                                        await file.delete();
                                      } else {
                                        final directory =
                                            await getApplicationDocumentsDirectory();
                                        final file = File(
                                            '${directory.path}/user_id.txt');
                                        await file.delete();
                                      }
                                    } catch (e){}
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Login_screen(),
                                        ),
                                        (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text("Logout"),
                                ),
                              ),
                            ],
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
                                builder: (context) => Visitor_history_screen(
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
                              child: const Stack(
                                children: [
                                  Positioned(
                                    top: 13,
                                    left: 10,
                                    child: Icon(
                                      Icons.history,
                                      size: 40,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    left: 60,
                                    child: Text(
                                      "History",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 60,
                                    child: Text(
                                      "View your history",
                                      style: TextStyle(fontSize: 12),
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
                                builder: (context) =>
                                    Visitor_active_booking_screen(
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
                              child: const Stack(
                                children: [
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
                                    top: 5,
                                    left: 60,
                                    child: Text(
                                      "Active booking",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 60,
                                    child: Text(
                                      "View current booking",
                                      style: TextStyle(fontSize: 12),
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
                                builder: (context) => Notification_screen(
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
                              child: const Stack(
                                children: [
                                  Positioned(
                                    top: 13,
                                    left: 10,
                                    child: Icon(
                                      Icons.notifications,
                                      size: 40,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    left: 60,
                                    child: Text(
                                      "Notification",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 60,
                                    child: Text(
                                      "View All Notification",
                                      style: TextStyle(fontSize: 12),
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
            ),
    );
  }
}
