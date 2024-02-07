import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../../style/color.dart';

final box = GetStorage();

class MyQrCode extends StatefulWidget {
  const MyQrCode({super.key});

  @override
  State<MyQrCode> createState() => _MyQrCodeState();
}

class _MyQrCodeState extends State<MyQrCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [gra, dient],
            ),
          ),
        ),
        title: const Text(
          'Qr ຂອງຂ້ອຍ',
          style: TextStyle(color: primaryColor),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () async {}, icon: Icon(Icons.download_outlined))
        // ],
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [gra, dient],
          ),
        ),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: box.read('userImage') == null || box.read('userImage') == ""
                ? const Icon(Icons.account_circle_outlined,
                    size: 120, color: primaryColor)
                : SizedBox(
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: MemoryImage(
                        scale: 1,
                        Base64Decoder().convert(box.read('userImage')),
                      ),
                    ),
                  ),
          ),
          box.read('fullName') == null
              ? Text(
                  'UserName',
                  style: TextStyle(color: primaryColor),
                )
              : Text(
                  box.read('fullName'),
                  style: TextStyle(color: primaryColor),
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: Get.width,
              height: Get.height * 0.55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: primaryColor),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'QR Code',
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 10, color: gra)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PrettyQrView.data(
                            errorCorrectLevel: QrErrorCorrectLevel.H,
                            data: box.read('userId'),
                            decoration: const PrettyQrDecoration(
                              image: PrettyQrDecorationImage(
                                  image: AssetImage(
                                      'assets/images/logo Member1.png'),
                                  position:
                                      PrettyQrDecorationImagePosition.embedded),
                              shape: PrettyQrSmoothSymbol(
                                color: icolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
