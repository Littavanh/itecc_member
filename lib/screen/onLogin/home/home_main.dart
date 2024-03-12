// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:get/get.dart';
import 'package:horizontal_list/horizontal_list.dart';
import 'package:itecc_member/controller/icon_and_background_controller.dart';
import 'package:itecc_member/controller/login_controller.dart';
import 'package:itecc_member/controller/news_controller.dart';
import 'package:itecc_member/screen/onLogin/Wallet/scan_qr_code_with_fromImage.dart';
import 'package:itecc_member/screen/onLogin/home/feed_details.dart';

import 'package:itecc_member/style/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/banner_controller.dart';
import '../../../controller/feed_controller.dart';
import '../../../controller/userTransaction_controller.dart';

import 'banner_details.dart';
import 'icon_details.dart';

// ignore: must_be_immutable
class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  NewsController newController = Get.put(NewsController());
  UserTransactionController userTransactionController =
      Get.put(UserTransactionController());
  AppController appController = Get.put(AppController());
  BannerListController bannerListController = Get.put(BannerListController());
  FeedController feedController = Get.put(FeedController());
  Future<void> refreshNews() async {
    await newController.fetchNewsUnread();
  }

  Future<void> refreshUserTran() async {
    await userTransactionController.fetchUnReadUserTran();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshNews();
      refreshUserTran();
      FlutterDynamicIcon.setApplicationIconBadgeNumber(
          box.read('newsUnread') + box.read('tranUnread'));
      print(box.read('newsUnread') + box.read('tranUnread'));
    });
  }

  // final List<Map> myProducts =
  Icon actionIcon = const Icon(Icons.search);
  Widget appBarTitle = const Text("");
  final carousContext = CarouselController();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    List<Widget> _itemsComponent() {
      List<Widget> myList = [];
      for (var i = 0;
          i < appController.applicationListModel!.data!.length;
          i++) {
        myList.add(InkWell(
          onTap: () async {
            var icon_id =
                appController.applicationListModel?.data?[i].applicationId;
            var icon_title =
                appController.applicationListModel?.data?[i].applicationName;
            var icon_details =
                appController.applicationListModel?.data?[i].applicationUrl;
            var icon_image = appController
                .applicationListModel?.data?[i].applicationIconImage;

            Get.to(const IconDetails(),
                arguments: [icon_id, icon_title, icon_details, icon_image]);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      appController.applicationListModel?.data![i]
                              .applicationIconImage ??
                          '',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                appController.applicationListModel!.data![i].applicationName!,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ));
      }
      return myList;
    }

    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: Get.width,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                  ),
                )),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.to(CamView());
              },
              icon: Icon(
                Icons.filter_center_focus,
                color: Colors.black54,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message_outlined,
                  color: Colors.black54,
                )),
          ],
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: RefreshIndicator(
            onRefresh: refreshScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => bannerListController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          flex: 3,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              InkWell(
                                onTap: () {
                                  var banner_id = bannerListController
                                      .bannerList?.data?[activeIndex].bannerId;
                                  var banner_title = bannerListController
                                      .bannerList
                                      ?.data?[activeIndex]
                                      .bannerName;
                                  var banner_details = bannerListController
                                      .bannerList
                                      ?.data?[activeIndex]
                                      .bannerDetail;
                                  var banner_image = bannerListController
                                      .bannerList?.data?[activeIndex].imageUrl;

                                  Get.to(const BannerDetails(), arguments: [
                                    banner_id,
                                    banner_title,
                                    banner_details,
                                    banner_image
                                  ]);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: CarouselSlider.builder(
                                    itemCount: bannerListController
                                        .bannerList!.data!.length,
                                    itemBuilder: (BuildContext context,
                                            int itemIndex, int pageViewIndex) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        bannerListController.bannerList
                                                ?.data![itemIndex].imageUrl ??
                                            '',
                                      ),
                                    ),
                                    options: CarouselOptions(
                                      height: Get.height,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: true,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 5),
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 2),
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          activeIndex = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedSmoothIndicator(
                                  activeIndex: activeIndex,
                                  count: bannerListController
                                      .bannerList!.data!.length,
                                  effect: ExpandingDotsEffect(
                                      dotColor: Colors.grey,
                                      activeDotColor: dient),
                                ),
                              )
                            ],
                          ),
                        ),
                ),
                Obx(
                  () => appController.isLoading1.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 8, left: 8),
                            child: Container(
                              alignment: Alignment.center,
                              width: Get.width,
                              height: Get.height,
                              child: HorizontalListView(
                                width: double.maxFinite,
                                height: Get.width,
                                list: _itemsComponent(),
                                // iconPrevious: const Icon(
                                //   Icons.arrow_back_ios,
                                //   color: Colors.red,
                                // ),
                                // iconNext: const Icon(
                                //   Icons.arrow_forward_ios,
                                //   color: Colors.red,
                                // ),
                                isStartedFromEnd: false,
                                itemWidth: 200,
                                onChanged: (index) {
                                  print(index);
                                },
                                onPreviousPressed: () {
                                  //DO WHAT YOU WANT ON PREVIOUS PRESSED
                                  log('onPreviousPressed');
                                },
                                onNextPressed: () {
                                  //DO WHAT YOU WANT ON NEXT PRESSED
                                  log('onNextPressed');
                                },
                              ),
                            ),
                          )),
                ),
               Obx(() => feedController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        flex: 8,
                        child: Card(
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8),
                                child: Text(
                                  'ໂປຣໂມຊັ້ນ',
                                  style: TextStyle(color: textColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 8, right: 8, bottom: 8),
                                child: Obx(() => feedController.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : GridView.builder(
                                        physics: ScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 150,
                                                childAspectRatio: 2 / 3,
                                                crossAxisSpacing: 8,
                                                mainAxisSpacing: 8),
                                        itemCount:
                                            feedController.feed?.data?.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              var feed_id = feedController
                                                  .feed?.data?[index].feedId;
                                              var feed_title = feedController
                                                  .feed?.data?[index].feedTitle;
                                              var feed_details = feedController
                                                  .feed
                                                  ?.data?[index]
                                                  .feedDetail;
                                              var feed_image = feedController
                                                  .feed?.data?[index].imageUrl;

                                              Get.to(const FeedDetails(),
                                                  arguments: [
                                                    feed_id,
                                                    feed_title,
                                                    feed_details,
                                                    feed_image
                                                  ]);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                              0.5), //color of shadow
                                                      spreadRadius:
                                                          1, //spread radius
                                                      blurRadius:
                                                          1, // blur radius
                                                      offset: Offset(1,
                                                          1), // changes position of shadow
                                                      //first paramerter of offset is left-right
                                                      //second parameter is top to down
                                                    ),
                                                    //you can set more BoxShadow() here
                                                  ],
                                                  color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: Image.network(
                                                        fit: BoxFit.cover,
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        alignment:
                                                            Alignment.center,
                                                        feedController
                                                                .feed
                                                                ?.data![index]
                                                                .imageUrl ??
                                                            '',
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 2,
                                                      child: SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              feedController
                                                                      .feed
                                                                      ?.data![
                                                                          index]
                                                                      .feedTitle ??
                                                                  '',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontSize: 12),
                                                                    softWrap: false,
                                                              maxLines: 1,
                                                              overflow: TextOverflow
                                                                  .ellipsis, // new
                                                            ),
                                                            Text(
                                                              feedController
                                                                      .feed
                                                                      ?.data![
                                                                          index]
                                                                      .feedDetail ??
                                                                  '',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontSize: 10),
                                                              softWrap: false,
                                                              maxLines: 2,
                                                              overflow: TextOverflow
                                                                  .ellipsis, // new
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        })),
                              ),
                            ],
                          ),
                        ),
                      ))
              ],
            ),
          ),
        ));
  }

  Future<void> refreshScreen() async {
    await feedController.fetchFeed();
    await appController.fetchApplicationList();
    await bannerListController.fetchBannerList();
  }
}
