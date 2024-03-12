

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/screen/onLogin/Wallet/qr_code_scanner.dart';
import '../../../controller/eye_controller.dart';
import '../../../controller/user_balance_info_controller.dart';
import '../../../services/todo_services.dart';
import '../../../style/color.dart';


final box = GetStorage();

class MyWalletStaff extends StatefulWidget {
  const MyWalletStaff({super.key});

  @override
  State<MyWalletStaff> createState() => _MyWalletStaffState();
}

class _MyWalletStaffState extends State<MyWalletStaff> {
  UserBalanceInfoController userBalanceInfoController =
      Get.put(UserBalanceInfoController());
  Future<void> refreshBalance() async {
    await userBalanceInfoController.fetchUserBalanceInfo();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    final EyeController eyeController = Get.put(EyeController());

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
          'ກະເປົາພະນັກງານ',
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
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => userBalanceInfoController.isLoading.value
                            ? Text('error')
                            : RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: 'ຍອດເງິນ : ',
                                        style: const TextStyle(
                                            color: textColor,
                                            fontFamily: 'NotoSansLao',
                                            fontSize: 14)),
                                    eyeController.pressedBool.isFalse
                                        ? TextSpan(
                                            text:
                                                '${userBalanceInfoController.userBalanceInfo!.staffBalance.toString().replaceAll(userBalanceInfoController.userBalanceInfo!.staffBalance.toString(), '******')} ₭',
                                            style: const TextStyle(
                                                color: textColor,
                                                fontFamily: 'NotoSansLao',
                                                fontSize: 14))
                                        : TextSpan(
                                            text:
                                                '${fm.format(userBalanceInfoController.userBalanceInfo!.staffBalance)} ₭',
                                            style: const TextStyle(
                                                color: textColor,
                                                fontFamily: 'NotoSansLao',
                                                fontSize: 14)),
                                    WidgetSpan(
                                        child: SizedBox(
                                      width: 10,
                                    )),
                                    WidgetSpan(
                                      child: InkWell(
                                        onTap: () {
                                          userBalanceInfoController
                                              .fetchUserBalanceInfo();
                                        },
                                        child: Icon(
                                          Icons.refresh_rounded,
                                          color: Colors.green,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    WidgetSpan(
                                        child: SizedBox(
                                      width: 10,
                                    )),
                                    WidgetSpan(
                                      child: InkWell(
                                        onTap: () {
                                          eyeController.changeStatus();
                                        },
                                        child: eyeController.pressedBool.isFalse
                                            ? Icon(
                                                Icons.visibility_off,
                                                color: Colors.green,
                                                size: 18,
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                color: Colors.green,
                                                size: 18,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
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
                  crossAxisCount: 3),
              children: [
                InkWell(
                  onTap: () {
                    Get.to(QrCodeScanner());
                  },
                  focusColor: icolor,
                  borderRadius: BorderRadius.circular(10),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.center_focus_weak_outlined,
                        size: 80,
                        color: dient,
                      ),
                      Text("ສະແກນເພື່ອຈ່າຍ",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: textColor))
                    ],
                  ),
                ),
              ]),
        )
      ]),
    );
  }
}
