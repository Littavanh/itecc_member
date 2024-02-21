import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itecc_member/controller/scan_qrcode_shop_personal.dart';
import 'package:itecc_member/style/color.dart';
import 'package:perfect_scanner/perfect_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controller/scan_qrcode_shop.dart';

class CamViewPersonal extends StatefulWidget {
  const CamViewPersonal({super.key});

  @override
  State<CamViewPersonal> createState() => _CamViewPersonalState();
}

class _CamViewPersonalState extends State<CamViewPersonal> {
  bool isFlashOn = false;
  ScanQrCodeShopPersonalController scanQrCodeShopController =
      Get.put(ScanQrCodeShopPersonalController());
  @override
  void initState() {
    permissionHandler();
    super.initState();
  }

  permissionHandler() async {
    Permission status = Permission.camera;
    await status.request();
  }

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
        centerTitle: true,
        title: Text(
          'ສະແກນ QR Code',
          style: TextStyle(color: primaryColor),
        ),
      ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ScannerView(
            qrOverlay: QrOverlay(
              borderColor: dient,
              borderWidth: 15,
              borderRadius: 10,
              cutOutSize: 300,
            ),
            onScan: (image) {
              if (image.isNotEmpty) {
                scanQrCodeShopController.scanQRcodeShop(shopCode: image);
              }
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 32, right: 32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () async {
                  final image = await ScannerController.getQrFromImage();
                  debugPrint(image);
                  if (image.isNotEmpty) {
                    scanQrCodeShopController.scanQRcodeShop(shopCode: image);
                  }
                },
                child: Icon(
                  Icons.image,
                  size: 30,
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  ScannerController.resumeScanning();
                  isFlashOn = await ScannerController.toggleFlash();
                  setState(() {});
                },
                child: Icon(
                  isFlashOn ? Icons.flashlight_off : Icons.flashlight_on,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
        ));
  }
}
