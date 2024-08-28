// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state, depend_on_referenced_packages, avoid_web_libraries_in_flutter, use_build_context_synchronously, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibration/vibration.dart';
import 'Current_IP.dart';
import 'Home_account_screen.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vrs/Driver_profile_screen.dart';

class Edit_driver_profile extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  Edit_driver_profile(this.user_id, this.first_name_first_char, {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Edit_driver_profile(user_id, first_name_first_char);
}

class _Edit_driver_profile extends State<Edit_driver_profile> {
  String user_id = "";
  String driver_first_name_first_char = "";

  _Edit_driver_profile(this.user_id, this.driver_first_name_first_char);

  ImagePicker image_picker = ImagePicker();
  File? profile_image_path;
  bool is_has_profile_image = false;
  bool done_without_profile_image = false;
  final first_name_Controller = TextEditingController();
  final last_name_Controller = TextEditingController();
  final price_Controller = TextEditingController();
  final contact_Controller = TextEditingController();
  final city_Controller = TextEditingController();
  final state_Controller = TextEditingController();
  final country_Controller = TextEditingController();
  final pin_code_Controller = TextEditingController();
  final first_name = FocusNode();
  final last_name = FocusNode();
  final price = FocusNode();
  final contact = FocusNode();
  final city = FocusNode();
  final state = FocusNode();
  final country = FocusNode();
  final pin_code = FocusNode();
  bool skill_two_wheeler = false;
  bool skill_three_wheeler = false;
  bool skill_four_wheeler = false;
  bool skill_more_than_four_wheeler = false;
  bool fule_type_petrol = false;
  bool fule_type_diesel = false;
  bool fule_type_electric = false;
  bool fule_type_hybrid = false;
  bool transmission_manual = false;
  bool transmission_auto = false;
  File? licence_image_1_path;
  File? licence_image_2_path;
  bool is_has_licence_image_1 = false;
  bool is_has_licence_image_2 = false;
  bool done_without_licence_image_1 = false;
  bool done_without_licence_image_2 = false;
  bool is_profile_image_loading = false;
  bool is_licence_image_loading = false;
  var driver_information;
  String ip = Current_IP().getIP();
  bool done_without_skill = false;
  bool done_without_fule_type = false;
  bool done_without_tranmission = false;
  String skill_string = "";
  String fule_type_string = "";
  String transmission_type_string = "";
  bool full_loading_screen = false;
  bool is_has_profile_network_image = false;
  bool is_has_licence_network_image_1 = false;
  bool is_has_licence_network_image_2 = false;
  bool on_booking = false;
  String driver_id = "";

  get_date() async {
    String URL = "http://$ip/VRS/apply_as_driver_get_date.php";
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    setState(() {
      driver_information = (jsonDecode(request.body));
      first_name_Controller.text = driver_information['first_name'];
      last_name_Controller.text = driver_information['last_name'];
      contact_Controller.text = driver_information['contact'];
      city_Controller.text = driver_information['city'];
      state_Controller.text = driver_information['state'];
      country_Controller.text = driver_information['country'];
      pin_code_Controller.text = driver_information['pin_code'];
      price_Controller.text = driver_information['price'];
      driver_id = driver_information['driver_id'];
      is_has_profile_network_image = true;
      is_has_profile_image = true;
      is_has_licence_network_image_1 = true;
      is_has_licence_image_1 = true;
      is_has_licence_network_image_2 = true;
      is_has_licence_image_2 = true;
      full_loading_screen = false;
      if (driver_information['active'] == "true") {
        on_booking = true;
      } else {
        on_booking = false;
      }
      print(driver_information['active']);
    });
  }

  click_apply() async {
    String URL = "http://$ip/VRS/apply_as_driver_get_date.php";
    var request = await http.post(Uri.parse(URL), body: {"user_id": user_id});
    if (is_has_profile_image == true) {
      if (price_Controller.text != "") {
        if (is_has_licence_image_1 == true) {
          if (is_has_licence_image_2 == true) {
            if (skill_two_wheeler == true ||
                skill_three_wheeler == true ||
                skill_four_wheeler == true ||
                skill_more_than_four_wheeler == true) {
              if (fule_type_petrol == true ||
                  fule_type_diesel == true ||
                  fule_type_electric == true ||
                  fule_type_hybrid == true) {
                if (transmission_manual == true || transmission_auto == true) {
                  setState(() {
                    full_loading_screen = true;
                  });
                  get_skill_string();
                  get_fule_type_string();
                  get_transmission_string();
                  print(skill_string);
                  print(fule_type_string);
                  print(transmission_type_string);
                  String responce;
                  String URL = "http://$ip/VRS/edit_driver_details.php";
                  var request = await http.post(Uri.parse(URL), body: {
                    "user_id": user_id,
                    "price": price_Controller.text,
                    "skill": skill_string,
                    "fule_type": fule_type_string,
                    "transmission": transmission_type_string,
                    "city": (city_Controller.text).toString(),
                    "state": (state_Controller.text).toString(),
                    "country": (country_Controller.text).toString(),
                    "pin_code": (pin_code_Controller.text).toString(),
                  });
                  responce = (jsonDecode(request.body)).toString();
                  if (responce == "success") {
                    if (is_has_profile_network_image == false) {
                      if (is_has_profile_image == true) {
                        URL = "http://$ip/VRS/apply_as_driver_add_images.php";
                        request = await http.post(Uri.parse(URL), body: {
                          "user_id": user_id,
                          "image_identifier": '1',
                          "image": base64Encode(
                              profile_image_path!.readAsBytesSync())
                        });
                        print((jsonDecode(request.body)).toString());
                      }
                    }
                    if (is_has_licence_network_image_1 == false) {
                      if (is_has_licence_image_1 == true) {
                        URL = "http://$ip/VRS/apply_as_driver_add_images.php";
                        request = await http.post(Uri.parse(URL), body: {
                          "user_id": user_id,
                          "image_identifier": '2',
                          "image": base64Encode(
                              licence_image_1_path!.readAsBytesSync())
                        });
                        print((jsonDecode(request.body)).toString());
                      }
                    }
                    if (is_has_licence_network_image_2 == false) {
                      if (is_has_licence_image_2 == true) {
                        URL = "http://$ip/VRS/apply_as_driver_add_images.php";
                        request = await http.post(Uri.parse(URL), body: {
                          "user_id": user_id,
                          "image_identifier": '3',
                          "image": base64Encode(
                              licence_image_2_path!.readAsBytesSync())
                        });
                        print((jsonDecode(request.body)).toString());
                      }
                    }
                    setState(() {
                      full_loading_screen = false;
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Driver_profile_screen(
                            user_id, driver_first_name_first_char),
                      ),
                      (route) => route.isFirst,
                    );
                  } else {
                    print("error");
                    setState(() {
                      full_loading_screen = false;
                    });
                  }
                } else {
                  setState(() {
                    done_without_tranmission = true;
                  });
                }
              } else {
                setState(() {
                  done_without_fule_type = true;
                });
              }
            } else {
              setState(() {
                done_without_skill = true;
              });
            }
          } else {
            setState(() {
              done_without_licence_image_2 = true;
            });
          }
        } else {
          setState(() {
            done_without_licence_image_1 = true;
          });
        }
      } else {
        FocusScope.of(context).requestFocus(price);
      }
    } else {
      setState(() {
        done_without_profile_image = true;
      });
    }
  }

  get_skill_string() {
    setState(() {
      skill_string = "";
    });
    if (skill_two_wheeler == true) {
      if (skill_string == "") {
        setState(() {
          skill_string = "2";
        });
      }
    }
    if (skill_three_wheeler == true) {
      if (skill_string == "") {
        setState(() {
          skill_string = "3";
        });
      } else {
        setState(() {
          skill_string = "$skill_string, 3";
        });
      }
    }
    if (skill_four_wheeler == true) {
      if (skill_string == "") {
        setState(() {
          skill_string = "4";
        });
      } else {
        setState(() {
          skill_string = "$skill_string, 4";
        });
      }
    }
    if (skill_more_than_four_wheeler == true) {
      if (skill_string == "") {
        setState(() {
          skill_string = "4+";
        });
      } else {
        setState(() {
          skill_string = "$skill_string, 4+";
        });
      }
    }
  }

  get_fule_type_string() {
    setState(() {
      fule_type_string = "";
    });
    if (fule_type_petrol == true) {
      if (fule_type_string == "") {
        setState(() {
          fule_type_string = "Petrol";
        });
      }
    }
    if (fule_type_diesel == true) {
      if (fule_type_string == "") {
        setState(() {
          fule_type_string = ", Diesel";
        });
      } else {
        setState(() {
          fule_type_string = "$fule_type_string, Diesel";
        });
      }
    }
    if (fule_type_electric == true) {
      if (fule_type_string == "") {
        setState(() {
          fule_type_string = ", Electric";
        });
      } else {
        setState(() {
          fule_type_string = "$fule_type_string, Electric";
        });
      }
    }
    if (fule_type_hybrid == true) {
      if (fule_type_string == "") {
        setState(() {
          fule_type_string = "Hybrid";
        });
      } else {
        setState(() {
          fule_type_string = "$fule_type_string, Hybrid";
        });
      }
    }
  }

  get_transmission_string() {
    setState(() {
      transmission_type_string = "";
    });
    if (transmission_manual == true) {
      if (transmission_type_string == "") {
        setState(() {
          transmission_type_string = "Manual";
        });
      }
    }
    if (transmission_auto == true) {
      if (transmission_type_string == "") {
        setState(() {
          transmission_type_string = "Automatic";
        });
      } else {
        setState(() {
          transmission_type_string = "$transmission_type_string, Automatic";
        });
      }
    }
  }

  Future<void> get_profile_image() async {
    setState(() {
      is_profile_image_loading = true;
    });
    var get_image = await image_picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (get_image != null) {
        profile_image_path = File(get_image.path);
        is_has_profile_image = true;
        image_compresser(1);
      } else {
        profile_image_path = null;
        is_has_profile_image = false;
      }
    });
  }

  Future<void> get_licence_image(int identifier) async {
    setState(() {
      is_licence_image_loading = true;
    });
    var get_image = await image_picker.pickImage(source: ImageSource.gallery);
    if (identifier == 1) {
      setState(() {
        if (get_image != null) {
          licence_image_1_path = File(get_image.path);
          is_has_licence_image_1 = true;
          image_compresser(2);
        } else {
          licence_image_1_path = null;
          is_has_licence_image_1 = false;
        }
      });
    } else if (identifier == 2) {
      setState(() {
        if (get_image != null) {
          licence_image_2_path = File(get_image.path);
          is_has_licence_image_2 = true;
          image_compresser(3);
        } else {
          licence_image_2_path = null;
          is_has_licence_image_2 = false;
        }
      });
    }
  }

  image_compresser(int identifire) async {
    if (identifire == 1) {
      int fileSizeInBytes = profile_image_path!.lengthSync();
      double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
      print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
      if (fileSizeInMb > 3) {
        try {
          print("pictures compresstion started");
          final directory = await getApplicationDocumentsDirectory();
          final copiedImage = await profile_image_path!.copy(
              '${directory.path}/profile_image_${profile_image_path!.path.split('/').last}');
          final compressedFile = await FlutterImageCompress.compressAndGetFile(
            profile_image_path!.path,
            copiedImage.path,
            quality: 80,
          );
          setState(() {
            profile_image_path = File(compressedFile!.absolute.path);
          });
        } catch (e) {
          print("error in image compresser... $e");
        }
      }
      setState(() {
        is_profile_image_loading = false;
      });
    } else if (identifire == 2) {
      int fileSizeInBytes = licence_image_1_path!.lengthSync();
      double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
      print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
      if (fileSizeInMb > 3) {
        try {
          print("pictures compresstion started");
          final directory = await getApplicationDocumentsDirectory();
          final copiedImage = await licence_image_1_path!.copy(
              '${directory.path}/licence_image_1_${licence_image_1_path!.path.split('/').last}');
          final compressedFile = await FlutterImageCompress.compressAndGetFile(
            licence_image_1_path!.path,
            copiedImage.path,
            quality: 80,
          );
          setState(() {
            licence_image_1_path = File(compressedFile!.absolute.path);
          });
        } catch (e) {
          print("error in image compresser... $e");
        }
      }
      setState(() {
        is_licence_image_loading = false;
      });
    } else if (identifire == 3) {
      int fileSizeInBytes = licence_image_2_path!.lengthSync();
      double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
      print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
      if (fileSizeInMb > 3) {
        try {
          print("pictures compresstion started");
          final directory = await getApplicationDocumentsDirectory();
          final copiedImage = await licence_image_2_path!.copy(
              '${directory.path}/licence_image_2_${licence_image_2_path!.path.split('/').last}');
          final compressedFile = await FlutterImageCompress.compressAndGetFile(
            licence_image_2_path!.path,
            copiedImage.path,
            quality: 80,
          );
          setState(() {
            licence_image_2_path = File(compressedFile!.absolute.path);
          });
        } catch (e) {
          print("error in image compresser... $e");
        }
      }
      setState(() {
        is_licence_image_loading = false;
      });
    }
  }

  back_to_booking() async {
    setState(() {
      full_loading_screen = true;
    });
    String URL = "http://$ip/VRS/driver_on_booking.php";
    String responce;
    var request =
        await http.post(Uri.parse(URL), body: {"driver_id": driver_id});
    responce = (jsonDecode(request.body));
    if (responce == "true") {
      try {
        Fluttertoast.showToast(
            msg: "Back to Drive",
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
        on_booking = true;
        full_loading_screen = false;
      });
    }
  }

  discontinue() async {
    String URL = "http://$ip/VRS/driver_out_of_booking_checker.php";
    String responce;
    var request = await http.post(Uri.parse(URL),
        body: {"driver_id": driver_id, "user_id": user_id});
    responce = (jsonDecode(request.body));
    // print(responce);

    if (responce == "false") {
      setState(() {
        full_loading_screen = true;
      });
      URL = "http://$ip/VRS/driver_out_of_booking.php";
      var request =
          await http.post(Uri.parse(URL), body: {"driver_id": driver_id});
      responce = (jsonDecode(request.body));
      // print(responce);
      if (responce == "true") {
        Fluttertoast.showToast(
          msg: "You Successfully Removes From The Booking",
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
                Driver_profile_screen(user_id, driver_first_name_first_char),
          ),
          (route) => route.isFirst,
        );
      }
      setState(() {
        full_loading_screen = false;
      });
    } else {
      try {
        Fluttertoast.showToast(
            msg: "Can't Remove From The Booking",
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
    full_loading_screen = true;
    get_date();
  }

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
                  child: Text(driver_first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_account_screen(
                          user_id, driver_first_name_first_char),
                    ),
                  );
                },
              )
              // child: Image.asset("pictures/Landing page image.png"),
              ),
        ],
      ),
      body: full_loading_screen
          ? const Center(
              child: SpinKitWave(
                color: Colors.blue,
                size: 35.0,
              ),
            )
          : ListView(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          is_has_profile_network_image = false;
                          is_has_profile_image = false;
                        });
                        get_profile_image();
                      },
                      child: AnimatedContainer(
                        height: 170,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: done_without_profile_image
                                ? Colors.blue
                                : Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(milliseconds: 5),
                        child: is_profile_image_loading
                            ? const Center(
                                child: SpinKitFadingFour(
                                  color: Colors.blue,
                                  size: 35.0,
                                ),
                              )
                            : is_has_profile_network_image
                                ? Image.network(
                                    "http://$ip/VRS/" +
                                        driver_information['profile_pic'],
                                    loadingBuilder: (BuildContext context,
                                        Widget child, Progress) {
                                      if (Progress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: Progress.expectedTotalBytes !=
                                                  null
                                              ? Progress.cumulativeBytesLoaded /
                                                  Progress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  )
                                : is_has_profile_image
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Center(
                                          child:
                                              Image.file(profile_image_path!),
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(Icons.image),
                                      ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    enabled: false,
                    controller: first_name_Controller,
                    focusNode: first_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          first_name_Controller.clear();
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
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "First Name",
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    enabled: false,
                    controller: last_name_Controller,
                    focusNode: last_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          last_name_Controller.clear();
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
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Last Name",
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    controller: price_Controller,
                    focusNode: price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.currency_rupee_sharp),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          price_Controller.clear();
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
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Price (Charge for 1 Day)",
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
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Container(
                    width: 373,
                    height: 230,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color:
                              done_without_skill ? Colors.blue : Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              "Skills...",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: skill_two_wheeler,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      skill_two_wheeler = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "2 Wheeler",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: skill_three_wheeler,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      skill_three_wheeler = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "3 Wheeler",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: skill_four_wheeler,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      skill_four_wheeler = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "4 Wheeler",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: skill_more_than_four_wheeler,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      skill_more_than_four_wheeler = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "> 4 Wheeler (More Than Four Wheeler)",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Container(
                    width: 373,
                    height: 230,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: done_without_fule_type
                              ? Colors.blue
                              : Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              "Fule Type...",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: fule_type_petrol,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      fule_type_petrol = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "Petrol",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: fule_type_diesel,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      fule_type_diesel = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "Diesel",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: fule_type_electric,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      fule_type_electric = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "Electric",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: fule_type_hybrid,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      fule_type_hybrid = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "Hybrid",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Container(
                    width: 373,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: done_without_tranmission
                              ? Colors.blue
                              : Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, left: 5),
                            child: Text(
                              "Transmission...",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: transmission_manual,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      transmission_manual = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "Manual",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Checkbox(
                                  value: transmission_auto,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      transmission_auto = value!;
                                    });
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(),
                                child: Text(
                                  "Automatic",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    enabled: false,
                    controller: contact_Controller,
                    focusNode: contact,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          contact_Controller.clear();
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
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Contact",
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          height: 250,
                          width: 373,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5, left: 5),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Add Images Of Your Licence.                              (* Upload Both Side Pictures *)",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 30, right: 20),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            is_has_licence_network_image_1 =
                                                false;
                                            is_has_licence_image_1 = false;
                                          });
                                          get_licence_image(1);
                                        },
                                        child: AnimatedContainer(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color:
                                                    done_without_licence_image_1
                                                        ? Colors.blue
                                                        : Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          duration:
                                              const Duration(milliseconds: 5),
                                          child: is_has_licence_network_image_1
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      driver_information[
                                                          'licence_image_1'],
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          Progress) {
                                                    if (Progress == null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: Progress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? Progress
                                                                    .cumulativeBytesLoaded /
                                                                Progress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : is_has_licence_image_1
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            licence_image_1_path!),
                                                      ),
                                                    )
                                                  : const Center(
                                                      child: Icon(Icons.image),
                                                    ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            is_has_licence_network_image_2 =
                                                false;
                                            is_has_licence_image_2 = false;
                                          });
                                          get_licence_image(2);
                                        },
                                        child: AnimatedContainer(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color:
                                                    done_without_licence_image_2
                                                        ? Colors.blue
                                                        : Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          duration:
                                              const Duration(milliseconds: 5),
                                          child: is_has_licence_network_image_2
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      driver_information[
                                                          'licence_image_2'],
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          Progress) {
                                                    if (Progress == null) {
                                                      return child;
                                                    }
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: Progress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? Progress
                                                                    .cumulativeBytesLoaded /
                                                                Progress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : is_has_licence_image_2
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            licence_image_2_path!),
                                                      ),
                                                    )
                                                  : const Center(
                                                      child: Icon(Icons.image),
                                                    ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          child: Container(
                            height: is_licence_image_loading ? 250 : 0,
                            width: is_licence_image_loading ? 373 : 0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(155, 255, 255, 255),
                            ),
                            child: const Center(
                              child: SpinKitFadingFour(
                                color: Colors.blue,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    enabled: false,
                    controller: city_Controller,
                    focusNode: city,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          city_Controller.clear();
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
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "City",
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    enabled: false,
                    controller: state_Controller,
                    focusNode: state,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          state_Controller.clear();
                        },
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 230, 230, 230),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "State",
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    enabled: false,
                    controller: country_Controller,
                    focusNode: country,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          country_Controller.clear();
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
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "country",
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    enabled: false,
                    controller: pin_code_Controller,
                    focusNode: pin_code,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          pin_code_Controller.clear();
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
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "pin_code",
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      click_apply();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (on_booking == false) {
                        back_to_booking();
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
                            Vibration.vibrate(duration: 100, amplitude: 128);
                          });
                        } catch (e) {}
                      }
                    },
                    onLongPress: () {
                      if (on_booking == true) {
                        discontinue();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: on_booking ? Colors.red : Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Text(
                        on_booking
                            ? "Discontinue From Booking"
                            : "Apply As Driver Again",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
