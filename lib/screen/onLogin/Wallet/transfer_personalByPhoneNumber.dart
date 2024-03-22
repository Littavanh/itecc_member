import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:itecc_member/controller/customerInfo_controller.dart';
import 'package:itecc_member/screen/onLogin/Wallet/transfer_personalByPhoneNumber.dart';
import 'package:itecc_member/screen/onLogin/Wallet/transfer_personalByQrcode.dart';

import '../../../controller/eye_controller.dart';
import '../../../controller/user_balance_info_controller.dart';
import '../../../services/todo_services.dart';
import '../../../style/color.dart';
import '../../../style/size.dart';

final box = GetStorage();

class TransferPersonalByPhoneNumber extends StatefulWidget {
  const TransferPersonalByPhoneNumber({super.key});

  @override
  State<TransferPersonalByPhoneNumber> createState() =>
      _TransferPersonalByPhoneNumberState();
}

class _TransferPersonalByPhoneNumberState
    extends State<TransferPersonalByPhoneNumber> {
  final _userController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final EyeController eyeController = Get.put(EyeController());
    UserBalanceInfoController userBalanceInfoController =
        Get.put(UserBalanceInfoController());
    CustomerInfoController customerInfoController =
        Get.put(CustomerInfoController());
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
          'ກະເປົາສ່ວນຕົວ',
          style: TextStyle(color: primaryColor),
        ),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: primaryColor),
            child: Column(
              children: [
                Row(
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
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                  text: 'ລະຫັດ : ',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                              TextSpan(
                                  text: box.read('userId'),
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(
                                  text: 'ຊື່ຜູ້ໃຊ້ : ',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                              TextSpan(
                                  text: box.read('fullName'),
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => userBalanceInfoController.isLoading.value
                              ? Text('error')
                              : RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'ຍອດເງິນ : ',
                                          style: const TextStyle(
                                              color: textColor,
                                              fontFamily: 'NotoSansLao',
                                              fontSize: 14)),
                                      eyeController.pressedBool.isFalse
                                          ? TextSpan(
                                              text:
                                                  '${userBalanceInfoController.userBalanceInfo!.personalBalance.toString().replaceAll(userBalanceInfoController.userBalanceInfo!.personalBalance.toString(), '******')} ₭',
                                              style: const TextStyle(
                                                  color: textColor,
                                                  fontFamily: 'NotoSansLao',
                                                  fontSize: 14))
                                          : TextSpan(
                                              text:
                                                  '${fm.format(userBalanceInfoController.userBalanceInfo!.personalBalance)} ₭',
                                              style: const TextStyle(
                                                  color: textColor,
                                                  fontFamily: 'NotoSansLao',
                                                  fontSize: 14)),
                                      WidgetSpan(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      WidgetSpan(
                                        child: InkWell(
                                          onTap: () {
                                            userBalanceInfoController
                                                .fetchUserBalanceInfo();
                                          },
                                          child: Icon(
                                            Icons.refresh_rounded,
                                            color: Colors.green,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      WidgetSpan(
                                        child: InkWell(
                                          onTap: () {
                                            eyeController.changeStatus();
                                          },
                                          child:
                                              eyeController.pressedBool.isFalse
                                                  ? Icon(
                                                      Icons.visibility_off,
                                                      color: Colors.green,
                                                      size: 18,
                                                    )
                                                  : Icon(
                                                      Icons.visibility,
                                                      color: Colors.green,
                                                      size: 18,
                                                    ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
              height: Get.height,
              width: Get.width,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    const Text(
                      "ກະລຸນາປ້ອນເບີມືຖືທີ່ທ່ານຕ້ອງການໂອນ",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.black),
                        controller: _userController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            // Get.showSnackbar(
                            //   const GetSnackBar(
                            //     backgroundColor: gra,
                            //     title: 'ແຈ້ງເຕືອນ',
                            //     message: 'ກະລຸນາປ້ອນເບີໂທຂອງທ່ານ',
                            //     icon: Icon(Icons.warning_amber_outlined),
                            //     duration: Duration(seconds: 3),
                            //   ),
                            // );
                            return 'ກະລຸນາປ້ອນເບີໂທຂອງທ່ານ';
                          } else if (value.length < 10) {
                            return 'ຮູບແບບຂອງເບີໂທ 20XXXXXXXX';
                          } else if (value.length > 10) {
                            return 'ຮູບແບບຂອງເບີໂທ 20XXXXXXXX';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "20XXXXXXXX",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: iconSize,
                            )),
                        // onChanged: (text) => _userController.text.isNotEmpty
                        //     ? setState(() => emptyUsername = "")
                        //     : null
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 60, right: 60),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            customerInfoController.fetchCustomerInfo(
                                mobileNumber: _userController.text);

                          
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient:
                                  const LinearGradient(colors: [gra, dient]),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            width: 300,
                            height: 100,
                            alignment: Alignment.center,
                            child: const Text(
                              'ຕໍ່ໄປ',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ))
        ]),
      ),
    );
  }
}
