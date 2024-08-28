// ignore_for_file: file_names, camel_case_types, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state, depend_on_referenced_packages, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'Current_IP.dart';
import 'Home_account_screen.dart';

class Notification_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Notification_screen(this.user_id, this.first_name_first_char, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Notification_screen(user_id, first_name_first_char);
}

class _Notification_screen extends State<Notification_screen> {
  String user_id = "";
  String visitor_first_name_first_char = "";
  String ip = Current_IP().getIP();
  var notification_information;
  bool loading_screen = true;
  bool is_empty = true;
  late String responce;

  _Notification_screen(this.user_id, this.visitor_first_name_first_char);

  get_data() async {
    setState(() {
      loading_screen = true;
    });

    String URL = "http://$ip/VRS/notification_checker.php";
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    responce = (jsonDecode(request.body));

    if (int.parse(responce) > 0) {
      URL = "http://$ip/VRS/notification_get_data.php";
      var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
      setState(() {
        notification_information = (jsonDecode(request.body));
        is_empty = false;
      });
      print(notification_information);
    }

    setState(() {
      loading_screen = false;
    });
  }

  @override
  void initState() {
    super.initState();
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Notification"),
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
                  child: Text(visitor_first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_account_screen(
                          user_id, visitor_first_name_first_char),
                    ),
                  );
                },
              )
              // child: Image.asset("pictures/Landing page image.png"),
              ),
        ],
      ),
      body: loading_screen
          ? const Center(
              child: SpinKitCubeGrid(
                size: 35,
                color: Colors.blue,
              ),
            )
          : ListView.builder(
              itemCount: int.parse(responce),
              itemBuilder: (contax, index) {
                if (is_empty == true) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text(
                        "No Notification...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "vehicle_booking") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Vehicle Booking",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.drive_eta_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  "Congratulation You Successfully Book Vehicle For Rent",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 115,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 155,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['booking_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "renters_vehicle_booking") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 168, 204, 247),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Vehicle Books",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.drive_eta_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Congratulation Your Vehicle is Book by " + notification_information[(int.parse(responce) - index - 1)]['first_name']} ' +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['last_name'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 105,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['booking_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "driver_booking") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Driver Booking",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.person_3_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  "Congratulation You Books " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['last_name'] +
                                      " As Your Driver",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 140,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['booking_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "drivers_booking") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 255, 168, 252),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Drive Books",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.person_3_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  "Congratulation You Booked by " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['last_name'] +
                                      " As Driver",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 140,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['booking_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "renter_vehicle_cancel") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 198, 224, 255),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Vehicle Cancel",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.drive_eta_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  notification_information[index]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[index]
                                          ['last_name'] +
                                      " Cancels Your Vehicle Booking",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 105,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['cancel_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "drivers_cancel") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 255, 209, 253),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Drive Cancel",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.person_3_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  notification_information[index]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[index]
                                          ['last_name'] +
                                      " Cancels Your Drive Booking",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 140,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['cancel_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "driver_booking_cancel") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Driver Cancel",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.person_3_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  "You Cancels the " +
                                      notification_information[index]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[index]
                                          ['last_name'] +
                                      " As Driver",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 140,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['cancel_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "drivers_booking_cancel") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 255, 168, 252),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Driver Cancel",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.person_3_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  "You Cancels the " +
                                      notification_information[index]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[index]
                                          ['last_name'] +
                                      " As Driver",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 140,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['cancel_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "vehicle_booking_cancel") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Vehicle Cancel",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.drive_eta_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  "You Cancels The Vehicle Booking",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 115,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"Date : " + notification_information[(int.parse(responce) - index - 1)]['starting_date']} '
                                          " To " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['ending_date'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 155,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  '${"price : " + notification_information[(int.parse(responce) - index - 1)]['price']} '
                                  " Rs/Day",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[(int.parse(responce) -
                                    index -
                                    1)]['cancel_date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "vehicle_report") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Reports Your Vehicle",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.report_gmailerrorred_rounded,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['last_name'] +
                                      " Reports Your Vehicle For " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['reason'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 125,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  "Date: " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['date'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 155,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  "Time: " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['time'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[
                                    (int.parse(responce) - index - 1)]['date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "driver_report") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Reports Driver Profile",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.report_gmailerrorred_rounded,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['first_name'] +
                                      ' ' +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['last_name'] +
                                      " Reports Your Vehicle For " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['reason'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 125,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  "Date: " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['date'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 155,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  "Time: " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['time'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[
                                    (int.parse(responce) - index - 1)]['date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (notification_information[(int.parse(responce) - index - 1)]
                        ['module'] ==
                    "vehicle_out_of_rent") {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 343,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.red,
                          gradient: const LinearGradient(
                            colors: [
                              Colors.red,
                              Color.fromARGB(255, 168, 204, 247)
                            ], // Specify your gradient colors
                            begin: Alignment
                                .topLeft, // Specify the starting point of the gradient
                            end: Alignment
                                .bottomRight, // Specify the ending point of the gradient
                            // You can also provide additional properties like stops and tileMode
                          ),
                        ),
                        child: Stack(
                          children: [
                            const Positioned(
                              top: 8,
                              left: 18,
                              child: Text(
                                "Vehicle Out Of Rent",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 293,
                              child: Icon(
                                Icons.report_gmailerrorred_rounded,
                                size: 45,
                                color: Colors.black,
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 20,
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 10,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      "http://$ip/VRS/" +
                                          notification_information[
                                              (int.parse(responce) -
                                                  index -
                                                  1)]['pic'],
                                      loadingBuilder: (BuildContext context,
                                          Widget child, Progress) {
                                        if (Progress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: Progress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? Progress
                                                        .cumulativeBytesLoaded /
                                                    Progress.expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              left: 130,
                              child: SizedBox(
                                height: 56,
                                width: 212,
                                child: Text(
                                  "Your Vehicle " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['vehicle_model'] +
                                      " Is Out Of Rent Due To Several Reports. ",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 125,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  "Date: " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['date'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 155,
                              left: 130,
                              child: SizedBox(
                                height: 36,
                                width: 212,
                                child: Text(
                                  "Time: " +
                                      notification_information[
                                              (int.parse(responce) - index - 1)]
                                          ['time'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 10,
                              child: Text(
                                notification_information[
                                    (int.parse(responce) - index - 1)]['date'],
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
    );
  }
}
