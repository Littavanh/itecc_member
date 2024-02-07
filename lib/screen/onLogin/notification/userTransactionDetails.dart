import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/todo_services.dart';
import '../../../style/color.dart';
import 'package:lottie/lottie.dart';

class UserTransactionDetails extends StatefulWidget {
  const UserTransactionDetails({super.key});

  @override
  State<UserTransactionDetails> createState() => _UserTransactionDetailsState();
}

class _UserTransactionDetailsState extends State<UserTransactionDetails>
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
    var value = Get.arguments;
    var tran_id = value[0];
    var tran_date = value[1];
    var tran_title = value[2];
    var tran_amount = value[3];
    var tran_shopName = value[4];
    var tran_detail = value[5];
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
          'ລາຍລະອຽດ',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Lottie.asset('assets/images/tick.json',
                      onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    tickController
                      ..duration = composition.duration
                      ..forward();
                  }, controller: tickController),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
               
                children: [
                  Text(
                    tran_title,
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                  Flexible(
                    child: Text(
                       tran_detail,
                      style: TextStyle(color: Colors.black45, fontSize: 14),textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'ວັນທີ: $tran_date',
                    style: TextStyle(color: Colors.black45, fontSize: 14),
                  ),
                  if(tran_title == 'Payment')
                       Text(
                          'ຈຳນວນ : - ${fm.format(double.parse(tran_amount ?? ''))} LAK',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: errorColor,
                              fontSize: 14),
                        ),
                         if(tran_title == 'Refund')
                       Text(
                          'ຈຳນວນ :  ${fm.format(double.parse(tran_amount ?? ''))} LAK',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: errorColor,
                              fontSize: 14),
                        ),
                     if(tran_title == 'TOP-UP')   Text(
                          'ຈຳນວນ : + ${fm.format(double.parse(tran_amount ?? ''))} LAK',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 14),
                        ),
                ],
              ),
            ),
          ),
          flex: 4,
        )
      ]),
    );
  }
}
