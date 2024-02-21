import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/model/scan_qr_code_shop.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:itecc_member/model/updateUser_model.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/screen/onLogin/Wallet/input_amount_personal.dart';

import '../screen/onLogin/Wallet/input_amount.dart';
import '../services/todo_services.dart';
import '../style/color.dart';

final box = GetStorage();

class ScanQrCodeShopPersonalController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');

  ScanQrCodeShop? scanQrCodeShop;

  Future<void> scanQRcodeShop({required String shopCode}) async {
    try {
      http.Response response = await http.post(
          Uri.tryParse('$url/Payment/scanQRcodeShop')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"userID": userID, "tokenKey": tokenKey, "shopCode": shopCode}));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          final shop = ScanQrCodeShop.fromJson(json);
          print('scanQRcodeShop: ${shop.toJson().toString()}');
          Get.back();
          Get.to(InputAmountPersonal(), arguments: [shop.shopCode, shop.shopName]);
          // Get.offAll(ButtomNavigate());
        } else {
          // Get.showSnackbar(
          //   GetSnackBar(
          //     backgroundColor: gra,
          //     title: 'ແຈ້ງເຕືອນ',
          //     message: json['message'],
          //     icon: Icon(Icons.warning_amber_outlined),
          //     duration: Duration(seconds: 5),
          //   ),
          // );
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
