import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

import 'package:get/get.dart';
import 'package:itecc_member/controller/userTransaction_controller.dart';
import 'package:itecc_member/screen/onLogin/notification/newsDetails.dart';
import 'package:badges/badges.dart' as badges;
import 'package:itecc_member/screen/onLogin/notification/userTransactionDetails.dart';
import '../../../controller/news_controller.dart';
import '../../../model/newsUnread_model.dart';
import '../../../services/todo_services.dart';
import '../../../style/color.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:itecc_member/model/news_model.dart';
import 'dart:convert';

final box = GetStorage();

class Notification extends StatefulWidget {
  Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  // The controller for the ListView
  int page = 0;
  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List addListView = [];

  late ScrollController _controller;

  Future reFreshLoad() async {
    print('refreshing');
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      page = 0;
      var userID = box.read('userId');
      var tokenKey = box.read('tokenKey');
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/userTransaction')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"userID": userID, "tokenKey": tokenKey, "pageNum": page}));

      setState(() {
        addListView = jsonDecode(response.body)['data'];
        print(addListView);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
        print('Error while getting data is $err');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
      _hasNextPage = true;
      _isLoadMoreRunning = false;
    });
  }

  Future _firstLoad() async {
    print('firstLoad');
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      print("_page :$page");
      var userID = box.read('userId');
      var tokenKey = box.read('tokenKey');
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/userTransaction')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"userID": userID, "tokenKey": tokenKey, "pageNum": page}));

      setState(() {
        addListView = jsonDecode(response.body)['data'];
        print(addListView);
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
        print('Error while getting data is $err');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    print('loadmore $page');
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      page += 1;
      try {
        print("_page :$page");
        var userID = box.read('userId');
        var tokenKey = box.read('tokenKey');
        http.Response response = await http.post(
            Uri.tryParse('$url/notication/userTransaction')!,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(
                {"userID": userID, "tokenKey": tokenKey, "pageNum": page}));
        final List fecthPosts = jsonDecode(response.body)['data'];
        print(fecthPosts);
        if (fecthPosts.isNotEmpty) {
          setState(() {
            addListView.addAll(fecthPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      refreshNews();
      refreshUserTran();
      reFreshLoad();
      FlutterDynamicIcon.setApplicationIconBadgeNumber(
          box.read('newsUnread') + box.read('tranUnread'));
      print(box.read('newsUnread') + box.read('tranUnread'));
    });
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  NewsController newController = Get.put(NewsController());
  UserTransactionController userTransactionController =
      Get.put(UserTransactionController());
  @override
  Widget build(BuildContext context) {
    // Usertransacc newController = Get.put(NewsController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              'ລາຍການແຈ້ງເຕືອນ',
              style: TextStyle(color: primaryColor),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: dient, borderRadius: BorderRadius.circular(10)),
                    labelColor: primaryColor,
                    unselectedLabelColor: textColor,
                    tabs: [
                      badges.Badge(
                        child: Tab(
                          text: 'ແຈ້ງເຕືອນໂປຣໂມຊັ້ນ',
                        ),
                        badgeContent: Obx(
                          () => newController.isLoading1.value
                              ? const Center(
                                  child: Text(''),
                                )
                              : Text(
                                  newController.newsUnreadModel?.numUnread
                                          .toString() ??
                                      '',
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 12),
                                ),
                        ),
                        position: badges.BadgePosition.topEnd(),
                        showBadge: true,
                      ),
                      badges.Badge(
                        child: Tab(
                          text: 'ແຈ້ງເຕືອນການເຄື່ອນໄຫວ',
                        ),
                        badgeContent:
                            Obx(() => userTransactionController.isLoading1.value
                                ? const Center(
                                    child: Text(''),
                                  )
                                : Text(
                                    userTransactionController
                                            .userTranUnReadModel?.numUnread
                                            .toString() ??
                                        '',
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 12),
                                  )),
                        position: badges.BadgePosition.topEnd(),
                        showBadge: true,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Obx(() => newController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RefreshIndicator(
                            onRefresh: refreshNews,
                            child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount:
                                    newController.newListModel?.data!.length ??
                                        0,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                    onTap: () {
                                      print(index);
                                      var news_id = newController
                                          .newListModel?.data?[index].newsId;
                                      var news_title = newController
                                          .newListModel?.data?[index].newsTitle;
                                      var news_details = newController
                                          .newListModel
                                          ?.data?[index]
                                          .newsDetail;
                                      var news_image = newController
                                          .newListModel?.data?[index].imageUrl;

                                      newController.fetchReadNews(news_id);
                                      refreshNews();

                                      Get.to(const NewsDetails(), arguments: [
                                        news_id,
                                        news_title,
                                        news_details,
                                        news_image
                                      ]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (newController.newListModel!
                                                      .data![index].readState ==
                                                  "unread")
                                              ? Theme.of(context).highlightColor
                                              : Colors.transparent),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 120,
                                            child: Row(children: [
                                              Expanded(
                                                child: Container(
                                                  height: Get.height,
                                                  child: Image.network(
                                                    fit: BoxFit.fill,
                                                    height: Get.height,
                                                    width: Get.width,
                                                    alignment: Alignment.center,
                                                    newController
                                                            .newListModel
                                                            ?.data![index]
                                                            .imageUrl ??
                                                        '',
                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        newController
                                                                .newListModel
                                                                ?.data![index]
                                                                .newsTitle ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: textColor),
                                                      ),
                                                      Text(
                                                        newController
                                                                .newListModel
                                                                ?.data![index]
                                                                .newsDetail ??
                                                            '',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 12),
                                                        softWrap: false,
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                flex: 5,
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )),
                    Column(
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: reFreshLoad,
                            child: ListView.separated(
                                controller: _controller,
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: addListView.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return InkWell(
                                    onTap: () async {
                                      print(index);
                                      var tran_id =
                                          addListView[index]['transactionId'];
                                      var tran_date =
                                          addListView[index]['transactionDate'];
                                      var tran_title = addListView[index]
                                          ['transactionTitle'];
                                      var tran_amount =
                                          addListView[index]['amount'];
                                      var tran_shopName =
                                          addListView[index]['shopName'];
                                      var tran_detail = addListView[index]
                                          ['transactionDetail'];
                                      userTransactionController
                                          .fetchReadUserTransaction(tran_id);
                                   reFreshLoad();
                                      Get.to(UserTransactionDetails(),
                                          arguments: [
                                            tran_id,
                                            tran_date,
                                            tran_title,
                                            tran_amount,
                                            tran_shopName,
                                            tran_detail
                                          ]);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (addListView[index]
                                                      ['readState'] ==
                                                  "unread")
                                              ? Theme.of(context).highlightColor
                                              : Colors.transparent),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 120,
                                              child: Row(children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        addListView[index][
                                                                'transactionTitle'] ??
                                                            '',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: textColor),
                                                      ),
                                                      addListView[index]
                                                                  ['amount'] ==
                                                              "0.00"
                                                          ? Text(
                                                              "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12),
                                                              softWrap: false,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          : Text(
                                                              "ລະຫັດ : ${addListView[index]['transactionId'] ?? ''}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12),
                                                              softWrap: false,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                      addListView[index]
                                                                  ['amount'] ==
                                                              "0.00"
                                                          ? Text(
                                                              "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12),
                                                            )
                                                          : Text(
                                                              "ຈາກຮ້ານ : ${addListView[index]['shopName'] ?? ''}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12),
                                                            ),
                                                      addListView[index]
                                                                  ['amount'] ==
                                                              "0.00"
                                                          ? Text(
                                                              "",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12),
                                                            )
                                                          : Text(
                                                              "ຄະແນນ : ${addListView[index]['point'] ?? ''}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 12),
                                                            ),
                                                    ],
                                                  ),
                                                  flex: 4,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        if (addListView[index][
                                                                'transactionTitle'] ==
                                                            'Payment')
                                                          Text(
                                                            '- ${fm.format(double.parse(addListView[index]['amount'] ?? ''))} LAK',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    errorColor),
                                                          ),
                                                        if (addListView[index][
                                                                'transactionTitle'] ==
                                                            'Refund')
                                                          Text(
                                                            ' ${fm.format(double.parse(addListView[index]['amount'] ?? ''))} LAK',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    errorColor),
                                                          ),
                                                        if (addListView[index][
                                                                'transactionTitle'] ==
                                                            'TOP-UP')
                                                          Text(
                                                            '+ ${fm.format(double.parse(addListView[index]['amount'] ?? ''))} LAK',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        Text(
                                                          addListView[index][
                                                                  'transactionDate'] ??
                                                              '',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  flex: 3,
                                                )
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        // when the _loadMore function is running
                        if (_isLoadMoreRunning == true)
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 40),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                        // When nothing else to load
                        if (_hasNextPage == false)
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            color: Colors.black45,
                            child: const Center(
                              child: Text('ການເຄື່ອນໄຫວທັງໝົດ'),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  Future<void> refreshNews() async {
    await newController.fetchNewList();
    await newController.fetchNewsUnread();
  }

  Future<void> refreshUserTran() async {
    await userTransactionController.fetchUserTransaction();
    await userTransactionController.fetchUnReadUserTran();
  }
}
