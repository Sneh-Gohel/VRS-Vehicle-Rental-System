// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, must_be_immutable, no_logic_in_create_state, constant_identifier_names, prefer_typing_uninitialized_variables, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vrs/Home_account_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrs/Renter_vehicle_details_screen.dart';
import 'package:vrs/Upload_image.dart';
import 'dart:io';
import 'Current_IP.dart';
import 'Renter_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';

const List<String> flue_list = <String>[
  'Petrol',
  'Diesel',
  'Electric',
];

const List<String> transmission_mode_list = <String>[
  'Manual',
  'Automatic',
  'None',
];

String flue_type = flue_list.first;
String tranmission_mode = transmission_mode_list.first;

class Edit_vehicle_details extends StatefulWidget {
  String user_id = "";
  String first_name_first_char = "";
  String vehicle_id = "";
  Edit_vehicle_details(
      this.user_id, this.first_name_first_char, this.vehicle_id,
      {super.key});

  @override
  State<StatefulWidget> createState() =>
      _Edit_vehicle_details(user_id, first_name_first_char, vehicle_id);
}

class _Edit_vehicle_details extends State<Edit_vehicle_details> {
  String user_id = "";
  String renter_first_name_first_char = "";
  String vehicle_id = "";
  final model_name_Controller = TextEditingController();
  final company_name_Controller = TextEditingController();
  final wheeler_type_Controller = TextEditingController();
  final passing_year_Controller = TextEditingController();
  final seater_Controller = TextEditingController();
  final price_Controller = TextEditingController();
  final vehicle_number_Controller = TextEditingController();
  final model_name = FocusNode();
  final company_name = FocusNode();
  final wheeler_type = FocusNode();
  final passing_year = FocusNode();
  final seater = FocusNode();
  final price = FocusNode();
  final vehicle_number = FocusNode();
  bool is_has_vehicle_image_1 = false;
  bool is_has_vehicle_image_2 = false;
  bool is_has_vehicle_image_3 = false;
  bool is_has_vehicle_image_4 = false;
  bool is_has_vehicle_image_5 = false;
  bool is_has_rc_image_1 = false;
  bool is_has_rc_image_2 = false;
  bool done_without_vehicle_image = false;
  bool done_without_rc_image_1 = false;
  bool done_without_rc_image_2 = false;
  File? vehicle_image_1_path;
  File? vehicle_image_2_path;
  File? vehicle_image_3_path;
  File? vehicle_image_4_path;
  File? vehicle_image_5_path;
  File? rc_image_1_path;
  File? rc_image_2_path;
  var vehicle_image_1_data = "";
  var vehicle_image_2_data = "";
  var vehicle_image_3_data = "";
  var vehicle_image_4_data = "";
  var vehicle_image_5_data = "";
  bool is_vehicle_image_loading = false;
  bool is_rc_image_loading = false;
  bool is_add_press = false;
  ImagePicker image_picker = ImagePicker();
  String ip = Current_IP().getIP();
  var vehicle_information;
  bool is_has_vehicle_network_image_1 = false;
  bool is_has_vehicle_network_image_2 = false;
  bool is_has_vehicle_network_image_3 = false;
  bool is_has_vehicle_network_image_4 = false;
  bool is_has_vehicle_network_image_5 = false;
  bool is_has_rc_network_image_1 = false;
  bool is_has_rc_network_image_2 = false;

  _Edit_vehicle_details(
      this.user_id, this.renter_first_name_first_char, this.vehicle_id);

  Add_vehicle_screen() {
    delete_cache();
  }

