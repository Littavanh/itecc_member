import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:itecc_member/screen/nonLogin/profile.dart';
import 'package:itecc_member/screen/onLogin/buttom_navigate.dart';

import '../screen/home_page.dart';
import '../services/auto_login.dart';
import '../services/todo_services.dart';

final box = GetStorage();

class LoginController extends GetxController {
  var isLoading = false.obs;
  Datum? loginModel;
  String device_token = box.read('fcmToken') ?? '';
  String os_version = box.read('os_version') ?? '';
  String app_version = box.read('app_version') ?? '';
  
  Future<void> postLogin({publickey, mobileNumber, otp}) async {
    try {
        print("device_token : $device_token ");
        print("os_version : $os_version ");
        print("app_version : $app_version ");

      isLoading(true);
      http.Response response =
          await http.post(Uri.tryParse('$url/Account/UserLogin')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "publickey": publickey,
                "mobileNumber": mobileNumber,
                "otp": otp,
                "device_token": device_token,
                "os_version": os_version,
                "app_version": app_version
              }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);
        // print(json);
        if (json['statusCode'] == 200) {
          final loginModel = Datum.fromJson(json['data'][0]);
          print('Login: ${loginModel.toJson().toString()}');

          box.write('userId', loginModel.userId);
          box.write('userName', loginModel.userName);
          box.write('tokenKey', loginModel.tokenKey);
          box.write('userImage', loginModel.userImage);
          box.write('firstName', loginModel.firstName);
          box.write('lastName', loginModel.lastName);
          box.write('fullName', loginModel.fullName);
          box.write('mobileNumber', loginModel.mobileNumber);
          box.write('updateProfile', loginModel.updateProfile);
          box.write('staffWalet', loginModel.staffWalet);
          box.write('personalWalet', loginModel.personalWalet);

          if (box.read('updateProfile') == '1') {
            Get.offAll(
              ButtomNavigate(),
            );
            final remember =
                AutoLogin(tokenKey: box.read('tokenKey'), rememberMe: true);
            remember.setUser();
          } else {
            Get.off(
              Profile(
                phone: mobileNumber,
                otp: otp,
              ),
            );
          }
        } else {
          print('no autoLogin ');
          Get.offAll(HomePage());
        }
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
