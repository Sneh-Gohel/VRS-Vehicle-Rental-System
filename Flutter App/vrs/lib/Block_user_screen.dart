import 'package:flutter/material.dart';

class Block_user_screen extends StatefulWidget {
  const Block_user_screen({super.key});

  @override
  State<StatefulWidget> createState() => _Block_user_screen();
}

class _Block_user_screen extends State<Block_user_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 80, 162, 238)),
        child: Center(
          child: Stack(
            children: [
              const Positioned(
                top: 33,
                child: Image(
                  image: AssetImage(
                    "pictures/city3.png",
                  ),
                ),
              ),
              Positioned(
                top: 216,
                child: Container(
                  height: 640,
                  width: 393,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: ListView(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, top: 100),
                          child: SizedBox(
                            width: 313,
                            height: 25,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Your Account Is Block",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: AnimatedContainer(
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeIn,
                            child: const Icon(
                              Icons.report_rounded,
                              color: Colors.red,
                              size: 300,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: SizedBox(
                            width: 313,
                            height: 25,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Unothorized Activity Found.",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const Positioned(
              //   top: 90,
              //   right: 23,
              //   child: Image(
              //     image: AssetImage("pictures/block_screen_car.png"),
              //     height: 200,
              //     width: 160,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
