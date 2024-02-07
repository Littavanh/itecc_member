import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:itecc_member/PIN/otp_pin.dart';
import 'package:itecc_member/controller/request_payment_staff.dart';
import 'package:itecc_member/model/check_pin_model.dart';
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

class CheckPinController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');

  CheckpinModel? checkpinModel;
  RequestPaymentStaffController requestPaymentStaffController =
      Get.put(RequestPaymentStaffController());
  Future<void> postCheckPin({
    required String pinNumber,
    required String shopCode,
    required String amount,
    required String shopName,
  }) async {
    try {
      http.Response response = await http.post(
          Uri.tryParse('$url/Payment/check_PIN')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "userID": userID,
            "tokenKey": tokenKey,
            "pinNumber": pinNumber
          }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);

        if (json['statusCode'] == 200) {
          final checkpinModel = CheckpinModel.fromJson(json);
          print('checkpin: ${checkpinModel.toJson().toString()}');
          Get.defaultDialog(
            title: 'ທາ່ນຕ້ອງການຊຳລະເງິນແທ້ຫຼືບໍ່',
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            content: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                  "ຊຳລະໃຫ້ : $shopName",
                  style: TextStyle(fontSize: 14, color: textColor),
                )),
                Container(
                    child: Text(
                  "ຈຳນວນເງິນ : $amount ກີບ",
                  style: TextStyle(fontSize: 14, color: textColor),
                )),
              ],
            ),
            // textCancel: 'ຍົກເລີກ',
            // textConfirm: 'ຢືນຢັນ',
            // cancelTextColor: errorColor,
            // confirmTextColor: Colors.white,
            // buttonColor: dient,
            // onConfirm: () {
            //   requestPaymentStaffController.postRequestPaymentStaff(
            //       shopCode: shopCode,
            //       requestAmount: amount,
            //       descript: "pay",
            //       paymentCode: checkpinModel.paymentCode.toString());
            // },
            // onCancel: () {
            //   Get.back();
            //   Get.back();
            // },
            cancel: TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: Text(
                  'ຍົກເລີກ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
            confirm: ElevatedButton(
              onPressed: () {
                requestPaymentStaffController.postRequestPaymentStaff(
                    shopCode: shopCode,
                    requestAmount: amount,
                    descript: "pay",
                    paymentCode: checkpinModel.paymentCode.toString());
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [gra, dient]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: 300,
                  height: 100,
                  alignment: Alignment.center,
                  child: const Text(
                    'ຢືນຢັນ',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
              ),
            ),
          );
        } else {
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
