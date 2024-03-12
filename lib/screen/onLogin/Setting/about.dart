import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controller/about_controller.dart';
import '../../../style/color.dart';

final box = GetStorage();

class About extends StatelessWidget {
  About({super.key});

  @override
  Widget build(BuildContext context) {
    AboutController aboutController = Get.put(AboutController());
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
            'ກ່ຽວກັບ',
            style: TextStyle(color: primaryColor),
          ),
        ),
        body: Obx(
          () => aboutController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/logo/Member23.png',
                                      height: Get.height,
                                      width: Get.width,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Text(
                                        //   'ໄອເຕັກເມັມເບີ',
                                        //   style: TextStyle(color: textColor),
                                        // ),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        Text(
                                          aboutController.aboutModel!
                                                  .applicationName ??
                                              '',
                                          style: TextStyle(color: textColor),
                                        )
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        )),
                    const Divider(),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                aboutController.aboutModel!.applicationInfo ??
                                    '',
                                style: TextStyle(
                                  color: textColor,
                                  fontFamily: 'NotoSansLao',
                                ),
                              ),
                            ),
                          ),
                        )),
                    const Divider(),
                    Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, bottom: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'ເວີຊັນ: ',
                                          style: TextStyle(
                                              color: textColor,
                                              fontFamily: 'NotoSansLao',
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          // text: aboutController.aboutModel!
                                          //         .applicationVersion ??
                                          //     '',

                                          text: box.read('app_version') ?? '',
                                          style: TextStyle(
                                            color: textColor,
                                            fontFamily: 'NotoSansLao',
                                          )),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'ອັບເດດລ່າສຸດ: ',
                                          style: TextStyle(
                                              color: textColor,
                                              fontFamily: 'NotoSansLao',
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: aboutController.aboutModel!
                                                  .applicationLastUpDate ??
                                              '',
                                          style: TextStyle(
                                            color: textColor,
                                            fontFamily: 'NotoSansLao',
                                          )),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'Owner: ',
                                          style: TextStyle(
                                              color: textColor,
                                              fontFamily: 'NotoSansLao',
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: aboutController.aboutModel!
                                                  .applicationOwner ??
                                              '',
                                          style: TextStyle(
                                            color: textColor,
                                            fontFamily: 'NotoSansLao',
                                          )),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'CopyRight: © ',
                                          style: TextStyle(
                                              color: textColor,
                                              fontFamily: 'NotoSansLao',
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: aboutController.aboutModel!
                                                  .applicationCopyRight ??
                                              '',
                                          style: TextStyle(
                                            color: textColor,
                                            fontFamily: 'NotoSansLao',
                                          )),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'Call Center: ',
                                          style: TextStyle(
                                              color: textColor,
                                              fontFamily: 'NotoSansLao',
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: aboutController
                                                  .aboutModel!.callCenter ??
                                              '',
                                          style: TextStyle(
                                            color: textColor,
                                            fontFamily: 'NotoSansLao',
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
        ));
  }
}
