import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'Starting_Screen.dart';
import 'Home_screen.dart';
import 'Strating_screen_1.dart';

void main() {
  DeviceOrientation.portraitUp;
  DeviceOrientation.portraitDown;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VRS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Starting_Screen(),
      // home:Home_screen("sneh"),
      home:  const Starting_screen_1(),
    );
  }
}
