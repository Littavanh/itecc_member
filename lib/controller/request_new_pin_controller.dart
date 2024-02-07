import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:itecc_member/PIN/otp_pin.dart';
import 'package:itecc_member/model/request_new_pin_model.dart';
import 'package:itecc_member/model/request_payment.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/screen/onLogin/Wallet/complete_payment.dart';

import '../services/todo_services.dart';
import '../style/color.dart';

final box = GetStorage();

class RequestNewPinController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');
  String device_token = box.read('fcmToken') ?? '';
  String os_version = box.read('os_version') ?? '';
  String app_version = box.read('app_version') ?? '';
  RequestNewPin? requestNewPin;

  Future<void> postRequestNewPin({
    required String newPIN,
  }) async {
    try {
      http.Response response =
          await http.post(Uri.tryParse('$url/Account/requestNewPIN')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "userID": userID,
                "tokenKey": tokenKey,
                "deviceToken": device_token,
                "deviceOS": os_version,
                "newPIN": newPIN
              }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          final requestNewPin = RequestNewPin.fromJson(json);
          print('requestNewPin: ${requestNewPin.toJson().toString()}');
          Get.to(OtpPin(),arguments: newPIN);
        } else {
          final requestNewPin = RequestNewPin.fromJson(json);
          Get.showSnackbar(
            GetSnackBar(
              backgroundColor: gra,
              title: 'ແຈ້ງເຕືອນ',
              message: requestNewPin.message,
              icon: Icon(Icons.warning_amber_outlined),
              duration: Duration(seconds: 3),
            ),
          );
          // Get.offAll(ButtomNavigate());
        }
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: gra,
          title: 'ແຈ້ງເຕືອນ',
          message: e.toString(),
          icon: Icon(Icons.warning_amber_outlined),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {}
  }
}
