import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:itecc_member/style/color.dart';
import 'package:perfect_scanner/perfect_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../controller/scan_qrcode_shop_personal.dart';

class QrCodeScannerPersonal extends StatefulWidget {
  const QrCodeScannerPersonal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrCodeScannerPersonalState();
}

class _QrCodeScannerPersonalState extends State<QrCodeScannerPersonal> {
  ScanQrCodeShopPersonalController scanQrCodeShopController =
      Get.put(ScanQrCodeShopPersonalController());

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isFlashOn = false;
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
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
        body: Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
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
                  await controller?.toggleFlash();

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

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: icolor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  int counter = 0;
  void _onQRViewCreated(QRViewController controller) {
    Barcode? result;
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      counter++;

      if (counter == 1) {
        setState(() {
          result = scanData;
          var value = result!.code;
          print(value);

          scanQrCodeShopController.scanQRcodeShop(shopCode: value.toString());
        });
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('no Permission', style: TextStyle(color: textColor))),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
