import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/homescreen_applicationList_controller.dart';
import '../style/color.dart';

class HomePageMenu extends StatefulWidget {
  const HomePageMenu({super.key});

  @override
  State<HomePageMenu> createState() => _HomePageMenuState();
}

class _HomePageMenuState extends State<HomePageMenu> {
  HomeScreenApplicationListController homeScreenApplicationListController =
      Get.put(HomeScreenApplicationListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/screenMenu.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ກະລຸນາເລືອກ',
                style: TextStyle(
                    color: errorColor,
                    fontSize: 32,
                    fontWeight: FontWeight.w800),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 2; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 1, //spread radius
                                  blurRadius: 1, // blur radius
                                  offset: Offset(
                                      1, 1), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                                //you can set more BoxShadow() here
                              ],
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          height: 120,
                          width: 120,
                          child: Obx(() => homeScreenApplicationListController
                                  .isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(
                                  child: InkWell(
                                    onTap: () async {
                                      var url =
                                          homeScreenApplicationListController
                                              .homeScreenApplicationListModel!
                                              .data?[i]
                                              .applicationUrl;
                                      if (url == '') {
                                        homeScreenApplicationListController
                                            .autoLogin();
                                      } else {
                                        final uri = Uri.parse(url!);
                                        if (!await launchUrl(
                                          uri,
                                        )) {
                                          throw Exception(
                                              'Could not launch $uri');
                                        }
                                      }

                                      print(i);
                                    },
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      height: double.infinity,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      homeScreenApplicationListController
                                              .homeScreenApplicationListModel
                                              ?.data![i]
                                              .applicationIconImage ??
                                          '',
                                    ),
                                  ),
                                )),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
