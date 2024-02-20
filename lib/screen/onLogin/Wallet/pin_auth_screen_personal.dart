import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itecc_member/PIN/otp_pin.dart';
import 'package:itecc_member/model/request_new_pin_model.dart';
import 'package:itecc_member/style/color.dart';


import '../../../controller/check_pin_personal_controller.dart';
import 'pin_code_field.dart';

class PinAuthScreenPersonal extends StatefulWidget {
  const PinAuthScreenPersonal({super.key});

  @override
  State<PinAuthScreenPersonal> createState() => _PinAuthScreenPersonalState();
}

class _PinAuthScreenPersonalState extends State<PinAuthScreenPersonal> {
  String pin = "";
  PinTheme pinTheme = PinTheme(
    keysColor: Colors.black,
  );
  @override
  CheckPinPersonalController checkPinPersonalController = Get.put(CheckPinPersonalController());
  Widget build(BuildContext context) {
    var argumentsData = Get.arguments;
    var shopCode = argumentsData[0];
    var amount = argumentsData[1];
    var shopName = argumentsData[2];

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
          'Enter PIN',
          style: const TextStyle(color: primaryColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Please enter your pin to continue",
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: textColor),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  PinCodeField(
                    key: Key('pinField$i'),
                    pin: pin,
                    pinCodeFieldIndex: i,
                    theme: pinTheme,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            CustomKeyBoard(
              pinTheme: pinTheme,
              onChanged: (v) {
                print('Pin:$v');
                pin = v;
                setState(() {});
              },
              specialKey: Icon(
                Icons.fingerprint,
                key: const Key('fingerprint'),
                color: pinTheme.keysColor,
                size: 50,
              ),
              specialKeyOnTap: () {
                print('fingerprint');
              },
              maxLength: 4,
              onCompleted: (p0) {
                print(p0);
             

                checkPinPersonalController.postCheckPin(pinNumber: p0,shopCode: shopCode,amount: amount,shopName:shopName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
