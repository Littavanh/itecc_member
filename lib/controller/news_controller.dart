import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:itecc_member/model/applicationList_model.dart';
import 'package:itecc_member/model/newsUnread_model.dart';
import 'package:itecc_member/model/news_model.dart';
import 'package:itecc_member/model/readNews_model.dart';
import 'dart:convert';

import '../model/backgroundImage_model.dart';
import '../services/todo_services.dart';

class NewsController extends GetxController {
  final box = GetStorage();

  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
  News? newListModel;
  NewsUnreadModel? newsUnreadModel;
  ReadNewsModel? readNewsModel;
  @override
  Future<void> onInit() async {
    super.onInit();

    fetchNewList();
    fetchNewsUnread();
  }

  fetchNewList() async {
    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/news')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        newListModel = News.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

  fetchNewsUnread() async {
    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading1(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/newsUnread')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        newsUnreadModel = NewsUnreadModel.fromJson(result);
         box.write('newsUnread', newsUnreadModel!.numUnread);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading1(false);
    }
  }

  fetchReadNews(newsId) async {
    var userID = box.read('userId');
    var tokenKey = box.read('tokenKey');
    try {
      isLoading2(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/notication/readNews')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(
              {"userID": userID, "tokenKey": tokenKey, "newsId": newsId}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        readNewsModel = ReadNewsModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading2(false);
    }
  }
}
