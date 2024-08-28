// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:vrs/Landing_screen_2.dart';
import 'package:vrs/Login_screen.dart';

class Landing_screen_3 extends StatefulWidget {
  const Landing_screen_3({super.key});

  @override
  State<StatefulWidget> createState() => _Landing_screen_2();
}

class _Landing_screen_2 extends State<Landing_screen_3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            // User swiped Left
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Landing_screen_2(),
              ),
            );
          } else if (details.primaryVelocity! < 0) {
            // User swiped Right
          }
        },
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(204, 242, 219, 161)),
          child: Center(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40, left: 310),
                  // child: Text(
                  //   "Skip",
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     color: Colors.black,
                  //     fontStyle: FontStyle.italic,
                  //   ),
                  // ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 124),
                  // child:
                  child: CircleAvatar(
                    radius: 106.5,
                    backgroundColor: Color.fromARGB(255, 208, 245, 239),
                    child: Image(
                      image: AssetImage("pictures/Landing_screen_3_image.png"),
                      width: 135,
                      height: 183,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Earn extra",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "income to give",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "your vehicle on rent",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  // child: Text(
                  //   "Find your best vehicle at a best price",
                  //   style:
                  //       TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 124),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 160),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 10,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 10,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: CircleAvatar(
                            // backgroundColor: Colors.white,
                            radius: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login_screen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(elevation: 15.0),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Text(
                        "Let's Go",
                        style: TextStyle(fontSize: 36, color: Colors.white),
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
