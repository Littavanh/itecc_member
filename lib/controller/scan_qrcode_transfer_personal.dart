import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/model/scan_qr_code_shop.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:itecc_member/model/updateUser_model.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/screen/onLogin/Wallet/input_amount_personal.dart';
import 'package:itecc_member/screen/onLogin/Wallet/input_transfer_personal_amount.dart';

import '../screen/onLogin/Wallet/input_amount.dart';
import '../services/todo_services.dart';
import '../style/color.dart';

final box = GetStorage();

class ScanQrCodeTransferPersonalController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');

  Future<void> scanQRcode({required String mobileNumber}) async {
    try {
      http.Response response = await http.post(
          Uri.tryParse('$url/Account/customerInfo')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userID": userID,
            "tokenKey": tokenKey,
            "mobileNumber": mobileNumber
          }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          print('customerInfo: ${json}');
          print('customerInfo: ${json['cusID']}');
          Get.back();
          Get.to(InputTransferPersonalAmount(), arguments: [
            json['cusID'],
            json['mobileNumber'],
            json['firstName'],
            json['lastName']
          ]);
        } else {
          Get.defaultDialog(
              title: "ແຈ້ງເຕືອນ",
              middleText: json['message'],
              backgroundColor: Colors.white,
              titleStyle: TextStyle(color: textColor),
              middleTextStyle: TextStyle(color: textColor),
              radius: 30);
          // Get.offAll(ButtomNavigate());
        }
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {}
  }
}
