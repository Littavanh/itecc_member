import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/model/homescreen_applicationList_model.dart';

import 'dart:convert';

import '../screen/home_page.dart';
import '../screen/hone_page_menu.dart';
import '../services/auto_login.dart';
import '../services/todo_services.dart';
import 'check_token_key_controller.dart';

class HomeScreenApplicationListController extends GetxController {
  ///////////////////// applicationList
  var isLoading = false.obs;

  HomeScreenApplicationListModel? homeScreenApplicationListModel;

  @override
  // Future<void> onInit() async {
  //   super.onInit();

  //   fetchHomeScreenAppList();
  // }
  autoLogin() async {
    _loginAuto();
  }

  fetchHomeScreenAppList() async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.tryParse('$url/homescreen/applicationList')!);
      if (response.statusCode == 200) {
        ///data successfully
        var item = jsonDecode(response.body);
        var result = jsonDecode(response.body)['data'];
        var count = item['totalRecord'];
        print('count: ' + count.toString());
        print('result: ' + result.toString());
        homeScreenApplicationListModel =
            HomeScreenApplicationListModel.fromJson(item);
        checkCount(count);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  checkCount(i) {
    if (i == 1.0) {
      _loginAuto();
    } else {
      // go to page menu
      print('Go to HomePageMenu()');
      Get.offAll(HomePageMenu());
    }
  }

  Future _loginAuto() async {
    final user = AutoLogin.getUser();

    if (user.rememberMe) {
      print('autoLogin');

      await CheckTokenKeyController.postCheckTokenKey(token: user.tokenKey);
    } else {
      print('no autoLogin');
      Get.offAll(HomePage());
    }
  }
}
