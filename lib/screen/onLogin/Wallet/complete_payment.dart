import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:itecc_member/screen/onLogin/buttom_navigate.dart';
import 'package:itecc_member/screen/onLogin/buttom_navigate_to_wallet.dart';
import 'package:itecc_member/style/color.dart';
import 'package:itecc_member/style/textstyle.dart';

import 'package:lottie/lottie.dart';

import '../../../services/water_mark.dart';

final box = GetStorage();

class CompletePayment extends StatefulWidget {
  const CompletePayment({super.key});

  @override
  State<CompletePayment> createState() => _CompletePaymentState();
}

class _CompletePaymentState extends State<CompletePayment>
    with TickerProviderStateMixin {
  late AnimationController tickController;

  @override
  void initState() {
    super.initState();

    tickController = AnimationController(vsync: this);
    // tickController.reset();
    // tickController.forward();
  }

  @override
  void dispose() {
    tickController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var argumentsData = Get.arguments;
    var shopCode = argumentsData[0];
    var shopName = argumentsData[1];
    var requestAmount = argumentsData[2];
    var paymentCode = argumentsData[3];
    // var descript = argumentsData[4];
    var transactionDate = argumentsData[5];
    var transactionTime = argumentsData[6];

    var userId = box.read('userId');
    var fullName = box.read('fullName');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 12,
            child: SizedBox(
              // color: Colors.black54,
              width: Get.width,
              height: Get.height,
              child: Stack(children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.only(top: 60),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.green.withOpacity(0.5), //color of shadow
                          spreadRadius: 3, //spread radius
                          blurRadius: 2, // blur radius
                          offset:
                              const Offset(0, 1), // changes position of shadow
                          //first paramerter of offset is left-right
                          //second parameter is top to down
                        ),
                        //you can set more BoxShadow() here
                      ],
                      color: primaryColor,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(50))),
                  child: Stack(
                    children: [
                      Watarmark(
                        rowCount: 1,
                        columnCount: 22,
                        text: paymentCode +
                            userId +
                            fullName +
                            shopCode +
                            shopName +
                            transactionTime +
                            transactionDate,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, left: 12, right: 12),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    transactionDate,
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14),
                                  ),
                                  Text(
                                    transactionTime,
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'ຈາກບັນຊີ: ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                                Text(
                                  fullName,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_rounded,
                                  size: 100,
                                  color: dient,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ລະຫັດ: $userId',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'ຊື່ຜູ້ໃຊ້: $fullName',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'ຫາບັນຊີ: ',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                                Text(
                                  shopName,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_rounded,
                                  size: 100,
                                  color: icolor1,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ລະຫັດ: $shopCode',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'ຊື່ຜູ້ໃຊ້: $shopName',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ຈຳນວນເງິນ',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                    Text(
                                      "$requestAmount LAK",
                                      style: TextStyle(
                                          color: errorColor, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Divider(),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           'ຄໍາອະທິບາຍ',
                            //           style: TextStyle(
                            //               color: Colors.black87, fontSize: 14),
                            //         ),
                            //         Text(
                            //           descript,
                            //           style: TextStyle(
                            //               color: Colors.black87, fontSize: 14),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ເລກໃບບິນ',
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                    Text(
                                      paymentCode,
                                      style: TextStyle(
                                          color: Colors.black87, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Lottie.asset('assets/images/tick.json',
                        onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      tickController
                        ..duration = composition.duration
                        ..forward();
                    }, controller: tickController),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.offAll(ButtomNavigateToWallet());
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [gra, dient]),
                ),
                width: Get.width,
                alignment: Alignment.center,
                child: const Text(
                  'ສຳເລັດແລ້ວ',
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
