import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/controller/address_controller.dart';
import 'package:itecc_member/model/userInfo_model.dart';
import 'package:http/http.dart' as http;

import '../services/todo_services.dart';

class UserInfoController extends GetxController {
  var isLoading = false.obs;
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthDayController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  var province;
  var district;
  var village;
  var villageCode;

  UserInfoModel? userInfo;
  final box = GetStorage();

  var gropRadioVal = "M".obs;

  void setGroupValue(var group) {
    gropRadioVal.value = group;
    print('select : ${gropRadioVal.value}');
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    fetchUserInfo();
  }

  fetchUserInfo() async {
    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/Account/userInfo')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);

        userInfo = UserInfoModel.fromJson(result);
        userNameController.text = userInfo!.data![0].userName!;
        firstNameController.text = userInfo!.data![0].firstName!;
        lastNameController.text = userInfo!.data![0].lastName!;
        emailController.text = userInfo!.data![0].emailAddr!;
        phoneController.text = userInfo!.data![0].userName!;
        birthDayController.text = userInfo!.data![0].dob!;
        province = userInfo!.data![0].province!;
        district = userInfo!.data![0].district!;
        village = userInfo!.data![0].village!;
        villageCode = userInfo!.data![0].villageCode!;
        gropRadioVal.value = userInfo!.data![0].gender! ;
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
