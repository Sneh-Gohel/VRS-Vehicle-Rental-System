// ignore_for_file: camel_case_types, file_names, prefer_interpolation_to_compose_strings, no_logic_in_create_state, non_constant_identifier_names, depend_on_referenced_packages, must_be_immutable, empty_catches, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibration/vibration.dart';
import 'package:vrs/Renter_profile_screen.dart';
import 'package:vrs/Renter_vehicle_history_screen.dart';
import 'package:http/http.dart' as http;
import 'Current_IP.dart';
import 'Edit_vehicle_details.dart';
import 'Home_account_screen.dart';

class Renter_vehicle_details_screen extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String vehicle_id = "";
  Renter_vehicle_details_screen(
      this.user_id, this.first_name_first_char, this.vehicle_id,
      {super.key});

  @override
  State<StatefulWidget> createState() => _Renter_vehicle_details_screen(
      user_id, first_name_first_char, vehicle_id);
}

class _Renter_vehicle_details_screen
    extends State<Renter_vehicle_details_screen> {
  String user_id = "";
  String renter_first_name_first_char = "";
  String vehicle_id = "";
  String ip = Current_IP().getIP();
  var vehicle_information;
  bool full_screen_loading_screen = false;
  bool on_rent = false;

  _Renter_vehicle_details_screen(
      this.user_id, this.renter_first_name_first_char, this.vehicle_id);

  get_data() async {
    String URL = "http://$ip/VRS/renter_vehicle_detail_screen_get_data.php";
    String responce;
    var request =
        await http.post(Uri.parse(URL), body: {"vehicle_id": vehicle_id});
    setState(() {
      vehicle_information = (jsonDecode(request.body));
      full_screen_loading_screen = false;
      if (vehicle_information['active'] == "true") {
        on_rent = true;
      } else {
        on_rent = false;
      }
      print(on_rent);
    });
  }

  back_to_rent() async {
    setState(() {
      full_screen_loading_screen = true;
    });
    String URL = "http://$ip/VRS/vehicle_on_rent.php";
    String responce;
    var request =
        await http.post(Uri.parse(URL), body: {"vehicle_id": vehicle_id});
    responce = (jsonDecode(request.body));
    if (responce == "true") {
      try {
        Fluttertoast.showToast(
            msg: "Back to Rent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() async {
          Vibration.vibrate(duration: 100, amplitude: 128);
        });
      } catch (e) {}
      setState(() {
        on_rent = true;
        full_screen_loading_screen = false;
      });
    }
  }

  discontinue() async {
    String URL = "http://$ip/VRS/vehicle_out_of_rent_checker.php";
    String responce;
    var request = await http.post(Uri.parse(URL),
        body: {"vehicle_id": vehicle_id, "user_id": user_id});
    responce = (jsonDecode(request.body));
    // print(responce);

    if (responce == "false") {
      setState(() {
        full_screen_loading_screen = true;
      });
      URL = "http://$ip/VRS/vehicle_out_of_rent.php";
      var request =
          await http.post(Uri.parse(URL), body: {"vehicle_id": vehicle_id});
      responce = (jsonDecode(request.body));
      // print(responce);
      if (responce == "true") {
        Fluttertoast.showToast(
          msg: "Vehicle Successfully Removes From The Rent",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Renter_profile_screen(user_id, renter_first_name_first_char),
          ),
          (route) => route.isFirst,
        );
      }
      setState(() {
        full_screen_loading_screen = false;
      });
    } else {
      try {
        Fluttertoast.showToast(
            msg: "Can't Remove From The Rent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() async {
          Vibration.vibrate(duration: 100, amplitude: 128);
        });
      } catch (e) {}
    }
  }

  @override
  void initState() {
    super.initState();
    full_screen_loading_screen = true;
    get_data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Details"),
        backgroundColor: Colors.blue,
        elevation: 10,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.white,
                child: Text(
                  renter_first_name_first_char,
                  style: const TextStyle(color: Colors.blue, fontSize: 25.0),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home_account_screen(
                        user_id, renter_first_name_first_char),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: full_screen_loading_screen
          ? Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: const Center(
                child: SpinKitCubeGrid(
                  color: Colors.blue,
                  size: 35.0,
                ),
              ),
            )
          : Stack(
              children: [
                Positioned(
                  child: Center(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 10,
                            child: SizedBox(
                              height: 180,
                              width: 340,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Center(
                                  child: Image.network(
                                    "http://$ip/VRS/" +
                                        vehicle_information['vehicle_image_1'],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30, left: 25),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Vehicle Information :",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Row(
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 5,
                                  child: Container(
                                    width: 170,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: const Border(
                                      //   right: BorderSide(width: 1.0, color: Colors.black),
                                      // ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Model",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            vehicle_information[
                                                'vehicle_model'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 5,
                                    child: Container(
                                      width: 170,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Company",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              vehicle_information[
                                                  'vehicle_company'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Row(
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(10),
                                  elevation: 5,
                                  child: Container(
                                    width: 170,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: const Border(
                                      //   right: BorderSide(width: 1.0, color: Colors.black),
                                      // ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Passing Year",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            vehicle_information[
                                                'vehicle_passing_year'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 5,
                                    child: Container(
                                      width: 170,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Seats",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              vehicle_information[
                                                  'vehicle_seater'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 23),
                            child: Row(
                              children: [
                                Material(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10),
                                  elevation: 5,
                                  child: Container(
                                    width: 170,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: const Border(
                                      //   right: BorderSide(width: 1.0, color: Colors.black),
                                      // ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Fule",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Text(
                                            vehicle_information[
                                                'vehicle_fule_type'],
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 5,
                                    child: Container(
                                      width: 170,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "Transmision",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 7),
                                            child: Text(
                                              vehicle_information[
                                                  'vehicle_transmission'],
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 23, right: 25),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: SizedBox(
                              height: 80,
                              width: 340,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 15),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(),
                                          child: Text(
                                            "Vehicle Number (As per Number Plate)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            vehicle_information[
                                                'vehicle_number'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, top: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Edit_vehicle_details(
                                          user_id,
                                          renter_first_name_first_char,
                                          vehicle_id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Edit Vehicle Details",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (on_rent == false) {
                                back_to_rent();
                              } else {
                                try {
                                  Fluttertoast.showToast(
                                      msg: "Press And Hold For Discontinue",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() async {
                                    Vibration.vibrate(
                                        duration: 100, amplitude: 128);
                                  });
                                } catch (e) {}
                              }
                            },
                            onLongPress: () {
                              if (on_rent == true) {
                                discontinue();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  on_rent ? Colors.red : Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Text(
                                on_rent
                                    ? "Discontinue From Rent"
                                    : "Rent Your Vehicle",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Renter_vehicle_history_screen(
                              user_id,
                              renter_first_name_first_char,
                              vehicle_id),
                        ),
                      );
                    },
                    backgroundColor: Colors.blue,
                    splashColor: Colors.white,
                    child: const Center(
                      child: Icon(
                        Icons.date_range_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
