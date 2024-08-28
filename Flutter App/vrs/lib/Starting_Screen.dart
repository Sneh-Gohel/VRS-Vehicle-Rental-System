// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, empty_catches

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vrs/Home_screen.dart';
import 'package:vrs/landing_screen_1.dart';
import 'package:path_provider/path_provider.dart';

class Starting_Screen extends StatefulWidget {
  const Starting_Screen({super.key});

  @override
  State<Starting_Screen> createState() => _Starting_Screen();
}

class _Starting_Screen extends State<Starting_Screen> {
  var opacity_vrs_text = 0;
  var opacity_search = 0;
  final info_string = TextEditingController();

  @override
  void initState() {
    super.initState();
    info_string.text = "";

    // Timer(Duration(seconds:2),())
    // {
    //   print("Times get over...");
    // }

    Timer _timer;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // bool fileExists = File('user_name.txt').existsSync();

        // if (fileExists) {
        //   print('The file exists.');
        // } else {
        //   print('The file does not exist.');
        // }
        setState(() {
          opacity_vrs_text = 1;
        });
        timer.cancel();
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        setState(() {
          opacity_search = 1;
        });
        timer.cancel();
      });
    });
    
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        setState(() {
          info_string.text = "Connecting to server";
        });
        timer.cancel();
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_id.txt');
      bool fileExists = file.existsSync();
      if (fileExists) {
        // print('The file exists.');
        String user_id = "";
        // String user_id = file.readAsLinesSync() as String;
        try {
          user_id = await file.readAsString();
        } catch (e) {
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home_screen(user_id)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Landing_screen_1()),
        );
        // Get.to(Landing_screen_1());
      }
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 300, bottom: 100),
              child: Center(
                  child: AnimatedOpacity(
                opacity: opacity_vrs_text.toDouble(),
                duration: const Duration(seconds: 1),
                child: const Text(
                  "VRS",
                  style: TextStyle(fontSize: 110, color: Colors.white),
                ),
              )),
            ),
            AnimatedOpacity(
                opacity: opacity_search.toDouble(),
                duration: const Duration(seconds: 2),
                child: Padding(
                  padding: const EdgeInsets.only(top: 135),
                  child: Center(
                    child: Text(
                      info_string.text,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )),
            AnimatedOpacity(
              opacity: opacity_search.toDouble(),
              duration: const Duration(seconds: 1),
              child: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
