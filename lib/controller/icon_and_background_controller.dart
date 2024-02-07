import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:itecc_member/model/applicationList_model.dart';
import 'package:itecc_member/model/news_model.dart';
import 'dart:convert';

import '../model/backgroundImage_model.dart';
import '../services/todo_services.dart';

class AppController extends GetxController {
  ///////////////////// applicationList
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  ApplicationListModel? applicationListModel;
  BackgroundImageModel? backgroundImageModel;
 

  @override
  Future<void> onInit() async {
    super.onInit();
    
   
    fetchApplicationList();
  
     
  }

  fetchApplicationList() async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.tryParse('$url/Main/ApplicationList')!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        applicationListModel = ApplicationListModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  // fetchBackgroundImage() async {
  //   try {
  //     isLoading1(true);
  //     http.Response response =
  //         await http.get(Uri.tryParse('$url/Main/backgroundImage')!);
  //     if (response.statusCode == 200) {
  //       ///data successfully
  //       var result = jsonDecode(response.body);
  //       print(result);
  //       backgroundImageModel = BackgroundImageModel.fromJson(result);
  //         final box = GetStorage();
  //        box.write('bgImage', backgroundImageModel!.bgImage);
  //     } else {
  //       print('error fetching data');
  //     }
  //   } catch (e) {
  //     print('Error while getting data is $e');
  //   } finally {
  //     isLoading1(false);
  //   }
  // }
  /////////////////////

 
}
