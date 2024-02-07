import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/PIN/pin_auth_screen.dart';
import 'package:itecc_member/controller/eye_controller.dart';
import 'package:itecc_member/controller/userInfo_controller.dart';
import 'package:itecc_member/controller/user_balance_info_controller.dart';
import 'package:itecc_member/screen/home_page.dart';
import 'package:itecc_member/screen/onLogin/Setting/about.dart';
import 'package:itecc_member/screen/onLogin/Setting/edit_profile.dart';

import '../../../services/auto_login.dart';
import '../../../style/color.dart';

final box = GetStorage();

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    final EyeController eyeController = Get.put(EyeController());
    UserBalanceInfoController userBalanceInfoController =
        Get.put(UserBalanceInfoController());

    // UserInfoController userInfoController = Get.put(UserInfoController());
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
        title: const Text(
          'ຕັ້ງຄ່າ',
          style: TextStyle(color: primaryColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(children: [
        DrawerHeader(
            decoration: const BoxDecoration(color: primaryColor),
            child: Column(
              children: [
                Row(
                  children: [
                    box.read('userImage') == null || box.read('userImage') == ""
                        ? Icon(Icons.account_circle_outlined,
                            size: 120, color: dient)
                        : CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: box.read('userImage'),
                             fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: 'ລະຫັດ : ',
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                              TextSpan(
                                  text: box.read('userId'),
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: 'ຊື່ຜູ້ໃຊ້ : ',
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                              TextSpan(
                                  text: box.read('fullName'),
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Obx(
                        //   () => userBalanceInfoController.isLoading.value
                        //       ? Text('error')
                        //       : RichText(
                        //           text: TextSpan(
                        //             style: const TextStyle(
                        //               fontSize: 16.0,
                        //               color: Colors.black,
                        //             ),
                        //             children: [
                        //               TextSpan(
                        //                   text: 'ຍອດເງິນ : ',
                        //                   style: const TextStyle(
                        //                       color: textColor,
                        //                       fontFamily: 'NotoSansLao',
                        //                       fontSize: 14)),
                        //               eyeController.pressedBool.isFalse
                        //                   ? TextSpan(
                        //                       text:
                        //                           '${userBalanceInfoController.userBalanceInfo!.personalBalance.toString().replaceAll(userBalanceInfoController.userBalanceInfo!.personalBalance.toString(), '******')} ₭',
                        //                       style: const TextStyle(
                        //                           color: textColor,
                        //                           fontFamily: 'NotoSansLao',
                        //                           fontSize: 14))
                        //                   : TextSpan(
                        //                       text:
                        //                           '${userBalanceInfoController.userBalanceInfo!.personalBalance.toString()} ₭',
                        //                       style: const TextStyle(
                        //                           color: textColor,
                        //                           fontFamily: 'NotoSansLao',
                        //                           fontSize: 14)),
                        //               WidgetSpan(
                        //                   child: SizedBox(
                        //                 width: 10,
                        //               )),
                        //               WidgetSpan(
                        //                 child: InkWell(
                        //                   onTap: () {
                        //                     userBalanceInfoController
                        //                         .fetchUserBalanceInfo();
                        //                   },
                        //                   child: Icon(
                        //                     Icons.refresh_rounded,
                        //                     color: Colors.green,
                        //                     size: 18,
                        //                   ),
                        //                 ),
                        //               ),
                        //               WidgetSpan(
                        //                   child: SizedBox(
                        //                 width: 10,
                        //               )),
                        //               WidgetSpan(
                        //                 child: InkWell(
                        //                   onTap: () {
                        //                     eyeController.changeStatus();
                        //                   },
                        //                   child:
                        //                       eyeController.pressedBool.isFalse
                        //                           ? Icon(
                        //                               Icons.visibility_off,
                        //                               color: Colors.green,
                        //                               size: 18,
                        //                             )
                        //                           : Icon(
                        //                               Icons.visibility,
                        //                               color: Colors.green,
                        //                               size: 18,
                        //                             ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
        ListTile(
          leading: Icon(Icons.account_circle_outlined, color: Colors.black),
          title: const Text(
            "ຂໍ້ມູນສ່ວນຕົວ",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Get.to(EditProfile());
          },
        ),
        ListTile(
          leading: Icon(Icons.lock_outline, color: Colors.black),
          title: const Text(
            "ຕັ້ງຄ່າ PIN",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
           Get.to( PinAuthScreen());
          },
        ),
        ListTile(
          leading: Icon(Icons.fingerprint, color: Colors.black),
          title: const Text(
            "Fingerprint vertification",
            style: TextStyle(color: Colors.black),
          ),
          trailing: Switch(
            value: isSwitched,
            onChanged: (value) {
              // setState(() {
              //   isSwitched=value;
              //   print(isSwitched);
              // });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.info_outline_rounded, color: Colors.black),
          title: const Text(
            "ກ່ຽວກັບ",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Get.to(About());
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_rounded, color: Colors.black),
          title: const Text(
            "ອອກຈາກລະບົບ",
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            Get.defaultDialog(
              middleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: textColor),
              title: 'ອອກຈາກລະບົບ',
              middleText: 'ທາ່ນຕ້ອງການອອກຈາກລະບົບແທ້ຫຼືບໍ່?',
              cancel: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    'ຍົກເລີກ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
              confirm: ElevatedButton(
                onPressed: () {
                  box.remove('userId');
                  box.remove('userName');
                  box.remove('tokenKey');
                  box.remove('userImage');
                  box.remove('firstName');
                  box.remove('lastName');
                  box.remove('fullName');
                  box.remove('mobileNumber');
                  box.remove('updateProfile');
                  box.remove('staffWalet');
                  box.remove('personalWalet');

                  final remember =
                      AutoLogin(tokenKey: '', rememberMe: false);
                  remember.setUser();

                  Get.offAll(HomePage());
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
                      'ອອກຈາກລະບົບ',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
