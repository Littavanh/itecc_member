import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/model/user_balance_info.dart';
import 'package:http/http.dart' as http;
import '../services/todo_services.dart';

class UserBalanceInfoController extends GetxController {
  var isLoading = false.obs;

  UserBalanceInfoModel? userBalanceInfo;
final box = GetStorage();

  @override
  
  Future<void> onInit() async {
    super.onInit();

    fetchUserBalanceInfo();
  }

  fetchUserBalanceInfo() async {
    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/Account/userBalanceInfo')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        userBalanceInfo = UserBalanceInfoModel.fromJson(result);
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
