import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/screen/onLogin/Wallet/my_wallet.dart';

import '../../../component/component.dart';
import '../../../controller/user_balance_info_controller.dart';
import '../../../style/color.dart';
import '../../../style/textstyle.dart';
import 'My_wallet_staff.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

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
          'ກະເປົາຂອງຂ້ອຍ',
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
                      ? const Icon(Icons.account_circle_outlined,
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
                  const SizedBox(
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
                            const TextSpan(
                                text: 'ລະຫັດ : ',
                                style: TextStyle(
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
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(
                                text: 'ຊື່ຜູ້ໃຊ້ : ',
                                style: TextStyle(
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
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              children: [
                box.read('staffWalet') == "1"
                    ? Component(
                        child: InkWell(
                          onTap: () {
                            Get.to(MyWalletStaff());
                          },
                          focusColor: icolor,
                          borderRadius: BorderRadius.circular(10),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_rounded,
                                size: 100,
                                color: dient,
                              ),
                              Text("ກະເປົາພະນັງງານ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: textColor))
                            ],
                          ),
                        ),
                      )
                    : Container(),
                box.read('personalWalet') == "1"
                    ? Component(
                        child: InkWell(
                          onTap: () {
                            Get.to(MyWallet());
                          },
                          focusColor: icolor,
                          borderRadius: BorderRadius.circular(10),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_rounded,
                                size: 100,
                                color: Colors.orange,
                              ),
                              Text("ກະເປົາສ່ວນຕົວ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: textColor))
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ]),
        )
      ]),
    );
  }
}
