import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itecc_member/screen/nonLogin/home.dart';
import 'package:itecc_member/screen/nonLogin/login.dart';
import 'package:itecc_member/style/color.dart';
import 'package:itecc_member/style/size.dart';
import 'package:itecc_member/style/textstyle.dart';

import '../controller/icon_and_background_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // StreamSocket stream = StreamSocket();
  int currentPageIndex = 0;
  void _onItemTapped(int index) {
  setState(() {
    currentPageIndex = index;
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: 'ໜ້າຫຼັກ',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        label: 'ບັນຊີຂອງຂ້ອຍ',
      ),
     
    ],
    currentIndex: currentPageIndex, //New
  onTap: _onItemTapped,   
  ),
      body: <Widget>[
        Home(),
        MyAcoount(),
     
      ][currentPageIndex],
    );
  }
}
