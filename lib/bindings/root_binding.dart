import 'package:get/get.dart';
import 'package:itecc_member/controller/icon_and_background_controller.dart';
import 'package:itecc_member/controller/news_controller.dart';
import 'package:itecc_member/controller/userInfo_controller.dart';


class RootBinding implements Bindings {
@override
void dependencies() {
  Get.put(AppController());
  //  Get.put(NewsController());
  
  }
}