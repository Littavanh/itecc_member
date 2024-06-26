import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/controller/check_token_key_controller.dart';
import 'package:itecc_member/controller/homescreen_applicationList_controller.dart';
import 'package:itecc_member/screen/home_page.dart';
import 'package:itecc_member/screen/hone_page_menu.dart';
import 'package:itecc_member/screen/nonLogin/home.dart';
import 'package:itecc_member/screen/onLogin/buttom_navigate.dart';
import 'package:itecc_member/services/auto_login.dart';
import 'package:itecc_member/style/color.dart';

import '../controller/login_controller.dart';
import '../services/todo_services.dart';

final box = GetStorage();

class SlapScreen extends StatefulWidget {
  const SlapScreen({super.key});

  @override
  State<SlapScreen> createState() => _SlapScreenState();
}

class _SlapScreenState extends State<SlapScreen> {
  HomeScreenApplicationListController homeScreenApplicationListController =
      Get.put(HomeScreenApplicationListController());
  @override
  void initState() {
    super.initState();
    loadCount();
  }

  Future<void> loadCount() async {
    await Future.delayed(const Duration(seconds: 3));
    await homeScreenApplicationListController.fetchHomeScreenAppList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            color: primaryColor,
            // gradient: LinearGradient(
            //     colors: [Colors.red, Colors.white],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     stops: [0.5, 1]),
          ),
          child: Image.asset(
            'assets/images/SplashScreen.png',
          ),
        ),
      ),
    );
  }
}
