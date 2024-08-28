// ignore_for_file: camel_case_types, file_names, use_build_context_synchronously, empty_catches

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vrs/Home_screen.dart';
import 'package:vrs/landing_screen_1.dart';
import 'package:path_provider/path_provider.dart';

class Starting_screen_1 extends StatefulWidget {
  const Starting_screen_1({super.key});

  @override
  State<StatefulWidget> createState() => _Starting_screen_1();
}

class _Starting_screen_1 extends State<Starting_screen_1> {
  bool is_tick = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        setState(() {
          is_tick = true;
        });
        print("timer tick");
        timer.cancel();
      });
    });

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_id.txt');
      bool fileExists = file.existsSync();
      if (fileExists) {
        // print('The file exists.');
        String user_id = "";
        // String user_id = file.readAsLinesSync() as String;
        try {
          user_id = await file.readAsString();
        } catch (e) {}
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
    Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height;
    return Scaffold(
      body: AnimatedContainer(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              is_tick
                  ? const Color.fromARGB(255, 90, 180, 229)
                  : const Color.fromARGB(255, 46, 111, 252),
              const Color.fromARGB(255, 46, 111, 252),
              is_tick
                  ? const Color.fromARGB(255, 55, 205, 250)
                  : const Color.fromARGB(255, 46, 111, 252),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: (height / 2) - 150),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    // "pictures/final_vrs_logo.jpg",
                    "pictures/final_vrs_logo_png.png",
                    height: 300,
                    width: 300,
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
