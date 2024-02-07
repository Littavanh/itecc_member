import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itecc_member/controller/scan_qrcode_shop.dart';
import 'package:itecc_member/screen/onLogin/Wallet/input_amount.dart';
import 'package:itecc_member/style/color.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrcode extends StatefulWidget {
  const ScanQrcode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQrcodeState();
}

ScanQrCodeShopController scanQrCodeShopController =
    Get.put(ScanQrCodeShopController());

class _ScanQrcodeState extends State<ScanQrcode> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
          'ສະແກນ',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
         
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
     
        },
        child: Icon(
          Icons.image_outlined,
          size: 30,
        ),
        backgroundColor: dient,
      ),
    );
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
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      counter++;

      if (counter == 1) {
        setState(() {
          result = scanData;
          var value = result!.code;
          print(result!.code);

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
