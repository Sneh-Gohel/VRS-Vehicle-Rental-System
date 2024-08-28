// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Upload_image {
  static upload(String URL, String responce, File image_path,
      String image_count, bool is_rc_image) async {
    if (is_rc_image == false) {
      try {
        print("upload started...");
        var request = await http.post(
          Uri.parse(URL),
          body: {
            "is_rc_image": "false",
            "vehicle_id": responce,
            "vehicle_image_count": image_count,
            "vehicle_image": base64Encode(image_path.readAsBytesSync())
          },
        );
        String info = (jsonDecode(request.body)).toString();
        print(info);
      } catch (e) {
        print("API error...  " + e.toString());
      }
    } else {
      try {
      print("upload started...");
      var request = await http.post(
        Uri.parse(URL),
        body: {
          "is_rc_image" : "true",
          "vehicle_id": responce,
          "rc_image_count": image_count,
          "rc_image": base64Encode(image_path.readAsBytesSync())
        },  
      );
      String info = (jsonDecode(request.body)).toString();
      print(info);
    } catch (e) {
      print("API error...  " + e.toString());
    }
    }
  }
}
