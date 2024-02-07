import 'package:flutter/material.dart';
import 'package:itecc_member/style/color.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRImage extends StatelessWidget {
  QRImage(this.userId, {super.key});

  String userId;

  @override
  Widget build(BuildContext context) {
    var text = "$userId";
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrettyQrView.data(errorCorrectLevel: QrErrorCorrectLevel.H,
                data: text,
                decoration: const PrettyQrDecoration(
                  image: PrettyQrDecorationImage(
                      image: AssetImage('assets/images/logo Member1.png'),
                      position: PrettyQrDecorationImagePosition.embedded),
                  shape: PrettyQrSmoothSymbol(
                    color: icolor,
                  ),
                ),
              ),
              // Text(
              //   "$userId",
              //   style: TextStyle(color: textColor),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
