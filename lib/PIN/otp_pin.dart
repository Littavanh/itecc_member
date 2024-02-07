import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/controller/save_new_pin_controller.dart';
import 'package:pinput/pinput.dart';

import '../style/color.dart';
final box = GetStorage();
class OtpPin extends StatefulWidget {
  const OtpPin({super.key});

  @override
  State<OtpPin> createState() => _OtpPinState();
}

class _OtpPinState extends State<OtpPin> {
  var pin = Get.arguments;
   String? otpCode;
  final _otpController = TextEditingController();
  String emptyUsername = "";
  SaveNewPinController saveNewPinController = Get.put(SaveNewPinController());
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
          'ປ້ອນລະຫັດ OTP',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
                image: AssetImage("assets/images/Sign in.png"),
                fit: BoxFit.fill,
              )
              // gradient: LinearGradient(
              //     colors: [Colors.red, Colors.white],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     stops: [0.5, 1]),
              ),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.asset("assets/images/Logo.png", height: 150),
              ),
              _buildForm()
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        child: Column(children: [
          Text(
            "ປ້ອນລະຫັດ OTP",
            style: TextStyle(fontSize: 32, color: textColor),
          ),
          Text(
            "ລະຫັດຖືກສົ່ງໄປເບີ ${box.read('userName')}",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Pinput(
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: dient,
                  ),
                ),
                textStyle: const TextStyle(color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onCompleted: (value) {
                setState(() {
                  otpCode = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: ElevatedButton(
              onPressed: () {
                if (otpCode != '') {
                  print(otpCode);

                saveNewPinController.postSaveNewPin(otp: otpCode!, newPIN: pin);

                
                } else {
                  emptyUsername = _otpController.text.isEmpty
                      ? "ກະລຸນາປ້ອນລະຫັດ otp..."
                      : emptyUsername = "";

                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [gra, dient]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: 300,
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text(
                    'ສົ່ງ OTP',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
