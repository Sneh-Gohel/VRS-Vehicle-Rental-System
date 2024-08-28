// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'Home_account_screen.dart';

class Qr_code_scanner extends StatefulWidget {
  const Qr_code_scanner({super.key});

  @override
  State<StatefulWidget> createState() => _Qr_code_scanner();
}

camera_permission() async {
  // await Permission.camera.request();
}

class _Qr_code_scanner extends State<Qr_code_scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  String result = '';

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
      controller.pauseCamera();
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('QR Code Result'),
          content: Text(result),
          actions: [
            ElevatedButton(
              onPressed: () {
                controller.resumeCamera();
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ).then((value) => controller.resumeCamera());
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    camera_permission();
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
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