  Future<void> delete_cache() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
      print("cache cleared");
    }
    print("delete cache called");
  }

  get_data() async {
    String URL = "http://$ip/VRS/edit_vehicle_get_data.php";
    String responce;
    var request =
        await http.post(Uri.parse(URL), body: {"vehicle_id": vehicle_id});
    setState(() {
      vehicle_information = jsonDecode(request.body);
      model_name_Controller.text = vehicle_information['vehicle_model'];
      company_name_Controller.text = vehicle_information['vehicle_company'];
      passing_year_Controller.text =
          vehicle_information['vehicle_passing_year'];
      wheeler_type_Controller.text = vehicle_information['vehicle_wheeler'];
      seater_Controller.text = vehicle_information['vehicle_seater'];
      price_Controller.text = vehicle_information['vehicle_price'];
      vehicle_number_Controller.text = vehicle_information['vehicle_number'];
      is_has_vehicle_network_image_1 = true;
      is_has_vehicle_image_1 = true;
      is_has_rc_network_image_1 = true;
      is_has_rc_image_1 = true;
      is_has_rc_network_image_2 = true;
      is_has_rc_image_2 = true;
      if (vehicle_information['vehicle_image_2'] != "") {
        is_has_vehicle_network_image_2 = true;
        is_has_vehicle_image_2 = true;
      }
      if (vehicle_information['vehicle_image_3'] != "") {
        is_has_vehicle_network_image_3 = true;
        is_has_vehicle_image_3 = true;
      }
      if (vehicle_information['vehicle_image_4'] != "") {
        is_has_vehicle_network_image_4 = true;
        is_has_vehicle_image_4 = true;
      }
      if (vehicle_information['vehicle_image_5'] != "") {
        is_has_vehicle_network_image_5 = true;
        is_has_vehicle_image_5 = true;
      }
    });
  }

  Future<void> get_vehicle_image(int identifier) async {
    setState(() {
      is_vehicle_image_loading = true;
    });
    var get_image = await image_picker.pickImage(
      source: ImageSource.gallery,
    );
    if (identifier == 1) {
      setState(() {
        if (get_image != null) {
          vehicle_image_1_path = File(get_image.path);
          is_has_vehicle_image_1 = true;
          _compressImage(1, "vehicle");
        } else {
          if (is_has_vehicle_image_2 == true) {
            vehicle_image_1_path = vehicle_image_2_path;
            is_has_vehicle_image_1 = true;
            if (is_has_vehicle_image_3 == true) {
              vehicle_image_2_path = vehicle_image_3_path;
              if (is_has_vehicle_image_4 == true) {
                vehicle_image_3_path = vehicle_image_4_path;
                if (is_has_vehicle_image_5 == true) {
                  vehicle_image_4_path = vehicle_image_5_path;
                  vehicle_image_5_path = null;
                  is_has_vehicle_image_5 = false;
                } else {
                  vehicle_image_4_path = null;
                  is_has_vehicle_image_4 = false;
                }
              } else {
                vehicle_image_3_path = null;
                is_has_vehicle_image_3 = false;
              }
            } else {
              vehicle_image_2_path = null;
              is_has_vehicle_image_2 = false;
            }
          } else {
            vehicle_image_1_path = null;
            is_has_vehicle_image_1 = false;
          }
        }
      });
    } else if (identifier == 2) {
      if (is_has_vehicle_image_1 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_1_path = File(get_image.path);
            is_has_vehicle_image_1 = true;
            _compressImage(1, "vehicle");
          } else {
            vehicle_image_1_path = null;
            is_has_vehicle_image_1 = false;
          }
        });
      } else {
        setState(() {
          if (get_image != null) {
            vehicle_image_2_path = File(get_image.path);
            is_has_vehicle_image_2 = true;
            _compressImage(2, "vehicle");
          } else if (is_has_vehicle_image_3 == true) {
            vehicle_image_2_path = vehicle_image_3_path;
            if (is_has_vehicle_image_4 == true) {
              vehicle_image_3_path = vehicle_image_4_path;
              if (is_has_vehicle_image_5 == true) {
                vehicle_image_4_path = vehicle_image_5_path;
                vehicle_image_5_path = null;
                is_has_vehicle_image_5 = false;
              } else {
                vehicle_image_4_path = null;
                is_has_vehicle_image_4 = false;
              }
            } else {
              vehicle_image_3_path = null;
              is_has_vehicle_image_3 = false;
            }
          } else {
            vehicle_image_2_path = null;
            is_has_vehicle_image_2 = false;
          }
        });
      }
    } else if (identifier == 3) {
      if (is_has_vehicle_image_1 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_1_path = File(get_image.path);
            is_has_vehicle_image_1 = true;
            _compressImage(1, "vehicle");
          } else {
            vehicle_image_1_path = null;
            is_has_vehicle_image_1 = false;
          }
        });
      } else if (is_has_vehicle_image_2 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_2_path = File(get_image.path);
            is_has_vehicle_image_2 = true;
            _compressImage(2, "vehicle");
          } else {
            vehicle_image_2_path = null;
            is_has_vehicle_image_2 = false;
          }
        });
      } else {
        setState(() {
          if (get_image != null) {
            vehicle_image_3_path = File(get_image.path);
            is_has_vehicle_image_3 = true;
            _compressImage(3, "vehicle");
          } else if (is_has_vehicle_image_4 == true) {
            vehicle_image_3_path = vehicle_image_4_path;
            if (is_has_vehicle_image_5 == true) {
              vehicle_image_4_path = vehicle_image_5_path;
              vehicle_image_5_path = null;
              is_has_vehicle_image_5 = false;
            } else {
              vehicle_image_4_path = null;
              is_has_vehicle_image_4 = false;
            }
          } else {
            vehicle_image_3_path = null;
            is_has_vehicle_image_3 = false;
          }
        });
      }
    } else if (identifier == 4) {
      if (is_has_vehicle_image_1 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_1_path = File(get_image.path);
            is_has_vehicle_image_1 = true;
            _compressImage(1, "vehicle");
          } else {
            vehicle_image_1_path = null;
            is_has_vehicle_image_1 = false;
          }
        });
      } else if (is_has_vehicle_image_2 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_2_path = File(get_image.path);
            is_has_vehicle_image_2 = true;
            _compressImage(2, "vehicle");
          } else {
            vehicle_image_2_path = null;
            is_has_vehicle_image_2 = false;
          }
        });
      } else if (is_has_vehicle_image_3 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_3_path = File(get_image.path);
            is_has_vehicle_image_3 = true;
            _compressImage(3, "vehicle");
          } else {
            vehicle_image_3_path = null;
            is_has_vehicle_image_3 = false;
          }
        });
      } else {
        setState(() {
          if (get_image != null) {
            vehicle_image_4_path = File(get_image.path);
            is_has_vehicle_image_4 = true;
            _compressImage(4, "vehicle");
          } else if (is_has_vehicle_image_5 == true) {
            vehicle_image_4_path = vehicle_image_5_path;
            vehicle_image_5_path = null;
            is_has_vehicle_image_5 = false;
          } else {
            vehicle_image_4_path = null;
            is_has_vehicle_image_4 = false;
          }
        });
      }
    } else if (identifier == 5) {
      if (is_has_vehicle_image_1 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_1_path = File(get_image.path);
            is_has_vehicle_image_1 = true;
            _compressImage(1, "vehicle");
          } else {
            vehicle_image_1_path = null;
            is_has_vehicle_image_1 = false;
          }
        });
      } else if (is_has_vehicle_image_2 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_2_path = File(get_image.path);
            is_has_vehicle_image_2 = true;
            _compressImage(2, "vehicle");
          } else {
            vehicle_image_2_path = null;
            is_has_vehicle_image_2 = false;
          }
        });
      } else if (is_has_vehicle_image_3 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_3_path = File(get_image.path);
            is_has_vehicle_image_3 = true;
            _compressImage(3, "vehicle");
          } else {
            vehicle_image_3_path = null;
            is_has_vehicle_image_3 = false;
          }
        });
      } else if (is_has_vehicle_image_4 == false) {
        setState(() {
          if (get_image != null) {
            vehicle_image_4_path = File(get_image.path);
            is_has_vehicle_image_4 = true;
            _compressImage(4, "vehicle");
          } else {
            vehicle_image_4_path = null;
            is_has_vehicle_image_4 = false;
          }
        });
      } else {
        setState(() {
          if (get_image != null) {
            vehicle_image_5_path = File(get_image.path);
            is_has_vehicle_image_5 = true;
            _compressImage(5, "vehicle");
          } else {
            vehicle_image_5_path = null;
            is_has_vehicle_image_5 = false;
          }
        });
      }
    }
    setState(() {
      is_vehicle_image_loading = false;
      if (identifier == 1) {
        is_has_vehicle_network_image_1 = false;
      } else if (identifier == 2) {
        is_has_vehicle_network_image_2 = false;
      } else if (identifier == 3) {
        is_has_vehicle_network_image_3 = false;
      } else if (identifier == 4) {
        is_has_vehicle_network_image_4 = false;
      } else if (identifier == 5) {
        is_has_vehicle_network_image_5 = false;
      }
    });
  }

  Future<void> get_rc_image(int identifier) async {
    setState(() {
      is_rc_image_loading = true;
    });
    var get_image = await image_picker.pickImage(source: ImageSource.gallery);
    if (identifier == 1) {
      setState(() {
        if (get_image != null) {
          rc_image_1_path = File(get_image.path);
          is_has_rc_image_1 = true;
          _compressImage(1, "rc");
        } else {
          rc_image_1_path = null;
          is_has_rc_image_1 = false;
        }
      });
    } else if (identifier == 2) {
      setState(() {
        if (get_image != null) {
          rc_image_2_path = File(get_image.path);
          is_has_rc_image_2 = true;
          _compressImage(2, "rc");
        } else {
          rc_image_2_path = null;
          is_has_rc_image_2 = false;
        }
      });
    }
    setState(() {
      is_rc_image_loading = false;
      if (identifier == 1) {
        is_has_rc_network_image_1 = false;
      } else {
        is_has_rc_network_image_2 = false;
      }
    });
  }

  Future<void> _compressImage(int identifier, String type) async {
    if (type == "vehicle") {
      setState(() {
        is_vehicle_image_loading = true;
      });
      if (identifier == 1) {
        int fileSizeInBytes = vehicle_image_1_path!.lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
        print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
        if (fileSizeInMb > 3) {
          try {
            print("pictures compresstion started");
            final directory = await getApplicationDocumentsDirectory();
            final copiedImage = await vehicle_image_1_path!.copy(
                '${directory.path}/vehicle_1_${vehicle_image_1_path!.path.split('/').last}');
            final compressedFile =
                await FlutterImageCompress.compressAndGetFile(
              vehicle_image_1_path!.path,
              copiedImage.path,
              quality: 50,
            );
            setState(() {
              vehicle_image_1_path = File(compressedFile!.absolute.path);
            });
          } catch (e) {
            print("error in image compresser... $e");
          }
        }
      } else if (identifier == 2) {
        int fileSizeInBytes = vehicle_image_2_path!.lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
        print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
        if (fileSizeInMb > 3) {
          try {
            print("pictures compresstion started");
            final directory = await getApplicationDocumentsDirectory();
            final copiedImage = await vehicle_image_2_path!.copy(
                '${directory.path}/vehicle_2_${vehicle_image_2_path!.path.split('/').last}');
            final compressedFile =
                await FlutterImageCompress.compressAndGetFile(
              vehicle_image_2_path!.path,
              copiedImage.path,
              quality: 50,
            );
            setState(() {
              vehicle_image_2_path = File(compressedFile!.absolute.path);
            });
          } catch (e) {
            print("error in image compresser... $e");
          }
        }
      } else if (identifier == 3) {
        int fileSizeInBytes = vehicle_image_3_path!.lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
        print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
        if (fileSizeInMb > 3) {
          try {
            print("pictures compresstion started");
            final directory = await getApplicationDocumentsDirectory();
            final copiedImage = await vehicle_image_3_path!.copy(
                '${directory.path}/vehicle_3_${vehicle_image_3_path!.path.split('/').last}');
            final compressedFile =
                await FlutterImageCompress.compressAndGetFile(
              vehicle_image_3_path!.path,
              copiedImage.path,
              quality: 50,
            );
            setState(() {
              vehicle_image_3_path = File(compressedFile!.absolute.path);
            });
          } catch (e) {
            print("error in image compresser... $e");
          }
        }
      } else if (identifier == 4) {
        int fileSizeInBytes = vehicle_image_4_path!.lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
        print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
        if (fileSizeInMb > 3) {
          try {
            print("pictures compresstion started");
            final directory = await getApplicationDocumentsDirectory();
            final copiedImage = await vehicle_image_4_path!.copy(
                '${directory.path}/vehicle_4_${vehicle_image_4_path!.path.split('/').last}');
            final compressedFile =
                await FlutterImageCompress.compressAndGetFile(
              vehicle_image_4_path!.path,
              copiedImage.path,
              quality: 50,
            );
            setState(() {
              vehicle_image_4_path = File(compressedFile!.absolute.path);
            });
          } catch (e) {
            print("error in image compresser... $e");
          }
        }
      } else if (identifier == 5) {
        int fileSizeInBytes = vehicle_image_5_path!.lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
        print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
        if (fileSizeInMb > 3) {
          try {
            print("pictures compresstion started");
            final directory = await getApplicationDocumentsDirectory();
            final copiedImage = await vehicle_image_5_path!.copy(
                '${directory.path}/vehicle_5_${vehicle_image_5_path!.path.split('/').last}');
            final compressedFile =
                await FlutterImageCompress.compressAndGetFile(
              vehicle_image_5_path!.path,
              copiedImage.path,
              quality: 50,
            );
            setState(() {
              vehicle_image_5_path = File(compressedFile!.absolute.path);
            });
          } catch (e) {
            print("error in image compresser... $e");
          }
        }
      }

      setState(() {
        is_vehicle_image_loading = false;
      });
    } else if (type == "rc") {
      setState(() {
        is_rc_image_loading = true;
      });
      if (identifier == 1) {
        int fileSizeInBytes = rc_image_1_path!.lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
        print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
        if (fileSizeInMb > 3) {
          try {
            print("pictures compresstion started");
            final directory = await getApplicationDocumentsDirectory();
            final copiedImage = await rc_image_1_path!.copy(
                '${directory.path}/rc_1_${rc_image_1_path!.path.split('/').last}');
            final compressedFile =
                await FlutterImageCompress.compressAndGetFile(
              rc_image_1_path!.path,
              copiedImage.path,
              quality: 80,
            );
            setState(() {
              rc_image_1_path = File(compressedFile!.absolute.path);
            });
          } catch (e) {
            print("error in image compresser... $e");
          }
        }
      } else if (identifier == 2) {
        int fileSizeInBytes = rc_image_2_path!.lengthSync();
        double fileSizeInMb = fileSizeInBytes / (1024 * 1024);
        print('Selected image size: ${fileSizeInMb.toStringAsFixed(2)} MB');
        if (fileSizeInMb > 3) {
          try {
            print("pictures compresstion started");
            final directory = await getApplicationDocumentsDirectory();
            final copiedImage = await rc_image_2_path!.copy(
                '${directory.path}/rc_2_${rc_image_2_path!.path.split('/').last}');
            final compressedFile =
                await FlutterImageCompress.compressAndGetFile(
              rc_image_2_path!.path,
              copiedImage.path,
              quality: 80,
            );
            setState(() {
              rc_image_2_path = File(compressedFile!.absolute.path);
            });
          } catch (e) {
            print("error in image compresser... $e");
          }
        }
      }
      setState(() {
        is_rc_image_loading = false;
      });
    }
  }

  save_press() async {
    if (model_name_Controller.text != "") {
      if (company_name_Controller.text != "") {
        if (passing_year_Controller.text != "") {
          if (wheeler_type_Controller.text != "") {
            if (seater_Controller.text != "") {
              if (price_Controller.text != "") {
                if (vehicle_number_Controller.text != "") {
                  if (is_has_vehicle_image_1 == true) {
                    if (is_has_rc_image_1 == true) {
                      if (is_has_rc_image_2 == true) {
                        try {
                          setState(() {
                            is_add_press = true;
                          });
                          String URL = "http://" + ip + "/VRS/edit_vehicle.php";
                          String responce;
                          var request = await http.post(Uri.parse(URL), body: {
                            "vehicle_id": vehicle_id,
                            "vehicle_model": model_name_Controller.text,
                            "vehicle_company": company_name_Controller.text,
                            "vehicle_price": price_Controller.text,
                            "vehicle_passing_year":
                                passing_year_Controller.text,
                            "vehicle_wheeler": wheeler_type_Controller.text,
                            "vehicle_seater": seater_Controller.text,
                            "vehicle_fule_type": flue_type,
                            "vehicle_tranmission": tranmission_mode,
                            "vehicle_number": vehicle_number_Controller.text
                          });
                          responce = (jsonDecode(request.body));
                          print(responce);

                          if (is_has_vehicle_network_image_1 == false) {
                            if (is_has_vehicle_image_1 == true) {
                              String URL2 = "http://" +
                                  ip +
                                  "/VRS/add_vehicle_add_image.php";
                              Upload_image.upload(URL2, vehicle_id,
                                  vehicle_image_1_path!, "1", false);
                            }
                          }
                          if (is_has_vehicle_network_image_2 == false) {
                            if (is_has_vehicle_image_2 == true) {
                              String URL2 = "http://" +
                                  ip +
                                  "/VRS/add_vehicle_add_image.php";
                              Upload_image.upload(URL2, vehicle_id,
                                  vehicle_image_2_path!, "2", false);
                            }
                          }
                          if (is_has_vehicle_network_image_3 == false) {
                            if (is_has_vehicle_image_3 == true) {
                              String URL2 = "http://" +
                                  ip +
                                  "/VRS/add_vehicle_add_image.php";
                              Upload_image.upload(URL2, vehicle_id,
                                  vehicle_image_3_path!, "3", false);
                            }
                          }
                          if (is_has_vehicle_network_image_4 == false) {
                            if (is_has_vehicle_image_4 == true) {
                              String URL2 = "http://" +
                                  ip +
                                  "/VRS/add_vehicle_add_image.php";
                              Upload_image.upload(URL2, vehicle_id,
                                  vehicle_image_4_path!, "4", false);
                            }
                          }
                          if (is_has_vehicle_network_image_5 == false) {
                            if (is_has_vehicle_image_5 == true) {
                              String URL2 = "http://" +
                                  ip +
                                  "/VRS/add_vehicle_add_image.php";
                              Upload_image.upload(URL2, vehicle_id,
                                  vehicle_image_5_path!, "5", false);
                            }
                          }
                          if (is_has_rc_network_image_1 == false) {
                            if (is_has_rc_image_1 == true) {
                              String URL2 = "http://" +
                                  ip +
                                  "/VRS/add_vehicle_add_image.php";
                              Upload_image.upload(URL2, vehicle_id,
                                  rc_image_1_path!, "1", true);
                            }
                          }
                          if (is_has_rc_network_image_2 == false) {
                            if (is_has_rc_image_2 == true) {
                              String URL2 = "http://" +
                                  ip +
                                  "/VRS/add_vehicle_add_image.php";
                              Upload_image.upload(URL2, vehicle_id,
                                  rc_image_2_path!, "2", true);
                            }
                          }
                          setState(() {
                            is_add_press = false;
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Renter_vehicle_details_screen(user_id,
                                      renter_first_name_first_char, vehicle_id),
                            ),
                            (route) => route.isFirst,
                          );
                        } catch (e) {
                          print("error");
                          setState(() {
                            is_add_press = false;
                          });
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
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
        backgroundColor: Colors.blue,
        elevation: 10,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.white,
                  child: Text(renter_first_name_first_char,
                      style:
                          const TextStyle(color: Colors.blue, fontSize: 25.0)),
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
              )),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            child: ListView(
              children: [
                // const Padding(
                //   padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                //   child: Center(
                //     child: Text(
                //       "( * Fill All Details Of Vehicle * )",
                //       style: TextStyle(
                //         fontSize: 22,
                //         color: Colors.blue,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: TextField(
                    controller: model_name_Controller,
                    focusNode: model_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.directions_car_sharp),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          model_name_Controller.clear();
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
                      hintText: "Vehicle Model Name",
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
                    controller: company_name_Controller,
                    focusNode: company_name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.directions_car_rounded),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          company_name_Controller.clear();
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
                      hintText: "Company Name",
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
                    controller: passing_year_Controller,
                    focusNode: passing_year,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.date_range_rounded),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          passing_year_Controller.clear();
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
                      hintText: "Passing year",
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
                    controller: wheeler_type_Controller,
                    focusNode: wheeler_type,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.album_rounded),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          passing_year_Controller.clear();
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
                      hintText: "Total Wheels",
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
                    controller: seater_Controller,
                    focusNode: seater,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.airline_seat_legroom_extra_rounded),
                      suffix: GestureDetector(
                        child: const Icon(Icons.clear),
                        onTap: () {
                          seater_Controller.clear();
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
                      hintText: "Available Seat",
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Text(
                          "Flue Type...",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70),
                        child: Text(
                          "Tranmission Mode...",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, top: 0),
                  child: Row(
                    children: const [
                      DropdownButton_for_flue_type(),
                      Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: DropdownButton_for_transmission_mode(),
                      ),
                    ],
                  ),
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 20, right: 189, top: 20),
                //   child: DropdownButton_for_transmission_mode(),
                // ),
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
                      hintText: "Price",
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
                    controller: vehicle_number_Controller,
                    focusNode: vehicle_number,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.onetwothree_rounded),
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
                      hintText: "Vehicle Number (As per Number Plate)",
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),

                Stack(
                  children: [
                    Positioned(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Container(
                          height: 580,
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
                                    "Add Images Of The Vehicle. (* 1 Image Required *)",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: GestureDetector(
                                        onTap: () {
                                          get_vehicle_image(1);
                                          setState(() {
                                            is_has_vehicle_image_1 = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: done_without_vehicle_image
                                                  ? Colors.blue
                                                  : Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 5),
                                          child: is_has_vehicle_network_image_1
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      vehicle_information[
                                                          'vehicle_image_1'],
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
                                              : is_has_vehicle_image_1
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            vehicle_image_1_path!),
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
                                          get_vehicle_image(2);
                                          setState(() {
                                            is_has_vehicle_image_2 = false;
                                          });
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_network_image_2
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      vehicle_information[
                                                          'vehicle_image_2'],
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
                                              : is_has_vehicle_image_2
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            vehicle_image_2_path!),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: GestureDetector(
                                        onTap: () {
                                          get_vehicle_image(3);
                                          setState(() {
                                            is_has_vehicle_image_3 = false;
                                          });
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_network_image_3
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      vehicle_information[
                                                          'vehicle_image_3'],
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
                                              : is_has_vehicle_image_3
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            vehicle_image_3_path!),
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
                                          get_vehicle_image(4);
                                          setState(() {
                                            is_has_vehicle_image_4 = false;
                                          });
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_network_image_4
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      vehicle_information[
                                                          'vehicle_image_4'],
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
                                              : is_has_vehicle_image_4
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            vehicle_image_4_path!),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 20),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(),
                                      child: GestureDetector(
                                        onTap: () {
                                          get_vehicle_image(5);
                                          setState(() {
                                            is_has_vehicle_image_5 = false;
                                          });
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_network_image_5
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      vehicle_information[
                                                          'vehicle_image_5'],
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
                                              : is_has_vehicle_image_5
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            vehicle_image_5_path!),
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
                    ),
                    Positioned(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Container(
                          height: is_vehicle_image_loading ? 580 : 0,
                          width: is_vehicle_image_loading ? 373 : 0,
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
                Stack(
                  children: [
                    Positioned(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 30),
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
                                    "Add Images Of RC Book Of The Vehicle.              (* Upload Both Side Pictures *)",
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
                                          get_rc_image(1);
                                          setState(() {
                                            is_has_rc_image_1 = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: done_without_rc_image_1
                                                    ? Colors.blue
                                                    : Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          duration:
                                              const Duration(milliseconds: 5),
                                          child: is_has_rc_network_image_1
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      vehicle_information[
                                                          'vehicle_rc_image_1'],
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
                                              : is_has_rc_image_1
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            rc_image_1_path!),
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
                                          get_rc_image(2);
                                          setState(() {
                                            is_has_rc_image_2 = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: done_without_rc_image_2
                                                    ? Colors.blue
                                                    : Colors.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          duration:
                                              const Duration(milliseconds: 5),
                                          child: is_has_rc_network_image_2
                                              ? Image.network(
                                                  "http://$ip/VRS/" +
                                                      vehicle_information[
                                                          'vehicle_rc_image_2'],
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
                                              : is_has_rc_image_2
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      child: Center(
                                                        child: Image.file(
                                                            rc_image_2_path!),
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
                    ),
                    Positioned(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 10, right: 10),
                        child: Container(
                          height: is_rc_image_loading ? 250 : 0,
                          width: is_rc_image_loading ? 373 : 0,
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        save_press();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              height: is_add_press ? null : 0,
              width: is_add_press ? null : 0,
              decoration: const BoxDecoration(
                color: Color.fromARGB(155, 255, 255, 255),
              ),
              child: const Center(
                child: SpinKitWave(
                  color: Colors.blue,
                  size: 35.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownButton_for_flue_type extends StatefulWidget {
  const DropdownButton_for_flue_type({super.key});

  @override
  State<DropdownButton_for_flue_type> createState() =>
      _DropdownButton_for_flue_type();
}

class _DropdownButton_for_flue_type
    extends State<DropdownButton_for_flue_type> {
  // String tranmission_mode = flue_list.first;
  String dropdownValue = flue_list.first;
//   String dropdownValue = "Hello";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      hint: const Text("                             "),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(
          () {
            dropdownValue = value!;
            flue_type = value;
          },
        );
      },
      items: flue_list.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}

class DropdownButton_for_transmission_mode extends StatefulWidget {
  const DropdownButton_for_transmission_mode({super.key});

  @override
  State<DropdownButton_for_transmission_mode> createState() =>
      _DropdownButton_for_transmission_mode();
}

class _DropdownButton_for_transmission_mode
    extends State<DropdownButton_for_transmission_mode> {
  String dropdownValue = transmission_mode_list.first;
//   String dropdownValue = "Hello";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      hint: const Text("                             "),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(
          () {
            dropdownValue = value!;
            tranmission_mode = value;
          },
        );
      },
      items: transmission_mode_list.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}
