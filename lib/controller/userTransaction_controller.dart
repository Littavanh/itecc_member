import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:itecc_member/model/readUserTransaction_model.dart';
import 'package:itecc_member/model/userTransactionUnread_model.dart';
import 'package:itecc_member/model/userTransaction_model.dart';

import 'dart:convert';

import '../services/todo_services.dart';
class UserTransactionController extends GetxController {
   final box = GetStorage();

  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
int page = 0;
  UserTransactionModel? userTranModel;
  UserTransactionUnreadModel? userTranUnReadModel;
  ReadUserTransactionModel? readUserTranModel;
 
  @override
  Future<void> onInit() async {
    super.onInit();

    fetchUserTransaction();
    fetchUnReadUserTran();
  }

  fetchUserTransaction() async {

    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/userTransaction')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey, "pageNum" : page}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        userTranModel = UserTransactionModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }








































  fetchUnReadUserTran() async {
    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading1(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/userTransactionUnread')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        userTranUnReadModel = UserTransactionUnreadModel.fromJson(result);
          box.write('tranUnread', userTranUnReadModel!.numUnread);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading1(false);
    }
  }

  fetchReadUserTransaction(transactionId) async {
    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading2(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/readUserTransaction')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"userID": userID, "tokenKey": tokenKey, "transactionId": transactionId}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        readUserTranModel = ReadUserTransactionModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading2(false);
    }
  }
}
