import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../../../style/color.dart';
import 'package:lottie/lottie.dart';

import '../buttom_navigate_to_wallet.dart';

class CancelPayment extends StatefulWidget {
  const CancelPayment({super.key});

  @override
  State<CancelPayment> createState() => _CancelPaymentState();
}

final box = GetStorage();

class _CancelPaymentState extends State<CancelPayment>
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

  Widget build(BuildContext context) {
    var argumentsData = Get.arguments;
    var message = argumentsData[0];

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ແຈ້ງເຕືອນ',
              style: TextStyle(color: primaryColor),
            ),
            Icon(Icons.warning_amber_outlined),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: 150,
                height: 150,
                child: Lottie.asset('assets/images/warning.json',
                    onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  tickController
                    ..duration = composition.duration
                    ..forward();
                }, controller: tickController),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  message.toString(),
                  style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
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
                    'ຕົກລົງ',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
