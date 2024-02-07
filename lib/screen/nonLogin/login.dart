import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itecc_member/controller/requstOTP_controller.dart';
import 'package:itecc_member/screen/nonLogin/otp.dart';
import 'package:itecc_member/services/todo_services.dart';

import '../../component/customcontainer.dart';
import '../../style/color.dart';
import '../../style/size.dart';

class MyAcoount extends StatefulWidget {
  const MyAcoount({super.key});

  @override
  State<MyAcoount> createState() => _MyAcoountState();
}

class _MyAcoountState extends State<MyAcoount> {
  final _userController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  RequstOTPController requstOTPController = Get.put(RequstOTPController());
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
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(
        //       Icons.language_outlined,
        //       color: primaryColor,
        //     ),
        //     tooltip: 'ປ່ຽນພາສາ',
        //     onPressed: () {
        //       // handle the press
        //       Get.updateLocale(const Locale("en", "US"));
        //     },
        //   ),
        // ],
        centerTitle: true,
        title: Text(
          'ເຂົ້າສູ່ລະບົບ'.tr,
          style: const TextStyle(color: primaryColor),
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.asset("assets/images/Logo.png", height: 150),
            ),
            _buildForm()
          ]),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(children: [
          Text(
            "ເຂົ້າສູ່ລະບົບ".tr,
            style: const TextStyle(fontSize: 32, color: textColor),
          ),
          const Text(
            "ກະລຸນາປ້ອນເບີມືຖືຂອງທ່ານ ເພື່ອເຂົ້າໃຊ້ງານ",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.black),
              controller: _userController,
              validator: (value) {
                if (value!.isEmpty) {
                  // Get.showSnackbar(
                  //   const GetSnackBar(
                  //     backgroundColor: gra,
                  //     title: 'ແຈ້ງເຕືອນ',
                  //     message: 'ກະລຸນາປ້ອນເບີໂທຂອງທ່ານ',
                  //     icon: Icon(Icons.warning_amber_outlined),
                  //     duration: Duration(seconds: 3),
                  //   ),
                  // );
                  return 'ກະລຸນາປ້ອນເບີໂທຂອງທ່ານ';
                } else if (value.length < 10) {
                  return 'ຮູບແບບຂອງເບີໂທ 20XXXXXXXX';
                } else if (value.length > 10) {
                  return 'ຮູບແບບຂອງເບີໂທ 20XXXXXXXX';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: "20XXXXXXXX",
                  prefixIcon: Icon(
                    Icons.phone,
                    size: iconSize,
                  )),
              // onChanged: (text) => _userController.text.isNotEmpty
              //     ? setState(() => emptyUsername = "")
              //     : null
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 60),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  //check if form data are valid,
                  // your process task ahed if all data are valid

                  print(_userController.text);

                  requstOTPController.requestOTP(
                      publickey: publickey,
                      mobileNumber: _userController.text,
                      device_token: '',
                      os_version: '');
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
