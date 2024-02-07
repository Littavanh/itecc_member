import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../style/color.dart';

class IconDetails extends StatelessWidget {
  const IconDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var value = Get.arguments;
    var icon_id = value[0];
    var icon_title = value[1];
    var icon_details = value[2];
    var icon_image = value[3];
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
          'ລາຍລະອຽດ',
          style: TextStyle(color: primaryColor),
        ),
      ),
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
               borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                icon_image,
                fit: BoxFit.fitHeight,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(alignment: Alignment.centerLeft,
             child: Column(
               children: [
                 Text(icon_title,style: TextStyle(color: textColor,fontSize: 18),),
                  Text(icon_details,style: TextStyle(color: Colors.black45,fontSize: 14),),
               ],
             ),
            ),
          ),
          flex: 4,
        )
      ]),
    );
  }
}
