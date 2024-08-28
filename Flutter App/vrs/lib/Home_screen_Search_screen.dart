// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'Home_account_screen.dart';

class Home_screen_Search_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Home_screen_Search_screen(this.user_id, this.first_name_first_char,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Home_screen_Search_screen(user_id, first_name_first_char);
}

class _Home_screen_Search_screen extends State<Home_screen_Search_screen> {
  String user_id = "";
  String first_name_first_char = "";
  final vehicle_search_Controller = TextEditingController();
  final vehicle_search = FocusNode();

  _Home_screen_Search_screen(this.user_id, this.first_name_first_char);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        elevation: 10,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                child: CircleAvatar(
                  radius: 20.0,
                  // backgroundImage: AssetImage("pictures/Landing page image.png"),
                  backgroundColor: Colors.white,
                  child: Text(first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Home_account_screen(user_id, first_name_first_char),
                    ),
                  );
                },
              )
              // child: Image.asset("pictures/Landing page image.png"),
              ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 25, left: 20),
            child: Text(
              "Vehicle Search :-",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              controller: vehicle_search_Controller,
              focusNode: vehicle_search,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.directions_car_rounded),
                suffix: GestureDetector(
                  child: const Icon(Icons.clear),
                  onTap: () {
                    vehicle_search_Controller.clear();
                  },
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 230, 230, 230),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                // disabledBorder: OutlineInputBorder(
                //   borderSide:
                //       const BorderSide(color: Colors.transparent),
                //   borderRadius: BorderRadius.circular(20),
                // ),
                hintText: "Model Name, Company Name, Passing Year",
                // errorBorder: InputBorder.none,
                border: const OutlineInputBorder(
                    //   borderRadius:
                    //       BorderRadius.all(Radius.circular(5)),
                    //   borderSide: BorderSide(width: 3),
                    // ),
                    ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25, left: 20),
            child: Text(
              "Location Search :-",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextField(
              controller: vehicle_search_Controller,
              focusNode: vehicle_search,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.pin_drop),
                suffix: GestureDetector(
                  child: const Icon(Icons.clear),
                  onTap: () {
                    vehicle_search_Controller.clear();
                  },
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 230, 230, 230),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                // disabledBorder: OutlineInputBorder(
                //   borderSide:
                //       const BorderSide(color: Colors.transparent),
                //   borderRadius: BorderRadius.circular(20),
                // ),
                hintText: "City, State, Pin Code",
                // errorBorder: InputBorder.none,
                border: const OutlineInputBorder(
                    //   borderRadius:
                    //       BorderRadius.all(Radius.circular(5)),
                    //   borderSide: BorderSide(width: 3),
                    // ),
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // add_press();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
