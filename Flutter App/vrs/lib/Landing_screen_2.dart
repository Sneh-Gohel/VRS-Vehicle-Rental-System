// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:vrs/Landing_screen_1.dart';
import 'package:vrs/Landing_screen_3.dart';
import 'package:vrs/Login_screen.dart';

class Landing_screen_2 extends StatefulWidget {
  const Landing_screen_2({super.key});

  @override
  State<StatefulWidget> createState() => _Landing_screen_2();
}

class _Landing_screen_2 extends State<Landing_screen_2> {
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
                builder: (context) => const Landing_screen_1(),
              ),
            );
          } else if (details.primaryVelocity! < 0) {
            // User swiped Right
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Landing_screen_3(),
              ),
            );
          }
        },
        child: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(153, 106, 141, 141)),
          child: Center(
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 40, left: 310),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login_screen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  // child:
                  child: CircleAvatar(
                    radius: 106.5,
                    backgroundColor: Color.fromARGB(255, 248, 184, 21),
                    child: Image(
                      image: AssetImage("pictures/Landing_screen_2_image.png"),
                      width: 135,
                      height: 183,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Take a",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "perfact man for",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "your perfect vehicle",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  // child: Text(
                  //   "Find your best vehicle at a best price",
                  //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                            // backgroundColor: Colors.white,
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
                          builder: (context) => const Landing_screen_3(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(elevation: 15.0),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Text(
                        "Next",
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
