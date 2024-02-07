import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/model/updateUser_model.dart';
import 'package:itecc_member/screen/onLogin/home/home_main.dart';
import 'package:http/http.dart' as http;

import '../screen/onLogin/buttom_navigate.dart';
import '../services/todo_services.dart';
import '../style/color.dart';

final box = GetStorage();

class UpdateUserController extends GetxController {
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');
  UpdateUserModel? updateUser;

  Future<void> postUpdateUser(
      {required String userName,
      required String firstName,
      required String lastName,
      required String dob,
      required String gender,
      required String emailAddr,
      required String villageCode,
      required String userImage,
      required String userImageExtention}) async {
   

    try {
      http.Response response =
          await http.post(Uri.tryParse('$url/Account/updateUser')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "userID": int.parse(userID),
                "tokenKey": tokenKey,
                "userName": userName,
                "firstName": firstName,
                "lastName": lastName,
                "dob": dob,
                "gender": gender,
                "emailAddr": emailAddr,
                "villageCode": villageCode,
                "userImage": userImage,
                "userImageExtention": userImageExtention
              }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);

        print(json);
        if (json['statusCode'] == 200) {
          final updateUser = UpdateUserModel.fromJson(json);
          print('responseData: ${updateUser.toJson().toString()}');



          // Get.offAll(ButtomNavigate());
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              backgroundColor: gra,
              title: 'ແຈ້ງເຕືອນ',
              message: 'ຜິດພາດ',
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
    } finally {}
  }
}
