import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/model/login_model.dart';

class MyPointController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'ສິນຄ້າທີ່ສາມາດແລກໄດ້',
    ),
    // Tab(
    //   text: 'ໂຄດແລກສິນຄ້າຂອງຂ້ອຍ',
    // ),
  ];
  late TabController controller;

  Datum loginModel = Datum();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    ;
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
