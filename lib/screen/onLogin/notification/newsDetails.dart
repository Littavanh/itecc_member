import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../style/color.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var value = Get.arguments;
    var news_id = value[0];
    var news_title = value[1];
    var news_details = value[2];
    var news_image = value[3];
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
                news_image,
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
                 Text(news_title,style: TextStyle(color: textColor,fontSize: 18),),
                  Text(news_details,style: TextStyle(color: Colors.black45,fontSize: 14),),
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
