import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/requestOTP_model.dart';
import '../screen/nonLogin/otp.dart';
import '../services/todo_services.dart';

class RequstOTPController extends GetxController {
 var isLoading = false.obs;
  RequstOtpModel? requstotpModel;

  Future<void> requestOTP(
      {publickey, mobileNumber, device_token, os_version}) async {
    try {
      isLoading(true);
      http.Response response =
          await http.post(Uri.tryParse('$url/Account/requestOTP')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "publickey": publickey,
                "mobileNumber": mobileNumber,
                "device_token": device_token,
                "os_version": os_version
              }));
      if (response.statusCode == 200) {
        ///data successfully
        var json = jsonDecode(response.body);
        print(json);
       Get.to(const OTP(), arguments: mobileNumber);
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