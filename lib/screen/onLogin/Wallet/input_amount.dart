import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:itecc_member/screen/onLogin/Wallet/pin_auth_screen.dart';
import 'package:itecc_member/screen/onLogin/Wallet/pin_auth_screen_personal.dart';

import '../../../controller/request_payment_staff.dart';
import '../../../style/color.dart';

final box = GetStorage();

class InputAmount extends StatelessWidget {
  const InputAmount({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final amountController = TextEditingController();
    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter();
    RequestPaymentStaffController requestPaymentStaff =
        Get.put(RequestPaymentStaffController());
    // final descriptionController = TextEditingController();
    var argumentsData = Get.arguments;
    var shopCode = argumentsData[0];
    var shopName = argumentsData[1];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [gra, dient],
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'ປ້ອນຈຳນວນເງິນທີ່ຈະຊຳລະ',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: dient, width: 2.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, right: 8, bottom: 8, left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              box.read('userImage') == null ||
                                      box.read('userImage') == ""
                                  ? const WidgetSpan(
                                      child: Icon(Icons.account_circle_outlined,
                                          size: 25, color: dient))
                                  : WidgetSpan(
                                      child: Container(
                                        width: 25,
                                        height: 25,
                                        child: CircleAvatar(
                                          radius: 50,
                                          child: ClipOval(
                                            child: CachedNetworkImage(
                                              imageUrl: box.read('userImage'),
                                              fit: BoxFit.fill,
                                              width: 120,
                                              height: 120,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              const WidgetSpan(
                                  child: SizedBox(
                                width: 10,
                              )),
                              const TextSpan(
                                  text: 'ຈາກບັນຊີ : ',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 16)),
                              TextSpan(
                                  text: box.read('fullName'),
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 16)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                              const WidgetSpan(
                                  child: Icon(Icons.account_circle_outlined,
                                      size: 25, color: dient)),
                              const WidgetSpan(
                                  child: SizedBox(
                                width: 10,
                              )),
                              const TextSpan(
                                  text: 'ຫາບັນຊີ : ',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 16)),
                              TextSpan(
                                  text: shopName,
                                  style: const TextStyle(
                                      color: textColor,
                                      fontFamily: 'NotoSansLao',
                                      fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'ກະລຸນາປ້ອນຈຳນວນເງິນ',
                        style: TextStyle(
                            color: textColor,
                            fontFamily: 'NotoSansLao',
                            fontSize: 16),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            locale: 'en_US',
                            decimalDigits: 0,
                            enableNegative: false,
                            symbol: '',
                          ),
                        ],
                        style: const TextStyle(color: Colors.black),
                        controller: amountController,
                        // inputFormatters: [
                        //   CurrencyInputFormatter(),
                        // ],
                        validator: (money) {
                          if (money!.isEmpty) {
                            return 'ກະລຸນາປ້ອນຈຳນວນເງິນ';
                          }
                          if (money == '0') {
                            return 'ກະລຸນາປ້ອນຈຳນວນເງິນ';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixText: 'LAK',
                          hintText: 'ຈຳນວນເງິນທີ່ໂອນ',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: dient, width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: dient, width: 3.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // TextFormField(
                      //   validator: (money) {
                      //     if (money!.isEmpty) {
                      //       return 'ກະລຸນາປ້ອນລາຍລະອຽດໃນການໂອນ';
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      //   style: const TextStyle(color: Colors.black),
                      //   controller: descriptionController,
                      //   decoration: const InputDecoration(
                      //     hintText: 'ລາຍລະອຽດ',
                      //     contentPadding: EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 20.0),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: dient, width: 2.0),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: dient, width: 3.0),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //check if form data are valid,
                            // your process task ahed if all data are valid
                            print(amountController.text);
                            print('checkPin');
                            Get.to(PinAuthScreen(),
                                arguments: [shopCode, amountController.text,shopName]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder()),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient:
                                const LinearGradient(colors: [gra, dient]),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'ຈ່າຍ',
                              style: TextStyle(color: primaryColor),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
              )),
        ],
      ),
    );
  }
}
