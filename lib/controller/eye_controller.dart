import 'package:get/get.dart';

class EyeController extends GetxController {
  RxBool pressedBool = false.obs;

  void changeStatus() {
     pressedBool.toggle();
  }

}