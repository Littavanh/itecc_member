import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/controller/userTransaction_controller.dart';

import 'package:itecc_member/screen/onLogin/home/home_main.dart';
import 'package:itecc_member/screen/onLogin/MyPoint/mypoint.dart';
import 'package:itecc_member/screen/onLogin/notification/notification.dart'
    as notiScreen;

import 'package:itecc_member/screen/onLogin/Setting/setting.dart';
import 'package:itecc_member/screen/onLogin/Wallet/wallet.dart';
import 'package:itecc_member/style/color.dart';
import 'package:badges/badges.dart' as badges;
import 'package:upgrader/upgrader.dart';

import '../../controller/news_controller.dart';

final box = GetStorage();

class ButtomNavigate extends StatefulWidget {
  const ButtomNavigate({super.key});

  @override
  State<ButtomNavigate> createState() => _ButtomNavigateState();
}

class _ButtomNavigateState extends State<ButtomNavigate> {
  // StreamSocket stream = StreamSocket();
  int currentPageIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  // int a = 0;
  // int b = 0;
  // int c = 0;

  @override
  void initState() {
    refreshNews();
    refreshUserTran();
    // a = box.read('newsUnread');
    // b = box.read('tranUnread');

    // c = a + b;
    // TODO: implement initState
    super.initState();

    // FlutterDynamicIcon.setApplicationIconBadgeNumber(c);

    // print(box.read('newsUnread') + box.read('tranUnread'));
  }

  NewsController newController = Get.put(NewsController());
  UserTransactionController userTransactionController =
      Get.put(UserTransactionController());
  // int notiBadgeNewsAmount = 0;
  // int notiBadgeUserTranAmount = 0;
  // int totalBadge = 0;

  @override
  Widget build(BuildContext context) {
    // notiBadgeNewsAmount = newController.newsUnreadModel!.numUnread!;
    // notiBadgeUserTranAmount =
    //     userTransactionController.userTranUnReadModel!.numUnread!;
    // totalBadge = notiBadgeNewsAmount + notiBadgeUserTranAmount;
    // _showCartBadge = _cartBadgeAmount > 0;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: icolor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'ໜ້າຫຼັກ',
          ),
          BottomNavigationBarItem(
            activeIcon: Image.asset(
              'assets/images/coins1.png',
              width: 24,
              height: 24,
              color: dient,
            ),
            icon:
                Image.asset('assets/images/coins1.png', width: 24, height: 24),
            label: 'ຄະແນນ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'ກະເປົາ',
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
              child: Icon(Icons.notifications_active_outlined),
              badgeContent: Obx(() => newController.isLoading1.value &&
                      userTransactionController.isLoading1.value
                  ? Center(
                      child: Container(child: Text('')),
                    )
                  : Text(
                      "${(newController.newsUnreadModel!.numUnread)! + (userTransactionController.userTranUnReadModel!.numUnread)!}",
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    )),
              position: badges.BadgePosition.topEnd(),
              showBadge: true,
            ),
            label: 'ແຈ້ງເຕືອນ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ຕັ້ງຄ່າ',
          ),
        ],
        currentIndex: currentPageIndex, //New
        onTap: _onItemTapped,
      ),
      body: UpgradeAlert(
        showIgnore: false,
        dialogStyle: UpgradeDialogStyle.cupertino,
        child: <Widget>[
          HomeMain(),
          MyPoint(),
          Wallet(),
          notiScreen.Notification(),
          Setting(),
        ][currentPageIndex],
      ),
    );
  }

  Future<void> refreshNews() async {
    await newController.fetchNewsUnread();
  }

  Future<void> refreshUserTran() async {
    await userTransactionController.fetchUnReadUserTran();
  }
}
