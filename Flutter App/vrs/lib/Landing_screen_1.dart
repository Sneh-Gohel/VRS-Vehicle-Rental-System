// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:vrs/Landing_screen_2.dart';
import 'package:vrs/Login_screen.dart';

class Landing_screen_1 extends StatefulWidget {
  const Landing_screen_1({super.key});

  @override
  State<StatefulWidget> createState() => _Landing_screen_1();
}

class _Landing_screen_1 extends State<Landing_screen_1> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            // User swiped Left
            // print("Swiped left");
          } else if (details.primaryVelocity! < 0) {
            // User swiped Right
            // print("Swiped rigth");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Landing_screen_2(),
              ),
            );
          }
        },
        child: Container(
            height: screenHeight,
            width: screenWidth,
            decoration:
                const BoxDecoration(color: Color.fromARGB(163, 185, 175, 224)),
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
                    padding: EdgeInsets.only(top: 160),
                    child: Image(
                      image: AssetImage("pictures/Landing_page_image.png"),
                      width: 349,
                      height: 156,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      "Rent",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "a perfect vehicle",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "for any occasion",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Find your best vehicle at a best price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 110),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 160),
                            child: CircleAvatar(
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
                              backgroundColor: Colors.white,
                              radius: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 50, right: 50),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Landing_screen_2(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(elevation: 15.0),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 10),
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 36, color: Colors.white),
                          ),
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
