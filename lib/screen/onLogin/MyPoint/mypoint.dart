import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/controller/mypoint_controller.dart';
import 'package:itecc_member/controller/reward_controller.dart';
import 'package:itecc_member/controller/user_balance_info_controller.dart';
import 'package:itecc_member/style/color.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '../../../controller/icon_and_background_controller.dart';
import '../../../controller/news_controller.dart';
import '../../../services/todo_services.dart';

final box = GetStorage();

class MyPoint extends StatefulWidget {
  const MyPoint({super.key});

  @override
  State<MyPoint> createState() => _MyPointState();
}

RewardController reawardController = Get.put(RewardController());

class _MyPointState extends State<MyPoint> {
  UserBalanceInfoController userBalanceInfoController =
      Get.put(UserBalanceInfoController());
  Future<void> refreshPoint() async {
    await userBalanceInfoController.fetchUserBalanceInfo();
  }

  Future<void> refreshReward() async {
    await reawardController.fecthRewardList();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshPoint();
      refreshReward();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(" userImage: ${box.read('userImage')}");

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [gra, dient],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'ຄະແນນຂອງຂ້ອຍ',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  box.read('userImage') == null || box.read('userImage') == ""
                      ? const Icon(Icons.account_circle_outlined,
                          size: 120, color: dient)
                      : CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: box.read('userImage'),
                              fit: BoxFit.cover,
                              width: 120,
                              height: 120,
                            ),
                          ),
                        ),
                  Obx(() => userBalanceInfoController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : RichText(
                          text: TextSpan(
                            // Note: Styles for TextSpans must be explicitly defined.
                            // Child text spans will inherit styles from parent
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                    'assets/images/coins1.png',
                                    color: icolor1,
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                              TextSpan(
                                  text:
                                      '  ${userBalanceInfoController.userBalanceInfo?.totalPoint.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: icolor1,
                                      fontSize: 20,
                                      fontFamily: 'NotoSansLao')),
                            ],
                          ),
                        )),
                  RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: [
                        const TextSpan(
                            text: "ປະຫວັດການແລກ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'NotoSansLao')),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: icolor1,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 3,
            child: MyTabbedWidget(),
          )
        ],
      ),
    );
  }
}

class MyTabbedWidget extends StatelessWidget {
  const MyTabbedWidget();

  @override
  Widget build(BuildContext context) {
    final MyPointController _tabx = Get.put(MyPointController());

    // ↑ init tab controller
    return Column(children: <Widget>[
      SizedBox(
        height: 60,
        child: TabBar(
          onTap: (index) {
            //your currently selected index
            print(index);
          },
          tabs: _tabx.myTabs,
          controller: _tabx.controller,
          unselectedLabelColor: textColor,
          indicatorColor: dient,
          labelColor: dient,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
          indicatorPadding: const EdgeInsets.all(10),
          isScrollable: false,
        ),
      ),
      Expanded(
        child: TabBarView(
          controller: _tabx.controller,
          children: _tabx.myTabs.map((Tab tab) {
            final String label = tab.text!;

            return Obx(() => reawardController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2 / 3,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8),
                              itemCount:
                                  reawardController.rewardList?.data?.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return Container(
                                  foregroundDecoration:
                                      const RotatedCornerDecoration.withColor(
                                    color: Colors.red,
                                    spanBaselineShift: 4,
                                    badgeSize: Size(40, 40),
                                    badgeCornerRadius: Radius.circular(8),
                                    badgePosition: BadgePosition.bottomEnd,
                                    textSpan: TextSpan(
                                      text: 'ແລກ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.yellowAccent,
                                              blurRadius: 8),
                                        ],
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Image.network(
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            reawardController.rewardList
                                                    ?.data![index].imageUrl ??
                                                '',
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: Get.width,
                                          height: Get.height,
                                          alignment: Alignment.center,
                                          color: primaryColor,
                                          child: Text(
                                            reawardController.rewardList
                                                    ?.data![index].rewardName ??
                                                '',
                                            style: const TextStyle(
                                                color: textColor,
                                                fontSize: 10,
                                                fontFamily: 'NotoSansLao'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: Get.width,
                                          height: Get.height,
                                          alignment: Alignment.bottomLeft,
                                          color: primaryColor,
                                          child: Text(
                                            '${fm.format(double.parse(reawardController.rewardList?.data![index].rewardPoint ?? ''))} P' ,
                                            style: const TextStyle(
                                                color: icolor1,
                                                fontSize: 10,
                                                fontFamily: 'NotoSansLao'),
                                          ),
                                        ),
                                      )
                                      // Container(
                                      //   child: Text(
                                      //     'COMING SOON',
                                      //     style:
                                      //         TextStyle(color: icolor, fontSize: 12),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                );
                              })),
                    ),
                  ));
          }).toList(),
        ),
      ),
    ]);
  }
}
