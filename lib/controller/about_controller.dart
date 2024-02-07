import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:itecc_member/model/about_model.dart';


import 'dart:convert';


import '../services/todo_services.dart';

class AboutController extends GetxController {
  ///////////////////// applicationList
  var isLoading = false.obs;

  AboutModel? aboutModel;

  @override
  Future<void> onInit() async {
    super.onInit();

    fetchAbout();
  }

  fetchAbout() async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.tryParse('$url/ApplicationInfo/About')!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        aboutModel = AboutModel.fromJson(result);
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
