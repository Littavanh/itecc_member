import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:itecc_member/model/walletTransferPersonal_model.dart';
import '../screen/onLogin/Wallet/cancel_payment.dart';
import '../screen/onLogin/Wallet/complete_transfer.dart';
import '../services/todo_services.dart';
import '../style/color.dart';

final box = GetStorage();

class WalletTransferPersonalController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');

  WalletTransferPersonalModel? walletTransferPersonalModel;

  Future<void> walletTransferPersonal({
    required String transactionCode,
    required String customerId,
    required String transferAmount,
    required String descript,
  }) async {
    try {
      var transactionDateFormat = DateFormat("dd/MM/yyyy");
      var transactionDate = transactionDateFormat.format(DateTime.now());
      var transactionTimeFormat = DateFormat("HH:mm:ss");
      var transactionTime = transactionTimeFormat.format(DateTime.now());
      http.Response response =
          await http.post(Uri.tryParse('$url/Payment/walletTransferPersonal')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "userID": userID,
                "tokenKey": tokenKey,
                "transactionCode": transactionCode,
                "customerId": customerId,
                "transferAmount": transferAmount,
                "descript": descript
              }));
      EasyLoading.instance
        ..displayDuration = const Duration(milliseconds: 2000)
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 60
        ..textColor = dient
        ..indicatorColor = dient
        ..maskColor = dient
        ..backgroundColor = Colors.transparent
        ..boxShadow = []
        ..userInteractions = false
        ..dismissOnTap = false
        ..indicatorType = EasyLoadingIndicatorType.circle;
      EasyLoading.show();
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          print('walletTransferPersonal: ${json}');

          Future.delayed(Duration(seconds: 2), () {
            EasyLoading.dismiss();
            Get.offAll(CompleteTransfer(), arguments: [
              json['toMobileNumber'],
              json['toAccountFulName'],
              json['transferAmount'],
              json['transferCode'],
              transactionDate,
              transactionTime,
            ]);
          });
        } else {
          Future.delayed(Duration(seconds: 2), () {
            EasyLoading.dismiss();
            Get.offAll(CancelPayment(), arguments: [json['message']]);
          });
        }
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {}
  }
}
