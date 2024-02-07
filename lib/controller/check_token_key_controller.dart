import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/model/check_token_key_model.dart';
import 'package:itecc_member/screen/nonLogin/profile.dart';
import 'package:itecc_member/screen/onLogin/buttom_navigate.dart';

import '../screen/home_page.dart';
import '../services/auto_login.dart';
import '../services/todo_services.dart';

final box = GetStorage();

class CheckTokenKeyController extends GetxController {
 

  static Future<void> postCheckTokenKey({token}) async {
     var isLoading = false.obs;
  Datum? checkTokenKey;
  String device_token = box.read('fcmToken') ?? '';
  String os_version = box.read('os_version') ?? '';
  String app_version = box.read('app_version') ?? '';
    try {
      print("device_token : $device_token ");
      print("os_version : $os_version ");
      print("app_version : $app_version ");
      print("token : $token ");
      isLoading(true);
      http.Response response =
          await http.post(Uri.tryParse('$url/Account/checkTokenKey')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "publickey": publickey,
                "token": token,
                "device_token": device_token,
                "os_version": os_version,
                "app_version": app_version
              }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);
        print(json);
        if (json['statusCode'] == 200) {
          final checkTokenKey = Datum.fromJson(json['data'][0]);
          print(
              'checktoken for auto login: ${checkTokenKey.toJson().toString()}');

          box.write('userId', checkTokenKey.userId);
          box.write('userName', checkTokenKey.userName);
          box.write('tokenKey', checkTokenKey.tokenKey);
          box.write('userImage', checkTokenKey.userImage);
          box.write('firstName', checkTokenKey.firstName);
          box.write('lastName', checkTokenKey.lastName);
          box.write('fullName', checkTokenKey.fullName);
          box.write('mobileNumber', checkTokenKey.mobileNumber);
          box.write('updateProfile', checkTokenKey.updateProfile);
          box.write('staffWalet', checkTokenKey.staffWalet);
          box.write('personalWalet', checkTokenKey.personalWalet);

          Get.offAll(
            ButtomNavigate(),
          );
          final remember =
              AutoLogin(tokenKey: box.read('tokenKey'), rememberMe: true);
          remember.setUser();
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
