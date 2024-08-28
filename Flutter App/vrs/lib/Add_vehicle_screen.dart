// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, constant_identifier_names, unused_field, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, prefer_typing_uninitialized_variables, empty_statements, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vrs/Home_account_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrs/Upload_image.dart';
import 'dart:io';
import 'Current_IP.dart';
import 'Renter_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';

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

class Add_vehicle_screen extends StatefulWidget {
  String user_id;
  String first_name_first_char;
  Add_vehicle_screen(this.user_id, this.first_name_first_char, {super.key});
  @override
  State<StatefulWidget> createState() =>
      _Add_vehicle_screen(user_id, first_name_first_char);
}

class _Add_vehicle_screen extends State<Add_vehicle_screen> {
  String user_id = "";
  String first_name_first_char = "";
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
  // final error_player = AudioPlayer();

  _Add_vehicle_screen(this.user_id, this.first_name_first_char);

  Add_vehicle_screen() {
    delete_cache();
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
    // setState(() {
    //   is_vehicle_image_loading = false;
    // });
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
  }

  Future<void> _compressImage(int identifier, String type) async {
    if (type == "vehicle") {
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
            print("error in image compresser... " + e.toString());
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
            print("error in image compresser... " + e.toString());
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
            print("error in image compresser... " + e.toString());
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
            print("error in image compresser... " + e.toString());
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
            print("error in image compresser... " + e.toString());
          }
        }
      }

      setState(() {
        is_vehicle_image_loading = false;
      });
    } else if (type == "rc") {
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
            print("error in image compresser... " + e.toString());
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
            print("error in image compresser... " + e.toString());
          }
        }
      }
      setState(() {
        is_rc_image_loading = false;
      });
    }
  }

  add_press() async {
    // delete_cache();
    String ip = Current_IP().getIP();
    String URL1 = "http://" + ip + "/VRS/add_vehicle.php";
    if (model_name_Controller.text == "") {
      // try {
      //   // String url = "http://" + ip + "/VRS/sound/error.php";
      //   // await error_player.play(url);
      //   final assetsAudioPlayer = AssetsAudioPlayer();
      //   assetsAudioPlayer.open(
      //     Audio("sound/error.mp3"),
      //     showNotification: false,
      //   );
      // } catch (e) {
      //   print("error in playing sound... " + e.toString());
      // }
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Invaild Model Name...",
              style: TextStyle(color: Colors.blue),
            ),
            content: const Text("Make Sure Enter Model Name..."),
            actions: [
              Center(
                child: ElevatedButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Renter_profile_screen(
                            user_id, first_name_first_char),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
      FocusScope.of(context).requestFocus(model_name);
    } else {
      if (company_name_Controller.text == "") {
        FocusScope.of(context).requestFocus(company_name);
      } else {
        if (passing_year_Controller.text == "") {
          FocusScope.of(context).requestFocus(passing_year);
        } else {
          if (wheeler_type_Controller.text == "") {
            FocusScope.of(context).requestFocus(wheeler_type);
          } else {
            if (seater_Controller.text == "") {
              FocusScope.of(context).requestFocus(seater);
            } else {
              if (price_Controller.text == "") {
                FocusScope.of(context).requestFocus(price);
              } else {
                if (vehicle_number_Controller.text == "") {
                  FocusScope.of(context).requestFocus(vehicle_number);
                } else {
                  if (is_has_vehicle_image_1 == false) {
                    setState(() {
                      done_without_vehicle_image = true;
                    });
                  } else {
                    if (is_has_rc_image_1 == false) {
                      setState(() {
                        done_without_rc_image_1 = true;
                      });
                    } else {
                      if (is_has_rc_image_2 == false) {
                        setState(() {
                          done_without_rc_image_2 = true;
                        });
                      } else {
                        if (passing_year_Controller.text != "Invaild") {
                          int passing_year_int =
                              int.parse(passing_year_Controller.text);
                          int currentYear = DateTime.now().year;
                          if (passing_year_int > 1900 &&
                              passing_year_int <= currentYear) {
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const Renter_profile_screen(),
                            //   ),
                            // );
                            try {
                              setState(() {
                                is_add_press = true;
                              });
                              String responce;
                              var request = await http.post(
                                Uri.parse(URL1),
                                body: {
                                  "vehicle_model": model_name_Controller.text,
                                  "vehicle_company":
                                      company_name_Controller.text,
                                  "vehicle_price": price_Controller.text,
                                  "vehicle_passing_year":
                                      passing_year_Controller.text,
                                  "vehicle_wheeler":
                                      wheeler_type_Controller.text,
                                  "vehicle_seater": seater_Controller.text,
                                  "vehicle_fule_type": flue_type,
                                  "vehicle_tranmission": tranmission_mode,
                                  "vehicle_number":
                                      vehicle_number_Controller.text,
                                  "vehicle_owner_user_id": user_id
                                },
                              );
                              responce = (jsonDecode(request.body)).toString();
                              try {
                                String ip = Current_IP().getIP();
                                String URL2 = "http://" +
                                    ip +
                                    "/VRS/add_vehicle_add_image.php";
                                Upload_image.upload(URL2, responce,
                                    vehicle_image_1_path!, "1", false);
                                await vehicle_image_1_path!.delete();
                                if (is_has_vehicle_image_2) {
                                  Upload_image.upload(URL2, responce,
                                      vehicle_image_2_path!, "2", false);
                                  await vehicle_image_2_path!.delete();
                                }
                                if (is_has_vehicle_image_3) {
                                  Upload_image.upload(URL2, responce,
                                      vehicle_image_3_path!, "3", false);
                                  await vehicle_image_3_path!.delete();
                                }
                                if (is_has_vehicle_image_4) {
                                  Upload_image.upload(URL2, responce,
                                      vehicle_image_4_path!, "4", false);
                                  await vehicle_image_4_path!.delete();
                                }
                                if (is_has_vehicle_image_5) {
                                  Upload_image.upload(URL2, responce,
                                      vehicle_image_5_path!, "5", false);
                                  await vehicle_image_5_path!.delete();
                                }
                                Upload_image.upload(URL2, responce,
                                    rc_image_1_path!, "1", true);
                                Upload_image.upload(URL2, responce,
                                    rc_image_2_path!, "2", true);
                                Timer _timer;
                                _timer = Timer.periodic(
                                    const Duration(seconds: 3), (timer) {
                                  setState(() {
                                    setState(() {
                                      is_add_press = false;
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Renter_profile_screen(user_id,
                                                  first_name_first_char),
                                        ),
                                      );
                                    });
                                    timer.cancel();
                                  });
                                });
                              } catch (e) {
                                print("error to store image..." + e.toString());
                              }
                            } catch (e) {
                              print("error" + e.toString());
                              setState(() {
                                is_add_press = false;
                              });
                            }
                          } else {
                            setState(() {
                              passing_year_Controller.text = "Invaild";
                              FocusScope.of(context).requestFocus(passing_year);
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
  }

  Future<void> delete_cache() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
      print("cache cleared");
    }
    print("delete cache called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Vehicle",
        ),
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
                                          child: is_has_vehicle_image_1
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
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_image_2
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
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_image_3
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
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_image_4
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
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: is_has_vehicle_image_5
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
                                          child: is_has_rc_image_1
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
                                          child: is_has_rc_image_2
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
                        add_press();
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
                          "Add",
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
