import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:itecc_member/model/request_payment.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/screen/onLogin/Wallet/complete_payment.dart';

import '../services/todo_services.dart';
import '../style/color.dart';

final box = GetStorage();

class RequestPaymentStaffController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');

  RequestPaymentStaff? requestPaymentStaff;

  Future<void> postRequestPaymentStaff(
      {required String shopCode,
      required String requestAmount,
      required String descript,required String paymentCode}) async {
    // var transactionNoFormat = DateFormat('yyMMddHHmmss');
    // var transactionNo = transactionNoFormat.format(DateTime.now());
    // var transactionCode = transactionNo + userID;

    var transactionDateFormat = DateFormat("dd/MM/yyyy");
    var transactionDate = transactionDateFormat.format(DateTime.now());
    var transactionTimeFormat = DateFormat("HH:mm:ss");
    var transactionTime = transactionTimeFormat.format(DateTime.now());
    // try {
      http.Response response =
          await http.post(Uri.tryParse('$url/Payment/requestPaymentStaff')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "userID": userID,
                "tokenKey": tokenKey,
                "transactionCode": paymentCode,
                "shopCode": shopCode,
                "requestAmount": requestAmount,
                "descript": descript
              }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);
         

        if (json['statusCode'] == 200) {
          final requestPaymentStaff = RequestPaymentStaff.fromJson(json);
          print(
              'requestPaymentStaff: ${requestPaymentStaff.toJson().toString()}');

          // Get.to(InputAmount(), arguments: [shop.shopCode, shop.shopName]);

          Get.offAll(CompletePayment(), arguments: [
            requestPaymentStaff.shopCode,
            requestPaymentStaff.shopName,
            requestPaymentStaff.requestAmount,
            requestPaymentStaff.paymentCode,
            descript,
            transactionDate,
            transactionTime
            
          ]);
        } else {
          final requestPaymentStaff = RequestPaymentStaff.fromJson(json);
          print(
              'requestPaymentStaff: ${requestPaymentStaff.toJson().toString()}');
          Get.showSnackbar(
            GetSnackBar(
              backgroundColor: gra,
              title: 'ແຈ້ງເຕືອນ',
              message: json['message'],
              icon: Icon(Icons.warning_amber_outlined),
              duration: Duration(seconds: 3),
            ),
          );
          // Get.offAll(ButtomNavigate());
        }
      } else {
        print('error fetching data');
      }
    // } catch (e) {
    //   print('Error while getting data is $e');
    //   // Get.showSnackbar(
    //   //   GetSnackBar(
    //   //     backgroundColor: gra,
    //   //     title: 'ແຈ້ງເຕືອນ',
    //   //     message: e.toString(),
    //   //     icon: Icon(Icons.warning_amber_outlined),
    //   //     duration: Duration(seconds: 3),
    //   //   ),
    //   // );
    // } 
    // finally {

    // }
  }
}
