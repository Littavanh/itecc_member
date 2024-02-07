import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:itecc_member/PIN/otp_pin.dart';
import 'package:itecc_member/model/request_new_pin_model.dart';
import 'package:itecc_member/model/request_payment.dart';

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/model/save_new_pin_model.dart';
import 'package:itecc_member/screen/onLogin/Wallet/complete_payment.dart';

import '../screen/onLogin/buttom_navigate.dart';
import '../services/todo_services.dart';
import '../style/color.dart';

final box = GetStorage();

class SaveNewPinController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');

  SaveNewPin? saveNewPin;

  Future<void> postSaveNewPin({
    required String otp,
    required String newPIN,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.tryParse('$url/Account/saveNewPIN')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userID": userID,
            "tokenKey": tokenKey,
            "otp": otp,
            "newPIN": newPIN
          }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          final saveNewPin = SaveNewPin.fromJson(json);
          print('saveNewPin: ${saveNewPin.toJson().toString()}');
          Get.showSnackbar(
            GetSnackBar(
              backgroundColor: gra,
              title: 'ສຳເລັດ',
              message: saveNewPin.message,
              icon: Icon(Icons.warning_amber_outlined),
              duration: Duration(seconds: 3),
            ),
          );
         Get.offAll(
              ButtomNavigate(),
            );
        } else {
          Get.showSnackbar(
            GetSnackBar(
              backgroundColor: gra,
              title: 'ແຈ້ງເຕືອນ',
              message: saveNewPin!.message,
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
