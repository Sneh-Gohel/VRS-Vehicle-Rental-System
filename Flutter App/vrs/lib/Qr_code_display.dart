// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Home_account_screen.dart';

class Qr_code_display extends StatefulWidget {
  const Qr_code_display({super.key});

  @override
  State<StatefulWidget> createState() => _Qr_code_display();
}

class _Qr_code_display extends State<Qr_code_display> {
  // QrImage qrImage = QrImage(data:"Hello");
  // QrImage qrImage = QrImage(
  //   data: data,
  //   size: 200.0,
  // );

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
                child: const CircleAvatar(
                  radius: 20.0,
                  // backgroundImage: AssetImage("pictures/Landing page image.png"),
                  backgroundColor: Colors.white,
                  child: Text("A",
                      style: TextStyle(color: Colors.blue, fontSize: 25.0)),
                  // child: Image.asset('pictures/Landing page image.png'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home_account_screen("", ""),
                    ),
                  );
                },
              )
              // child: Image.asset("pictures/Landing page image.png"),
              ),
        ],
      ),
      body: Center(
        // child: QrImage(
        //   data: "Hello",
        //   version: QrVersions.auto,
        //   size: 200.0,
        // ),
      ),
    );
  }
}
